#!/bin/bash
# PM-OS Agent Orchestrator
# Auto-discovers agents from frontmatter in agents/*.md
# Usage:
#   ./run-agents.sh                           # runs agents matching current schedule (auto-detects day/time)
#   ./run-agents.sh daily-8am                 # runs only daily-8am agents
#   ./run-agents.sh hourly                    # runs only hourly agents
#   ./run-agents.sh weekly-monday-8am         # runs only weekly-monday-8am agents
#   ./run-agents.sh weekly-friday-4pm         # runs only weekly-friday-4pm agents
#   ./run-agents.sh daily-8am,weekly-monday-8am  # runs agents matching either schedule (comma-separated)
#   ./run-agents.sh all                       # runs all agents regardless of schedule
#
# Schedule Logic (when run with no argument):
#   Monday 8am:   daily-8am + weekly-monday-8am
#   Friday 4pm:   weekly-friday-4pm
#   Other 8am:    daily-8am
#   Other times:  hourly

AGENTS_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE="$(dirname "$AGENTS_DIR")"
LOG_DIR="$AGENTS_DIR/logs"
mkdir -p "$LOG_DIR"

# Ensure PATH includes common tool locations (launchd uses minimal PATH)
export PATH="/usr/local/bin:/opt/homebrew/bin:$HOME/.local/bin:$PATH"

# macOS doesn't ship GNU timeout — add coreutils gnubin to PATH so timeout resolves correctly
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
if ! command -v timeout &>/dev/null; then
    echo "ERROR: timeout not found. Install coreutils: brew install coreutils" >&2
    exit 1
fi

SCHEDULE_FILTER="${1:-auto}"
TIMESTAMP=$(date +%Y-%m-%d_%H%M)
RUN_SUMMARY="$LOG_DIR/run-history.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_DIR/orchestrator.log"
}

# Detect if we're running inside an active Rovo Dev session.
# Signs of an in-session run: ROVODEV_SESSION_ID is set, or the parent process
# is an interactive terminal (not launchd/cron). In-session runs should use
# invoke_subagents for parallelism — this script is for unattended cron runs.
detect_run_context() {
    if [ -n "$ROVODEV_SESSION_ID" ]; then
        echo "in-session"
    elif [ -n "$TERM" ] && [ "$TERM" != "dumb" ] && [ -t 0 ]; then
        # Interactive terminal — human is present
        echo "in-session"
    else
        # No TTY, no session ID — assume cron/launchd
        echo "cron"
    fi
}

RUN_CONTEXT=$(detect_run_context)

if [ "$RUN_CONTEXT" = "in-session" ]; then
    log "⚡ In-session context detected — for maximum efficiency, consider invoking agents via 'invoke_subagents' inside the Rovo Dev session instead of this script. Proceeding with sequential acli runs."
    log "   Tip: Orchestrator agents (monday-intel-drop, stakeholder-brief) use invoke_subagents automatically when run from a live session."
fi

# Determine current schedule based on time of day and day of week
# ── every-2h-workhours: Slack Action Scanner catch-up logic ──────────────────
# Work hours: 7am–8pm Melbourne (HOUR 7–20)
# Fires on even hours: 7,8,10,12,14,16,18,20
# On resume after a gap, calculates how many hours were missed and sets SCAN_WINDOW_HOURS
# so the agent knows to scan further back than the default 2h window.
SCAN_WINDOW_HOURS=2
LAST_SCAN_FILE="$LOG_DIR/.last_slack_scan_hour"
SLACK_SCANNER_ACTIVE=false

compute_slack_scan_window() {
    local current_hour="$1"
    # Work hours: 7–20
    if [ "$current_hour" -lt 7 ] || [ "$current_hour" -gt 20 ]; then
        echo "skip"
        return
    fi
    # Only fire on even hours within work window (7,8,10,12,14,16,18,20)
    local remainder=$(( current_hour % 2 ))
    if [ "$remainder" -ne 0 ] && [ "$current_hour" -ne 7 ]; then
        echo "skip"
        return
    fi
    # Catch-up: how long since last scan?
    local window=2
    if [ -f "$LAST_SCAN_FILE" ]; then
        local last_hour
        last_hour=$(cat "$LAST_SCAN_FILE" 2>/dev/null || echo "")
        if [ -n "$last_hour" ] && [ "$last_hour" -lt "$current_hour" ]; then
            window=$(( current_hour - last_hour ))
            # Cap at 12h (overnight gap — don't scan days back)
            [ "$window" -gt 12 ] && window=12
        fi
    fi
    echo "$window"
}

if [ "$SCHEDULE_FILTER" = "auto" ]; then
    HOUR=$(date +%H)
    HOUR_NUM=$(echo "$HOUR" | sed 's/^0*//' | grep -v '^$' || echo "0")
    DOW=$(date +%A)  # Monday, Tuesday, etc.

    # Check if Slack scanner should run this hour
    SLACK_WINDOW=$(compute_slack_scan_window "$HOUR_NUM")
    if [ "$SLACK_WINDOW" != "skip" ]; then
        SLACK_SCANNER_ACTIVE=true
        SCAN_WINDOW_HOURS=$SLACK_WINDOW
        echo "$HOUR_NUM" > "$LAST_SCAN_FILE"
        log "Slack Action Scanner: active (scan window: ${SCAN_WINDOW_HOURS}h)"
    else
        log "Slack Action Scanner: skipping (outside work hours or odd hour)"
    fi

    if [ "$DOW" = "Monday" ] && [ "$HOUR_NUM" -eq 8 ]; then
        # Monday 8am: run both daily-8am and weekly-monday-8am
        SCHEDULE_FILTER="daily-8am,weekly-monday-8am"
    elif [ "$DOW" = "Friday" ] && [ "$HOUR_NUM" -ge 16 ] && [ "$HOUR_NUM" -le 18 ]; then
        # Friday 4-6pm: run weekly-friday-4pm — catch-up window handles Mac sleep/wake misses
        SCHEDULE_FILTER="weekly-friday-4pm"
    elif [ "$HOUR_NUM" -eq 8 ]; then
        # Other days at 8am: run daily-8am only
        SCHEDULE_FILTER="daily-8am"
    else
        # All other times: hourly (Slack scanner handled separately above)
        SCHEDULE_FILTER="hourly"
    fi
fi

# Export scan window for Slack scanner agent
export SCAN_WINDOW_HOURS

log "=== Orchestrator started (schedule: $SCHEDULE_FILTER) ==="
echo "" >> "$RUN_SUMMARY"
echo "══════════════════════════════════════════════════════════" >> "$RUN_SUMMARY"
echo "Run: $(date '+%Y-%m-%d %H:%M') | Schedule: $SCHEDULE_FILTER" >> "$RUN_SUMMARY"
echo "══════════════════════════════════════════════════════════" >> "$RUN_SUMMARY"

AGENTS_RUN=0
AGENTS_OK=0
AGENTS_FAIL=0

# Build list of orchestrator slugs that will run in this window.
# Only includes agents that are referenced by at least one sub-agent's orchestrator: field.
# Used below to suppress sub-agents when their orchestrator is active.
ACTIVE_ORCHESTRATORS=()

# First: collect all unique orchestrator slugs referenced by any sub-agent
REFERENCED_ORCHESTRATORS=()
for ofile in "$AGENTS_DIR"/*.md; do
    [ -f "$ofile" ] || continue
    ref=$(awk '/^---$/{f++; next} f==1 && /^orchestrator:/{sub(/^orchestrator: */, ""); print}' "$ofile")
    [ -n "$ref" ] && REFERENCED_ORCHESTRATORS+=("$ref")
done

# Second: for each referenced orchestrator, check if it's scheduled to run in this window
for ofile in "$AGENTS_DIR"/*.md; do
    [ -f "$ofile" ] || continue
    oname=$(awk '/^---$/{f++; next} f==1 && /^name:/{sub(/^name: */, ""); print}' "$ofile")
    oschedule=$(awk '/^---$/{f++; next} f==1 && /^schedule:/{sub(/^schedule: */, ""); print}' "$ofile")
    [ -z "$oname" ] && continue
    [ -z "$oschedule" ] && continue
    oslug=$(echo "$oname" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    # Only consider agents that are actually referenced as orchestrators
    IS_REFERENCED=0
    for ref in "${REFERENCED_ORCHESTRATORS[@]}"; do
        [ "$ref" = "$oslug" ] && IS_REFERENCED=1 && break
    done
    [ $IS_REFERENCED -eq 0 ] && continue
    # Check if scheduled to run this window
    if [ "$SCHEDULE_FILTER" = "all" ]; then
        ACTIVE_ORCHESTRATORS+=("$oslug")
    else
        IFS=',' read -ra OFILTERS <<< "$SCHEDULE_FILTER"
        for ofilter in "${OFILTERS[@]}"; do
            ofilter=$(echo "$ofilter" | xargs)
            if [ "$oschedule" = "$ofilter" ]; then
                ACTIVE_ORCHESTRATORS+=("$oslug")
                break
            fi
        done
    fi
done

# Parse frontmatter from agent files
for agent_file in "$AGENTS_DIR"/*.md; do
    [ -f "$agent_file" ] || continue
    
    # Extract frontmatter (awk for macOS BSD sed compatibility)
    name=$(awk '/^---$/{f++; next} f==1 && /^name:/{sub(/^name: */, ""); print}' "$agent_file")
    schedule=$(awk '/^---$/{f++; next} f==1 && /^schedule:/{sub(/^schedule: */, ""); print}' "$agent_file")
    prompt=$(awk '/^---$/{f++; next} f==1 && /^prompt:/{sub(/^prompt: *"?/, ""); sub(/"$/, ""); print}' "$agent_file")
    orchestrator=$(awk '/^---$/{f++; next} f==1 && /^orchestrator:/{sub(/^orchestrator: */, ""); print}' "$agent_file")
    
    # Skip files without frontmatter
    [ -z "$name" ] && continue
    [ -z "$schedule" ] && continue
    [ -z "$prompt" ] && continue
    
    # Check if schedule matches (support comma-separated filters like "daily-8am,weekly-monday-8am")
    SHOULD_RUN=0
    if [ "$SCHEDULE_FILTER" = "all" ]; then
        SHOULD_RUN=1
    else
        # Split comma-separated schedule filter and check if agent schedule matches any
        IFS=',' read -ra FILTERS <<< "$SCHEDULE_FILTER"
        for filter in "${FILTERS[@]}"; do
            filter=$(echo "$filter" | xargs)  # trim whitespace
            if [ "$schedule" = "$filter" ]; then
                SHOULD_RUN=1
                break
            fi
        done
    fi
    
    # Handle every-2h-workhours schedule separately via SLACK_SCANNER_ACTIVE flag
    if [ "$schedule" = "every-2h-workhours" ]; then
        if [ "$SLACK_SCANNER_ACTIVE" = "true" ]; then
            SHOULD_RUN=1
        else
            log "Skipping $name (schedule: every-2h-workhours — outside window or odd hour)"
            continue
        fi
    fi

    if [ $SHOULD_RUN -eq 0 ]; then
        log "Skipping $name (schedule: $schedule, filter: $SCHEDULE_FILTER)"
        continue
    fi

    # If this agent's orchestrator is running in this window, skip it —
    # the orchestrator will invoke it as a sub-agent and own the Slack delivery
    if [ -n "$orchestrator" ]; then
        for active_orch in "${ACTIVE_ORCHESTRATORS[@]}"; do
            if [ "$orchestrator" = "$active_orch" ]; then
                log "Skipping $name — delegated to orchestrator '$orchestrator' (running this window)"
                continue 2
            fi
        done
    fi
    
    log "Running: $name"
    AGENTS_RUN=$((AGENTS_RUN + 1))
    AGENT_START=$(date +%s)
    AGENT_LOG="$LOG_DIR/${name// /-}_${TIMESTAMP}.log"
    
    cd "$WORKSPACE"
    # Apply a timeout to prevent hung agents from blocking the orchestrator.
    # Hourly agents get 10 min; daily/weekly agents get 15 min.
    if [ "$schedule" = "hourly" ] || [ "$schedule" = "every-2h-workhours" ]; then
        AGENT_TIMEOUT=600
    else
        AGENT_TIMEOUT=900
    fi
    timeout "$AGENT_TIMEOUT" acli rovodev run --yolo "$prompt" > "$AGENT_LOG" 2>&1
    EXIT_CODE=$?
    if [ $EXIT_CODE -eq 124 ]; then
        log "TIMEOUT: $name exceeded ${AGENT_TIMEOUT}s — killed"
        echo "  ⏱️  $name — TIMED OUT (${AGENT_TIMEOUT}s)" >> "$AGENT_LOG"
    fi
    
    AGENT_END=$(date +%s)
    AGENT_DURATION=$(( AGENT_END - AGENT_START ))
    AGENT_MINS=$(( AGENT_DURATION / 60 ))
    AGENT_SECS=$(( AGENT_DURATION % 60 ))
    LOG_SIZE=$(wc -c < "$AGENT_LOG" | tr -d ' ')
    
    if [ $EXIT_CODE -eq 0 ]; then
        log "Completed: $name (${AGENT_MINS}m${AGENT_SECS}s)"
        echo "  ✅ $name — ${AGENT_MINS}m${AGENT_SECS}s — log: ${LOG_SIZE} bytes" >> "$RUN_SUMMARY"
        AGENTS_OK=$((AGENTS_OK + 1))
    else
        log "FAILED: $name (exit code: $EXIT_CODE, ${AGENT_MINS}m${AGENT_SECS}s)"
        # Grab last 3 lines of log for quick error context
        TAIL=$(tail -3 "$AGENT_LOG" | tr '\n' ' ')
        echo "  ❌ $name — FAILED (exit $EXIT_CODE, ${AGENT_MINS}m${AGENT_SECS}s) — $TAIL" >> "$RUN_SUMMARY"
        AGENTS_FAIL=$((AGENTS_FAIL + 1))
    fi
done

if [ $AGENTS_RUN -eq 0 ]; then
    echo "  ⚠️  No agents matched schedule '$SCHEDULE_FILTER'" >> "$RUN_SUMMARY"
fi
echo "  ── Summary: $AGENTS_OK ok / $AGENTS_FAIL failed / $AGENTS_RUN total" >> "$RUN_SUMMARY"

log "=== Orchestrator finished ($AGENTS_OK ok, $AGENTS_FAIL failed) ==="

# ── Session cleanup ──────────────────────────────────────────────────────────
# Delete agent-created sessions older than 7 days to prevent accumulation.
# Agent sessions are identified by initial_prompt starting with "Run the".
SESSIONS_DIR="$HOME/.rovodev/sessions"
CLEANUP_CUTOFF=$(( $(date +%s) - 7 * 86400 ))
CLEANED=0
if [ -d "$SESSIONS_DIR" ]; then
    for session_dir in "$SESSIONS_DIR"/*/; do
        ctx="$session_dir/session_context.json"
        [ -f "$ctx" ] || continue
        ts=$(python3 -c "import json; d=json.load(open('$ctx')); print(d.get('timestamp',0))" 2>/dev/null)
        prompt=$(python3 -c "import json; d=json.load(open('$ctx')); print((d.get('initial_prompt','') or '')[:10])" 2>/dev/null)
        if [ "$prompt" = "Run the " ] && [ -n "$ts" ] && [ "$ts" -lt "$CLEANUP_CUTOFF" ] 2>/dev/null; then
            rm -rf "$session_dir"
            CLEANED=$((CLEANED + 1))
        fi
    done
    log "Session cleanup: removed $CLEANED old agent sessions"
fi

# ── Agent Dashboard Sync ─────────────────────────────────────────────────────
# Parse session-log.md → agent_runs.json, then push to Replit dashboard.
WORKSPACE_ROOT="$(dirname "$AGENTS_DIR")"
DASHBOARD_DIR="$WORKSPACE_ROOT/projects/agent-dashboard"
REPLIT_SSH_KEY="$HOME/.ssh/replit"
REPLIT_HOST="${AGENT_DASHBOARD_HOST:-}"  # Set in ~/.zshrc: export AGENT_DASHBOARD_HOST="user@host.repl.co"

if [ -f "$DASHBOARD_DIR/parse_agents.py" ]; then
    log "Syncing agent dashboard..."
    python3 "$DASHBOARD_DIR/parse_agents.py" \
        --log "$WORKSPACE_ROOT/Knowledge/session-log.md" \
        --out "$DASHBOARD_DIR/agent_runs.json" \
        >> "$LOG_DIR/dashboard_sync.log" 2>&1

    if [ -n "$REPLIT_HOST" ] && [ -f "$REPLIT_SSH_KEY" ]; then
        scp -i "$REPLIT_SSH_KEY" -o StrictHostKeyChecking=no -o ConnectTimeout=10 \
            "$DASHBOARD_DIR/agent_runs.json" \
            "$REPLIT_HOST:/home/runner/workspace/agent_runs.json" \
            >> "$LOG_DIR/dashboard_sync.log" 2>&1 \
            && log "Dashboard synced to Replit ✅" \
            || log "Dashboard Replit sync failed (JSON updated locally)"
    else
        log "Dashboard JSON updated locally (AGENT_DASHBOARD_HOST not set — skipping Replit push)"
    fi
fi

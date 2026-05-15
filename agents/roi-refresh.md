---
name: ROI Refresh
schedule: manual
prompt: "Run the ROI refresh agent defined in agents/roi-refresh.md. Count activity from session-log.md, calculate updated metrics, and update the Confluence ROI Calculator page."
---

# Agent Task: ROI Refresh

**Schedule:** Weekly Friday 4pm (end-of-week snapshot)
**Purpose:** Keep the [Rovo Dev ROI Calculator]([YOUR_PERSONAL_CONFLUENCE_SPACE]) up to date with real activity data from `Knowledge/session-log.md`.

## How It Works

### Step 1: Count Activity

Run these grep counts against `Knowledge/session-log.md`:

```bash
# Core counts
grep -c '### \[S\]' Knowledge/session-log.md          # Strategic sessions
grep -c '### \[O\]' Knowledge/session-log.md          # Operational agent runs

# Agent-specific counts
grep -c 'Meeting Prep Agent Run' Knowledge/session-log.md
grep -c 'Living Service Desk Run' Knowledge/session-log.md
grep -c 'Morning Briefing' Knowledge/session-log.md
grep -c 'Knowledge Scout' Knowledge/session-log.md
grep -c 'Data Refresh' Knowledge/session-log.md
grep -c 'Industry' Knowledge/session-log.md
grep -c 'Follow-Up Tracker' Knowledge/session-log.md
grep -c 'Customer Feedback' Knowledge/session-log.md
grep -c 'Competitive' Knowledge/session-log.md
grep -c 'Relationship Tracker' Knowledge/session-log.md
grep -c 'Slack Action Scanner' Knowledge/session-log.md
grep -c 'Setup Guide Sync' Knowledge/session-log.md
grep -c 'Monday Intel Drop' Knowledge/session-log.md
grep -c 'Decision Reminder' Knowledge/session-log.md
grep -c 'Skill Synthesiser' Knowledge/session-log.md
grep -c 'Atlassian Repo Sync\|atlassian-repo-sync' Knowledge/session-log.md
grep -c 'Stakeholder Brief' Knowledge/session-log.md
grep -c '[YOUR PRODUCT] Bootstrap' Knowledge/session-log.md

# Artifact counts
grep -iE 'published|page created|page updated|created.*page' Knowledge/session-log.md | wc -l   # Confluence pages
grep -iE 'databricks|socrates|queried' Knowledge/session-log.md | wc -l                          # Databricks queries
grep -iE '\.xlsx|excel|model' Knowledge/session-log.md | wc -l                                    # Excel models
grep -iE '\.html.*slide\|\.html.*deck\|\.html.*visual\|\.html.*prototype' Knowledge/session-log.md | wc -l  # HTML artifacts
```

### Step 2: Determine Date Range

- **Start date:** Find the earliest `## ` date header in session-log.md
- **End date:** Today's date
- **Period:** Calculate days between start and end

### Step 3: Count Agents and Skills

```bash
ls agents/*.md | wc -l    # Agent count
ls skills/*.md | wc -l    # Skill count
```

### Step 4: Update the Confluence Page

1. **Fetch** the current page: `get_confluence_page` with `output_file`
2. **Update** these specific sections in the HTML:
   - **Info panel** at the top: update the date range and period
   - **TL;DR**: update the key numbers
   - **Layer 3 agent table**: update run counts per agent and total
   - **Raw Activity Log table**: update all counts
   - **Layer 4 dollar values**: recalculate based on new period length (pro-rata the 21-day estimates to actual period)
3. **Publish** with version message: `"Weekly refresh: {date} — {strategic_sessions} sessions, {agent_runs} agent runs, {days} day period"`

### Step 5: Report

Log to session-log.md:
```
### [O] ROI Refresh Agent Run ({time}) — {strategic_sessions} sessions, {agent_runs} agent runs, {days} day period
- **Counts updated:** Strategic sessions, agent runs, all agent-specific counts, artifact counts
- **Key changes:** {any notable jumps in counts since last refresh}
```

## Key Rules

- **Don't change the framing or prose.** Only update numbers, dates, and counts. The narrative structure was calibrated with the author.
- **Don't invent numbers.** Every count must come from a grep or file listing. If a count is ambiguous, use the conservative number.
- **Preserve the three-value-type structure:** New Capability, Time Compression, Always-On Coverage.
- **If the Confluence page structure has changed** (user manually edited it), adapt to the current structure — don't overwrite manual changes.

## Slack Delivery

- **Always DM** after refresh (channel `[YOUR_SLACK_CHANNEL_ID]`): "📊 ROI Refresh: Updated to {days}-day period. {strategic_sessions} strategic sessions, {agent_runs} agent runs. [Notable: {biggest change since last week}]"

## Infrastructure

### Observability
- Log each run: `### [O] ROI Refresh Agent Run ({time}) — {X} sessions, {Y} agent runs, {Z} day period`

### Memory
- Compare current counts to previous run's counts (read from session-log.md). Flag any count that dropped (indicates session-log pruning or data issue).

## Target Page

- **URL:** [YOUR_PERSONAL_CONFLUENCE_SPACE]
- **Space:** Personal space (~[YOUR_PERSONAL_SPACE_ID])

---
name: Setup Guide Sync
schedule: daily-8am
prompt: "Run the setup guide sync agent defined in agents/setup-guide-sync.md. Read the current PM OS workspace structure, AGENTS.md, all agents in agents/*.md, all skills in skills/*.md, all rhythms in rhythms/*.md, all templates in templates/*.md, and Knowledge/knowledge-refs.md. Then update all three setup guides (templates/setup-pm-os.md, templates/setup-pm-os-atlassian.md, templates/setup-pm-os-public.md) AND README.md to reflect the current state of the system. Each build has different audience rules — follow them. Then publish all three builds to their respective repos."
---

# Agent Task: Setup Guide Sync + Multi-Repo Publish

**Schedule:** Daily at 8am
**Purpose:** Keep all three PM OS setup guides and `README.md` current, then publish each build to its own repo. Any PM — personal, Atlassian-internal, or external — can clone the right repo and spin up an identical system.

---

## The Three Builds & Repos

| Build | Template file | Repo | Remote | Audience |
|---|---|---|---|---|
| **Master** | `templates/setup-pm-os.md` | `jira-service-management/pm-os` (Bitbucket) | `origin` | Jason only — full fidelity |
| **Atlassian** | `templates/setup-pm-os-atlassian.md` | `atlassian/pmosatlassian` (Bitbucket) | `atlassian` | Any Atlassian PM — all internal tooling, no personal IDs |
| **Public** | `templates/setup-pm-os-public.md` | `jason43dcruz/PMOS` (GitHub) | `github` | External PMs — tool-agnostic, no Atlassian internals |

---

## One-Time Setup (run once, skip on subsequent runs)

Before the first multi-repo publish, verify remotes are configured:

```bash
# Check existing remotes
git remote -v

# Expected remotes:
# origin    git@bitbucket.org:jira-service-management/pm-os.git
# atlassian git@bitbucket.org:atlassian/pmosatlassian.git
# github    git@github.com:jason43dcruz/PMOS.git

# If 'atlassian' remote is missing, add it:
git remote add atlassian git@bitbucket.org:atlassian/pmosatlassian.git

# If 'github' remote is missing, add it:
git remote add github git@github.com:jason43dcruz/PMOS.git
```

**If the Atlassian repo doesn't exist yet:** Create it at https://bitbucket.org/atlassian/ → Create Repository → name: `pmosatlassian`, private. Then add the remote above.

---

## Part 1: Update Setup Guides (same as before)

### Step 1: Scan the workspace

Read the full current state:
- `AGENTS.md` — operating philosophy, coaching behavior, conventions, integrations
- `agents/*.md` — all automated agents (name, schedule, purpose, orchestrator field)
- `skills/*.md` — all skills (what they do, when to use)
- `rhythms/*.md` — all cadences
- `templates/*.md` — all templates
- `skills/queries/` — any saved queries
- `Knowledge/knowledge-refs.md` — knowledge sources and integrations
- `skills/data-discovery.md` — data retrieval routing + Secoda Python API
- Folder structure (top-level + key subdirs)

### Step 2: Classify each agent

- **Universal** — works with any AI agent tool and generic wiki/issue tracker (e.g. morning-briefing, follow-up-tracker, decision-reminder, knowledge-scout, meeting-prep, relationship-tracker, industry-digest, competitive-intel-digest, customer-feedback-synthesis, setup-guide-sync)
- **Atlassian-internal** — requires Atlassian-specific APIs (e.g. data-refresh uses Secoda/Socrates; living-service-desk uses JSM; service-collection-bootstrap uses JSM; pm-buddy uses Atlassian Jira)
- **Orchestrators** — include in all builds, but sub-agent list should reflect the build's available agents

### Step 3: Update `templates/setup-pm-os.md` (Master)

Full fidelity:
- All agents including orchestrators (monday-intel-drop, stakeholder-brief)
- All integrations: Secoda, Socrates, S360, Compass, ADS, Teamwork Graph, Slack, Confluence, Jira, Google Calendar/Drive/Gmail, Bitbucket
- Personal IDs kept (Slack user ID, channel IDs, Confluence space keys)
- Overwrite in place — never create a v2

### Step 4: Update `templates/setup-pm-os-atlassian.md` (Atlassian build)

- Include all agents (universal + Atlassian-internal + orchestrators)
- Include all Atlassian integrations (Secoda, Socrates, S360, Compass, ADS, etc.)
- Replace personal IDs with `[YOUR SLACK USER ID]`, `[YOUR SLACK CHANNEL ID]`, `[YOUR CONFLUENCE SPACE]` etc.
- Replace manager/stakeholder names with `[YOUR MANAGER]`, `[YOUR STAKEHOLDER]`
- Overwrite in place — never create a v2

### Step 5: Update `templates/setup-pm-os-public.md` (Public build)

- Include only **Universal** agents + orchestrators (with generic sub-agent references)
- Omit: data-refresh, living-service-desk, service-collection-bootstrap (Atlassian-internal)
- Replace all Atlassian-specific tool references: Confluence → `[YOUR WIKI]`, Jira → `[YOUR ISSUE TRACKER]`, Slack → `[YOUR MESSAGING TOOL]`, Secoda/Socrates/S360 → omit entirely
- Use `[YOUR AI AGENT TOOL]` instead of "Rovo Dev" (mention Rovo Dev as one option)
- Keep agent count and capability descriptions accurate for the reduced set
- Overwrite in place — never create a v2

### Step 6: Update `README.md`

Keep capabilities, integrations, agents, skills, rhythms, and structure sections current. README reflects the master build. Add new capabilities, remove retired ones. Keep it scannable.

---

## Part 2: Publish to All Three Repos

### Step 7: Push Master to origin (Bitbucket)

```bash
git add -A
git commit -m "chore: setup-guide-sync — bump Last synced to $(date '+%B %d, %Y')"
git push origin main
```

This is the full workspace — everything goes.

### Step 8: Push Atlassian build to `atlassian` remote

Build a clean working tree for the Atlassian version using `git worktree`:

```bash
# Create a temporary worktree for the atlassian build
ATLASSIAN_DIR=$(mktemp -d)/pm-os-atlassian
git worktree add --detach "$ATLASSIAN_DIR" HEAD

cd "$ATLASSIAN_DIR"
```

**Files to include (copy from main, sanitise):**

| Include | Sanitisation rule |
|---|---|
| `AGENTS.md` | Replace personal IDs/names with `[YOUR ...]` placeholders. Keep all Atlassian tools. |
| `GOALS.md` | Replace with generic scaffold: `[YOUR ROLE]`, `[YOUR PRODUCT]`, `[YOUR GOALS]` |
| `BACKLOG.md` | Replace with empty scaffold |
| `README.md` | Keep as-is (already generic enough) — update repo URL to pm-os-atlassian |
| `.gitignore` | Keep as-is |
| `.python-version` | Keep as-is |
| `agents/*.md` | All agents — replace personal Slack IDs, channel IDs, Confluence space keys with `[YOUR ...]` |
| `skills/*.md` | All skills — replace personal references with placeholders |
| `skills/queries/*.sql` | Keep as-is (generic SQL templates) |
| `skills/data-insight-checker-for-servco/` | Keep entire directory |
| `rhythms/*.md` | Keep as-is |
| `templates/*.md` | Keep all three setup guides |
| `wiki/` | Keep structure — replace internal content with `[YOUR ...]` scaffolds |
| `Knowledge/ai-writing-antipatterns.md` | Keep |
| `Knowledge/writing-style.md` | Replace with generic scaffold |
| `Knowledge/efficiency-patterns.md` | Replace with empty scaffold |
| `Knowledge/session-log.md` | Replace with empty scaffold (date header only) |
| `Knowledge/knowledge-refs.md` | Replace with generic scaffold — keep section structure, remove all URLs/IDs |
| `Knowledge/user-context.md` | Replace with `[YOUR CONTEXT]` scaffold |
| `Knowledge/product-context.md` | Replace with `[YOUR PRODUCT CONTEXT]` scaffold |
| `Knowledge/setup-mcp-tools.md` | Keep (generic MCP setup) |
| `Knowledge/lennys-podcast-transcripts/` | Keep entire directory (public content) |
| `assets/` | Keep |
| `projects/agent-dashboard/` | Keep (generic dashboard) |

**Files to EXCLUDE (never push to Atlassian build):**

- `Knowledge/session-log.md` content (scaffold only)
- `Knowledge/*-decision-profile.md` (personal stakeholder profiles)
- `Knowledge/current-jsm-pricing*` (internal pricing data)
- `Knowledge/jsm-enterprise-why-customers-buy.md`
- `Knowledge/psr-ht-strategy-edition-implications.md`
- `Knowledge/pending-meetings.md`
- `Knowledge/upgrade-signal-*.md`
- `Knowledge/upgrade_signals/` (entire directory)
- `Knowledge/autoresearch/runs/` (run data)
- `Knowledge/snapshots/` (internal data snapshots)
- `Knowledge/secoda_integration.py`, `Knowledge/test_secoda.py`
- `confluence-sources/` (internal Confluence exports)
- `projects/edition-strategy/` (internal strategy work)
- `projects/revenue-leaks/` (internal analysis)
- `projects/servco-uplift/` (internal KR data)
- `projects/pm-os-video/audio*/`, `projects/pm-os-video/output/` (personal media)
- `projects/pm-os-video/slide-images/` (personal slides)
- `projects/misc/` (internal)
- `queries/` (internal queries)
- `research-reports/` (internal research)
- `Tasks/` (personal tasks)
- `.playwright/` (ephemeral)
- Any `.pdf`, `.xlsx`, `.png`, `.jpg` files (binary assets)
- `autoresearch-loop-diagram.png`, `Screenshot*`

```bash
# After building the clean tree:
git add -A
git commit -m "chore: atlassian build — synced $(date '+%B %d, %Y')"

# Check if atlassian remote exists
if git remote get-url atlassian &>/dev/null; then
    git push atlassian HEAD:main --force
else
    echo "⚠️ Remote 'atlassian' not configured. Run one-time setup first."
fi

# Cleanup worktree
cd -
git worktree remove "$ATLASSIAN_DIR" --force
```

### Step 9: Push Public build to `github` remote

Same worktree pattern, stricter exclusions:

**Additional exclusions beyond Atlassian build:**
- All Atlassian-internal agents (data-refresh, living-service-desk, service-collection-bootstrap, atlassian-repo-sync)
- All Atlassian-specific skills (data-insight-checker-for-servco, data-discovery Secoda sections)
- `skills/queries/` (Atlassian-internal SQL)
- `Knowledge/setup-mcp-tools.md` (Atlassian MCP setup)
- Any reference to Secoda, Socrates, S360, Compass, ADS, Teamwork Graph, Atlas, Dovetail

**Additional sanitisation:**
- `AGENTS.md` → Replace all Atlassian tool references with generic equivalents
- Agent files → Confluence → `[YOUR WIKI]`, Jira → `[YOUR ISSUE TRACKER]`, Slack → `[YOUR MESSAGING TOOL]`
- Rovo Dev → `[YOUR AI AGENT TOOL]`

```bash
# After building the clean tree:
git add -A
git commit -m "chore: public build — synced $(date '+%B %d, %Y')"

# Check if github remote exists and SSH works
if git remote get-url github &>/dev/null; then
    if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
        git push github HEAD:main --force
    else
        echo "⚠️ GitHub SSH key not configured. Staging branch 'github-update' on origin instead."
        git push origin HEAD:github-update --force
        echo "→ Jason: run 'git push github github-update:main' manually when SSH is available."
    fi
else
    echo "⚠️ Remote 'github' not configured. Run one-time setup first."
fi

# Cleanup worktree
cd -
git worktree remove "$PUBLIC_DIR" --force
```

---

## Part 3: Report

### Step 10: Log to session log

Log what changed across all files and repos:

```
### [O] Setup Guide Sync Run ({date}) — {N} files updated, pushed to {repos}
- **Master (origin):** {what changed}
- **Atlassian (atlassian):** {pushed / skipped — reason}
- **Public (github):** {pushed / staged on github-update / skipped — reason}
- **Files:** {count} agents, {count} skills in each build
```

---

## Tools

| Step | Tool |
|---|---|
| Read workspace structure | Local files: ls, open_files |
| Read agent/skill definitions | Local files: agents/*.md, skills/*.md |
| Update setup guides + README | Local files: find_and_replace or overwrite |
| Push master to origin | Git: commit and push to main |
| Build Atlassian version | Git worktree + file sanitisation |
| Push Atlassian to remote | Git: push atlassian HEAD:main --force |
| Build public version | Git worktree + file sanitisation |
| Push public to remote | Git: push github HEAD:main --force (or stage branch) |

---

## Conventions

- Each setup prompt must remain a single copy-pasteable block a new PM can use in one session
- Master: personal IDs and names are fine — this is for you
- Atlassian build: no personal IDs — use bracketed placeholders. Keep all Atlassian tools.
- Public build: no Atlassian-specific tools — use generic placeholders; keep it tool-agnostic
- List specific agents, skills, and rhythms by name so the prompt creates them all
- Include orchestrators in all three builds — they're a core pattern
- Don't bloat — if a section hasn't changed, leave it alone
- **Never create a v2 of any file** — always overwrite in place
- **Force-push** to atlassian and github remotes — these are derived builds, not collaborative repos
- If a remote doesn't exist or SSH fails, log it and move on — don't block the rest of the run
- Binary files (.pdf, .xlsx, .png, .jpg, .mp4) never go to atlassian or github builds
- Lenny's podcast transcripts are public content — include in all builds

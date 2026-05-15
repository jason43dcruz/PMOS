# PM-OS Setup Guide (Master)

Set up your PM operating system in one session. This is the **master build** — full fidelity, all agents, all integrations, personal IDs. This is your system.

## Prerequisites

1. **Rovo Dev** — VS Code extension or CLI (`acli rovodev run`)
2. **Git repo** — Bitbucket workspace for version control
3. **Atlassian account** — Confluence (hello.atlassian.net), Jira, Slack
4. **Secoda API key** — for data catalogue integration
5. **Demo JSM site** — jason-jsm.atlassian.net (for living-service-desk and service-collection-bootstrap agents)

## Setup Guide Variants

| File | Who it's for |
|------|-------------|
| `setup-pm-os.md` (this file) | **You** — rebuilds your exact PMOS with all conventions baked in |
| `setup-pm-os-atlassian.md` | **Any Atlassian PM** — full toolset with generic placeholders |
| `setup-pm-os-public.md` | **Any PM** — tool-agnostic, no Atlassian-internal tools |

## Quick Start

Open a Rovo Dev session and paste this prompt. The wizard will ask you questions one at a time and create everything with your real values — no brackets to fill in.

```
Set up my PM Operating System.

You are an interactive setup wizard. Follow these steps exactly:

## Step 1: Ask me these questions ONE AT A TIME

Wait for my answer before asking the next question. If I say "skip", mark it as TODO and move on.

1. What's your full name?
2. What's your timezone? (e.g. Australia/Melbourne, America/New_York)
3. What product do you own or work on?
4. Who is your manager? (first name is fine)
5. What are your top 3 priorities right now? (one sentence each)
6. Who are your 3–5 key stakeholders? (names and roles)
7. What are your top 3 competitors to track?
8. What's your Slack user ID? (click your profile → "Copy member ID" — or say "skip")
9. What Slack channel should briefings go to? (channel ID or name — or say "skip")
10. What's your personal Confluence space key? (or say "skip")
11. What's your primary Jira project key? (or say "skip")

## Step 2: Create the core files

Using the answers above, create these files:

**AGENTS.md** — Use the full template below. Fill in name, timezone, role, manager, product, stakeholders, Slack IDs, Confluence space, Jira project.

**GOALS.md** — Fill in priorities from the answers. Leave vision and OKR sections as TODO if they weren't answered.

**Knowledge/session-log.md** — Create with today's date and a first entry: "PM OS initialized."

**Knowledge/knowledge-refs.md** — Create with sections: Key Docs, Slack Channels, Data Sources. Leave links as TODO.

**Knowledge/user-context.md** — Fill in name, Slack ID, Confluence space, Jira project, timezone.

**Knowledge/product-context.md** — Fill in product, stakeholders, competitors.

**Knowledge/efficiency-patterns.md** — Create with one starter entry: "No known failure patterns yet. Update as failures are discovered."

**BACKLOG.md** — Create as empty list.

## Step 3: Create the agent files

Create all 24 agent files in agents/ with frontmatter:

```yaml
---
name: [Agent Name]
schedule: [schedule]
prompt: "[Full prompt for the agent]"
---
```

Agents to create:

Daily (8am):
- morning-briefing — Orchestrator: fans out to follow-up-tracker, meeting-prep, decision-reminder. Synthesises into one prioritised daily summary with confidence tags.
- follow-up-tracker — Scans Confluence pages from key stakeholders (Anand, Eleanor, Matt, Mark) for action items. Deduplicates against BACKLOG.md.
- knowledge-scout — Scans Slack channels and Confluence spaces for docs relevant to GOALS.md. Curates knowledge-refs.md.
- data-refresh — Checks Secoda docs for staleness (>7 days). Re-runs SQL, publishes to Confluence. Only Slacks if something changed.
- setup-guide-sync — Scans full workspace. Updates all three setup guides + README. Pushes to main.
- industry-digest — Scans sources for PM/industry news. Delivers top 3 reads + data point + provocation via Slack DM.

Hourly:
- living-service-desk — Creates and updates realistic tickets on demo JSM site (jason-jsm.atlassian.net). [Optional]
- meeting-prep — Checks calendar for meetings in next 60 min. Sends prep via Slack DM 15–30 min before.

Every 2 hours (work hours):
- slack-action-scanner — Scans Slack DMs for meeting requests and commitments. Queues to pending-meetings.md (never auto-books). Adds tasks to BACKLOG.md.

Weekly Monday (8am):
- customer-feedback-synthesis — Synthesises VOC from Jira, Slack, Secoda, Confluence. Themed brief with confidence tags.
- competitive-intel-digest — Monitors competitors for product/pricing moves. Ranked digest via Slack DM.
- relationship-tracker — Tracks interactions with key stakeholders. Scores health (🟢/🟡/🔴).
- monday-intel-drop — Orchestrator: fans out to Competitive Intel, Industry Digest, Knowledge Scout, Customer Feedback Synthesis. Synthesises into one start-of-week briefing.
- wiki-refresh — Fetches live Confluence pages, compares against LLM wiki, re-compiles changed topics, republishes synthesis.
- atlassian-repo-sync — Checks `atlassian/ds-agent-starter-kit` on Bitbucket for new/updated skills. Syncs changed skill files locally and updates data-discovery.md if approved tables change.

Weekly Friday (4pm):
- decision-reminder — Scans for open DACIs/LDRs/RFCs. Nudges on stale decisions (>14 days).
- skill-synthesiser — Reviews last 7 days of session log. Writes or updates skill files for recurring workflows.
- efficiency-audit — Analyses session log for wasted iterations, dead-end patterns, and recurring failures. Scores efficiency.
- upgrade-signal-researcher — Orchestrates unattended upgrade-signal autoresearch via Databricks notebooks.
- ai-brand-builder — Reviews the week's work and external AI PM content. Drafts 2–3 content packages (LinkedIn/Slack posts + optional long-form). Suggest only — never auto-posts.

Manual:
- pm-buddy — PM sparring partner. Strategy, product sense, execution pressure-test. Uses Lenny transcripts.
- stakeholder-brief — Orchestrator: fans out to Relationship Tracker, Decision Reminder, Knowledge Scout. Synthesises into pre-meeting brief.
- service-collection-bootstrap — One-time setup of a complete JSM demo site. [Optional]
- roi-refresh — Updates ROI Calculator Confluence page with fresh counts of strategic sessions, agent runs, and artifacts from session log.

For each agent, use the agent template in Step 4 and personalise with your values.

## Step 4: Create the skill files

Create all 29 skill files in skills/ with a description header and trigger line.

- write-like-me — Voice enforcement: first person, conversational, short paragraphs, specific phrases
- think-like-me — PM mental models: where to play, how to win, prioritisation, decisions under uncertainty
- review-pm-doc — Structured doc critique with Lenny transcripts + Atlassian context. Posts Confluence comments.
- draft-stakeholder-comm — Audience-calibrated comms for manager/eng/leadership/customers
- resolve-stakeholder-comments — Process stakeholder feedback from email/Slack/Confluence
- data-to-narrative — Convert query results → headline → context → evidence → so what → next
- html-deck-style-guide — Full design system for HTML decks (Official + Flashy styles, typography, tokens, JS nav)
- html-deck-to-pdf — Convert HTML slide deck to page-per-slide PDF via headless browser
- data-discovery — Source routing (S360→Secoda→Socrates), known tables, query templates, async workflow
- analysis-artifacts — Full artifact chain after any data analysis: Databricks notebook → Lakeview dashboard → Confluence page
- l1-okr-scoring — Monthly OKR scoring rules, data sources, milestone targets, Confluence update workflow
- prep-1-1-anand — Weekly 1:1 prep: Eisenhower matrix on Confluence with ADF formatting + status lozenges
- apply-confluence-comments — Apply inline/footer comments from a page: interprets intent, applies changes
- browser-copilot — Live browser via playwright-cli: admin workflows, API escape hatch, screen capture
- create-agent — Add new automated agents: frontmatter pattern, schedule options, conventions
- create-excel-model — Build real .xlsx financial models with openpyxl
- update-edition-strategy — Update edition strategy Confluence pages: layer structure, data sourcing
- slide-creation — End-to-end pipeline for HTML slide decks with AI-generated visuals
- video-creation — Complete pipeline for narrated videos — HTML decks, browser walkthroughs, or both
- make-video — Generate narrated explainer videos from a script and screenshots using Kokoro TTS and ffmpeg
- daily-coaching — Daily focus recommendations (3 tasks max), backlog clearing, goal alignment
- strategy-sparring — 10 moves for pressure-testing strategy docs, ordered by intensity
- prototyping — Interactive HTML prototypes — sliders, calculators, rubrics, comparison tools
- replit-integration — SSH-based deployment to Replit for public-facing prototypes and dashboards
- design-prototyping — Full product prototypes on Atlassian staging with Atlaskit, AI Gateway
- forge-apps — Build and deploy Forge apps to real Jira/JSM sites
- in-session-orchestration — Fan out work to multiple sub-agents in parallel within a live session
- autoresearch — Converts plain-English research questions into spec YAML, drives cohort_builder.py + engine.py for ServCo/JSM customer analysis
- data-insight-checker-for-servco — Sense-checks ServCo data insights against approved tables, metric definitions, causality rules

## Step 5: Create the rhythm files

Create 4 rhythm files in rhythms/:
- daily-check.md — Daily: check Slack, Confluence mentions, context, responses needed, blockers
- weekly-review.md — Weekly: process backlog, review goals, scan tasks, plan next week, memory hygiene
- weekly-1-1-anand.md — Weekly: 1:1 prep with Eisenhower matrix and status updates
- monthly-l1-okr-update.md — Monthly: pull metrics from Atlas + SQL, score KRs, update Confluence

## Step 6: Confirm

When everything is created, list all files created, confirm counts match (24 agents, 28 skills, 4 rhythms), and ask: "Ready to push to git?"
```

## Agent Infrastructure

All 24 agents follow shared patterns:
- **Confidence scoring:** Tag outputs with [HIGH], [MEDIUM], [LOW]
- **Memory & deduplication:** Read previous output before generating. Don't resurface unless materially updated. Flag recurring items (3+ days).
- **Observability:** Log every run to Knowledge/session-log.md with item counts and key metrics
- **Delivery:** Slack DM to channel `DFFF0J94G`
- **Scheduling:** launchd plist at `agents/com.pmos.agents.plist` — runs orchestrator hourly; 8am triggers daily agents

Schedule options: `daily-8am`, `hourly`, `every-2h-workhours`, `weekly-monday-8am`, `weekly-friday-4pm`, `manual`

## Agents (24)

| Agent | Schedule | Type | What it does |
|-------|----------|------|-------------|
| **morning-briefing** | Daily 8am | Orchestrator | Fans out to follow-up-tracker, meeting-prep, decision-reminder. Synthesises into one prioritised daily summary with confidence tags. |
| **follow-up-tracker** | Daily 8am | Standalone | Scans Confluence pages from key stakeholders (Anand, Eleanor, Matt, Mark) for action items. Deduplicates against BACKLOG.md. |
| **knowledge-scout** | Daily 8am | Standalone | Scans Slack channels and Confluence spaces for docs relevant to GOALS.md. Curates knowledge-refs.md. |
| **data-refresh** | Daily 8am | Standalone | Checks Secoda docs for staleness (>7 days). Re-runs SQL, publishes to Confluence. Only Slacks if something meaningfully changed. |
| **setup-guide-sync** | Daily 8am | Standalone | Scans full workspace. Updates all three setup guides + README to reflect current state. Pushes to main. |
| **industry-digest** | Daily 8am | Standalone | Scans Confluence, Atlassian docs, Slack, Secoda for PM/industry news. Delivers top 3 reads + data point + provocation. |
| **living-service-desk** | Hourly | Standalone | Creates and updates realistic tickets on demo JSM site (jason-jsm.atlassian.net). 1–2 new tickets + 2–3 updates per run. [Optional] |
| **meeting-prep** | Hourly | Standalone | Checks calendar for meetings in next 60 min. Gathers context from Confluence/Jira/Slack. Sends prep 15–30 min before. |
| **slack-action-scanner** | Every 2h | Standalone | Scans Slack DMs for meeting requests and commitments. Queues meeting requests to pending-meetings.md (never auto-books). Adds tasks to BACKLOG.md. |
| **customer-feedback-synthesis** | Weekly Mon 8am | Standalone | Synthesises VOC from Jira, Slack, Secoda, Confluence. Delivers themed brief with confidence tags. Publishes to Confluence. |
| **competitive-intel-digest** | Weekly Mon 8am | Standalone | Monitors ServiceNow, Zendesk, Freshworks, BMC, Ivanti, ManageEngine for product/pricing moves. Ranked digest via Slack DM. |
| **relationship-tracker** | Weekly Mon 8am | Standalone | Tracks interactions with key stakeholders across Slack/Calendar/Confluence/Jira. Scores health (🟢/🟡/🔴). |
| **monday-intel-drop** | Weekly Mon 8am | Orchestrator | Fans out to Competitive Intel, Industry Digest, Knowledge Scout, Customer Feedback Synthesis. Synthesises into one start-of-week briefing. |
| **wiki-refresh** | Weekly Mon 8am | Standalone | Fetches live Confluence edition strategy pages, compares against LLM wiki, re-compiles changed topics, refreshes synthesis, republishes to Confluence. |
| **atlassian-repo-sync** | Weekly Mon 8am | Standalone | Checks `atlassian/ds-agent-starter-kit` on Bitbucket for new or updated skills. Syncs changed skill files into local `skills/` and updates `data-discovery.md` if approved tables change. |
| **decision-reminder** | Weekly Fri 4pm | Standalone | Scans for open DACIs/LDRs/RFCs. Nudges on stale decisions (>14 days). Tracks decision velocity. |
| **skill-synthesiser** | Weekly Fri 4pm | Standalone | Reviews last 7 days of session log for recurring workflows. Decides if any are worth codifying into new/updated skills. |
| **efficiency-audit** | Weekly Fri 4pm | Standalone | Analyses session log for wasted iterations, dead-end patterns, and recurring failures. Scores efficiency and recommends optimisations. |
| **upgrade-signal-researcher** | Weekly Fri 4pm | Standalone | Orchestrates unattended upgrade-signal autoresearch via Databricks notebooks. Searches for interpretable signals that predict JSM Std → Premium upgrades. |
| **ai-brand-builder** | Weekly Fri 4pm | Standalone | Reviews the week's work and external AI PM content. Drafts 2–3 content packages (LinkedIn/Slack posts + optional long-form). Suggest only — never auto-posts. |
| **pm-buddy** | Manual | Standalone | PM sparring partner — strategy, product sense, execution pressure-test. Uses Lenny transcripts. One question at a time. |
| **stakeholder-brief** | Manual | Orchestrator | Fans out to Relationship Tracker, Decision Reminder, Knowledge Scout. Synthesises into pre-meeting brief. |
| **service-collection-bootstrap** | Manual | Standalone | One-time setup of a complete JSM demo site — 178 users, 3 service desks, ~200 tickets, 70+ KB articles, 3 asset schemas. [Optional] |
| **roi-refresh** | Manual | Standalone | Updates Rovo Dev ROI Calculator Confluence page with fresh counts of strategic sessions, agent runs, and artifacts from session log. |

## Skills (29)

| Skill | What it does |
|-------|-------------|
| **write-like-me** | Voice enforcement — first person, conversational, short paragraphs, your actual phrases |
| **think-like-me** | PM mental models — strategy, prioritisation, decisions under uncertainty, team dynamics |
| **review-pm-doc** | Structured doc critique with Lenny transcripts + Atlassian context. Posts Confluence comments. |
| **draft-stakeholder-comm** | Audience-calibrated comms for manager/eng/leadership/customers across all channels |
| **resolve-stakeholder-comments** | Process stakeholder feedback from email/Slack/Confluence — extract requests, map to goals, recommend next steps |
| **data-to-narrative** | Convert query results → headline → context → evidence → so what → next. Audience-calibrated. |
| **html-deck-style-guide** | Full design system for HTML decks (Official + Flashy styles, typography, tokens, JS nav) |
| **html-deck-to-pdf** | Convert HTML slide deck to page-per-slide PDF via headless browser export |
| **data-discovery** | Source routing (S360→Secoda→Socrates), known tables map, query templates, async workflow |
| **analysis-artifacts** | Full artifact chain after data analysis: Databricks notebook → Lakeview dashboard → Confluence page |
| **l1-okr-scoring** | Monthly OKR scoring — rules, data sources, milestone targets, Confluence update workflow |
| **prep-1-1-anand** | Weekly 1:1 prep — Eisenhower matrix on Confluence with ADF formatting + status lozenges |
| **apply-confluence-comments** | Apply your inline/footer comments from a page — interprets intent, applies changes, shows summary |
| **browser-copilot** | Live browser via playwright-cli — admin workflows, API escape hatch, screen capture, recordings |
| **create-agent** | Add new automated agents — frontmatter pattern, schedule options, conventions, Slack delivery |
| **create-excel-model** | Build real `.xlsx` financial models with openpyxl — Assumptions/Model/Waterfall sheets, colour coding, formula-only output |
| **update-edition-strategy** | Update edition strategy Confluence pages — layer structure, data sourcing, when to overwrite |
| **slide-creation** | End-to-end pipeline for HTML slide decks with AI-generated visuals; feeds into video-creation |
| **video-creation** | Complete pipeline for narrated videos — HTML decks, browser walkthroughs, or both |
| **make-video** | Generate narrated explainer videos from a script and screenshots using Kokoro TTS and ffmpeg |
| **daily-coaching** | Daily focus recommendations (3 tasks max), backlog clearing, goal alignment |
| **strategy-sparring** | 10 moves for pressure-testing strategy docs, ordered by intensity — reads source-of-truth docs first |
| **prototyping** | Interactive HTML prototypes — sliders, calculators, rubrics, comparison tools |
| **replit-integration** | SSH-based deployment to Replit for public-facing prototypes and dashboards [Experimental] |
| **design-prototyping** | Full product prototypes on Atlassian staging with Atlaskit, AI Gateway, and live URLs |
| **forge-apps** | Build and deploy Forge apps to real Jira/JSM sites |
| **in-session-orchestration** | Fan out work to multiple sub-agents in parallel within a live session (4× faster than sequential) |
| **autoresearch** | Converts plain-English questions into spec YAML, drives cohort_builder.py + engine.py for ServCo/JSM analysis |
| **data-insight-checker-for-servco** | Sense-checks data insights against approved tables, metric definitions, causality rules, population filters |

## Rhythms (4)

| Rhythm | Frequency | What it does |
|--------|-----------|-------------|
| **daily-check** | Daily | Check Slack channels, Confluence mentions, recent context, responses needed, blockers |
| **weekly-review** | Weekly | Process backlog, review goals, scan tasks, plan next week, kernel evolution check, memory hygiene |
| **weekly-1-1-anand** | Weekly | Eisenhower matrix 1:1 prep on Confluence with status lozenges (Need Input / Important note / FYI) |
| **monthly-l1-okr-update** | Monthly | Pull metrics from Atlas + SQL, score KRs (0.7–1.0), update Confluence scoring page |

## After Setup

1. Fill in `GOALS.md` with real priorities — link to your OKRs or strategy doc
2. Customise `AGENTS.md` — role, timezone, Slack IDs, conventions
3. Create your first task: `Tasks/[task-name].md`
4. Add a project brief: `projects/[project-name]/brief.md`
5. Populate `Knowledge/knowledge-refs.md` with links to your key docs
6. Set up Secoda: paste API key into `Knowledge/secoda_integration.py`
7. Activate the schedule:
   ```bash
   cp agents/com.pmos.agents.plist ~/Library/LaunchAgents/
   launchctl load ~/Library/LaunchAgents/com.pmos.agents.plist
   launchctl list | grep pmos  # verify
   ```
8. Test: `bash agents/run-agents.sh all`

## Design Principles

- **Chats are disposable. Files are permanent.** Start a new chat for every task. Your Knowledge/ folder persists.
- **AI drafts, humans steer.** The agent handles research and formatting. You handle insight and decisions.
- **Bias to action.** Shipping beats planning. An imperfect decision today beats a perfect one next month.
- **Engineering time is the scarcest asset.** Every feature request earns its place.
- **Often wrong, never in doubt.** Move forward confidently; course-correct when needed.
- **Never create a v2.** Always overwrite in place. One source of truth.

*Last synced: May 15, 2026*

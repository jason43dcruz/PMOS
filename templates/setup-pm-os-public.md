# PM Operating System — Setup Guide (Public)

A personal operating system for Product Managers, powered by AI agents. Built on markdown and your AI agent tool of choice.

This guide works with any AI agent tool — [Rovo Dev](https://developer.atlassian.com/platform/rovo/dev/), Cursor, Claude Desktop, Copilot, or similar. Replace all `[PLACEHOLDER]` values with your own details.

For the Atlassian-internal version (with S360, Secoda, Socrates, Compass, ADS, Teamwork Graph, Atlas, Dovetail), see `setup-pm-os-atlassian.md`.

## Prerequisites

1. **[YOUR AI AGENT TOOL]** — e.g. Rovo Dev, Cursor, Claude Desktop, Copilot
2. **Git repo** — any host (GitHub, GitLab, Bitbucket)
3. **[YOUR WIKI]** — Confluence, Notion, Coda, or any wiki tool
4. **[YOUR ISSUE TRACKER]** — Jira, Linear, Asana, GitHub Issues, or similar
5. **[YOUR MESSAGING TOOL]** — Slack, Teams, or similar

### Optional Integrations

| Integration | What it enables |
|---|---|
| **[YOUR WIKI]** | Read/create/update docs, search, agent delivery |
| **[YOUR ISSUE TRACKER]** | Read/create/update issues, search |
| **[YOUR MESSAGING TOOL]** | Send messages, read channels, agent delivery |
| **Google Calendar** | Read events, check availability, meeting prep |
| **Google Drive / Gmail** | Read/create docs, search email threads |

## Quick Start

Paste this prompt into a new [YOUR AI AGENT TOOL] session. The wizard asks questions one at a time and scaffolds everything.

```
Set up my PM Operating System.

You are an interactive setup wizard. Follow these steps exactly:

## Step 1: Ask me these questions ONE AT A TIME

Wait for my answer before asking the next question. If I say "skip", mark it as TODO and move on.

1. What's your full name?
2. What's your timezone? (e.g. America/New_York, Europe/London, Australia/Melbourne)
3. What product or area do you own or work on?
4. Who is your manager? (first name is fine)
5. What are your top 3 priorities right now? (one sentence each)
6. Who are your 3–5 key stakeholders? (names and roles)
7. What are your top 3 competitors to track?
8. What messaging tool do you use? (Slack, Teams, etc.)
9. What wiki tool do you use? (Confluence, Notion, Coda, etc.)
10. What issue tracker do you use? (Jira, Linear, Asana, etc.)
11. What AI agent tool are you using right now?

## Step 2: Create the core files

Using your answers, create:

**AGENTS.md** — AI coach and advisor persona. Include: name, timezone, role, manager, product, stakeholders. Conventions:
- Read session-log.md and efficiency-patterns.md at the start of every session
- Bias to action — shipping beats planning
- One question at a time when sparring
- Never create a v2; always overwrite in place
- Suggest no more than 3 focus tasks per day
- Deliver agent output via [YOUR MESSAGING TOOL]

**GOALS.md** — Current role, 6-month success criteria, 5-year north star, active focus areas, P0–3 priority framework.

**Knowledge/session-log.md** — Memory across sessions. Read at session start, update at session end.

**Knowledge/knowledge-refs.md** — Curated links: key wiki pages, project boards, data sources, messaging channels.

**Knowledge/user-context.md** — Your name, messaging ID, wiki space, issue tracker project, timezone.

**Knowledge/product-context.md** — Product, stakeholders, current focus, meeting cadences.

**Knowledge/efficiency-patterns.md** — Known failure modes, infrastructure constraints, retry limits.

**BACKLOG.md** — Unprocessed items, cleared weekly.

## Step 3: Create the agent files (17 agents)

Create all agent files in agents/ with frontmatter (name, schedule, prompt).

Daily (8am):
- morning-briefing — Orchestrator: fans out to follow-up-tracker, meeting-prep, decision-reminder. Synthesises into one prioritised daily summary with confidence tags [HIGH/MEDIUM/LOW].
- follow-up-tracker — Scans [YOUR WIKI] pages from key stakeholders for action items. Deduplicates against BACKLOG.md. Sends summary.
- knowledge-scout — Scans [YOUR MESSAGING TOOL] channels and [YOUR WIKI] spaces for docs relevant to GOALS.md. Curates knowledge-refs.md.
- setup-guide-sync — Scans full workspace. Updates all setup guides + README to reflect current state. Pushes to main.
- industry-digest — Scans sources for PM/industry news. Delivers top 3 reads + data point + provocation via [YOUR MESSAGING TOOL].

Hourly:
- meeting-prep — Checks calendar for meetings in next 60 min. Gathers context from [YOUR WIKI]/[YOUR ISSUE TRACKER]. Sends prep via [YOUR MESSAGING TOOL].

Every 2 hours (work hours):
- slack-action-scanner — Scans [YOUR MESSAGING TOOL] DMs for meeting requests and commitments. Queues to pending-meetings.md (never auto-books). Adds tasks to BACKLOG.md.

Weekly Monday (8am):
- customer-feedback-synthesis — Synthesises VOC from [YOUR ISSUE TRACKER], [YOUR MESSAGING TOOL], [YOUR WIKI]. Themed brief with confidence tags.
- competitive-intel-digest — Monitors competitors for product/pricing moves via web search. Ranked digest via [YOUR MESSAGING TOOL].
- relationship-tracker — Tracks interactions with key stakeholders. Scores health (🟢/🟡/🔴).
- monday-intel-drop — Orchestrator: fans out to Competitive Intel, Industry Digest, Knowledge Scout, Customer Feedback Synthesis.

Weekly Friday (4pm):
- decision-reminder — Scans for open decisions/RFCs. Nudges on stale items (>14 days). Tracks decision velocity.
- skill-synthesiser — Reviews last 7 days of session log. Writes or updates skill files for recurring workflows.
- efficiency-audit — Analyses session log for wasted patterns. Scores efficiency and recommends optimisations.
- ai-brand-builder — Reviews the week's work and external content in your domain. Drafts 2–3 content packages ([YOUR MESSAGING TOOL] posts + optional long-form). Suggest only — never auto-posts.

Manual:
- pm-buddy — PM sparring partner. Strategy, product sense, execution pressure-test. One question at a time.
- stakeholder-brief — Orchestrator: fans out for a named stakeholder. Synthesises into a pre-meeting brief.

## Step 4: Create the skill files (20 skills)

- write-like-me — Voice enforcement: first person, conversational, short paragraphs
- think-like-me — PM mental models: prioritisation, decisions under uncertainty
- review-pm-doc — Structured doc critique grounded in PM best practices. Posts [YOUR WIKI] comments when requested.
- draft-stakeholder-comm — Audience-calibrated comms for manager/eng/leadership/customers
- resolve-stakeholder-comments — Process stakeholder feedback from email/messaging/wiki
- data-to-narrative — Query results → headline → context → evidence → so what → next
- html-deck-style-guide — Design system for HTML decks (two styles, typography, tokens, JS nav)
- html-deck-to-pdf — Convert HTML deck to page-per-slide PDF via headless browser
- slide-creation — HTML slide deck pipeline with AI-generated visuals
- video-creation — Complete pipeline for narrated videos
- make-video — Narrated explainer videos via TTS and ffmpeg
- daily-coaching — Daily focus (3 tasks max), backlog clearing, goal alignment
- strategy-sparring — 10 moves for pressure-testing strategy docs, ordered by intensity
- prototyping — Interactive HTML prototypes: sliders, calculators, rubrics, comparison tools
- browser-copilot — Live browser: admin workflows, API escape hatch, screen capture
- create-agent — Add new agents: frontmatter pattern, schedule options, conventions
- create-excel-model — Build real .xlsx financial models with openpyxl
- in-session-orchestration — Fan out work to sub-agents in parallel (4× faster than sequential)
- data-discovery — Source routing, known tables, query templates (adapt to your data tools)
- prep-1-1-[YOUR MANAGER] — Weekly 1:1 prep: meeting agenda, what needs input, important notes, FYIs

## Step 5: Create the rhythm files (4 rhythms)

- daily-check.md — Daily: [YOUR MESSAGING TOOL], [YOUR WIKI] mentions, context, blockers
- weekly-review.md — Weekly: backlog, goals, tasks, plan next week, memory hygiene
- weekly-1-1-[YOUR MANAGER].md — Weekly: meeting prep — what needs input, important notes, FYIs
- monthly-okr-update.md — Monthly: pull metrics, score OKRs/KRs, update [YOUR WIKI]

## Step 6: Confirm

List all files created. Confirm counts (17 agents, 20 skills, 4 rhythms). Ask: "Ready to push to git?"
```

## Agent Infrastructure

All agents follow shared patterns:
- **Confidence scoring:** Tag outputs with [HIGH], [MEDIUM], [LOW] based on corroborating sources
- **Memory & deduplication:** Read previous output before generating. Don't resurface unless materially updated. Flag recurring items (3+ days).
- **Observability:** Log every run to Knowledge/session-log.md with item counts and key metrics
- **Delivery:** [YOUR MESSAGING TOOL] DM

Schedule options: `daily-8am`, `hourly`, `every-2h-workhours`, `weekly-monday-8am`, `weekly-friday-4pm`, `manual`

## Agents (17)

| Agent | Schedule | Type | What it does |
|-------|----------|------|-------------|
| **morning-briefing** | Daily 8am | Orchestrator | Fans out to follow-up-tracker, meeting-prep, decision-reminder. Synthesises into one prioritised daily summary with confidence tags. |
| **follow-up-tracker** | Daily 8am | Standalone | Scans [YOUR WIKI] pages from key stakeholders for action items. Deduplicates against BACKLOG.md. |
| **knowledge-scout** | Daily 8am | Standalone | Scans [YOUR MESSAGING TOOL] and [YOUR WIKI] for docs relevant to GOALS.md. Curates knowledge-refs.md. |
| **setup-guide-sync** | Daily 8am | Standalone | Scans full workspace. Updates setup guides + README to reflect current state. Pushes to main. |
| **industry-digest** | Daily 8am | Standalone | Scans sources for PM/industry news. Delivers top 3 reads + data point + provocation. |
| **meeting-prep** | Hourly | Standalone | Checks calendar for meetings in next 60 min. Gathers context. Sends prep via [YOUR MESSAGING TOOL]. |
| **slack-action-scanner** | Every 2h | Standalone | Scans [YOUR MESSAGING TOOL] DMs for meeting requests and commitments. Queues to pending-meetings.md (never auto-books). |
| **customer-feedback-synthesis** | Weekly Mon 8am | Standalone | Synthesises VOC from [YOUR ISSUE TRACKER], [YOUR MESSAGING TOOL], [YOUR WIKI]. Themed brief with confidence tags. |
| **competitive-intel-digest** | Weekly Mon 8am | Standalone | Monitors competitors for product/pricing moves via web search. Ranked digest via [YOUR MESSAGING TOOL]. |
| **relationship-tracker** | Weekly Mon 8am | Standalone | Tracks interactions with key stakeholders. Scores health (🟢/🟡/🔴). |
| **monday-intel-drop** | Weekly Mon 8am | Orchestrator | Fans out to Competitive Intel, Industry Digest, Knowledge Scout, Customer Feedback Synthesis. Synthesises into one briefing. |
| **decision-reminder** | Weekly Fri 4pm | Standalone | Scans for open decisions/RFCs. Nudges on stale items (>14 days). Tracks decision velocity. |
| **skill-synthesiser** | Weekly Fri 4pm | Standalone | Reviews last 7 days of session log for recurring workflows. Writes or updates skill files. |
| **efficiency-audit** | Weekly Fri 4pm | Standalone | Analyses session log for wasted patterns. Scores efficiency and recommends optimisations. |
| **ai-brand-builder** | Weekly Fri 4pm | Standalone | Reviews the week's work and external content. Drafts 2–3 content packages for [YOUR MESSAGING TOOL]/social. Suggest only — never auto-posts. |
| **pm-buddy** | Manual | Standalone | PM sparring partner — strategy, product sense, execution pressure-test. One question at a time. |
| **stakeholder-brief** | Manual | Orchestrator | Fans out for a named stakeholder. Synthesises into a pre-meeting brief with relationship history and open decisions. |

## Skills (20)

| Skill | What it does |
|-------|-------------|
| **write-like-me** | Voice enforcement — first person, conversational, short paragraphs, your actual phrases |
| **think-like-me** | PM mental models — strategy, prioritisation, decisions under uncertainty, team dynamics |
| **review-pm-doc** | Structured doc critique grounded in PM best practices. Posts [YOUR WIKI] comments when requested. |
| **draft-stakeholder-comm** | Audience-calibrated comms for manager/eng/leadership/customers across all channels |
| **resolve-stakeholder-comments** | Process stakeholder feedback from email/messaging/wiki — extract requests, map to goals, recommend next steps |
| **data-to-narrative** | Convert query results → headline → context → evidence → so what → next. Audience-calibrated. |
| **html-deck-style-guide** | Design system for HTML decks (two styles, typography, tokens, JS nav) |
| **html-deck-to-pdf** | Convert HTML slide deck to page-per-slide PDF via headless browser export |
| **slide-creation** | End-to-end pipeline for HTML slide decks with AI-generated visuals; feeds into video-creation |
| **video-creation** | Complete pipeline for narrated videos — HTML decks, browser walkthroughs, or both |
| **make-video** | Generate narrated explainer videos from a script and screenshots using TTS and ffmpeg |
| **daily-coaching** | Daily focus recommendations (3 tasks max), backlog clearing, goal alignment |
| **strategy-sparring** | 10 moves for pressure-testing strategy docs, ordered by intensity |
| **prototyping** | Interactive HTML prototypes — sliders, calculators, rubrics, comparison tools |
| **browser-copilot** | Live browser via playwright-cli — admin workflows, API escape hatch, screen capture, recordings |
| **create-agent** | Add new automated agents — frontmatter pattern, schedule options, conventions |
| **create-excel-model** | Build real `.xlsx` financial models with openpyxl — Assumptions/Model/Waterfall sheets, colour coding |
| **in-session-orchestration** | Fan out work to multiple sub-agents in parallel within a live session (4× faster than sequential) |
| **data-discovery** | Source routing, known tables, query templates — adapt to your data tools |
| **prep-1-1-[YOUR MANAGER]** | Weekly 1:1 prep — meeting agenda with what needs input, important notes, FYIs |

## Rhythms (4)

| Rhythm | Frequency | What it does |
|--------|-----------|-------------|
| **daily-check** | Daily | Check [YOUR MESSAGING TOOL], [YOUR WIKI] mentions, recent context, responses needed, blockers |
| **weekly-review** | Weekly | Process backlog, review goals, scan tasks, plan next week, memory hygiene |
| **weekly-1-1-[YOUR MANAGER]** | Weekly | Meeting prep: what needs input, important notes, FYIs |
| **monthly-okr-update** | Monthly | Pull metrics, score OKRs/KRs, update [YOUR WIKI] |

## After Setup

1. Fill in `GOALS.md` with your real priorities
2. Customise `AGENTS.md` — replace all `[PLACEHOLDER]` values with your details
3. Create your first task: `Tasks/[task-name].md`
4. Populate `Knowledge/knowledge-refs.md` with links to your key docs
5. Personalise `skills/write-like-me.md` and `skills/think-like-me.md` — these are the highest-leverage files
6. Test an agent: trigger `morning-briefing` manually to verify your integrations work

## Customisation Guide

| File | What to change |
|------|----------------|
| `AGENTS.md` | Your name, role, timezone, manager, tool names, messaging IDs |
| `GOALS.md` | Your current priorities, OKRs, focus areas |
| `agents/morning-briefing.md` | Your key stakeholders, wiki spaces to scan |
| `agents/follow-up-tracker.md` | Stakeholder names → wiki page URLs to scan |
| `agents/knowledge-scout.md` | Channels and wiki spaces relevant to your area |
| `agents/competitive-intel-digest.md` | Your competitor list (primary + secondary) |
| `agents/relationship-tracker.md` | Your key stakeholder list and cadence expectations |
| `skills/write-like-me.md` | Your voice — phrases you use, phrases you avoid |
| `skills/think-like-me.md` | Your PM mental models and decision heuristics |

## Design Principles

- **Chats are disposable. Files are permanent.** Start a new chat for every task. Your Knowledge/ folder persists.
- **AI drafts, humans steer.** The agent handles research and formatting. You handle insight and decisions.
- **Bias to action.** Shipping beats planning. An imperfect decision today beats a perfect one next month.
- **Engineering time is the scarcest asset.** Every feature request earns its place.
- **Often wrong, never in doubt.** Move forward confidently; course-correct when needed.
- **Never create a v2.** Always overwrite in place. One source of truth.

*Last synced: May 15, 2026*

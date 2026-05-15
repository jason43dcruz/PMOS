# PM Operating System

A personal operating system for Product Managers, powered by AI agents. Built on [Rovo Dev](https://developer.atlassian.com/platform/rovo/dev/) and markdown. Originally inspired by [How I Built My Personal PM Operating System](https://hello.atlassian.net/wiki/spaces/CONF/blog/6520874773/How+I+Built+My+Personal+PM+Operating+System).

Your AI agent gets full context — goals, priorities, writing style, product knowledge, live data — and uses it to coach, draft, analyse, and ship alongside you.

## What It Can Do

### 🤖 Automated Agents

24 agents run on schedule — no manual triggering needed. They surface what matters, so you can focus on the work.

| Agent | Schedule | What it does |
|-------|----------|-------------|
| **morning-briefing** | Daily 8am | Orchestrator: fans out to follow-up-tracker, meeting-prep, decision-reminder. Synthesises into one prioritised daily summary with confidence tags. |
| **follow-up-tracker** | Daily 8am | Scans Confluence pages from key stakeholders for action items. Deduplicates against BACKLOG.md, appends new items, sends Slack summary. |
| **knowledge-scout** | Daily 8am | Scans Slack channels and Confluence spaces for docs relevant to current goals. Curates knowledge-refs.md. |
| **data-refresh** | Daily 8am | Checks Secoda docs for staleness (>7 days). Re-runs SQL, publishes to Confluence. Only Slacks if something meaningfully changed. |
| **setup-guide-sync** | Daily 8am | Scans full workspace. Updates all three setup guides + README to reflect current state. Pushes to main. |
| **industry-digest** | Daily 8am | Scans Confluence, Atlassian docs, Slack, Secoda for PM/industry news. Delivers top 3 reads + data point + provocation via Slack DM. |
| **living-service-desk** | Hourly | Creates and updates realistic tickets on a demo JSM site to keep it active. [Optional] |
| **meeting-prep** | Hourly | Checks calendar for meetings in the next 60 min. Gathers context from Confluence/Jira/Slack. Sends prep via Slack DM 15–30 min before. |
| **slack-action-scanner** | Every 2h | Scans Slack DMs for meeting requests and commitments. Queues to pending-meetings.md (never auto-books). Adds tasks to BACKLOG.md. |
| **customer-feedback-synthesis** | Weekly Mon | Synthesises VOC from Jira, Slack, Secoda, Confluence. Delivers themed brief with confidence tags. Publishes to Confluence. |
| **competitive-intel-digest** | Weekly Mon | Monitors ServiceNow, Zendesk, Freshworks, BMC, Ivanti, ManageEngine for product/pricing moves. Ranked digest via Slack DM. |
| **relationship-tracker** | Weekly Mon | Tracks interactions with key stakeholders across Slack/Calendar/Confluence/Jira. Scores relationship health (🟢/🟡/🔴). |
| **monday-intel-drop** | Weekly Mon | Orchestrator: fans out to Competitive Intel, Industry Digest, Knowledge Scout, Customer Feedback Synthesis. Synthesises into one start-of-week briefing. |
| **wiki-refresh** | Weekly Mon | Fetches live Confluence edition strategy pages, compares against LLM wiki, re-compiles changed topics, refreshes synthesis pages, republishes. |
| **atlassian-repo-sync** | Weekly Mon | Checks `atlassian/ds-agent-starter-kit` on Bitbucket for new or updated skills. Syncs changed skill files into local `skills/` and updates `data-discovery.md` if approved tables change. |
| **decision-reminder** | Weekly Fri | Scans for open DACIs/LDRs/RFCs. Nudges on stale decisions (>14 days). Tracks decision velocity. Count summary via Slack. |
| **skill-synthesiser** | Weekly Fri | Reads last 7 days of session log. Identifies recurring workflows worth codifying. Writes or updates skill files. |
| **efficiency-audit** | Weekly Fri | Analyses session log for wasted iterations, dead-end patterns, and recurring failures. Scores efficiency and recommends optimisations. |
| **upgrade-signal-researcher** | Weekly Fri | Orchestrates unattended upgrade-signal autoresearch via Databricks notebooks. Searches for signals predicting JSM Std → Premium upgrades. |
| **ai-brand-builder** | Weekly Fri | Reviews the week's work and external AI PM content. Drafts 2–3 content packages (LinkedIn/Slack posts + optional long-form). Suggest only — never auto-posts. |
| **pm-buddy** | Manual | PM sparring partner — strategy, product sense, execution pressure-test. Uses Lenny transcripts. One question at a time. |
| **stakeholder-brief** | Manual | Orchestrator: fans out to sub-agents for a named stakeholder. Synthesises into a pre-meeting brief with relationship history, open decisions, and suggested agenda. |
| **service-collection-bootstrap** | Manual | One-time setup of a complete JSM demo site — 178 users, 3 service desks, ~200 tickets, 70+ KB articles, 3 asset schemas. [Optional] |
| **roi-refresh** | Manual | Updates Rovo Dev ROI Calculator Confluence page with fresh counts of strategic sessions, agent runs, and artifacts from session log. |

All agents follow shared infrastructure patterns: **confidence scoring** ([HIGH]/[MEDIUM]/[LOW]), **deduplication** (don't resurface unless materially updated), and **observability** (log every run to session-log.md).

### 📊 Data & Analytics

Ask any data question. The agent routes to the right source:

1. **S360 MCP** — primary for sales/GTM data: opportunities, pipeline, forecasts, discounting, accounts, churn prediction, AI/cloud usage (160+ GraphQL queries)
2. **Secoda MCP** — primary for table/schema discovery (`search_data_assets`) and ad-hoc SQL (`run_sql`). Also the live source for data-backed strategy docs.
3. **Socrates / Databricks** — fallback for SQL when Secoda errors; primary for saved queries (`queries/`) and async workloads. Gong/Salesforce data accessible via Databricks tables.

The `skills/data-discovery.md` skill maps known tables, join keys, column gotchas, and tested query templates. Always consulted before exploring schemas from scratch.

After any analysis: `skills/analysis-artifacts.md` governs the full artifact chain — Databricks notebook → Lakeview dashboard → Confluence page linking both.

Workflow: route → discover → query → narrate → save to `skills/queries/` → publish to Confluence.

### 🗑 HTML Presentation Decks

Two styles, both self-contained single HTML files. No external dependencies — works offline.

- **Official** — Atlassian 2024 brand. Clean, structured. Default for stakeholder decks, strategy reviews, exec updates.
- **Flashy** — Event/keynote style (Team25 Founders Keynote). High energy, bold typography. Use for demos and conferences.

Features: Charlie Display + Atlassian Sans fonts, full colour palette, arrow/spacebar/swipe navigation, progress bar, click-reveal, responsive. See `skills/html-deck-style-guide.md` for the full design system.

Convert any deck to PDF with `skills/html-deck-to-pdf.md` — page-per-slide export via headless browser.

### 🎤 Video Production

Two-skill pipeline: `skills/slide-creation.md` builds the deck with AI-generated visuals; `skills/video-creation.md` turns it into a narrated video. For static content, `skills/make-video.md` generates narrated explainer videos from a script and screenshots using Kokoro TTS and ffmpeg — no browser recording needed.

### 🌐 Browser Copilot

A live browser session via `playwright-cli`. Use it for:

- **Admin workflows** — Jira config, Confluence setup, JSM admin, Assets schema creation
- **API escape hatch** — when an API needs an ID it doesn't provide, open the app and get it from the URL. Save it to knowledge-refs.md for next time.
- **Screen capture** — `screencapture -l<windowID>` for browser-only screenshots
- **Demo recordings** — `playwright-cli video-start/stop` → ffmpeg → MP4

Always `--headed --persistent --browser firefox`. Snapshot before acting. One action at a time. See `skills/browser-copilot.md` for the full playbook.

### ✍️ Writing & Communication

Every draft sounds like you, not a chatbot:

- **write-like-me** — voice rules, structure preferences, vocabulary, tone by audience, AI-tell words to avoid
- **think-like-me** — PM mental models: where to play, how to win, prioritisation (impact × confidence ÷ effort), decisions under uncertainty
- **draft-stakeholder-comm** — audience-calibrated comms for manager/eng/leadership/customers across Slack/email/Confluence
- **review-pm-doc** — structured critique grounded in Lenny's podcast transcripts + Atlassian context. Posts inline Confluence comments when requested.
- **resolve-stakeholder-comments** — processes stakeholder feedback from email/Slack/Confluence, extracts requests, maps to goals, recommends next steps

### 🎉 Strategy & Sparring

- **strategy-sparring** — 10 moves ordered by intensity, from gentle reframe to hard challenge. Prep step reads source-of-truth docs before engaging.

Triggered by: "spar", "pressure-test", "poke holes", "evaluate this", or feedback on any strategy doc.

### ✍️ Content & Brand Building

- **ai-brand-builder** — weekly agent that reviews your work and external AI PM content, then drafts LinkedIn posts, internal Slack updates, and optional long-form pieces grounded in something real you did that week. Suggest only — never auto-posts.

### 🤝 PM Coaching & Task Management

Built-in coaching loops:

- **daily-coaching** — start each day with 3 focus tasks ordered by deadline → impact → strategic alignment. If the day looks too heavy, it says so.
- **GOALS.md** — always-on priority compass. Every recommendation ties back to a goal.
- **BACKLOG.md** — cleared weekly. Items categorised by priority and goal alignment.
- **Tasks/** — one file per active work item, from task-template.md.
- **pm-buddy** — async sparring partner for strategy docs, executive summaries, and product decisions. Uses Lenny's Podcast transcripts as PM grounding.

### 🔗 Live Integrations

| Integration | What it enables |
|---|---|
| **Confluence** | Read/create/update pages, CQL search, inline comments, ADF formatting |
| **Jira** | Read/create/update issues, JQL search, transitions, attachments |
| **Slack** | Send DMs, read channels, search messages, agent delivery |
| **Google Calendar** | Read events, check availability, meeting prep |
| **Google Drive** | Read/create docs, manage permissions |
| **Gmail** | Search threads, read emails |
| **Bitbucket** | PRs, repos, branches, pipelines |
| **Secoda** | Data catalogue, SQL queries, documentation, lineage, glossary |
| **Socrates / Databricks** | SQL queries, notebooks, clusters, async workloads, Lakeview dashboards |
| **S360** | Sales forecasts, opportunities, pipeline, discounting, accounts, churn prediction |
| **Compass** | Component search, documentation, API changelogs, package dependencies |
| **ADS** | Design tokens, components, icons, accessibility checks, migration guides |
| **Teamwork Graph** | User activity, team projects, collaboration summaries, org hierarchy |
| **Atlas (Projects & Goals)** | Project tracking, goal management, updates, dependencies |
| **Dovetail** | Qualitative research insights, project data, participant notes, interview transcripts |

### 📅 Rhythms & Cadences

Four recurring guides that keep the system healthy:

| Rhythm | Frequency | What it does |
|--------|-----------|-------------|
| **daily-check** | Daily | Check Slack channels, Confluence mentions, context, responses needed, blockers |
| **weekly-review** | Weekly | Process backlog, review goals, scan tasks, plan next week, kernel evolution check, memory hygiene |
| **weekly-1-1-anand** | Weekly | Eisenhower matrix 1:1 prep on Confluence with status lozenges |
| **monthly-l1-okr-update** | Monthly | Pull metrics from Atlas + SQL, score KRs (0.7–1.0), update Confluence scoring page |

## Skills

29 reusable instruction sets. Load any skill with `get_skill(skill_name_or_path="...")` or by opening the file.

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

## Structure

```
AGENTS.md              — Agent instructions, philosophy, integrations, conventions
GOALS.md               — Priorities, vision, focus areas, P0–3 framework
BACKLOG.md             — Unprocessed items (cleared weekly)
README.md              — This file

agents/                — Automated agent definitions (frontmatter: name, schedule, prompt)
  run-agents.sh        — Orchestrator (auto-discovers agents, runs via acli rovodev)
  com.pmos.agents.plist — launchd plist (runs orchestrator hourly)

skills/                — Reusable instruction sets for the agent
  queries/             — Saved SQL query templates
  data-insight-checker-for-servco/ — Data validation skill with reference tables
rhythms/               — Daily, weekly, monthly cadence guides
templates/             — Setup guides and task template

Knowledge/             — Persistent context
  session-log.md       — Memory across sessions (read at start, update at end)
  knowledge-refs.md    — Curated links to all key docs and data sources
  product-context.md   — Stakeholders, meetings, current focus
  user-context.md      — Your identifiers, channels, accounts
  writing-style.md     — Your voice and vocabulary
  ai-writing-antipatterns.md — Patterns to actively avoid
  efficiency-patterns.md — Known failure modes and retry limits
  secoda_integration.py — Python fallback for Secoda (owner-filtered discovery)
  lennys-podcast-transcripts/ — Full transcript bundle (300+ episodes, local)
  autoresearch/        — Cohort builder, engine, specs, and run outputs
  upgrade_signals/     — Upgrade signal analysis and autoresearch loop scripts
  snapshots/           — Point-in-time snapshots of key external pages

wiki/                  — LLM wiki: pre-synthesised cross-linked context layer
  synthesis/           — what-we-believe.md, open-questions.md, evidence-changelog.md
  topics/              — Domain-specific topic pages (edition-strategy, ai-pm-craft, …)

projects/              — One subfolder per active project
  edition-strategy/    — Edition strategy project
    strategy/          — Strategy docs and frameworks
    data/              — Analysis, models, data
    decks/             — Presentations
    prototypes/        — Interactive HTML, rubrics, sliders
    value-slide-drafts/ — Slide iteration drafts
  misc/                — One-off projects (e.g. awards scoring)
Tasks/                 — Individual task files (from task-template.md)
research-reports/      — Generated research reports
```

## Quick Start

### Option 1: One-prompt setup

Pick the right setup guide for your situation:

| File | Who it's for |
|------|-------------|
| `templates/setup-pm-os.md` | **You** — rebuilds your exact PMOS with all conventions baked in |
| `templates/setup-pm-os-atlassian.md` | **Any Atlassian PM** — full toolset (S360, Secoda, Socrates, Compass, ADS, Atlas, Dovetail) with generic placeholders |
| `templates/setup-pm-os-public.md` | **Any PM** — tool-agnostic (Rovo Dev, Cursor, Claude, or any AI agent tool), no Atlassian-internal tools assumed |

Open a Rovo Dev session, open the right setup guide, and paste the prompt inside. One session to scaffold everything.

### Option 2: Manual setup

1. Copy `AGENTS.md` from this repo and customise for your role, timezone, tools
2. Create `GOALS.md` with your top 3 priorities
3. Create `Knowledge/session-log.md`, `Knowledge/knowledge-refs.md`, `Knowledge/user-context.md`, `Knowledge/product-context.md`
4. Copy agents from `agents/` — customise Slack IDs, Confluence spaces, stakeholder names
5. Copy skills from `skills/` — personalise `write-like-me.md` and `think-like-me.md` first
6. Activate the schedule:
   ```bash
   cp agents/com.pmos.agents.plist ~/Library/LaunchAgents/
   launchctl load ~/Library/LaunchAgents/com.pmos.agents.plist
   ```
7. Test: `bash agents/run-agents.sh all`

## Design Principles

- **Chats are disposable. Files are permanent.** Start a new chat for every task. Your Knowledge/ folder persists across sessions.
- **AI drafts, humans steer.** The agent handles research and formatting. You handle insight and decisions.
- **Bias to action.** Shipping beats planning. An imperfect decision today beats a perfect one next month.
- **Engineering time is the scarcest asset.** Every feature request earns its place.
- **Often wrong, never in doubt.** Move forward confidently; course-correct when needed.
- **Never create a v2.** Always overwrite in place. One source of truth.

*Last synced: May 15, 2026*

---
name: Knowledge Scout
schedule: daily-8am
orchestrator: monday-intel-drop
prompt: "Run the knowledge scout agent defined in agents/knowledge-scout.md. Scan Slack channels CFGQGGSRH and C085EDZ9C9K, plus Confluence spaces ITSOL, PM, AAI for pages created or updated in the last 24 hours. Only surface docs that directly connect to my active goals in GOALS.md. If anything is worth adding to Knowledge, update knowledge-refs.md and push. NOTE: If this agent is being called by an orchestrator (i.e. as a sub-agent), do NOT send a Slack message — return your output as text only for the orchestrator to synthesise and deliver."
---

# Agent Task: Knowledge Scout

**Schedule:** Daily (morning)
**Type:** Scan → Summarise → Curate

## What This Agent Does

1. Scans Slack channels and Confluence for docs, articles, and links shared in the last 24 hours
2. Evaluates each against your interests and goals (see Relevance Criteria below)
3. Summarises what's worth reading and why
4. If a doc is relevant enough, saves a reference to Knowledge/knowledge-refs.md and optionally saves a local summary to Knowledge/

## Sources

### Slack Channels

| Channel | ID | Why |
|---|---|---|
| #ProductManagement | CFGQGGSRH | PM craft, frameworks, experimentation, cross-functional best practices |
| #AIPM design hacks | C085EDZ9C9K | AI applied to product work, design patterns, AI product craft |

### Confluence

| Space | Key | Why |
|---|---|---|
| IT Solutions | ITSOL | Your home space — edition strategy, packaging, [YOUR PRODUCT] decisions |
| Product Management | PM | PM craft, frameworks, best practices across Atlassian |
| AI & Intelligence | AAI | AI packaging, Rovo, AI strategy |

Scan for pages created or updated in the last 24 hours in these spaces.

## Relevance Criteria

Be ruthless. Only surface docs that directly connect to an active goal or could change a decision you're making right now. A doc is relevant if it matches 2+ criteria AND connects to a current priority in GOALS.md:

- **PM craft:** Frameworks, decision-making, prioritisation, experimentation, stakeholder management
- **AI + product:** AI applied to product work, AI packaging, AI features, AI strategy
- **Edition / packaging / pricing:** Anything about how SaaS products tier, gate, or price features
- **Service management / ITSM:** Industry trends, competitor moves, customer pain patterns
- **Leadership / influence:** Communication, persuasion, exec communication, career growth for senior PMs
- **Shipping / execution:** Practices that help ship faster, reduce waste, break logjams

Use GOALS.md and AGENTS.md as the reference for what matters to you right now.

## Output

### Daily Summary

Keep it short. Aim for 1-3 items max. If nothing is worth reading today, say so. For each relevant doc:

- **Title** and link
- **One-line summary**
- **Why it matters right now**
- **Read today / Save for later**

### Slack Delivery
- **Silent if nothing worth surfacing.** If no documents score 2+ relevance criteria, do NOT send a Slack DM — log the run to session-log.md only.
- **Keep it short:** List only the top 3-5 most relevant new documents found. One line each: title + why it's relevant + link. Skip low-confidence items from Slack delivery.

### Knowledge Curation

If a doc scores 3+ relevance criteria or is directly applicable to a current project:

1. Add a reference to `Knowledge/knowledge-refs.md` under the appropriate section (create a new "## Curated Knowledge" section if needed)
2. Include: title, URL, one-line summary, date found, source channel

Do not duplicate entries already in knowledge-refs.md.

## Agent Instructions

When running this task:

1. Read GOALS.md and AGENTS.md to understand current priorities
2. Pull messages from each Slack channel (last 24 hours)
3. Extract any links to Confluence pages, Google Docs, blog posts, or other docs
4. For each link, fetch the content (Confluence via MCP, others via URL if possible)
5. Score against relevance criteria
6. For relevant docs: summarise, evaluate, recommend
7. For highly relevant docs: add to knowledge-refs.md
8. Present the daily summary

## How To Run

Say: **"run knowledge scout"** or **"what's worth reading today?"**

## Infrastructure

### Confidence Scoring
Tag each discovered document with relevance confidence:
- **[HIGH]** — directly mentions a current goal or active project from GOALS.md
- **[MEDIUM]** — related to a goal area but not directly actionable
- **[LOW]** — tangentially relevant, included for awareness

### Memory & Deduplication
- Read Knowledge/knowledge-refs.md before scouting. Do not re-surface documents already indexed.
- Track documents surfaced in the last 7 days. If a document was surfaced but not added to knowledge-refs by the user, deprioritize it.

### Observability
- Log each run: `### [O] Knowledge Scout Run ({time}) — {X} docs found, {Y} new, {Z} already indexed`

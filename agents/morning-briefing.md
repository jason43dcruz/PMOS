---
name: Morning Briefing
schedule: daily-8am
prompt: "Run the morning briefing agent defined in agents/morning-briefing.md. Scan Confluence mentions, Jira updates, and Slack DMs from the last 24 hours. Send the formatted briefing as a Slack DM to channel [YOUR_SLACK_CHANNEL_ID]. Keep it short — only items that need my attention."
---

# Agent Task: Morning Briefing

**Schedule:** Daily, first thing (before daily check)
**Purpose:** Surface everything that needs your attention or response so you can triage before starting work.

## What It Checks

### Slack
- **Direct messages** and **mentions** in the last 24 hours
- **Threads you're in** that have new replies
- Channels to scan for @mentions: all channels you're a member of

### Confluence
- **Pages you're watching** that were updated
- **Comments on your pages** (inline and footer)
- **@mentions** on any page in the last 24 hours

### Jira
- **Issues assigned to you** that have new comments or status changes
- **Issues you're watching** with updates
- **@mentions** in issue comments

### L1 KR: [YOUR PRODUCT] Uplift (P0)
- Run the SQL query from `skills/queries/servco-uplift-kr.sql` via Socrates async query (heavy query, use `submit_async_query`)
- Report: % paid orgs uplifted, % free orgs uplifted, date of data
- Compare against monthly milestone targets in `skills/l1-okr-scoring.md` (monthly targets are progress milestones, not scoring thresholds)
- The OKR score (0.7/0.8/0.9/1.0) is based on end-of-half thresholds (94%/95%/99%/100% paid orgs) AND which cohorts are complete. Read the latest update on the [FY26 O2KR3 Scoring Working Page]([YOUR_CONFLUENCE_SPACE]) for the current score and cohort status
- Report: current %, monthly milestone comparison, current OKR score, active cohort status
- Flag if behind monthly milestone or if cohorts are blocked/at risk

### Delivery
- **Send briefing as Slack DM** to channel `[YOUR_SLACK_CHANNEL_ID]` ([YOU]'s DM with self/agent)
- Slack user ID: `[YOUR_SLACK_USER_ID]`
- **Keep it short:** 5 bullets max. Headline + 3-4 items that need attention + one FYI. Skip anything that doesn't require action today.
- If there are more than 5 items, prioritise by urgency and link to a Confluence page for the rest.

## Tools

| Source | Tool |
|---|---|
| Slack DMs | Slack MCP: `channel_get_message` on DM channels for unread messages |
| Confluence mentions | Atlassian MCP: `search_confluence_using_cql` with `mention = currentUser() AND lastModified > now("-1d")` |
| Confluence page comments | Atlassian MCP: `get_confluence_page` with `get_comments = true` for watched pages |
| Jira updates | Atlassian MCP: `search_jira_using_jql` with `(assignee = currentUser() OR watcher = currentUser()) AND updated >= -1d` |
| L1 KR data | Socrates MCP: `submit_async_query` with SQL from `skills/queries/servco-uplift-kr.sql`, then `get_query_results` |
| Deliver briefing | Slack MCP: `channel_create_message` to DM channel `[YOUR_SLACK_CHANNEL_ID]` |

## Output

Keep it short. Group by urgency:

### Needs Response (someone is waiting on you)
- Direct questions in Slack DMs or threads
- Confluence comments asking for input
- Jira issues where you're blocking progress

### FYI (updated but no action needed yet)
- Pages you watch that changed
- Jira issues with status updates
- Threads where others replied but didn't ask you anything

### Can Wait
- Newsletter-style Slack messages
- Automated notifications

For each item: one line with the source, who's asking, what they need, and a link.

## Triage Rule

If there are more than 5 items in "Needs Response," flag it. That means you're overcommitted or need to delegate.

## Infrastructure

### Confidence Scoring
Tag each briefing item with a confidence indicator:
- **[HIGH]** — multiple corroborating sources (e.g., Jira issue + Slack mention + Confluence page)
- **[MEDIUM]** — single source, verified
- **[LOW]** — single source, unverified or inferred

Present high-confidence items first.

### Memory & Deduplication
- Before generating the briefing, read the previous day's briefing from Knowledge/session-log.md
- Do not resurface items that were in yesterday's briefing unless they have a material update
- Flag items that have appeared 3+ days in a row as "recurring" and suggest resolution

### Observability
- At the end of each run, append a one-line summary to Knowledge/session-log.md under the current date:
  `### [O] Morning Briefing Agent Run ({time}) — {X} items surfaced, {Y} high-confidence, {Z} deduplicated`

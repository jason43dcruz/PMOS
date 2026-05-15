---
name: Relationship Tracker
schedule: weekly-monday-8am
prompt: "Run the relationship tracker agent defined in agents/relationship-tracker.md. Analyze stakeholder interactions and deliver relationship health report via Slack DM."
---

# Agent Task: Relationship Tracker

**Schedule:** Weekly, Monday 8am
**Purpose:** Track interactions with key stakeholders and nudge when relationships go cold. Acts as a personal CRM for the PM, ensuring no critical relationships atrophy due to busyness.

## How It Works

1. **Load stakeholder list.** Read Knowledge/product-context.md to get the list of key stakeholders. If that file doesn't exist or lacks a stakeholders table, flag this and ask the user to populate it.
2. **Check recent interactions (last 14 days).** For each stakeholder, scan across all channels:
   - **Slack:** Check DMs and channel mentions using `email_thread_search` to find messages in last 14 days
   - **Google Calendar:** Query `get_events` for shared meetings in last 14 days
   - **Confluence:** Search for co-edited pages, mentions, and comments using `search_confluence_using_cql`
   - **Jira:** Search for shared issues, comments, and mentions using `search_jira_using_jql`
3. **Score each relationship:**
   - 🟢 **Active** — interaction within 7 days (meeting, message, comment, or page edit)
   - 🟡 **Cooling** — 8-14 days since last interaction
   - 🔴 **Cold** — 14+ days since last interaction
4. **Suggest actions for cold/cooling relationships:**
   - "Send a quick Slack check-in"
   - "Schedule a 15-min catch-up"
   - "Comment on their recent Confluence page"
   - "Reply to their last message"

## Output Format

### Slack Message Format (keep it short!)
The Slack DM must be **5 bullets or fewer**:
1. 📊 "X of Y key relationships active this week"
2. 🔴 Cold relationships (1-3 names) — who + days since last interaction
3. 🟡 Cooling relationships (1-3 names) — who + suggested action
4. 💡 Interaction pattern insight — one line (e.g., "heavy on Slack, light on 1:1s")
5. 🔗 Link to full relationship health table if published

Keep it to names and nudges. No full tables in Slack.

**Slack DM to channel DFFF0J94G**

```
📋 **Relationship Health Report — Week of [DATE]**

**Summary:** X of Y key relationships are active this week. Z relationships trending cooler.

**Relationship Health Table:**
| Name | Role | Last Interaction | Channel | Status | Suggested Action |
|---|---|---|---|---|---|
| [Name] | [Role] | [Date & Type] | Slack / Calendar / Confluence / Jira | 🟢 / 🟡 / 🔴 | [Action] |

**New Connections This Week:**
People you interacted with who aren't on your key stakeholders list (potential future additions):
- [Name] — [Context of interaction]

**Interaction Patterns:**
- You've been heavy on Slack, light on 1:1s this week
- 3 stakeholders haven't had a meeting in 3+ weeks
- [Other pattern observations]

**Trending Alerts:**
- [Name]: 🟢 → 🟡 (was active, now cooling)
- [Name]: 🟡 → 🔴 (was cooling, now cold)
```

## Memory & Trending

- Compare against last week's report. Flag relationships trending from green → yellow → red.
- If a relationship was already cold/cooling last week and remains so, highlight it as "at risk."
- Celebrate relationships that improved (🔴 → 🟡 or 🟡 → 🟢).

## Initial Stakeholder List

**Source:** Knowledge/product-context.md

This agent requires a stakeholders table in Knowledge/product-context.md with at least these columns:
- Name
- Role / Title
- Team / Org
- Why they matter (brief context)

**If the file is missing or incomplete:**
- Flag to the user: "Knowledge/product-context.md doesn't have a stakeholders table. Add one with key people you want to track."
- Example structure:
  ```
  | Name | Role | Team | Why They Matter |
  |---|---|---|---|
  | [Name] | [Role] | [Team] | [Context] |
  ```

Once populated, the agent will run automatically every Monday at 8am.

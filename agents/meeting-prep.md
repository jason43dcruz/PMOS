---
name: Meeting Prep
schedule: hourly
prompt: "Run the meeting prep agent defined in agents/meeting-prep.md. FIRST: check the current time in Australia/Melbourne. If it is before 8:00am or after 4:30pm, OR if it is a Saturday or Sunday — stop immediately and do nothing. Otherwise: check my Google Calendar for meetings in the next 60 minutes. If there are NO meetings with real attendees in the next 60 minutes, stop immediately — do NOT send any Slack message. Only send a Slack DM to channel DFFF0J94G if there is at least one actionable meeting requiring prep."
---

# Agent Task: Meeting Prep

**Schedule:** Hourly (checks for meetings in the next 60 minutes)
**Purpose:** Prepare you for upcoming meetings with relevant context so you walk in ready.

## How It Works

1. **Check calendar.** Pull events from Google Calendar for the next 60 minutes.
2. **Skip if nothing coming up.** No meetings in the next hour? Do nothing.
3. **For each meeting:**
   - Identify the meeting type (1:1, team sync, review, external)
   - Pull context based on type
   - Send prep as a Slack DM 15-30 minutes before the meeting starts

## Context Gathering — General Rules

**Always do these for EVERY meeting, regardless of type:**

1. **Check Slack DMs with each attendee.** This is the most important context source — it captures the real conversations, questions, and commitments that formal docs miss. Use the known DM channel IDs below, or look up the attendee via `workspace_search_user_by_email` and ask for the DM channel.
2. **Check for recent meetings with the same person.** Search calendar for meetings with this attendee in the past 7 days. If you met recently, reference what was discussed and frame today's meeting as a continuation.
3. **Pull any docs linked in the calendar event description.**

### Known Slack DM Channel IDs

Keep this list updated as you discover DM channels. Use these to pull recent messages (last 7 days) with `channel_get_message`.

| Person | Email | Slack User ID | DM Channel ID |
|---|---|---|---|
| Shilpa Koneru | skoneru@atlassian.com | U01MM6PL4SW | D0A9UNCF55Y |
| Eleanor Groeneveld | egroeneveld@atlassian.com | U02PCLS72G0 | TBD |
| Sage Ray | sray@atlassian.com | U04DRP39N8G | TBD |

_(Add new DM channel IDs here as they are discovered during prep runs.)_

## Context Gathering by Meeting Type

### 1:1s and Small Meetings (≤3 attendees)
- Check Slack DMs with each attendee (see above — this is mandatory)
- Check if there's a recurring Confluence page for this 1:1 (search by attendee name)
- Read the last meeting's notes
- Check Jira for any issues involving both you and the other person
- Look at the meeting title — if it references a specific topic, search Confluence and Jira for that topic too

### Team Syncs / Reviews
- Check Slack DMs with the organiser
- Read the meeting page if one exists (Confluence)
- Check the agenda
- Pull any docs linked in the calendar event description

### Stakeholder Meetings (Anand, Shamik)
- Read their decision profiles from Knowledge/
- Check recent project updates relevant to the meeting topic
- Check Slack DMs for recent exchanges
- Flag any open decisions or blockers

## Classification Rule

**Do NOT rely solely on meeting title format to classify meetings.** A meeting titled "Child Collection vs. App conversation" with only 2 attendees is a 1:1, not a review. Classify by attendee count:
- **≤3 people** → treat as 1:1 / small meeting (full DM context gathering)
- **4-8 people** → treat as team sync
- **9+ people** → treat as review / all-hands

## Tools

| Step | Tool |
|---|---|
| Check calendar | Google Calendar MCP: `get_events` for next 60 minutes |
| Read meeting pages | Atlassian MCP: `get_confluence_page` |
| Search for context | Atlassian MCP: `search_confluence_using_cql` |
| Check Jira | Atlassian MCP: `search_jira_using_jql` |
| Send prep | Slack MCP: `channel_create_message` to DM channel `DFFF0J94G` |

## Output Format

Short, scannable. For each meeting:

- **Meeting name** and time
- **Who:** attendees
- **Context:** 2-3 bullet points of relevant background
- **Last time:** key points from previous meeting (if recurring)
- **Your prep:** what you should review or bring up

## Delivery

- Slack DM to channel `DFFF0J94G`
- Send 15-30 minutes before the meeting
- If multiple meetings in the window, send one message covering all of them
- **Keep it short:** 3-5 bullet points per meeting. Context, key question, one suggested talking point. No lengthy backgrounds.

## Infrastructure

### Confidence Scoring
Tag each prep item with confidence:
- **[HIGH]** — confirmed from calendar + recent docs/issues
- **[MEDIUM]** — inferred from context (e.g., attendee's recent work)
- **[LOW]** — speculative (e.g., "they might want to discuss X based on their role")

### Memory
- Check if this meeting has occurred before (recurring meetings). If so, read the previous prep and the previous meeting's notes/decisions.
- For recurring 1:1s, track open items from prior meetings and flag unresolved topics.

### Observability
- Log each run: `### [O] Meeting Prep Agent Run ({time}) — {X} meetings in next 60 min, prep sent for {Y}`

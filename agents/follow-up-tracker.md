---
name: Follow-Up Tracker
schedule: daily-8am
prompt: "Run the follow-up tracker agent defined in agents/follow-up-tracker.md. Scan recent Slack DMs AND Confluence pages from Anand, Eleanor, Matt, and Mark for action items and follow-ups. Add any new items to BACKLOG.md and send a Slack summary."
---

# Agent Task: Follow-Up Tracker

**Schedule:** Daily at 8am
**Purpose:** Check Slack DMs AND meeting notes/Confluence pages from key stakeholders for action items and follow-ups. Add new items to BACKLOG.md. Send a Slack summary of what was added.

## People to Watch

| Person | Confluence (CQL) | Slack DM Channel ID |
|---|---|---|
| **Anand Narayanan** | `creator = "712020:f8c6ac7c-3caa-4d29-bb3c-77f7901aa00d" AND lastModified > now("-1d")` | `D06J8HWTY6R` |
| **Eleanor** | `creator.displayName ~ "Eleanor" AND lastModified > now("-1d")` | `D06T3EWKBLB` |
| **Matt Chapman** | `creator.displayName = "Matt Chapman" AND lastModified > now("-1d")` | `D07NPTQ3XQX` |
| **Mark O'Shea** | `creator.displayName = "Mark O'Shea" AND lastModified > now("-1d")` | `D064W037MD1` |
| **[YOU]'s own meeting notes** | `creator = currentUser() AND lastModified > now("-1d") AND space = "~349409947"` | — |

> **DM channel IDs:** If a channel ID is unknown or returns an error, use `slack_workspace_search_user_by_email` to find the user, then `channel_get_message` with the DM channel. Save any newly discovered IDs back to this table.

## Step 0 — Scan Slack DMs (run first)

For each person in the People to Watch table who has a Slack DM channel ID:
1. Use `channel_get_message` with `oldest` = Unix timestamp of **25 hours ago** (covers yesterday's full day)
2. Scan messages for action items directed at [YOU] — look for:
   - Direct asks: "can you...", "could you...", "would you...", "please..."
   - Commitments [YOU] made in the thread: "I'll...", "will send", "will look at"
   - Follow-up requests: "let me know", "circle back", "confirm", "by [date]"
   - Anything time-bound or explicitly awaiting [YOU]'s response
3. Classify each signal as HIGH, MEDIUM, or LOW (see confidence scoring below)
4. Add HIGH and MEDIUM items to the backlog queue (deduplicate first)

**What to ignore in DMs:** casual chat, FYIs, things [YOU] already responded to in the thread, bot/automated messages.

## Step 1 — Scan Confluence Pages

For each person in the People to Watch table:

## What to Look For

For each new page or DM message found, scan for:
- **Action items** explicitly assigned to [YOU] (look for "[YOU] to...", "JDC to...", "@[YOU]", "you will...", "can you...")
- **Follow-up requests** — "let me know", "circle back", "send me", "confirm by"
- **Commitments [YOU] made** — "I'll...", "will send", "will share"
- **Open questions** directed at [YOU] that haven't been answered

## What to Ignore

- FYI-only updates with no action required
- Items already in BACKLOG.md (deduplicate before adding)
- Items already marked as complete in meeting notes

## How to Add to Backlog

1. Read `BACKLOG.md` to check what's already there
2. For each new action item found, append to BACKLOG.md in this format:
   ```
   - **[Person] — [Topic]** — [One-line description of what's needed]. (From: [page title], [date])
   ```
3. Only add items not already captured

## Delivery

Send a Slack DM to channel `[YOUR_SLACK_CHANNEL_ID]` with:
- How many new items were added to BACKLOG.md
- A bulleted list of each new item (one line each)
- If nothing new: **do NOT send a Slack DM.** Log the run to session-log.md only.

Format:
```
📋 *Follow-Up Tracker* — {date}

New items added to BACKLOG.md:
• [Person] — [brief description] (from: [meeting/page title])
• ...

Run complete. {X} items added, {Y} already in backlog (skipped).
```

## Tools

| Source | Tool |
|---|---|
| Confluence pages from stakeholders | Atlassian MCP: `search_confluence_using_cql` |
| Read each page | Atlassian MCP: `get_confluence_page` |
| Slack DMs from stakeholders | Slack MCP: `channel_get_message` with DM channel ID |
| Find Slack user by email | Slack MCP: `slack_workspace_search_user_by_email` |
| Read current backlog | `open_files` on `BACKLOG.md` |
| Update backlog | `find_and_replace_code` on `BACKLOG.md` |
| Send Slack summary | Slack MCP: `channel_create_message` to `[YOUR_SLACK_CHANNEL_ID]` |

## Infrastructure

### Confidence Scoring
- **[HIGH]** — Explicit action item with [YOU] named
- **[MEDIUM]** — Implicit follow-up (e.g. "let me know")
- **[LOW]** — Inferred from context

Only add [HIGH] and [MEDIUM] items to BACKLOG.md. Flag [LOW] items in the Slack message only.

### Memory & Deduplication
- Read BACKLOG.md before adding anything
- Check if the item (or a close variant) already exists — if so, skip it
- Flag if the same item has appeared 3+ days in a row as a recurring blocker

### Observability
- Append to `Knowledge/session-log.md`:
  `### [O] Follow-Up Tracker Run ({time}) — {X} items added, {Y} deduplicated, {Z} sources scanned`

---
name: Decision Documentation Reminder
schedule: weekly-friday-4pm
prompt: "Run the decision reminder agent defined in agents/decision-reminder.md. Scan for open decisions and deliver a summary via Slack DM."
---

# Decision Documentation Reminder Agent

## Schedule
Weekly, Friday 4pm

## Purpose
Track open decisions, nudge on stale ones, and maintain a running decision log. This agent fights decision drift, re-litigation, and ensures ownership stays clear. It's a forcing function for timely, documented decisions.

## Sources to Scan

### Confluence
- Search for pages tagged or titled with **DACI**, **LDR** (Leadership Decision Record), **RFC** (Request for Comments) in the user's spaces
- Check page status: pending, decided, returned, implementing
- Filter by modified date: past 30 days (to surface stale decisions)
- Look in: personal space, strategy spaces, product spaces

### Knowledge/session-log.md
- Extract decisions made and things rejected from recent sessions
- Pull any open questions or parking lots flagged as "pending decision"

### Jira (hello.atlassian.net)
- Look for issues with "decision" or "DACI" labels
- Check decision-related epics or portfolios
- Filter by status: not done, blocked waiting for decision

### Slack
- Scan for threads where decisions were discussed but may not have been formally documented
- Look for threads with 10+ replies discussing a strategic or roadmap question
- Capture verbatim decisions made in calls that may have been documented only as DMs or Slack threads

## Output Format

### Slack Message Format (keep it short!)
The Slack DM must be **5 bullets or fewer**:
1. 📋 "X open decisions, Y stale (>14 days)" — counts only
2. 🔴 Top 1-2 stale decisions that need attention — name + owner + days open
3. ✅ Decisions made this week — 1-2 line summary
4. ⚠️ Undocumented decisions detected (if any) — flag briefly
5. 🔗 Link to full decision log if on Confluence

No full decision tables in Slack. Just the nudges.

### Open Decisions
List all open DACI/LDR/RFC pages with:
- **Decision title:** Clear, specific
- **Owner:** Who's driving it
- **Age:** Days since created
- **Status:** Pending input / stakeholder review / final decision pending / decided (not implemented)
- **Link:** Direct Confluence link

### Stale Decisions (>14 days no update)
Flagged decisions that haven't moved in 2+ weeks:
- **Decision title**
- **Last update:** How long ago
- **Current blocker:** Waiting on what? (input from X, alignment with Y, etc.)
- **Nudge:** Specific ask (e.g., "Needs final call from PMO by Friday")
- **Link:** Confluence link

### Decisions Made This Week
Summary of closed decisions:
- **Decision title**
- **Outcome:** What was decided
- **Owner:** Who made the call
- **Implementation:** Is this being handed off? Link to epic/ticket if yes
- **Link:** Confluence page

### Decisions Rejected This Week
What was explicitly rejected and why:
- **Option/proposal:** What was rejected
- **Reason:** Rationale documented
- **Alternatives:** What won if applicable
- **Link:** Confluence page

### Undocumented Decisions Detected
Verbal decisions spotted in Slack/meetings that need formal documentation:
- **Decision (inferred from Slack/transcript):** What was decided
- **Context:** Where was this made (Slack thread, meeting, 1:1)
- **Stakeholders involved:** Who should be on the DACI
- **Action:** Create DACI stub for this decision

## Delivery

### Slack DM
Send to channel `DFFF0J94G` with formatted blocks:
- **Open Decisions** as a numbered list (with age callouts for old ones)
- **Stale Decisions** in bold with 🚨 emoji
- **Decisions Made & Rejected** as a summary
- **Undocumented Decisions** flagged for immediate action
- CTA: "Reply to thread if you're unblocking anything"

## Memory

### Running Counters
Maintain in session log:
- **Total open decisions:** Track week-over-week (growing backlog vs. clearing)
- **Average age of open decision:** Alert if trending up
- **Stale decision count:** Trend to catch decision-making slowdowns
- **Undocumented decisions:** Count of verbal decisions needing write-ups

### Pattern Detection
Flag trends:
- **Decision backlog is growing?** → Escalate to leadership. Decision velocity is slowing.
- **Same decision re-litigated?** → Link to previous decision, escalate stakeholder misalignment.
- **Stale decisions all owned by one person?** → Capacity issue or context blocker? Call it out.
- **Undocumented decisions spike?** → Team isn't documenting. Reinforce discipline.

This prevents silent decision failure and keeps the org moving.

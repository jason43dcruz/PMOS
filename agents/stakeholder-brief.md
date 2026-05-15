---
name: Stakeholder Brief
schedule: manual
prompt: "Run the Stakeholder Brief orchestrator defined in agents/stakeholder-brief.md. A stakeholder name or meeting context should be provided. Fan out to sub-agents to gather relationship context, open decisions, and relevant knowledge, then synthesise into a single pre-meeting brief delivered via Slack DM."
---

# Agent Task: Stakeholder Brief (Orchestrator)

**Schedule:** Manual — triggered before a specific meeting or stakeholder interaction
**Type:** Orchestrator — fans out to sub-agents, synthesises into one pre-meeting brief
**Purpose:** Walk into any high-stakes meeting fully prepared. One brief covers the relationship history, open decisions, relevant knowledge, and a suggested agenda — assembled in under 2 minutes.

## How to Trigger

Run manually by saying:
> "Run stakeholder brief for [person name]" or "Prep me for my meeting with [person] about [topic]"

The orchestrator needs at minimum: **a stakeholder name**. Optionally: meeting topic, meeting time.

## Sub-Agents to Run

Run all three simultaneously as parallel sub-tasks using `invoke_subagents`.

| Sub-Agent | File | What It Contributes |
|---|---|---|
| Relationship Tracker | `agents/relationship-tracker.md` | Recent interaction history, relationship health, last touchpoints |
| Decision Documentation Reminder | `agents/decision-reminder.md` | Open decisions involving or relevant to this stakeholder |
| Knowledge Scout | `agents/knowledge-scout.md` | Recent docs, pages, or Jira issues relevant to the meeting topic |

In addition to the sub-agents, the orchestrator itself should:
- Read the stakeholder's decision profile from `Knowledge/` if one exists (e.g. `Knowledge/anand-narayanan-decision-profile.md`, `Knowledge/shamik-sharma-decision-profile.md`)
- Check Google Calendar for the specific meeting details (time, attendees, description, any linked docs)
- Pull recent Slack DMs with the stakeholder (last 14 days) using `channel_get_message`

## Orchestration Instructions

> **In-session efficiency:** Read `skills/in-session-orchestration.md` before running. This agent is always triggered from a live session — use `invoke_subagents` to fan out in parallel. Fire the three sub-agents simultaneously alongside your own direct lookups (calendar, Slack DMs, decision profile). Do not run them sequentially.

1. **Extract stakeholder name and topic** from the trigger prompt.
2. **Fan out simultaneously** in a single `invoke_subagents` call:
   - Invoke Relationship Tracker sub-agent (scoped to this stakeholder) — instruct: "Return text only, no Slack"
   - Invoke Decision Reminder sub-agent (scoped to decisions relevant to this stakeholder/topic) — instruct: "Return text only, no Slack"
   - Invoke Knowledge Scout sub-agent (scoped to the meeting topic) — instruct: "Return text only, no Slack"
   - **While subagents run**, directly: read decision profile from Knowledge/, pull calendar event, pull Slack DMs
3. **Collect all outputs.**
4. **Synthesise** into a single pre-meeting brief (see format below).
5. **Deliver once** to Slack channel `DFFF0J94G`.

## Output Format

Send a single Slack DM to `DFFF0J94G`. Keep it under one screen.

```
🤝 *Pre-Meeting Brief: [Stakeholder Name] — [Meeting Title or Topic]*
📅 [Time] | [Duration] | [Attendees]

*🧠 Who They Are*
[From decision profile: 2-3 bullet points on how they think, what they care about, how they make decisions. Skip if no profile exists.]

*📬 Where You Left Off*
[From Relationship Tracker + Slack DMs: last meaningful interaction — when, what was discussed, any commitments made. One line.]

*⚖️ Open Decisions Involving Them*
[From Decision Reminder: 1-3 open decisions where they're a driver, approver, or stakeholder. Decision name + status + link. "None" if clean.]

*📎 Relevant Context for This Meeting*
[From Knowledge Scout + calendar description + linked docs: 2-3 most relevant docs or pages. Title + one-line summary + link.]

*💬 Suggested Talking Points*
[Synthesised from all of the above: 2-3 concrete things to raise, ask, or resolve. Be specific.]

*⚠️ Watch Outs*
[From decision profile + open decisions: anything likely to create friction — known sensitivities, positions they've taken, undocumented decisions that could be re-litigated.]
```

## Synthesis Rules

- **Be specific, not generic.** "They care about data" is useless. "They pushed back on the Standard gating proposal in Feb — their concern was mid-market displacement" is useful.
- **Prioritise recency.** Weight interactions from the last 7 days over the last 30.
- **If no decision profile exists**, note it and suggest creating one after the meeting.
- **If a sub-agent fails**, note it and proceed with whatever data is available. Don't block on a single source.
- **Cap at one screen.** If there's more, cut. The goal is confidence walking in, not a research dossier.

## Infrastructure

### Confidence Scoring
- **[HIGH]** — decision profile exists + recent Slack DMs + sub-agents all returned data
- **[MEDIUM]** — 2 of 3 sources available
- **[LOW]** — minimal data (flag: "Limited context available — consider a pre-meeting check-in")

### Observability
Append to `Knowledge/session-log.md`:
`### [O] Stakeholder Brief Run ({time}) — Stakeholder: {name}, {X}/3 sub-agents completed, brief delivered`

### Post-Meeting
After the meeting, optionally run: "Update stakeholder brief for [name] — we discussed [topic], decided [X], next step [Y]."
This will update the decision profile and relationship tracker log for next time.

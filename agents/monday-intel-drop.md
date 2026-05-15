---
name: Monday Intel Drop
schedule: weekly-monday-8am
prompt: "Run the Monday Intel Drop orchestrator defined in agents/monday-intel-drop.md. Fan out to four sub-agents, collect their outputs, synthesise into a single Slack briefing."
---

# Agent Task: Monday Intel Drop (Orchestrator)

**Schedule:** Weekly, Monday 8am
**Type:** Orchestrator — fans out to sub-agents, synthesises into one delivery
**Purpose:** Replace four separate Monday morning Slack pings with a single, coherent start-of-week briefing. One message. One narrative. Everything that matters for the week ahead.

## Sub-Agents to Run

Run all four of these as parallel sub-tasks using `invoke_subagents`. Each sub-agent should follow the full instructions in its respective agent file.

| Sub-Agent | File | What It Contributes |
|---|---|---|
| Morning Briefing | `agents/morning-briefing.md` | Slack/Jira/Confluence mentions needing response + L1 KR status |
| Competitive Intelligence Digest | `agents/competitive-intel-digest.md` | Competitor moves in the past 7 days |
| Industry Trends Digest | `agents/industry-digest.md` | Top reads, data point, one provocation |
| Knowledge Scout | `agents/knowledge-scout.md` | New internal docs worth reading, curated against GOALS.md |

## Orchestration Instructions

> **In-session efficiency:** Read `skills/in-session-orchestration.md` before running. When triggered from a live session, use `invoke_subagents` to fan out in parallel — not sequential `acli` calls. Pass the full content of each agent file as context to each subagent, and instruct them to return text only (no Slack).

1. **Fan out simultaneously.** Invoke all four sub-agents in a single `invoke_subagents` call. Pass each one the full content of its agent file as context. Instruct each: "Return your output as text only — do NOT send any Slack messages."
2. **Collect outputs.** Wait for all four to complete. Capture their outputs.
3. **Do NOT send individual Slack messages** for each sub-agent. Suppress individual delivery — the orchestrator owns the single Slack send.
4. **Synthesise.** Combine the four outputs into one structured Slack message (see format below).
5. **Deliver once** to Slack channel `DFFF0J94G`.

## Output Format

Send a single Slack DM to `DFFF0J94G`. Keep it scannable — aim for under 2 minutes to read.

```
🗓️ *Monday Intel Drop — [DATE]*

*🚨 Needs Your Attention*
[From Morning Briefing: 1-3 items requiring a response today. One line each: who, what, link.]
[If none: "Nothing urgent. Clean inbox to start the week."]

*📊 L1 KR: ServCo Uplift*
[From Morning Briefing: current %, monthly milestone status, OKR score. One line.]

*⚔️ Competitive Pulse*
[From Competitive Intel: headline + top 2 competitor moves. Max 3 lines.]

*📰 Worth Reading This Week*
[From Industry Digest + Knowledge Scout: top 3 items combined. Title + one-line summary + link each.]

*🤖 AI Radar*
[From Industry Digest: top 1-2 AI/ML frontier developments from the past week. New models, tools, techniques, or paradigms worth knowing about. One line each. Skip if nothing notable — don't force it.]

*💡 One Thing to Think About*
[From Industry Digest: the provocation question. One line.]

*🔗 If you want more detail:*
[Links to any Confluence pages published by sub-agents]
```

## Synthesis Rules

- **Prioritise action over information.** "Needs Your Attention" always comes first.
- **Merge overlapping content.** If competitive intel and industry digest surface the same item, show it once.
- **Cap total length.** If there's too much, cut — don't expand. The goal is one screen, not a newsletter.
- **If a sub-agent fails or returns nothing**, note it briefly: "⚠️ Competitive intel unavailable this week."
- **Never send four separate messages.** One message only.

## Infrastructure

### Confidence Scoring
Tag the overall briefing with a confidence level based on how many sub-agents returned data:
- **[HIGH]** — all 4 sub-agents returned substantive output
- **[MEDIUM]** — 2-3 sub-agents returned output
- **[LOW]** — 0-1 sub-agents returned output (flag this)

### Observability
Append to `Knowledge/session-log.md`:
`### [O] Monday Intel Drop Run ({time}) — {X}/4 sub-agents completed, {Y} action items surfaced`

### Memory & Deduplication
- Read last week's Monday Intel Drop entry from session-log.md before synthesising
- Do not resurface competitive or industry items from the previous week unless materially updated

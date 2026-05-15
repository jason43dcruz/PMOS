# Skill: In-Session Orchestration

## When to Use This Skill

When you are running **inside a live Rovo Dev session** and need to fan out work to multiple sub-agents, use `invoke_subagents` — **not** `acli rovodev run`.

The shell orchestrator (`run-agents.sh`) exists for **unattended cron runs**. When a human is present in a session, `invoke_subagents` is always faster, more efficient, and more reliable.

---

## The Pattern

### 1. Fan out in parallel — always

Never invoke sub-agents sequentially. Always fire them simultaneously in a single `invoke_subagents` call. This is the whole point.

```
invoke_subagents(
  subagent_names=["General Purpose", "General Purpose", "General Purpose"],
  task_names=["Agent A", "Agent B", "Agent C"],
  task_descriptions=[
    "Full context for agent A...",
    "Full context for agent B...",
    "Full context for agent C..."
  ]
)
```

### 2. Pass full context in each task description

Subagents have no access to conversation history or the workspace — only what you give them. Each task description must be **self-contained**:

- Include the full agent file content (copy the relevant sections)
- Include any scoping parameters (stakeholder name, topic, date range)
- Include the instruction: **"Return your output as text only — do NOT send any Slack messages. The orchestrator will handle delivery."**
- Include relevant goal context from GOALS.md if the sub-agent needs it

### 3. Collect, synthesise, then deliver once

Wait for all sub-agents to complete. Then:
- Synthesise their outputs into a single message
- Send **one** Slack DM to `DFFF0J94G`
- Log the run to `Knowledge/session-log.md`

### 4. Handle failures gracefully

If a sub-agent returns nothing or errors, note it briefly in the final output (`⚠️ [Agent Name] unavailable`) and proceed with available data. Never block the synthesis on a single missing source.

---

## Subagent Names to Use

Always use `"General Purpose"` as the subagent name for PM-OS agents. Each General Purpose subagent gets its own isolated context.

Up to **4 subagents** can run concurrently in a single `invoke_subagents` call. If you have more than 4, batch them: run the first 4, wait, then run the remainder.

---

## In-Session vs Cron: How to Know Which You're In

| Context | Signal | Use |
|---|---|---|
| Live session (human present) | User triggered the agent via chat | `invoke_subagents` |
| Cron / unattended | `run-agents.sh` triggered via launchd | `acli rovodev run --yolo` |

When in doubt: if you're reading this skill file, you're in a live session. Use `invoke_subagents`.

---

## Example: Monday Intel Drop (In-Session)

```
invoke_subagents(
  subagent_names=["General Purpose", "General Purpose", "General Purpose", "General Purpose"],
  task_names=["Morning Briefing", "Competitive Intel", "Industry Digest", "Knowledge Scout"],
  task_descriptions=[
    "Run the Morning Briefing agent. [full agent file content]. Return text only — no Slack.",
    "Run the Competitive Intelligence Digest agent. [full agent file content]. Return text only — no Slack.",
    "Run the Industry Trends Digest agent. [full agent file content]. Return text only — no Slack.",
    "Run the Knowledge Scout agent. [full agent file content]. Return text only — no Slack."
  ]
)
```

Then synthesise all four outputs and send a single Slack DM.

---

## Performance Expectation

- **Sequential `acli` calls:** 4 agents × ~3 min each = ~12 minutes
- **Parallel `invoke_subagents`:** All 4 run simultaneously = ~3 minutes total

That's a 4× speedup minimum. Always fan out.

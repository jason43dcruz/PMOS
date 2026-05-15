# Skill: Create Agent

Create a `.md` file in `agents/` with frontmatter. The orchestrator auto-discovers it — no other files to edit.

## Frontmatter Template

```
---
name: My Agent Name
schedule: daily-8am
prompt: "Reference the agent file path so Rovo Dev reads the full instructions."
---
```

**Schedules:** `daily-8am` | `hourly` | `weekly-monday-8am` | `weekly-friday-4pm` | `manual`

## Conventions

- Lowercase hyphenated filenames: `agents/my-agent.md`
- Include delivery method (Slack DM to `DFFF0J94G`, file output, or in-session)
- Include a tools table listing MCP tools the agent needs

---

## Orchestrator Pattern

An orchestrator is an agent that fans out to multiple sub-agents, collects their outputs, and synthesises into a single delivery. Use this pattern when you want one coherent output instead of several separate Slack pings.

### When to use it
- Multiple agents produce related outputs that are more valuable combined
- You want one Slack message instead of several
- The synthesis step adds meaning (e.g. cross-referencing competitive intel with open decisions)

### How to build one

1. **Create an orchestrator `.md` file** in `agents/` — same structure as any agent
2. **List the sub-agents** it will invoke (by file path)
3. **Use `invoke_subagents`** in the prompt to fan out simultaneously — pass each sub-agent the full content of its agent file as context
4. **Suppress individual Slack sends** from sub-agents — the orchestrator owns the single delivery
5. **Define a synthesis format** — what sections appear, in what order, at what length

### Key rules
- **One Slack message only.** Never let sub-agents each send their own message.
- **Fan out simultaneously.** Run sub-agents in parallel, not sequentially.
- **Degrade gracefully.** If a sub-agent fails, note it and synthesise from what's available.
- **Cap length.** The synthesised output should be shorter than the sum of its parts.

### Existing orchestrators

| Agent | File | Sub-Agents | Schedule |
|---|---|---|---|
| Monday Intel Drop | `agents/monday-intel-drop.md` | Morning Briefing, Competitive Intel, Industry Digest, Knowledge Scout | `weekly-monday-8am` |
| Stakeholder Brief | `agents/stakeholder-brief.md` | Relationship Tracker, Decision Reminder, Knowledge Scout | `manual` |

# AI PM Craft — Decisions Made

## What this page is

Decisions about how to apply AI to PM work. What works, what doesn't, what we've stopped doing.

---

## Settled Decisions

### 1. Agents for recurring work, prompts for one-off (Mar 2026)
**Decision:** If you've done the same synthesis 3+ times, build an agent. Otherwise, prompt ad-hoc.
**Reasoning:** Agent overhead (file, schedule, observability) isn't worth it for one-off tasks. But for recurring scans (morning briefing, competitive intel), the compound value is high.

### 2. One Slack message per orchestrator, not per sub-agent (Mar 2026)
**Decision:** Orchestrators own the delivery. Sub-agents never send their own Slack messages.
**Reasoning:** Multiple pings per run creates noise. One synthesised message is more valuable and less disruptive.

### 3. Always read context before drafting (Apr 2026)
**Decision:** Every drafting task starts with reading knowledge-refs, source docs, and session history. No "cold" generation.
**Reasoning:** LLM output without internal context defaults to generic frameworks. With context, output is dramatically more useful and requires less editing.

### 4. Rewrite from source, never from summary (Apr 2026)
**Decision:** When rewriting a TL;DR or executive summary, derive it from the underlying content — never recycle the existing summary.
**Reasoning:** The whole point of a rewrite is fresh synthesis. Editing an existing summary just polishes the same framing.

### 5. Write-like-me skill applied to all drafting (Apr 2026)
**Decision:** Every written output reads `write-like-me.md` first. This includes Confluence, strategy docs, summaries, rewrites.
**Reasoning:** Consistency of voice builds trust. Readers shouldn't be able to tell which parts are AI-assisted.

---

## Things Explicitly Rejected

### "Let the AI write the full doc end-to-end"
**Rejected:** AI amplifies thinking, it doesn't replace it. The PM owns the argument. AI handles synthesis, formatting, and draft generation. The PM edits, validates, and decides.

### "Build a general-purpose life wiki"
**Rejected:** Too broad. The LLM wiki is scoped to strategic PM work (editions, AI craft). Not personal knowledge management.

---

## Related pages

- [[ai-agent-design]]
- [[prompt-engineering-for-pms]]
- [[strategy-sparring]]

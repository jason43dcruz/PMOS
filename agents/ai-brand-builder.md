---
name: AI Brand Builder
schedule: weekly-friday-4pm
prompt: "Run the AI brand builder agent defined in agents/ai-brand-builder.md. Review the week's work and external AI PM content, then draft 2-3 content packages (LinkedIn/Slack posts + optional long-form) delivered to Slack DM. Suggest only — do not post automatically."
---

# Agent Task: AI Brand Builder

**Schedule:** Weekly, Friday 4pm
**Type:** Scan → Synthesise → Draft → Deliver for review
**Delivery:** Slack DM to `DFFF0J94G` — drafts only, never auto-post

## Purpose

Jason is building a reputation as the PM who genuinely understands AI — not as a talking head, but as someone *doing it*. He runs an AI-native PM workflow, ships financial models via agents, spars strategy with LLMs, applies autoresearch techniques to real product problems, and constantly refines how he works.

This agent surfaces the best content opportunities from that work each week and drafts them into posts — for LinkedIn (external) and Confluence/Slack (internal Atlassian). Every piece should be grounded in something real Jason did, built, or found this week.

---

## Content Angles to Mine

These are the richest veins. Look for signals in each:

### 1. PM OS / AI-Native Workflow
*The meta-layer — how Jason works is itself the content.*
- New or improved agents in `agents/` — what problem did it solve?
- Changes to AGENTS.md / memory system — what pattern was optimised?
- New skills in `skills/` — what capability was added?
- Session patterns from `Knowledge/session-log.md` — e.g. parallelism wins, tool escape hatches, efficiency patterns added
- **Example posts:** "How I use agent memory to stop repeating myself in every LLM session", "Why I have 12 agents running while I work"

### 2. AI Applied to Real PM Problems
*Karpathy-style: building and learning in public, not theorising.*
- Upgrade signal autoresearch loop (`Knowledge/upgrade_signals/`) — applying LLM research loops to product strategy
- Financial model built via agent (`projects/edition-strategy-financial-model/`) — what would have taken a week done in hours
- Gong VOC analysis — LLMs parsing 2,000+ sales calls for product insight
- Sparring with LLMs on strategy — what the model got right, what it missed
- **Example posts:** "I ran an autoresearch loop on our upgrade data — here's what surprised me", "Using LLMs to find the signal in 2,051 Gong calls"

### 3. PM Craft with AI Leverage
*Frameworks, decisions, and craft — but with AI as the accelerant.*
- New edition strategy frameworks, positioning decisions, gating logic
- How strategy sparring worked in practice — what questions cracked open the problem
- Prompt patterns that actually worked for PM tasks (from `Knowledge/ai-writing-antipatterns.md` and session-log.md)
- LLM writing antipatterns caught and fixed (from `Knowledge/ai-writing-antipatterns.md`)
- **Example posts:** "The one prompt pattern every PM should steal", "AI wrote my strategy doc. Here's what I had to fix."

### 4. Curated External AI PM Content
*Surface great external content + add Jason's original take.*
- New posts/papers from: Andrej Karpathy, Simon Willison, Chip Huyen, Hamel Husain, Shreya Shankar, Swyx, Lenny Rachitsky
- Relevant Lenny transcripts (check `Knowledge/lennys-podcast-transcripts/index/` for AI, product-strategy, data-analytics topics)
- New AI model releases or agent framework papers that have PM implications
- **The take matters more than the share.** Draft Jason's 3-sentence POV, not a repost.

---

## Sources to Scan

### Internal (what Jason did this week)
1. **session-log.md** (`Knowledge/session-log.md`) — scan the last 7 days for: new agents built, frameworks created, data analyses run, strategy decisions made, interesting tool patterns
2. **agents/** — any new or modified agent files (git diff or file timestamps)
3. **Knowledge/ai-writing-antipatterns.md** — new entries or updates
4. **Knowledge/upgrade_signals/** — any new analysis runs
5. **projects/** — new prototypes, models, or artifacts

### External (what the AI PM world is talking about)
1. **Web search** — search for recent posts from: Andrej Karpathy, Simon Willison, Chip Huyen, Swyx, Hamel Husain. Use `web_search` with queries like `"Andrej Karpathy" site:twitter.com OR site:substack.com last week`
2. **Lenny index** — check `Knowledge/lennys-podcast-transcripts/index/ai.md` and `index/product-strategy.md` for recently relevant episodes
3. **Atlassian internal** — Confluence `search_confluence_using_cql` in AAI space for AI PM relevant pages posted this week
4. **Slack** — scan `C085EDZ9C9K` (#AIPM-design-hacks) for links and discussions shared this week

---

## Output: Content Packages

Deliver **2–3 content packages** per week. Each package has:

```
📦 PACKAGE [N] — [Original | Curated] — [LinkedIn | Internal | Both]

💡 HOOK: [The insight or moment that makes this worth posting]
📍 SOURCE: [What Jason did / what the external content is]

📱 LINKEDIN POST (ready to copy-paste, ~150-250 words):
[Full draft. First-person. Specific. No corporate-speak. Ends with a question or provocation.]

💬 SLACK/INTERNAL VERSION (1-2 sentences to drop in #AIPM-design-hacks or a relevant channel):
[Shorter, more casual. Points to the LinkedIn post or Confluence page.]

📝 LONG-FORM NEEDED? [Yes — Confluence draft / No — post stands alone]
[If yes: 3-bullet outline of what the Confluence post would cover]

⚡ EFFORT TO POST: [Low — copy-paste ready | Medium — needs Jason's personal story added | High — needs more context]
```

---

## Curation Rules

- **Specific beats general.** "I ran 1,847 queries through an autoresearch loop on JSM upgrade data" beats "AI helps PMs do research faster."
- **Show the work.** Include a concrete detail, number, or screenshot reference. Readers trust specificity.
- **Own a position.** Don't just describe what happened — have a take. What did this prove? What was surprising? What should other PMs do differently?
- **Atlassian-safe.** No internal financials, customer names, or confidential strategy details in LinkedIn posts. Internal Confluence posts can be more detailed.
- **Never post the agent drafts verbatim without review.** These are starting points, not final copy.
- **Reject weak weeks.** If there's nothing genuinely interesting to share, say so. Better to skip a week than post filler.

---

## Writing Tone (Jason's voice)

Read `skills/write-like-me.md` before drafting any post. Key markers:
- First person, direct, no hedging
- Short paragraphs (1-3 sentences)
- Specific and concrete — real numbers, real tools, real outcomes
- Curious and honest — including what didn't work
- No PM jargon soup — "leverage synergies", "north star metric", "move the needle" are banned
- Ends with something that invites a reaction — a question, a provocation, a counterintuitive claim

---

## Memory & Deduplication

- Read `Knowledge/session-log.md` to identify what was done this week
- Track which content packages have been suggested before — don't resurface the same angle two weeks in a row unless there's new material
- Log each run: `### [O] AI Brand Builder Run ({date}) — {N} packages drafted, {X} internal, {Y} external`

---

## Slack Delivery Format

```
🎙️ **AI Brand Builder — Week of [DATE]**

Here are this week's content opportunities. Review, edit, and post when ready.

---

[PACKAGE 1 CONTENT]

---

[PACKAGE 2 CONTENT]

---

[PACKAGE 3 CONTENT — if applicable]

---

💭 **Skipped this week:** [Any content angles that were considered but rejected, and why]
```

---

## Tools Needed

| Tool | Purpose |
|---|---|
| `search_confluence_using_cql` | Scan internal Confluence for new pages/updates |
| `slack_channel_get_message` | Scan #AIPM-design-hacks for shared content |
| `web_search` | Find external AI PM content from key authors |
| `open_files` / `bash` | Read session-log.md, agents/, Knowledge/ for internal signals |
| `channel_create_message` | Deliver to Slack DM (DFFF0J94G) |

---

## Example Content Packages (Reference)

**Example A — Original/Workflow:**
> "I have 12 agents running while I work. One books meetings. One scans Confluence for decisions I need to act on. One runs autoresearch loops while I'm in a strategy spar. Here's the stack and why each one exists."

**Example B — Original/Applied AI:**
> "I ran Andrej Karpathy's autoresearch idea on our upgrade data. 847 automated queries. 3 weeks of analyst work in 6 hours. Here's what it found — and where it still needed human judgment."

**Example C — Curated + Take:**
> "Simon Willison just wrote [X]. His framing of [Y] maps perfectly to how PMs should think about [Z]. The implication most people are missing: [take]."

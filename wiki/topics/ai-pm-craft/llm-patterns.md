# LLM Patterns for PM Work

## Sources
- AGENTS.md (Agent Infrastructure section)
- efficiency-patterns.md (known failure modes and workarounds)
- Session logs (May 2026)

---

## What This Is

Practical patterns that work (and don't work) when using LLMs for PM tasks. These are lessons learned from 6+ months of AI-assisted PM work in this workspace.

---

## Patterns That Work

### 1. Parallelism Beats Sequencing
**Pattern:** When you have independent tasks, invoke them all at once instead of one-by-one.

**Example:** Pulling a data point, reading a Confluence page, and running a query.
- ❌ **Sequential:** 3 iterations (read → data → query)
- ✓ **Parallel:** 1 iteration (all three at once)

**Expected speedup:** 3-4× faster to resolution.

**Constraint:** Only works for truly independent tasks. If task B needs output from task A, you must sequence.

### 2. Subagents for Background Work
**Pattern:** Use subagents (`invoke_subagents`) for work that shouldn't block the conversation. You stay engaged; they work in parallel.

**Best for:**
- Pulling a data point while you're mid-spar
- Running a long Databricks query while you're drafting
- Scanning Confluence while discussing strategy

**Not for:**
- Hand-offs (don't hand off the whole conversation)
- Synchronous decisions (you need to be present)

### 3. Specificity + Context
**Pattern:** The more specific your request, the better the output. Always include:
- Exact numbers (not "increase by a lot" → "drive Standard→Premium by 15%")
- Real customer data (not "some customers" → "3,782 signal-ready tenants")
- Specific failure modes (not "it didn't work" → "37% of Premium have zero engagement with gated features")

**Example:**
- ❌ "Help me think through Premium strategy"
- ✓ "We have 37% feature disengagement in Premium, 56% of MRR, but $23.3M in enterprise-segment revenue sitting here. How do we unlock the Premium→Enterprise move without raising prices 4× in one jump?"

### 4. Output Format Specification
**Pattern:** Define exactly what you want back (structure, length, format, tone).

**Example:**
- ❌ "Give me some thoughts on this"
- ✓ "Give me 3 pressure-test questions (each 1-2 sentences) that would challenge this edition strategy."

The specificity cuts hallucination by 60-70%.

### 5. Reference + Reasoning
**Pattern:** When you disagree with LLM output, call out the specific claim and ask why.

**Example:**
- ❌ "That doesn't seem right"
- ✓ "You said 'Premium doesn't have PMF.' What data backs that up? The signal analysis shows 8.5% of Standard tenants are upgrade-ready, so Premium does have a landing motion."

This separates true errors (call them out) from disagreements (dig deeper).

---

## Failure Modes & Mitigations

### Mode 1: Hallucinated Numbers
**Symptom:** LLM cites a fact that sounds right but isn't in your data.

**Example:** "Based on the edition strategy, Standard should be 35% of MRR" (actual: 28%).

**Fix:**
1. Always cite sources in your request ("From the Exec View v2 page dated May 14…")
2. Run data-insight-checker before citing findings
3. One-sentence fact-checks on any number >5 years old or from secondary sources

### Mode 2: Context Window Drift
**Symptom:** Mid-conversation, LLM "forgets" something you said 5 iterations ago.

**Fix:**
- Restate critical context in long conversations
- Save key decisions to a temp file and reference it
- If drift is obvious, pause and ask: "Can you re-read [specific doc/file] to get back on track?"

### Mode 3: Framework Overfit
**Symptom:** LLM applies a generic PM framework (SJF, RICE, OKR) that doesn't fit your context.

**Example:** "Use OKRs to structure edition strategy" (you already have a specific strategy; you need sparring, not structuring).

**Fix:**
- Name the problem type first ("This is a pricing question, not a product strategy question")
- Reject frameworks; ask for specific analysis instead
- If it keeps happening, the prompt needs more context

### Mode 4: Missing Domain Knowledge
**Symptom:** LLM treats JSM and ServCo as separate products, or doesn't know about the DC migration tailwind.

**Fix:**
- Always include domain context in the prompt (2-3 bullet points of non-obvious setup)
- For strategy work, link to the source Confluence page or Secoda doc
- Flag this: "Don't assume you know the domain. Ask me before applying frameworks."

---

## Context Management

### What to Include (Speeds Up Output)
1. **Real numbers** (not ranges or estimates)
2. **Customer quotes** (direct voice > summarized insight)
3. **Decision constraints** (budget, timeline, team capacity)
4. **Failed approaches** (what we tried that didn't work)
5. **Explicit disagreements** (where you think the data is wrong)

### What to Exclude (Slows Down Output)
1. **Boilerplate** (meeting notes, full chat transcripts)
2. **Old context** (decisions from 6+ months ago that are stale)
3. **Conflicting sources** (if you have 3 different numbers, resolve before asking)
4. **Vague aspirations** ("grow faster," "be more customer-centric")

### Pattern: Context Handoff
When moving between tasks or conversations, briefly recap:
- What you decided
- What changed your mind
- What you're unsure about

**2-3 sentences.** This saves 2-3 iterations of re-explaining.

---

## PM-Specific Use Cases

### Sparring / Pressure-Testing
**Works best:** When you have a draft and need pushback.
**Setup:** Load `skills/strategy-sparring.md`, give LLM the draft + your key metrics, ask for specific moves (Move 1: internal contradiction, Move 2: alternate conclusion, etc.)
**Output quality:** HIGH (moves are structured, concrete, based on data)

### Data → Narrative
**Works best:** When you have SQL results and need a story.
**Setup:** Paste the data, ask for narrative + key finding + implications + next step. Specify tone (executive, analytical, conversational).
**Output quality:** MEDIUM-HIGH (good at synthesis, sometimes needs fact-checking)

### Stakeholder Communications
**Works best:** For drafts and tone adjustment.
**Setup:** Give the core message + audience + tone + constraints (word count, no jargon). Ask for a first draft.
**Output quality:** MEDIUM (drafts are useful, usually need 1-2 rounds of editing)

### Prompt Engineering
**Works best:** When you need a specific output format.
**Setup:** Define the task precisely, give an example of the output you want, ask for refinement.
**Output quality:** HIGH (LLMs are good at understanding format requirements)

### Code / SQL Generation
**Works best:** For boilerplate, not for novel logic.
**Setup:** Give exact requirements, specify technology (Python 3.11, Databricks SQL, etc.), ask for implementation.
**Output quality:** MEDIUM (works for templates, needs testing before running)

---

## Retry Strategy

**Rule:** One retry per tool call. If it fails twice, move on.

**When to retry:**
- Same prompt, different LLM model
- Prompt with slightly more context
- Asking for a different output format

**When to stop retrying:**
- Infrastructure error (API rate limit, auth failure)
- Hallucination (LLM making up facts that don't exist in your data)
- Context confusion (LLM misunderstood the domain)

In those cases, either simplify the task or hand it off to a human.

---

## Related pages
- [[strategy-sparring]] — How to use LLMs for strategy pressure-testing
- [[prompt-engineering-for-pms]] — How to write effective prompts
- [[ai-writing-antipatterns]] — What robotic language looks like

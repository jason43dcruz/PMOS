# Strategy Sparring with AI

## Sources
- skills/strategy-sparring.md (the full sparring skill)
- AGENTS.md (Brainstorming & Sparring section)
- efficiency-patterns.md (known patterns from live sessions)

---

## What This Is

How to use AI for strategy pressure-testing. Not just validation — actual, useful pushback that helps you find the flaws in your thinking.

---

## When to Use Sparring (And When Not To)

### Use AI Sparring When:
- You have a draft and need pressure-test
- You want specific moves (internal contradiction, alternate conclusion, data audit)
- You have real numbers and want to validate the story
- You're mid-strategy and need to pressure-test one claim

### Don't Use AI Sparring When:
- You haven't written anything yet (first, write the draft; then spar)
- You're looking for validation (that's not sparring; that's asking for a hug)
- The strategy relies on customer feedback you haven't shared (AI can't evaluate what you haven't told it)
- You need a human decision (sparring surfaces the issue; a human decides)

---

## The Prep Step (Before You Ask)

Always read these first. Takes 5 minutes, saves 2-3 iterations.

### 1. Read Domain Context
For edition strategy sparring: Read the Edition Strategy — Executive View v2 page (6949208363) and supporting data pages. Know:
- Current MRR by edition
- Upgrade signals
- Competitive positioning
- LRP targets

For pricing sparring: Read P&P guidelines, competitive pricing map, discount headroom analysis.

For GTM sparring: Read the upgrade signal analysis, sales motion breakdown, customer acquisition costs.

**Why:** LLMs hallucinate when they don't have domain context. Give them the context upfront, and they spar way better.

### 2. Read Lenny's Greatest Hits
If you have a strategy question, the answer has probably been debated on Lenny's Podcast. Read `Knowledge/lennys-greatest-hits.md` to see what the best PMs think.

This prevents LLM from applying frameworks that don't fit. You can say: "Lenny episode X says this, but our context is different because..."

### 3. Write the Draft First
Don't ask AI to build your strategy. Write it first (even if rough). Then ask for sparring.

**Good draft for sparring:**
- Thesis (one sentence)
- 3-5 supporting points (with numbers where available)
- Open questions or uncertain parts
- What you're least confident about

**Bad input for sparring:**
- Just the problem ("Premium has low engagement")
- Just a framework ("Use RICE to prioritize")
- A question without context ("What should we do?")

---

## The 10 Sparring Moves

Use these in order of intensity. Start gentle (Move 1), escalate as needed (Move 10 if something feels really off).

### Move 1: Internal Contradiction
Find two claims in your draft that point in opposite directions. Force the question of which one is actually true.

**Your draft says:**
- Standard→Premium upgrade is driven by configuration complexity
- But also: 56% of Standard tenants show zero upgrade signals

**Sparring question:**
"If configuration complexity drives upgrades, why don't 56% of low-config tenants upgrade? What's different about them?"

**What this surfaces:** You're either missing a segment (some Standard tenants will never upgrade, and that's okay) or the signal is weaker than you thought.

### Move 2: Alternate Conclusion
Same data, different answer. Why is your interpretation right and the other one isn't?

**Your data:** $23.3M of enterprise-segment revenue in Premium (not Enterprise)

**Alternate conclusion:** "Just collapse to two tiers. Why spend effort upgrading these customers when they're happy in Premium?"

**Sparring question:**
"You could read this data and say: Premium is doing its job. Why is the move to Enterprise the right bet vs. just accepting Premium as the stable middle?"

**What this surfaces:** Whether Premium→Enterprise is a real lever or just nice-to-have growth.

### Move 3: Data Audit
For every claim on the page, ask: is there sufficient evidence? Be specific about which claims are solid and which are thin.

**Your draft:** "37% of Premium tenants have zero engagement with gated features."

**Sparring question:**
"Where does that 37% come from? Is it from a single measure (zero change management usage) or is it a composite (zero engagement with ANY gated feature)? How recent is the data? Could it be tenure-biased (new Premium customers engaging slower)?"

**What this surfaces:** Which parts of your strategy rest on solid evidence and which ones need validation.

### Move 4: Source Verification
Don't trust numbers you created. Go back to the source and check if they're being applied correctly.

**Your draft:** "77% of Enterprise purchases are driven by DC migration"

**Sparring question:**
"That 77% — is it from the Supporting Data page? Let me re-read... it says those are 'structural events driving upgrade velocity.' Does DC migration = Enterprise upgrade, or is it being used to explain something else?"

**What this surfaces:** Misapplied evidence (right data, wrong context).

### Move 5: Unwritten Assumption
Surface the thing everyone's thinking but nobody has written down. Usually the most important claim.

**Your draft:** Talks about Premium activation, but never states the core assumption.

**Sparring question:**
"You're saying Premium doesn't have PMF. That's the most important sentence and it's nowhere on the page. If Premium doesn't have PMF, what does that mean for the business in 12 months?"

**What this surfaces:** Assumptions you're operating under but haven't made explicit.

### Move 6: Misapplied Evidence
Check whether a data point is being used in the right context.

**Your draft:** Uses automation rules as a Standard→Premium upgrade signal.

**Sparring question:**
"The automation rule limit (10 in Standard, 50 in Premium) — is that actually driving upgrades? Or are we confusing signal with need? Could Premium rule complexity be 'nice to have' rather than 'need to have'?"

**What this surfaces:** Whether a feature gate is actually creating upgrade pull.

### Move 7: Adjacent Implications
Read external docs (roadmap, timelines, decisions) and ask: does this change the strategy?

**Your draft:** Plans to fix Premium activation in Q2 FY27.

**Sparring question:**
"AI Control Tower ships Q3 FY27. That's the structural unlock for Premium→Enterprise. If activation improvements don't land until Q2, are we building the floor before the ceiling?"

**What this surfaces:** Sequencing risks and dependency gaps.

### Move 8: Sequencing Test
Ask what has to be true first, and in what order.

**Your draft:** Proposes Premium pricing and Premium→Enterprise upsell motion.

**Sparring question:**
"What are the three things that have to be true before this motion works? (Spoiler: probably Premium activation > Enterprise feature adoption > Sales enablement.) In what order do we need those?"

**What this surfaces:** Hidden dependencies and prerequisites.

### Move 9: Dangerous Misread
Ask what your audience could walk away believing that would be wrong.

**Your draft:** Positions Standard as the "simple" edition.

**Sparring question:**
"What's the one thing the sales team could misunderstand that would be dangerous? (Spoiler: they might think Standard is where you land customers to upsell them fast. But actually, 56% of Standard will never upgrade.)"

**What this surfaces:** Messaging gaps and unintended interpretation.

### Move 10: Constraint or Choice?
Is this something you're deciding, or a constraint you're operating within? Name it.

**Your draft:** "We can't raise Enterprise pricing."

**Sparring question:**
"Is that a real constraint (customer will churn) or a sales psychology constraint (we're uncomfortable asking)? What would happen if we tested a price increase?"

**What this surfaces:** Whether you're constrained by reality or by fear.

---

## PM OS Workflow: Live vs Async Sparring

### Live Sparring (With Jason, In-Session)
**When:** During a strategy working session, mid-draft.

**Setup:**
1. Read the Confluence page or draft
2. Read domain context (Edition Strategy Exec View, competitive data, etc.)
3. Load `Knowledge/lennys-greatest-hits.md` for relevant frameworks
4. Ask one sparring question at a time

**Example flow:**
- You: "Here's the edition strategy draft."
- AI: "Move 1: Internal contradiction. Standard→Premium is driven by config complexity, but 56% of Standard show zero signals. Why?"
- You: "Those 56% will never need more complexity. Single-queue, informal processes."
- AI: "So Edition identity is 'who you are,' not 'where you'll grow.' Is that explicit on the page?"

**Pace:** One move per iteration. Don't dump all 10 at once.

### Async Sparring (Via Agent, No Human Present)
**When:** You want a proactive spar without waiting for a live conversation.

**Setup:**
1. Create a Confluence draft
2. Invoke the `pm-buddy` agent with link to the draft
3. Agent reads it, infers what to pressure-test, delivers spar to Slack

**What pm-buddy does:**
- Reads domain context automatically
- Runs 5-6 of the most relevant sparring moves
- Delivers a threaded Slack message with questions

**Timing:** Don't use pm-buddy during a live session (adds latency with no benefit). Use it async for overnight feedback.

---

## How to Get Useful Pushback (Not Validation)

### The Setup Matters
If you ask "Is this good?" you'll get validation.  
If you ask "Where's the flaw?" you'll get sparring.

**What to say:**
- "I built this. I'm biased. Find the flaw."
- "What's the claim I'm least confident about?"
- "What data am I weak on?"
- "What would change your mind about this strategy?"

**What not to say:**
- "Is this right?"
- "Do you agree?"
- "This is my best thinking — what do you think?"

(The last one invites agreement, not criticism.)

### Respond to Sparring Questions
When AI asks a sparring question, answer it honestly. Don't defend your draft.

**Bad response:** "No, that assumption is implicit."  
**Good response:** "You're right, it's not explicit. And actually, I'm not sure it's true."

Once you admit the gap, you've found where to focus.

### When Sparring Reveals a Real Problem
**Example:** "Move 3: Data audit. The 37% engagement number is from a single measure (zero change management usage). You don't know if customers are using ITAM, automation, or advanced reporting."

**Your response:** "That's a real gap. I need to re-slice this data to understand what 'engagement' actually means."

**Next action:** Go fix the data before finalizing the strategy. This is what sparring is for.

---

## Common Traps to Avoid

### Trap 1: Sparring Without Data
If you don't have numbers to back up your claims, sparring won't help. You'll just get abstract critique.

**Fix:** Before asking for sparring, fill in the numbers. Even rough estimates are better than blanks.

### Trap 2: Asking for Sparring When You Mean Strategy Building
"Help me build the Premium strategy" ≠ "Spar on the Premium strategy I wrote."

**Fix:** Write the first draft yourself (rough is fine). Then ask for sparring.

### Trap 3: Too Many Moves at Once
If you ask AI to run all 10 moves, you get 10 surface-level critiques instead of 3-4 deep ones.

**Fix:** Ask for 2-3 moves per round. Go deep on the ones that sting.

### Trap 4: Ignoring the Sparring Because It's AI-Generated
"An LLM said this, so it's probably wrong" is as bad as "An LLM said this, so it's definitely right."

**Fix:** Evaluate the sparring question on merit, not source. If it makes you think, it's useful sparring.

---

## Related pages
- [[llm-patterns]] — Patterns that work for PM work
- [[prompt-engineering-for-pms]] — How to write effective prompts
- [[ai-writing-antipatterns]] — What robotic language looks like

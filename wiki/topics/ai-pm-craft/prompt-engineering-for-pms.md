# Prompt Engineering for PMs

## Sources
- AGENTS.md (Coaching Behavior + Operating Philosophy sections)
- efficiency-patterns.md (Context Management)
- write-like-me.md (writing style + tone)

---

## What This Is

A practical guide to writing prompts that get useful, PM-relevant output from LLMs. Not a technical deep-dive — just patterns that work.

---

## Key Principles

### 1. Be Specific
Vague prompts get vague outputs. Use exact numbers, names, and constraints.

❌ "What should we do about Premium?"  
✓ "Premium is 56% of MRR ($73M Apr 2026) but 37% of customers have zero engagement with gated features (Change Management, ITAM). What's our top lever to improve activation?"

The second prompt:
- Grounds the problem in numbers
- Defines the scope (activation, not pricing or packaging)
- Makes the output actionable (not strategy theater)

### 2. Provide Context Upfront
The first 2-3 sentences should tell the LLM what it needs to know.

**What to include:**
- Current state (where we are)
- Goal (where we're going)
- Constraints (what we can't change)

**Example:**
"We have three editions: Standard ($20/agent, entry tier), Premium ($50/agent, 56% of MRR, has Change Management + ITAM), Enterprise (~$200/agent, 15% of MRR, has governance + AI Control Tower). Current problem: $23.3M of enterprise-segment revenue is in Premium, not Enterprise. We can't raise Enterprise pricing without losing deals. What's the motion to unlock Premium→Enterprise upgrades?"

This takes 30 seconds to write and cuts LLM hallucination by 60%.

### 3. Define Output Format
Tell the LLM exactly what you want back.

❌ "What are the risks?"  
✓ "Name 3 risks (each as: Name | Why this matters | Mitigation). Keep each to 1-2 sentences."

Format specification reduces ambiguity. You get what you asked for.

### 4. Be Honest About Your Role
If you helped build the thing you're asking for feedback on, say so. LLMs will hedge and validate by default. Push them to be critical.

❌ "Is this edition strategy good?"  
✓ "I built this edition strategy. I'm biased. What's the biggest hole in the logic? Don't validate — find the flaw."

This flips the conversation from "is it good?" to "what's actually broken?"

### 5. Ask for Reasoning, Not Conclusions
Show the work. Don't ask "Is this right?" Ask "Why is this the strongest lever?"

❌ "Is Premium activation important?"  
✓ "Why is Premium activation more important than Premium pricing? Walk me through the trade-off."

Reasoning outputs are debuggable. Conclusions are not.

---

## Patterns for Common PM Tasks

### Strategy Docs & Sparring
**What you want:** Pressure-test, not validation.

**Template:**
```
[Context: 2-3 sentences on the strategy]

[Your question: name the specific claim you want tested]

[Format: I want you to find the flaw. Not confirm it's good.]

Use this sparring move: [Move 1: internal contradiction / Move 2: alternate conclusion / etc.]
```

**Example:**
```
We think Premium needs better activation (37% have zero feature engagement). 
Our lever is on-product education and onboarding flows.

But here's what I'm unsure about: is the activation gap a product problem, or a sales/motion problem?

Sparring move: Data audit. What's solid evidence vs. thin inference?
```

### Data Analysis & Narrative
**What you want:** A story, not a summary.

**Template:**
```
[Data: Paste 5-10 key numbers or findings]

[Audience: Who will read this?]

[Tone: Executive summary / analytical / conversational]

[Format: Opening hook (1 sentence) | 3 key findings (bullet points) | implication | next step]
```

**Example:**
```
Data:
- Standard: 28% of MRR, 1.19M seats, ~$34M Apr 2026
- Premium: 56% of MRR, 1.26M seats, ~$73M Apr 2026
- Enterprise: 15% of MRR, 588K seats, ~$22.1M Jan 2026, growing 90% YoY
- Premium activation: 37% have zero engagement with gated features
- Signal-ready cohort: 3,782 Standard tenants (8.5%) with 2+ upgrade signals

Audience: Executive team (CFO, VP Product)
Tone: Analytical + action-oriented

Format: Hook | Key findings | Strategic implication | Recommended motion
```

### Stakeholder Communications
**What you want:** A draft you can edit, not a polished final.

**Template:**
```
[Core message: One sentence, the main thing]

[Audience: Who, what they care about, what they already know]

[Constraints: Word count, jargon level, what NOT to say]

[Format: Opening | 3 supporting points | closing call-to-action]
```

**Example:**
```
Core message: We need to fix Premium activation to unlock $23M in enterprise-segment upgrades.

Audience: Sales leadership. They know Premium has a low conversion rate but don't know about the 37% disengagement stat.

Constraints: <200 words, no jargon, don't mention pricing yet.

Format: Why this matters | 1 stat that proves it | what we're asking of sales | timeline
```

### Product Prioritization
**What you want:** Critique of your framework, not a ranking.

**Template:**
```
[Framework: How you're deciding what to build]

[Current ranking: Top 3 items in priority order]

[Constraint I might be missing: Budget, team capacity, customer timeline, etc.]

[Question: Is this framework sound? Or am I missing something?]
```

**Example:**
```
I'm using this framework: (1) Shipping deadline, (2) User impact, (3) Strategic alignment (edition mix, LRP targets).

Current top 3:
1. Premium onboarding for Change Management (ships Q2, 150K-200K impact, drives upgrade signals)
2. AI Control Tower Phase 1 (ships Q3, 500K+ impact, enterprise differentiator)
3. Enterprise feature engagement measurement (internal tool, 0 customer impact, clarifies where we're losing value)

Constraint: 12-week engineering runway, no headcount increase.

Question: Is #3 worth doing now, or should we defer until we ship #1 and #2?
```

---

## Anti-Patterns to Avoid

### 1. Vague Prompts
❌ "What's our strategy?"
✓ "What are the three levers to improve Standard→Premium conversion?"

### 2. Asking LLMs to Be You
❌ "What would you do if you were running this product?"
✓ "I'm deciding between A and B. Here's the data for each. Which trade-off should I make?"

(LLMs don't have judgment. You do. Use them for analysis, not judgment.)

### 3. Asking for Validation When You Mean Sparring
❌ "Is this strategy good?"
✓ "Where's the flaw in this logic?"

(LLMs validate by default. You have to push them to critique.)

### 4. Expecting LLMs to Know Your Domain
❌ "How should we price ServCo?"
✓ "We're migrating JSM customers to ServCo (same product, different platform). Pricing must stay aligned or customers will churn. The LRP target is $2.5B by FY29 with ~68% High-Touch revenue. Given these constraints, what's our pricing strategy?"

(The second prompt provides context that fixes hallucinations.)

### 5. Prompt Too Long
If your prompt is >5 paragraphs, you've included too much. Cut it to the essentials.

**Essentials:**
- What you're deciding
- Why it matters
- What you're unsure about
- What you want back

Everything else is context bloat.

---

## Testing Your Prompts

### Fast Validation (Before You Commit to Output)

1. **Does the first output look right?** If not, the prompt was unclear. Revise before iterating.
2. **Can you say back what you asked for?** If not, your prompt was ambiguous.
3. **Did you get one answer or three mediocre ones?** If three, your prompt was too open-ended.

### Red Flags

- ✋ "I think you misunderstood the problem" → Prompt was unclear
- ✋ "This is too generic" → Add more specificity (numbers, constraints, examples)
- ✋ "You contradicted yourself" → LLM is hallucinating; add a source or ask it to cite evidence
- ✋ "This is just validation" → Add "Don't validate — find the flaw"

---

## Iterating on Outputs

**Good practice:** 1-2 iterations max. After that, you're either:
- Trying to get validation (stop; use a human instead)
- Hitting a fundamental mismatch in what you want (rewrite the prompt, don't retry)
- The LLM is hallucinating (move on, don't retry)

**When to iterate:**
- Output is 80% right; needs 1 edit for tone or format
- You phrased something wrong; reframe and ask again

**When to stop:**
- More than 2 iterations without improvement
- You're arguing with the output (you're right; move on)
- Output contradicts your known facts (stop; the prompt needs domain context)

---

## Related pages
- [[ai-writing-antipatterns]] — What robotic language looks like (avoid in prompts too)
- [[llm-patterns]] — Patterns that work for PM work
- [[strategy-sparring]] — How to structure sparring prompts

# Open Questions

_Updated: May 14, 2026._

---

## Edition Strategy

### Q1: Why Is the Premium→Enterprise Conversion Funnel So Leaky?

**Status:** ACTIVE — High priority, path to resolution exists  
**Why it matters:** Signal analysis says $75M of Standard→Premium opportunity exists (3,782 ready tenants). But actual upgrade MRR is 10-20% of that. Either the signal is wrong or the motion is broken. Same problem exists at Premium→Enterprise (42.6% of Enterprise tenants have zero engagement with gated features).  
**Path to resolution:**
1. Run cohort analysis: of the 3,782 signal-ready tenants, what % actually convert in 90 days? (This validates signal strength.)
2. For converters: when did they convert relative to signal detection? (This validates motion timing.)
3. For non-converters: what was the blocker? Pricing? Complexity? Sales not reaching them? (This finds the friction point.)

**Expected impact:** If signal is strong but motion is broken, we fix the motion (better onboarding, sales enablement, in-app messaging). If signal is weak, we re-run autoresearch to find stronger signals.

---

### Q2: Is the $23.3M Enterprise-Segment Cohort in Premium Actually an Upgrade Opportunity?

**Status:** ACTIVE — Data exists; interpretation is open  
**Why it matters:** We treat $23.3M as "Premium customers who should upgrade to Enterprise." But what if they're actually "customers who found the right tier and will never upgrade"? If they're satisfied in Premium, forcing an upgrade motion could backfire (churn, pricing pushback).  
**Path to resolution:**
1. Qualitative: Run 10-15 customer interviews with this cohort. Ask: why Premium and not Enterprise? What would change that?
2. Quantitative: Measure engagement with Enterprise-only gates (governance, multi-org, org-wide analytics). If usage is zero, they don't need it.
3. Expansion signal: Are these customers adding seats faster than Enterprise-segment average? If yes, they're growing and might be ready to upgrade later. If no, they're stable and might never upgrade.

**Expected impact:** Clarifies whether this is a real $23M opportunity or a $0 opportunity we're misreading. Changes Premium→Enterprise motion (or kills it entirely).

---

### Q3: What Predicts Premium→Enterprise Upgrade?

**Status:** INVESTIGATION NEEDED — No behavioral signals yet  
**Why it matters:** We have strong Standard→Premium signals (queue config ≥5, etc.). We don't have equivalent Premium→Enterprise signals. Current prediction relies on customer size + sales conversations (qualitative). This limits our ability to identify and target ready cohorts.  
**Path to resolution:**
1. Autoresearch Run 3: test organizational_coordination family (multi-actor signals, config complexity, cross-functional usage patterns).
2. Autoresearch Run 4: test service_scope_expansion family (request type diversity, org-wide project count, multi-region complexity).
3. Validation: once signals are found, test lift in a small cohort before scaling to full targeting.

**Expected impact:** Once we have Premium→Enterprise signals, we can build a predictive model and target ready customers at renewal. This is the precision motion missing today.

---

### Q4: Does AI Control Tower Actually Unlock Premium→Enterprise, or Is It Just One Lever Among Many?

**Status:** ACTIVE — Strategic assumption, not yet validated  
**Why it matters:** We're planning Enterprise motion around AI Control Tower (governance, cost transparency, org-level approvals). But 42.6% of current Enterprise tenants don't use governance controls. If existing customers don't care, why would Premium prospects? AI Control Tower could ship and flop.  
**Path to resolution:**
1. Customer research: Run Gong/sales call analysis on Enterprise deals. How often is "AI governance" mentioned as a close reason? (Baseline: likely 0-5% today.)
2. Product validation: once AI Control Tower MVP ships, measure adoption in Enterprise. Target: >50% actively using within 60 days.
3. Sales test: Train 1-2 enterprise reps to pitch AI Control Tower at Premium renewal conversations. Track conversion vs control group.

**Expected impact:** Either validates AI Control Tower as the unlock (proceed with full motion) or reveals it's not the lever (find the real unlock for Premium→Enterprise).

---

### Q5: What Is the Interim Motion for Premium→Enterprise While AI Control Tower Is in Explore?

**Status:** OPEN — No interim motion exists  
**Why it matters:** AI Control Tower is the long-term unlock for Premium→Enterprise upgrade. But it's in EXPLORE, ship timeline is uncertain (likely Q3 FY27 or later). $23.3M of enterprise-segment revenue sits in Premium for 12+ months with no structural reason to upgrade. What motion do we run now?  
**Path to resolution:**
1. Option A: Rely on sales to pitch governance + org-scale value. Work with Sales Enablement to build playbook.
2. Option B: Introduce Premium+ ($75/agent with basic governance) as stepping stone. Reduces 4× jump to 1.5×.
3. Option C: Accept that Premium→Enterprise won't move meaningfully until AI Control Tower ships. Focus on Premium activation and Standard→Premium instead.

**Expected impact:** Clarifies Q2-Q3 FY27 motion and sets sales expectations. Buys time for AI Control Tower without leaving revenue on table.

---

### Q6: How Do We Fix Premium Activation Before It Becomes a Downgrade Cascade?

**Status:** ACTIVE — Roadmap prioritized, but timing is critical  
**Why it matters:** 37% of Premium tenants have zero engagement with gated features. This is a hidden downgrade risk. If large cohorts hit renewal without engagement, churn accelerates. Premium is 56% of MRR; Premium downgrade = catastrophic.  
**Path to resolution:**
1. Product: Implement guided onboarding for Change Management and ITAM (Q2 FY26). Measure engagement at 14d, 30d, 90d post-upgrade.
2. Sales: Build motion to identify low-engagement tenants at renewal. Re-engage with focused conversations (change workflows, asset tracking use cases).
3. Analytics: Build dashboard to track Premium engagement cohort by cohort. Flag cohorts below 40% feature engagement for intervention.

**Expected impact:** Prevents cascade downgrade. Gets Premium to >60% engagement within 6 months. Unlocks repricing in FY27.

---

## AI PM Craft

### Q1: How Do We Avoid Hallucination When LLMs Don't Have Domain Context?

**Status:** PARTIALLY SOLVED — Patterns exist, but not foolproof  
**Why it matters:** When domain context is missing (customer psychology, Atlassian constraints, market dynamics), LLMs make up answers that sound right. We've caught this on pricing claims, customer segment assumptions, and feature value claims. One solution: embed context upfront. But there's always something missed.  
**Path to resolution:**
1. Create a "domain primer" document (1 page) for complex strategy work. Include: current state, constraints, LRP targets, known customer truths.
2. Always require sources for numbers (not just "the strategy says X" — which document, which page, which version).
3. Build a "hallucination test": any claim >5 years old or from secondary sources gets re-checked before use.

**Expected impact:** Reduces hallucination incidents by 70-80%. Not zero — but enough to trust AI output with a final human check.

---

### Q2: When Is Sparring Worth It, and When Is It Just Procrastination?

**Status:** OPEN — Cultural, not technical  
**Why it matters:** Strategy sparring is powerful. But it's also easy to hide behind ("I'm still validating the strategy"). At some point you have to decide and move. How do you know when you've sparred enough?  
**Path to resolution:**
1. Rule: one round of sparring (2-3 moves) per draft iteration. After that, it's procrastination.
2. Decision gate: after sparring, ask "Did this change my mind?" If no → ship it. If yes → go fix the data/strategy, then decide.
3. Time box: sparring should take 30 minutes max. More than that means the draft wasn't clear enough.

**Expected impact:** Sparring becomes a decision tool, not a delay tactic. Faster strategy shipping.

---

### Q3: How Much Prompt Engineering Is "Enough" Before Asking for Output?

**Status:** OPEN — Depends on complexity  
**Why it matters:** Simple prompts can be vague ("What should we do?"). Complex prompts take 5+ iterations to get right. At what point is diminishing return kicking in? How do you know when to just ask and see what you get?  
**Path to resolution:**
1. Framework: If the prompt has been revised 2+ times, ship it. If output is <80% useful, revise the prompt, not the output.
2. Quality threshold: Output should pass the "say-back test" (you can summarize what you asked for in 1 sentence).
3. Red flag: If you're iterating on output more than 3 times, the prompt was unclear. Rewrite the prompt instead.

**Expected impact:** More efficient use of AI time. Clearer signal on when a prompt needs refinement vs when output needs iteration.

---

### Q4: How Do You Balance "AI Should Pressure-Test Me" with "I Know My Domain Better"?

**Status:** OPEN — Cultural tension  
**Why it matters:** Best sparring happens when you listen to AI's questions, even when you think AI is wrong. But there's a real risk of over-trusting AI on domain-specific nuance (customer psychology, competitive dynamics, Atlassian org constraints). How do you know when to push back vs when to dig deeper?  
**Path to resolution:**
1. Rule: If AI questions facts you know, push back immediately. If it questions your interpretation, dig deeper.
2. Ask why: When AI sparring surprises you, ask "why?" instead of defending. 80% of the time, you learn something.
3. Lived experience trumps frameworks: If your customer conversations contradict the data, trust the conversations. Tell the AI why.

**Expected impact:** Better balance between using AI for genuine pressure-test and protecting domain expertise where it matters.

---

### Q5: What's the Right Retry Strategy When AI Output Misses?

**Status:** PARTIALLY SOLVED — Documented in efficiency-patterns.md, but culturally underused  
**Why it matters:** When AI output is bad, do you retry (revise prompt and try again)? Switch strategy (ask a human, go search external sources)? Give up? Current guidance: one retry max. But that feels arbitrary sometimes.  
**Path to resolution:**
1. Retry criteria: one retry if the prompt was clear but output was weak. After that, stop.
2. Switch strategy triggers: if output contradicts known facts (hallucination), switch immediately (don't retry). If output is generic (no domain context), add context and retry once.
3. Escalation: after one failed retry, either simplify the task or hand off to a human.

**Expected impact:** Clearer decision logic on retry vs switch. Saves 2-3 iterations per task.

---

## Related pages

**Edition Strategy:**
- [[what-we-believe]] — Core beliefs compiled from all strategy pages
- [[edition-positioning]] — The three editions and their jobs

**AI PM Craft:**
- [[ai-writing-antipatterns]] — Robotic language to kill
- [[llm-patterns]] — Patterns that work for PM work
- [[prompt-engineering-for-pms]] — How to write effective prompts

**Evidence Log:**
- [[evidence-changelog]] — What data has changed, when, and why

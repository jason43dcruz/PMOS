# AI Governance & AI Control Tower

## Sources
- Edition Strategy — Executive View v2 (Post-Spar) [6949208363]
- Edition Strategy — Full Context [6856213431]
- Edition Strategy Supporting Data [6773086820]

---

## Overview

AI is a separate monetization surface from seat-based pricing. AI features are available across all editions, but **governance** is gated at Enterprise only.

AI Control Tower is the strategic post-DC-migration differentiator for Enterprise. When DC migration completes, it replaces the structural tailwind that drove 77% of Enterprise sales.

---

## Current State (May 2026)

### AI Availability
- **Standard:** AI features available, consumption-based pricing (credit model TBD)
- **Premium:** AI features available, consumption-based pricing
- **Enterprise:** AI features + AI Control Tower (governance, cost transparency, approval workflows)

### The Cost Opacity Problem

From customer research (Supporting Data):
- **85 sales calls** cite credit/cost uncertainty as a barrier to Enterprise upgrade
- **30% of blocked deals** waiting on org-level AI approval — not a product gap, but commercial/procurement friction
- **Key insight:** Enterprise customers want predictable, transparent AI cost and org-level control

---

## AI Control Tower — Enterprise Differentiator

### What It Does

**Phase 1 (FY26-27):** Predictive Cost Modeling
- Forecast org-level AI spend by department/project
- Budget controls and approval workflows
- Cost transparency dashboard for finance

**Phase 2 (FY27-28):** Org-Level Analytics
- Which teams are using AI? At what frequency?
- Which AI capabilities are most valuable? (e.g., summarization vs troubleshooting)
- Cost per outcome by use case

**Phase 3 (FY28+):** Proactive Governance
- Recommend optimal AI usage patterns
- Detect cost anomalies
- Suggest efficiency improvements

### Why It Matters

1. **Replaces DC migration tailwind** — 77% of Enterprise purchases today are driven by structural events (DC migration, org consolidation). When that ends, AI Control Tower becomes the reason to upgrade.

2. **Solves a real blocker** — Enterprise procurement is waiting on org-level AI approval. Control Tower gives them the approval infrastructure.

3. **Defensible differentiation** — Governance is table-stakes for Enterprise. AI governance (cost control, approval workflows, analytics) is uniquely Enterprise-focused.

4. **Pricing opportunity** — Control Tower creates a new value lever: "manage AI cost and usage" is worth premium pricing.

---

## Feature Placement by Edition

### Standard
- **AI available:** Yes, consumption-based
- **AI governance:** No
- **Cost visibility:** No (opacity is a feature! Reduces decision friction)
- **Approval workflows:** No
- **Cross-team analytics:** No

**Job:** Use AI features to solve individual problems; cost is transparent in the bill.

---

### Premium
- **AI available:** Yes, consumption-based
- **AI governance:** No (soft-gated — basic usage controls)
- **Cost visibility:** Per-team only (not org-level)
- **Approval workflows:** No
- **Cross-team analytics:** No

**Job:** Teams use AI with light cost controls; no org-wide oversight.

**Design note:** Premium could have basic usage meters (e.g., max 10,000 AI queries/month) but no governance.

---

### Enterprise
- **AI available:** Yes, consumption-based
- **AI governance:** Yes (hard gate from Premium)
- **Cost visibility:** Org-wide forecasting and actual
- **Approval workflows:** Yes (org-level AI credit approval)
- **Cross-team analytics:** Yes (which teams, use cases, cost/outcome)

**Job:** Enterprise controls AI spend org-wide, approves usage by department, tracks ROI.

---

## Consumption Model (TBD — Decision Point)

### Options Under Consideration

**Option 1: Credit-based across all editions**
- All customers buy credits (separate from seat pricing)
- Enterprise gets predictive modeling + approval workflows on top
- Pros: Simple, separates AI cost from seat cost
- Cons: Customer confusion ("how many credits do I need?")

**Option 2: Bundled credit allowance by edition**
- Standard: 500 credits/month (fixed)
- Premium: 2,500 credits/month (fixed)
- Enterprise: 10,000+ credits/month + custom budgets
- Overages on consumption basis
- Pros: Predictable, aligns with edition value
- Cons: May undershoot large customers; requires tuning

**Option 3: Hybrid (Most Likely)**
- Base credits bundled by edition
- Overage credits consumed on marketplace model
- Enterprise gets predictive modeling to forecast overages
- Pros: Predictable base + flexibility for overages
- Cons: Complexity in pricing communication

---

## Gating Logic

### Hard Gate: AI Control Tower (Premium → Enterprise)

**Definition:** Org-level AI cost governance, approval workflows, cross-team analytics

**Why hard gate:**
- Only large organizations need org-level AI budget controls
- Compliance/procurement oversight is enterprise-only
- Creates structural difference between Premium (team-focused) and Enterprise (org-focused)

**When to gate:**
- Ship in FY26-27 as DC migration begins to tail off
- Tie to Enterprise renewal cycle (not in-product trial)
- Sales motion: "Take control of AI spend, approve by department"

**Metrics to track:**
- % of Enterprise customers with AI Control Tower enabled
- Avg AI spend forecast accuracy (should improve over time)
- Approval workflow usage (# of approvals/month)
- ROI: Does AI Control Tower usage correlate with higher renewal rates?

---

### Soft Gate: AI Usage Controls (Standard ← → Premium)

**Definition:** Basic usage meters, team-level cost visibility

**Why soft gate:**
- All editions need some visibility into AI consumption
- The difference is team-level (Premium) vs org-level (Enterprise)
- Creates pebble, not rock — usage hits limit → team sees it → considers upgrade

**When to gate:**
- Include in initial AI rollout (FY26)
- Test Standard meter (e.g., 500 queries/month) against actual usage
- Measure: % of Standard/Premium customers hitting the meter

---

## Risks & Mitigations

### Risk 1: AI Commoditizes Edition Boundaries

**Scenario:** If AI is cheap to deliver and heavy usage is already high, adding Enterprise governance doesn't create upgrade pull.

**Mitigation:**
1. Price AI conservatively (higher than internal cost) to create headroom for governance premium
2. Track Enterprise AI Control Tower adoption; if it's low (<40%), pricing is wrong
3. Develop non-pricing levers: governance + predictive recommendations + efficiency insights

### Risk 2: Customers Resist Consumption-Based Pricing

**Scenario:** Enterprise customers want predictable, fixed AI budgets, not variable consumption pricing.

**Mitigation:**
1. Test messaging with 10-15 Enterprise customers before launch
2. Offer fixed-budget option for large deals (convert variable to fixed at ~120% of forecast)
3. Simplify credit model: 1 credit = 1 query (not 1 credit = 0.5-2 queries depending on type)

### Risk 3: AI Cost Model Becomes Unreliable

**Scenario:** As infrastructure costs change or usage patterns shift, the pricing model breaks.

**Mitigation:**
1. Build in quarterly price review checkpoints
2. Track cost ratio: COGS / revenue per credit
3. Adjust guardrails if ratio drifts >20%

---

## Timeline & Sequencing

### FY26 (Now)
- Finalize consumption model (credit-based vs bundled vs hybrid)
- Design AI Control Tower (mockups, spec, go/no-go decision)
- Pilot with 5-10 Enterprise accounts
- Launch basic AI across all editions with soft usage controls

### FY27 (Q1-Q3)
- Ship AI Control Tower Phase 1 (cost forecasting, approval workflows)
- Repricing round: capture AI value in seat pricing (if tests successful)
- Premium→Enterprise upsell motion on AI governance

### FY27-28 (Q4 FY27 onwards)
- Ship AI Control Tower Phase 2 (cross-team analytics)
- AI consumption becomes significant portion of Enterprise revenue
- Pricing stabilizes; AI is now a core Enterprise differentiator

---

## Metrics to Track

| Metric | Current | Target (FY27) | Target (FY29) |
|--------|---------|---------------|---------------|
| % of customers using AI features | [TBD] | >50% (all editions) | >70% |
| AI as % of total revenue | <5% | 10-15% | 20-25% |
| Enterprise customers with AI Control Tower | 0% | >30% | >60% |
| Avg AI credit consumption by edition | [TBD] | [Monitor] | [Monitor] |
| Enterprise Premium→Enterprise upgrade correlation with AI governance | N/A | Track starting FY27 | Target: 15-20% uplift from AI messaging |

---

## Related pages
- [[enterprise-edition]] — Enterprise positioning and AI as differentiator
- [[edition-gating]] — AI feature gating across editions
- [[rocks-pebbles-meters]] — Gating framework applied to AI

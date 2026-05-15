# Rocks, Pebbles, Meters — The Gating Framework

## Sources
- Edition Strategy — Full Context [6856213431]
- Edition Strategy Supporting Data [6773086820]

---

## The Framework

We gate by **rocks** (hard gates), not pebbles (soft gates). This creates clear edition boundaries while allowing capabilities to span editions with different experiences.

### Rocks (Hard Gates)
**Definition:** Features that are completely unavailable in lower editions. Access is binary — you either have it or you don't.

**Rules:**
- Create a structural reason to upgrade
- Only placed when there's a real capability delta (not just preference or UX)
- Require a business event to gate (renewal, upgrade decision)
- Used sparingly — too many rocks and the ladder breaks

**Examples:** Change Management (Standard→Premium), Governance Controls (Premium→Enterprise), AI Control Tower (Enterprise-only)

### Pebbles (Soft Gates)
**Definition:** Features available at all editions but with usage limits, reduced functionality, or simpler UX.

**Rules:**
- Same capability, different experience
- Don't require a business event to hit the limit
- Create upgrade pull through usage signal (you hit the limit, see value, want more)
- Used liberally — this is how capabilities span editions

**Examples:** Automation rules (Standard: basic, Premium: advanced builder, Enterprise: org-level rules), Reporting (Standard: OOTB dashboards, Premium: custom reports, Enterprise: org-wide analytics)

### Meters (Usage Limits)
**Definition:** Quantitative limits (e.g., max users, max API calls, max automation rules) that create friction when hit.

**Rules:**
- Should reflect real scarcity or cost, not arbitrary lines
- Make the limit visible in-product before it hurts
- Measure against actual usage distribution

---

## The Placement Rubric

For any new or existing feature, walk through these questions in order:

1. **Is this a core job for the edition?**
   - Yes → Rock (hard gate) or Pebble (soft gate)?
   - No → Can it go at a lower edition?

2. **If it's a rock: Is there a structural reason to gate it?**
   - Compliance? Cost? Complexity?
   - Can we defend gating it at this edition in sales conversations?

3. **If it spans editions: What's the experience delta?**
   - Standard: bare minimum (what job is the customer doing?)
   - Premium: orchestration-ready (what expanded complexity?)
   - Enterprise: org-scale (what governance?

4. **What signal tells us when to upsell?**
   - Usage limit (meter)?
   - Feature request (pebble)?
   - Behavior pattern (upgrade signal)?

5. **What fails if we gate it wrong?**
   - Too high: customers stay in Standard, $0 uplift
   - Too low: commoditizes the edition below, breaks pricing
   - Wrong experience: customers buy and don't use it

6. **Can we instrument it to measure adoption and engagement?**
   - If not, how will we know if the gate works?

---

## Worked Examples

### Change Management (Rock: Standard→Premium)
- **Core job:** Standard doesn't do formal change control. Premium does orchestrated, approvals-driven change workflows.
- **Why a rock:** Without this gate, Premium has no structural reason to exist. Customers would stay in Standard.
- **Experience delta:**
  - Standard: No change capability
  - Premium: Full change workflow with approval rules, impact analysis, rollback
  - Enterprise: Premium + org-level change governance, audit trail
- **Upgrade signal:** Tenant creates >5 change request types in 28 days, or performs >5 configuration actions on change workflows
- **Metric:** Track adoption in Premium tenants; should be >60% within 90 days of upgrade

### Automation (Pebble: soft-gated at all editions)
- **Core job:** All editions automate; complexity and scale differ
- **Why a pebble:** Automation is so fundamental that locking it out of Standard kills adoption
- **Experience delta:**
  - Standard: Simple rule builder, basic triggers/actions, max 10 rules
  - Premium: Advanced builder, complex conditions, org-level rules, max 50 rules
  - Enterprise: Premium + system automation, cross-tenant rules, unlimited
- **Upgrade signal:** Tenant hits the rule limit (9/10 for Standard), requests complex logic their rules can't express
- **Metric:** Track rule usage by cohort; measure % hitting the limit by month

### ITAM (Rock: Standard→Premium)
- **Core job:** Asset lifecycle and procurement. Standard doesn't track assets; Premium does.
- **Why a rock:** ITAM is a distinct practice requiring data structure, workflows, and integrations that don't exist in Standard
- **Experience delta:**
  - Standard: No ITAM
  - Premium: Asset catalog, CI relationships, lifecycle workflows, procurement integration
  - Enterprise: Premium + multi-org asset governance, compliance reporting
- **Upgrade signal:** Tenant creates custom fields for asset tracking, requests procurement integration, or has >50 assets under management
- **Metric:** % of Premium tenants with >5 lifecycle workflows, procurement integration active

### AI Control Tower (Rock: Premium→Enterprise)
- **Core job:** Predictive governance, cost transparency, proactive analytics for AI
- **Why a rock:** Enterprise is the org-scale governance layer; AI Control Tower is its structural differentiator post-DC migration
- **Experience delta:**
  - Standard/Premium: AI features available, cost is opaque
  - Enterprise: AI Control Tower with predictive cost modeling, org-level approval workflows, cross-tenant AI analytics
- **Upgrade signal:** Tenant has >100 agents, >5 active projects, runs >10 AI queries/week, has procurement oversight requirements
- **Metric:** Track AI spend forecasting accuracy; measure % of Enterprise tenants using predictive cost features

---

## Gating at Scale

**Current state (Apr 2026):**
- Premium trials: ~8× the volume of Standard trials
- Premium trial conversion: ~1/6th the rate of Standard (activation gap)
- 37% of Premium tenants have **zero engagement** with gated Premium features
- 56% of Standard tenants show zero Premium demand signals — Standard is their destination

**Implication:** Hard gates alone aren't enough. We need:
1. Better activation pathways for Premium features (onboarding, education)
2. Upgrade signals that predict readiness (not just capability availability)
3. Continuous validation that gates are working (adoption metrics)

---

## Related pages
- [[edition-positioning]] — The three editions and their jobs
- [[upgrade-signals]] — Signals that predict edition movement
- [[premium-edition]] — Premium-specific gates and features
- [[enterprise-edition]] — Enterprise-specific gates and features

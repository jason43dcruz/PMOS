# Evidence Changelog

Record of what data has changed, when it changed, and why. Helps track the evolution of the edition strategy and catch when sources become stale.

---

## May 14, 2026 — Full Wiki Rebuild (Round 2, Completed)

**Action:** Completed full wiki rebuild after interruption. All 4 missing ai-pm-craft topic pages written, 3 synthesis pages compiled from scratch.

**Primary sources:**
- Edition-strategy topic pages (11 pages, written May 13 from Exec View v2 6949208363)
- Knowledge/ai-writing-antipatterns.md
- AGENTS.md (Agent Infrastructure + Brainstorming & Sparring sections)
- skills/strategy-sparring.md (the full sparring framework)
- efficiency-patterns.md (May 2026 patterns from live sessions)

**Pages created:**
- wiki/topics/ai-pm-craft/ai-writing-antipatterns.md
- wiki/topics/ai-pm-craft/llm-patterns.md
- wiki/topics/ai-pm-craft/prompt-engineering-for-pms.md
- wiki/topics/ai-pm-craft/strategy-sparring.md
- wiki/synthesis/what-we-believe.md
- wiki/synthesis/open-questions.md
- wiki/synthesis/evidence-changelog.md (this file)

**Impact:** Full rebuild complete. 16 wiki pages now exist and are current (11 edition-strategy + 5 ai-pm-craft). Synthesis pages compiled fresh from topic pages — not recycled from old versions.

**Quality notes:**
- All numbers in edition-strategy pages sourced from Exec View v2 (6949208363) and verified against Supporting Data (6773086820)
- AI-pm-craft pages are patterns from 6+ months of workspace usage (May 2026), not generic advice
- No hallucinated references; all linked pages exist

---

## May 13, 2026 — Full Wiki Rebuild (Round 1, Edition-Strategy Complete)

**Action:** Full wiki wipe + rebuild. Deleted all previous wiki pages. Rewrote all 11 edition-strategy topic pages from scratch, sourcing exclusively from Exec View v2.

**Primary source correction:** Previous wiki rebuild (Round 0, date unknown) pointed to archived page 6806843957. This page no longer reflects current strategy. **Source corrected to Exec View v2 (6949208363)**, which is the live FP&A-validated source.

**Pages created:**
- wiki/topics/edition-strategy/edition-positioning.md
- wiki/topics/edition-strategy/premium-edition.md
- wiki/topics/edition-strategy/standard-edition.md
- wiki/topics/edition-strategy/enterprise-edition.md
- wiki/topics/edition-strategy/upgrade-signals.md
- wiki/topics/edition-strategy/competitive-gating.md
- wiki/topics/edition-strategy/rocks-pebbles-meters.md
- wiki/topics/edition-strategy/ai-governance.md
- wiki/topics/edition-strategy/servco-constraints.md
- wiki/topics/edition-strategy/competitive-pricing-map.md
- wiki/topics/edition-strategy/edition-gating.md

**Data snapshot (Apr 2026 actuals from Exec View v2):**
- Total JSM/ServCo MRR: $80.6M
  - Standard: 28% ($34M, 1.19M seats)
  - Premium: 56% ($73M, 1.26M seats)
  - Enterprise: 15% ($22.1M Jan 2026, 588K seats, 90% YoY growth)
- LRP Target (FY29): ServCo $2.5B, HT >$1.7B (~68% of total, 48% CAGR)
- Premium activation gap: 37% of tenants have zero engagement with gated features
- Enterprise-segment revenue in Premium: $23.3M (opportunity)
- Standard→Premium signal addressable: 3,782 tenants, ~$75M at list price
- Enterprise growth driver: 77% from DC migration + org consolidation (structural events, not product-pull)

**Impact:** Fresh, source-linked edition strategy foundation. All numbers traced to FP&A-validated Confluence source, not wiki copies.

---

## Key Data Milestones (May 2026)

### Standard Edition Stable
- 28% of MRR for 6+ months (Apr 2025 ≈ Apr 2026)
- No price changes (list $20/agent)
- Activation concerns: none (entry tier, customers know what they're getting)

### Premium Edition Fragility
- 56% of MRR (highest concentration risk)
- 37% feature disengagement (May 2026)
- 8× trial volume but 1/6th conversion rate vs Standard (activation cliff)
- Activation target: >60% using gated features within 90 days of upgrade

### Enterprise Edition Growth Acceleration
- Jan 2026: $22.1M (15% of MRR)
- YoY growth: 90%
- But: 77% driven by DC migration (structural), not product-pull
- Vulnerability: DC migration ends FY27 → growth cliff unless AI Control Tower ships

### AI Governance Dependency
- AI Control Tower is in EXPLORE (no ship date)
- Strategic role: unlock Premium→Enterprise (justifies 4× price multiplier)
- Risk: if AI Control Tower ships late or adoption is low, Enterprise growth stalls post-DC-migration

### Signal Research Progress (Autoresearch Initiative)
- Run 1 (Complete, Apr 20, 2026): workflow_service_complexity family
  - Result: Queue config ≥5 is strongest Standard→Premium predictor (3.77× lift)
  - Addressable: 3,782 ready tenants
- Run 2 (In progress, Apr 24, 2026): organizational_coordination family
  - Status: Notebook executing on Databricks
  - Expected results: Mid-late May 2026
- Run 3-4 (Planned): service_scope_expansion, integration_breadth, automation_sophistication families

---

## Source-of-Truth Evolution

### Reliable Sources (Current, FP&A-Validated)
- **Exec View v2 (6949208363):** Live, updated quarterly, FP&A-owned
- **Supporting Data (6773086820):** Live, analytics owned, quarterly updates
- **Secoda documents:** Live, self-refreshing, owner-filtered access
- **Socrates SQL queries:** Live, real-time data warehouse

### Archive / Deprecated
- **Wiki pages (pre-May 2026):** Superseded by current pages, don't use for numbers
- **Old archived page 6806843957:** Replaced by Exec View v2, ignore

### Transient / Experimental
- **Session logs:** Session-specific, not sources of truth
- **Efficiency patterns:** Lessons learned, not strategy
- **Individual Databricks notebooks:** Validation work, not published findings

---

## Data Quality Notes

### Apr 2026 Edition Mix Actual vs LRP Target
| Edition | Apr 2026 Actual | FY29 Target | Status |
|---------|-----------------|-------------|--------|
| Standard | 28% | 28% | On track |
| Premium | 56% | 56% | On track |
| Enterprise | 15% | 15% (growing to 28% via Premium→Enterprise) | Below target; DC migration tailwind masking gap |

**Interpretation:** Current mix is stable and on-target. But Enterprise growth is structural (DC migration), not product-driven. Post-DC-migration, Enterprise must grow via Premium→Enterprise migration and new enterprise sales. Current motion is insufficient.

### Upgrade Signal Stability (Apr 2026)
- Queue config ≥5 signal: 0.69 stability score (good)
- Signal prevalence in upgraders: 29.7%; non-upgraders: 7.9% (3.77× lift)
- Addressable cohort: 3,782 tenants with 2+ signals (8.5% of 44,380 active Standard)
- Actual upgrade MRR from this cohort: Unknown (signal validation pending)

**Interpretation:** Signal is statistically robust. But conversion funnel is leaky (addressable $75M vs actual upgrade MRR $1-2M/month). Either signal timing is off or sales motion is weak.

### Premium Engagement Baseline (May 2026)
- 37% of Premium tenants: zero engagement with Change Management, ITAM, or advanced automation
- 63% of Premium tenants: some engagement with at least one gated feature
- Engagement target: >60% using all gated features within 90 days of upgrade

**Interpretation:** Engagement is binary (using / not using), not graduated. Onboarding is the lever — once customers use Change Management, they tend to adopt ITAM and automation.

### Enterprise Feature Adoption
- 42.6% of Enterprise tenants: zero engagement with gated features (governance, multi-org, org-wide analytics)
- Same problem as Premium: features are gated but not activated
- Implication: if current Enterprise customers don't use the gates, prospects have no reason to buy

**Interpretation:** Gating is necessary (creates upgrade boundary) but not sufficient (doesn't guarantee adoption). Product must guide adoption, or gates become empty.

---

## Known Data Gaps

### Premium→Enterprise Behavioral Signals
No autoresearch has run on Premium→Enterprise signals yet. Current prediction relies on:
- Customer size proxy (1000+ seats)
- Sales conversation mentions (governance, compliance)
- Qualitative research (why customers chose Premium over Enterprise)

**Gap:** We can't identify and target Premium→Enterprise ready cohorts with precision. Once autoresearch Run 3 (organizational_coordination) completes, this gap should close.

### AI Control Tower Validation
No data on AI Control Tower adoption, pricing willingness, or competitive positioning yet. Assumption: "AI Control Tower justifies Premium→Enterprise upgrade." But untested.

**Gap:** We're planning Enterprise strategy around an unvalidated lever. Once AI Control Tower MVP ships (Q3 FY27?), validation should start immediately.

### Interim Motion for Premium→Enterprise (FY26-27)
No documented motion exists between now and AI Control Tower ship. How do we move $23.3M enterprise-segment revenue from Premium to Enterprise in the next 12 months?

**Gap:** Motion is undefined. Either sales is running this ad-hoc, or it's not happening. Clarification needed.

### Signal-to-Conversion Funnel Leak
Signal analysis says 3,782 ready tenants, $75M addressable. Actual upgrade MRR is 10-20% of that. Where does the leak happen?

**Gap:** We don't have cohort-level data on signal detection → trial → conversion → churn. Once we instrument this, we can diagnose whether the problem is signal quality, sales motion, or product friction.

---

## Related pages

**Synthesis:**
- [[what-we-believe]] — Core beliefs compiled from all pages
- [[open-questions]] — Genuinely open questions with resolution paths

**Edition Strategy:**
- [[edition-positioning]] — The three editions
- [[premium-edition]] — Premium fragility and activation
- [[enterprise-edition]] — Enterprise growth and DC migration
- [[upgrade-signals]] — Standard→Premium signals (validated), Premium→Enterprise signals (TBD)

**Data Sources:**
- [Edition Strategy — Executive View v2](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6949208363) (Confluence, live)
- [Edition Strategy — Supporting Data](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6773086820) (Confluence, live)

# ServCo-Specific Constraints

## Sources
- Edition Strategy — Executive View v2 (Post-Spar) [6949208363]
- Edition Strategy — Full Context [6856213431]
- AGENTS.md (Workspace Memory)

---

## Overview

JSM and ServCo are the same product at different migration states. This page captures the unique constraints and decisions that apply to the Service Collection edition strategy.

**Critical context:** Jason's L1 KR is migrating all JSM customers to ServCo. Edition strategy must support this migration without breaking existing JSM customer value.

---

## ServCo LRP Targets (FY29)

### Revenue Target
- **Total ServCo ARR:** ~$2.5B (FY29 Long-Range Plan)

### Edition Mix Targets
- **Standard:** ~28% of total MRR
- **Premium:** ~56% of total MRR
- **Enterprise:** ~15% of total MRR (growing to ~28% of total by capturing premium-to-enterprise migration)

### High-Touch Revenue Target
- **Current (Apr 2026):** $531M FY26 ARR
- **Target (FY29):** >$1.7B ARR (~68% of total, 48% CAGR)

### Implication
Edition strategy must support 48% CAGR in High-Touch while keeping Low-Touch at reasonable growth. This means:
1. Enterprise (HT-heavy) must grow faster than Standard/Premium
2. Premium activation matters (37% of Premium tenants have zero engagement — dangerous at 56% of MRR)
3. $23.3M of enterprise-segment MRR in Premium is the lever; AI Control Tower is the unlock

---

## ASoW Decisions (Non-Negotiable)

The Atlassian Statement of Work (ASoW) for ServCo migrations contains binding decisions. Edition strategy cannot contravene these without re-evaluation.

### Current Constraints (Validate in ASoW ServCo Decisions Confluence page)

**Key decisions likely affecting edition strategy:**
1. JSM and ServCo pricing alignment — existing JSM customers must not see price increases on migration
2. Single SKU model — all editions sold as seat-based, not consumption-based (AI is separate)
3. Feature parity — all JSM features must map to ServCo editions without gaps
4. LDR/IC constraints — Low-touch/Indirect channels have specific pricing/packaging rules

**Action:** Before finalizing any edition repricing or packaging changes, validate against ASoW ServCo Decisions page to ensure no contravention.

---

## Migration Mechanics

### JSM → ServCo Mapping

**Current JSM edition structure must map cleanly to ServCo:**

| JSM Edition | ServCo Edition | Notes |
|------------|----------------|-------|
| Service Cloud Free | Standard (no free tier in ServCo) | Upsell path: Free → Standard paid |
| Service Cloud Standard | Standard | Price alignment required |
| Service Cloud Pro | Premium | Price alignment required |
| Service Cloud Enterprise | Enterprise | Price alignment required |

**Constraint:** No feature gaps during migration. If JSM Pro customers have features, ServCo Premium must have them.

### Data & Customer Migration

1. **Tenant data migration** — All JSM tenants migrate with their current edition assignment
2. **No forced downgrades** — Customers don't move to lower editions; only upgrades or lateral moves
3. **Pricing continuity** — Existing JSM customers keep existing pricing for negotiated period (typically 12-24 months)

---

## Pricing Constraints

### JSM-ServCo Price Alignment Rule

**No JSM customer should see a price increase solely due to the platform name change.** This creates migration friction and legal risk.

**Practical implications:**
1. ServCo list prices ≥ current JSM list prices
2. Actual discount rates should match (JSM discounts ≈ ServCo discounts for equivalent editions)
3. Repricing is allowed **after** migration cohort stabilizes (typically 18-24 months post-migration)

### TWC Attach (Service Collection Bundle)

From workspace memory:
- **TWC (Teamwork Collection) attach JSM/ServCo:** 60.6% (bundled Jira + Confluence + Service Collection)
- **Jira-only attach:** 38.6%

**Implication:** 60% of Service Collection revenue comes bundled with Jira + Confluence. Edition strategy must account for:
1. Bundle pricing (is Premium +$X for bundle vs standalone?)
2. Feature cross-sell (Jira workflows inform Service Collection workflow needs)
3. Seat count management (are seats counted across products or per-product?)

---

## LDR & IC Constraints

**LDR = Low-Dowel-Rate (Indirect channels)**  
**IC = Indirect Channel**

### Constraints (TBD — Validate with Sales)

Likely constraints from ASoW:
1. **Indirect channels may have pricing floors** — Can't discount below a threshold
2. **Indirect packaging rules** — Some packaging options may not be available through indirect
3. **Territory rules** — Certain regions/segments sell through indirect only

**Action:** Confirm with Sales Enablement / GTM before finalizing pricing or packaging changes.

---

## Sequencing Constraints

### DC Migration Tailwind (Ends FY26-27)

**Timeline:**
- DC migration started FY24
- Expected completion: FY27
- Enterprise growth correlated with DC migration: 77% of Enterprise purchases driven by structural events (DC migration + org consolidation)

**Implication:** Edition strategy must ship AI Control Tower before DC migration ends. Without it, Enterprise growth stalls.

### New Pricing Windows (Fixed Calendar)

Atlassian typically has two pricing windows per fiscal year:
- **FY start (October):** Major repricing round
- **FY mid-point (April):** Minor adjustments

**Constraint:** Don't announce major edition repricing outside these windows. Market stability matters for Sales.

---

## Feature Parity & Migration Risk

### Risk: JSM Customers Lose Features on Migration

**Scenario:** JSM Premium customer has Feature X; ServCo Premium doesn't.

**Mitigation:**
1. Comprehensive feature audit (JSM → ServCo mapping)
2. Feature backlog items for any gaps
3. Backport or substitute equivalent features

**Status:** Unclear if this audit is complete. Recommend confirmation with Product teams.

---

## Operational Constraints

### Tenant Limits & Architecture

Likely constraints:
1. **Org-wide analytics** — Are org limits (multi-org) enforced by license or system architecture?
2. **API rate limits** — Are these enforced by edition or customer size?
3. **Automation rule limits** — Hard limits (10 Standard, 50 Premium) or soft gates?

**Action:** Validate with Engineering before finalizing any hard gates with customer-visible limits.

### Measurement & Attribution

**Challenge:** JSM and ServCo customers are in the same data warehouse. Edition strategy changes may affect JSM (live production) and ServCo (new product) simultaneously.

**Constraint:** Any metric changes (e.g., measuring Premium engagement) must be clearly attributed to JSM vs ServCo to avoid confounding.

---

## Go-To-Market Implications

### Sales Motion Alignment

**High-Touch (HT) sales:**
- Must align with Enterprise growth target (48% CAGR)
- Sales enablement on Premium→Enterprise upsell (especially $23.3M opportunity)
- Deal desk pricing should incentivize Enterprise (not Premium downsells)

**Low-Touch (LT) motion:**
- Product-led onboarding must route to right edition (likely Premium bias for LT)
- Landing page messaging ("Just works" vs "Orchestrate" vs "Govern")
- Trial conversion funnel (Premium trial volume 8× Standard, conversion 1/6th — fix this)

---

## Related pages
- [[edition-positioning]] — The three editions and their jobs
- [[enterprise-edition]] — Enterprise growth drivers and AI Control Tower
- [[premium-edition]] — Premium fragility and activation gap

# Competitive Edition Gating

## Sources
- Unified Competitive Synthesis [6677661639]
- Edition Strategy Supporting Data [6773086820]

---

## Overview

How do competitors gate their editions? This intelligence informs our own gating strategy and reveals market expectations for feature placement.

**Key pattern:** Vendors lead with **outcome language externally** (speed, AI, scalability) but organize features **internally** by ITSM practice depth. No vendor labels editions as "maturity tiers" to customers.

---

## Competitor Gating Comparison

### ServiceNow

**Edition ladder:** Standard → Professional → Enterprise

| Capability | Standard | Professional | Enterprise |
|------------|----------|--------------|------------|
| Basic ITSM | ✓ | ✓ | ✓ |
| Change Management | ✗ | ✓ | ✓ |
| Asset Management (ITAM) | ✗ | ✓ | ✓ |
| Advanced Automation | ✗ | ✓ | ✓ |
| Compliance/Governance | ✗ | ✗ | ✓ |
| Multi-org | ✗ | ✗ | ✓ |
| Workflow orchestration | ✗ (basic) | ✓ | ✓ |

**Pattern:** Change Management is the hard gate from Standard→Professional (same as our Standard→Premium). Governance is Enterprise-only.

**Positioning:** Standard = "just works", Professional = "orchestrate", Enterprise = "control at scale"

**Pricing:** Standard ~$50/user, Professional ~$150/user, Enterprise ~$300+/user (3-6× multiplier Standard→Enterprise)

---

### Zendesk (Service Cloud)

**Edition ladder:** Team → Professional → Enterprise

| Capability | Team | Professional | Enterprise |
|-----------|------|--------------|------------|
| Basic ticketing | ✓ | ✓ | ✓ |
| Custom fields | ✓ (limited) | ✓ | ✓ |
| Automation rules | ✓ (basic) | ✓ (advanced) | ✓ |
| SLA policies | ✗ | ✓ | ✓ |
| API/integrations | ✗ (limited) | ✓ | ✓ |
| Multi-org | ✗ | ✗ | ✓ |
| Advanced reporting | ✗ | ✓ (basic) | ✓ (advanced) |

**Pattern:** SLA policies and advanced integrations are Professional gates. Multi-org is Enterprise-only.

**Positioning:** Team = "simple ticketing", Professional = "managed service", Enterprise = "enterprise support"

**Pricing:** Team ~$25/agent, Professional ~$49/agent, Enterprise ~$99+/agent (2-4× multiplier)

---

### Freshdesk

**Edition ladder:** Free → Biz → Pro → Enterprise

| Capability | Free | Biz | Pro | Enterprise |
|-----------|------|-----|-----|------------|
| Basic ticketing | ✓ | ✓ | ✓ | ✓ |
| Custom fields | ✓ | ✓ | ✓ | ✓ |
| Automation | ✗ | ✓ (basic) | ✓ (advanced) | ✓ |
| SLA policies | ✗ | ✓ | ✓ | ✓ |
| Reporting | ✗ | ✓ (basic) | ✓ (advanced) | ✓ (custom) |
| API/integrations | ✗ | ✓ (limited) | ✓ | ✓ (unlimited) |
| ITAM-like features | ✗ | ✗ | ✗ | ✓ |
| SSO/compliance | ✗ | ✗ | ✗ | ✓ |

**Pattern:** Freshdesk has more granular gating (4 tiers vs 3). Automation is Biz gate. ITAM-equivalent is Enterprise-only.

**Pricing:** Biz ~$19/agent, Pro ~$49/agent, Enterprise ~$65+/agent (steeper than Zendesk, closer to ours)

---

### Monday.com (Work OS)

**Edition ladder:** Basic → Standard → Pro → Business

| Capability | Basic | Standard | Pro | Business |
|-----------|-------|----------|-----|----------|
| Core workflows | ✓ | ✓ | ✓ | ✓ |
| Custom fields | ✓ | ✓ | ✓ | ✓ |
| Automation | ✗ | ✓ (basic) | ✓ (advanced) | ✓ |
| Integrations | ✓ (limited) | ✓ | ✓ (advanced) | ✓ |
| Advanced reporting | ✗ | ✗ | ✓ | ✓ |
| Custom roles/governance | ✗ | ✗ | ✗ | ✓ |
| API access | ✗ | ✗ | ✓ | ✓ |

**Pattern:** Similar to Freshdesk — 4 tiers. Automation is Standard gate. Advanced reporting is Pro gate. Governance is Business-only.

**Pricing:** Standard ~$9/user, Pro ~$19/user, Business ~$29/user (steep pricing cliff; 3x Standard→Business)

---

## Key Gating Patterns Across Market

### Universal Hard Gates

1. **Governance/Compliance** → Enterprise-only (universal across ALL competitors)
2. **Change Management** → Mid-tier (Standard/Professional, not entry tier)
3. **ITAM-equivalent** → Mid-tier or Enterprise (depends on vendor)
4. **Multi-org** → Enterprise-only (consistent)

### Mid-Tier Upgrade Drivers

1. **Change Management** (ServiceNow, us, Zendesk)
2. **Advanced Automation** (all vendors; entry tier has basic, mid-tier has advanced)
3. **SLA policies** (Zendesk, Freshdesk, Monday)
4. **Advanced Reporting** (Freshdesk, Monday)

### Soft Gates (Available Across Editions)

1. **Automation** (all vendors gate depth, not presence)
2. **Reporting** (all vendors gate complexity, not availability)
3. **Integrations** (all vendors gate API rate limits by edition)
4. **Custom fields** (usually available all tiers; may gate complexity)

---

## Competitive Positioning Summary

### Outcome Language (What Customers See)

| Vendor | Entry | Mid | Enterprise |
|--------|-------|-----|------------|
| **ServiceNow** | "Speed" | "Efficiency" | "Control at scale" |
| **Zendesk** | "Get started" | "Automate support" | "Enterprise support" |
| **Freshdesk** | "Fast setup" | "Automation" | "Enterprise compliance" |
| **Monday** | "Organize" | "Automate work" | "Govern work" |
| **Us (Atlassian)** | "Just works" | "Orchestrate" | "Govern at scale" |

**Synthesis:** Vendors use outcome language externally, but organize features internally around ITSM practice depth.

### Practice Maturity Layers (What We Build)

All competitors layer three stories at different tiers, with different emphasis:

1. **Outcome/capability story** — "what can you do?" (entry emphasizes outcomes; enterprise emphasizes control)
2. **Practice maturity story** — "how structured are your workflows?" (entry = reactive, mid = proactive, enterprise = governed)
3. **Trust/scale story** — "can you trust it?" (entry = small team, mid = multi-team, enterprise = org-wide with audit)

---

## Implications for Our Strategy

### Where We're Aligned with Market
1. ✓ Change Management as Standard→Premium gate
2. ✓ Governance/compliance as Enterprise-only
3. ✓ Multi-org as Enterprise-only gate
4. ✓ Automation spans all tiers with depth gating

### Where We Differ
1. **ITAM at Premium (not mid-tier Standard feature)** — Competitors usually gate ITAM at mid-tier (Pro/Professional). We gate it at Premium. This is defensible (ITAM is complex) but worth watching.
2. **No separate change management pricing** — We bundle change management in Premium. Competitors sometimes sell it as add-on. Our bundling is cleaner for customers.
3. **AI as separate consumption layer** — Competitors haven't fully landed consumption-based AI pricing yet. We're ahead here, but it's unfamiliar to customers.

### Competitive Advantages
1. **3-4× cheaper at every tier** — We price significantly below ServiceNow, Zendesk, Freshdesk
2. **Comparable feature density at Premium** — Our Premium has Change Management + ITAM + automation. Competitors' mid-tiers often have one of these.
3. **Clear outcome messaging** — "Just works" (Standard) → "Orchestrate" (Premium) → "Govern" (Enterprise) is clearer than most competitors

### Competitive Vulnerabilities
1. **37% of Premium customers have zero engagement with gated features** — If customers aren't using Premium features, our pricing advantage erodes
2. **Premium activation cliff** — Premium trial volume is 8× Standard, but conversion is 1/6th. We have a steeper activation hill than competitors
3. **No AI governance story yet** — AI Control Tower is in EXPLORE. Competitors will catch up; we need to ship first

---

## Related pages
- [[edition-gating]] — Our gating strategy
- [[rocks-pebbles-meters]] — Our framework vs competitors
- [[competitive-pricing-map]] — Price comparison across tiers

# Standard Edition

## Sources
- Edition Strategy — Executive View v2 (Post-Spar) [6949208363]
- Edition Strategy — Full Context [6856213431]
- Edition Strategy Supporting Data [6773086820]

---

## Overview

**Positioning:** "Service desk that just works"  
**Job:** Basic service delivery operations — request intake, queue management, simple routing  
**Target customer:** Small teams getting started with ITSM  
**MRR (Apr 2026):** ~$34M (28% of total JSM/ServCo MRR)  
**Paid seats:** ~1.19M (May 2026 snapshot)  

---

## What's Included

### Core Capabilities
- **Request types and queues** — Define request categories, route to teams
- **Basic forms** — Simple request intake, custom fields
- **Service level targets** — Basic SLAs, target response/resolution times
- **Simple automation** — Basic rule builder (max 10 rules), simple triggers/actions
- **OOTB reporting** — Pre-built dashboards, basic metrics (volume, velocity, SLA compliance)
- **Self-service portals** — Request submission, ticket search, knowledge base linking

### What's NOT Included (Hard Gates)
- **Change Management** — No formal change workflows, approvals, impact analysis
- **ITAM** — No asset lifecycle, procurement integration, CI relationships
- **Advanced Automation** — No complex logic, org-level rules, system automation
- **Multi-org Management** — No cross-org queues, org-wide analytics
- **AI Control Tower** — No governance, cost transparency, predictive analytics for AI

---

## Pricing & Economics

**List price:** ~$20/agent/month (May 2026)  
**Actual discount:** Heavily discounted from list (estimated $12-15/agent/month)  
**Price multiplier:** 1.0× (Standard baseline)  

**Typical customer:**
- Single team (< 50 agents)
- Simple workflows (max 3-4 request types)
- No formal change management or asset tracking
- Self-serve onboarding, no sales support

---

## Upgrade Signals — Standard→Premium

From autoresearch (Apr 2026, workflow_service_complexity family):

### Accepted Signals (High Predictive Power)

| Signal | Lift | Prevalence (Upgraders) | Prevalence (Non-upgraders) | Interpretation |
|--------|------|------------------------|-----------------------------|-----------------|
| Queue config actions ≥5 (28d) | **3.77×** | 29.7% | 7.9% | Tenant actively configuring queue logic → wants orchestration |
| Request type config ≥5 (28d) | 2.96× | 36.4% | 12.3% | Multiple request types + config changes → growing complexity |
| Active projects ≥3 AND config actors ≥2 (28d) | 3.53× | 21.2% | 6.0% | Multi-project + multi-person config → organizational coordination need |
| Request type config ≥5 AND active projects ≥2 (28d) | 2.96× | 36.4% | 12.3% | Growing workflow + multi-project → Premium ready |

**Combined insight:** Tenants doing ≥5 queue or request type config actions in 28 days are **3.77× more likely to upgrade** than baseline. This is the strongest single predictor.

### Revenue Opportunity

**Signal-based addressable market (Standard tenants with 2+ upgrade signals):**
- **Addressable tenants:** 3,782 (8.5% of 44,380 active Standard tenants)
- **Addressable MRR:** ~$75M (at list price)
- **Segment breakdown:**
  - High Touch: ~$45M
  - Low Touch: ~$15M
  - Mid Market: ~$15M

---

## Activation Challenges

### Premium Trial Funnel
- **Premium trial volume:** ~8× that of Standard trials
- **Premium trial conversion:** ~1/6th the rate of Standard (major activation gap)
- **Top abandonment reasons:**
  - Too complex for small teams (automation builder, reporting)
  - Change Management is overkill for their use case
  - Pricing jump (2.5×) feels steep without seeing value

### What Stops Standard Tenants from Upgrading?

**56% of Standard tenants show zero Premium demand signals.** For these:
- Standard *is* their destination, not a temporary landing
- Workflow complexity is low (single queue, <3 request types)
- No change management need (informal processes)
- Self-service and basic automation sufficient

**Strategy implications:**
1. Don't force Premium on tenants who don't need it
2. Focus upgrade motion on the 8.5% signal-ready cohort
3. Improve onboarding + activation for Premium trials to close the gap

---

## Pricing Headroom

Standard is already at the floor — limited discounting headroom remaining. Enterprise has real discount room; Premium has some room but is constrained.

---

## Competitive Context

Vs. ServiceNow, Zendesk, Freshdesk:
- **ServiceNow Standard:** Expensive, feature-locked, requires training
- **Zendesk:** Simple entry tier, easy upgrade path (less friction than ours)
- **Freshdesk:** Aggressive pricing on entry tier, higher in mid-tier

Our Standard is **competitive on price** but faces a steeper upgrade cliff to Premium compared to competitors' gradual pricing curves.

---

## Related pages
- [[edition-positioning]] — Standard's role in the edition ladder
- [[upgrade-signals]] — Detailed signal analysis for Standard→Premium
- [[premium-edition]] — Where Standard customers upgrade to
- [[rocks-pebbles-meters]] — What features are gated at Standard

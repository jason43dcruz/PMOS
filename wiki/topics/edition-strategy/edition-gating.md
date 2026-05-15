# Edition Gating — Feature Map

## Sources
- Edition Strategy — Executive View v2 (Post-Spar) [6949208363]
- Edition Strategy — Full Context [6856213431]
- Edition Strategy Supporting Data [6773086820]

---

## Feature Gating Summary

| Capability | Standard | Premium | Enterprise | Gating Type |
|------------|----------|---------|------------|------------|
| **Request intake & queues** | ✓ (basic) | ✓ (advanced) | ✓ (org-scale) | Pebble (soft-gated) |
| **Forms** | ✓ (simple) | ✓ (advanced) | ✓ (org-level) | Pebble |
| **Basic automation** | ✓ (10 rules max) | ✓ (50 rules) | ✓ (unlimited) | Pebble (meter) |
| **Service level targets** | ✓ (basic) | ✓ (advanced) | ✓ (multi-org) | Pebble |
| **OOTB reporting** | ✓ | ✓ (custom) | ✓ (org-wide) | Pebble |
| **Self-service portals** | ✓ | ✓ (advanced) | ✓ (org-branding) | Pebble |
| **Change Management** | ✗ | ✓ (full) | ✓ (org-level) | **Rock** (Hard gate S→P) |
| **ITAM** | ✗ | ✓ (full) | ✓ (org-wide) | **Rock** (Hard gate S→P) |
| **Advanced automation** | ✗ (basic only) | ✓ | ✓ | Rock (Hard gate S→P) |
| **Escalation policies** | ✗ | ✓ | ✓ (org-level) | Rock |
| **Solution Composer** | ✗ | ✓ | ✓ | Rock |
| **Multi-org management** | ✗ | ✗ | ✓ | **Rock** (Hard gate P→E) |
| **Enterprise governance** | ✗ | ✗ | ✓ (role-based access, audit) | **Rock** (Hard gate P→E) |
| **AI Control Tower** | ✗ | ✗ | ✓ | **Rock** (Hard gate P→E) |
| **Org-wide analytics** | ✗ | ✗ | ✓ | Rock |

---

## Hard Gates (Rocks)

### Standard → Premium

**Change Management** (non-negotiable)
- Standard: Not available
- Premium: Full workflow with approvals, impact analysis, rollback
- Enterprise: Premium + org-level change governance
- Why: Structural difference in ITSM maturity; customers move from informal to formal change control

**ITAM** (non-negotiable)
- Standard: Not available
- Premium: Asset catalog, CI relationships, procurement integration
- Enterprise: Premium + org-wide governance, compliance reporting
- Why: Asset lifecycle requires distinct data structures and workflows; Standard customers don't track assets formally

**Advanced Automation** (non-negotiable)
- Standard: 10 rules max, simple triggers/actions
- Premium: 50 rules, complex logic, org-level automation
- Enterprise: Unlimited, system automation
- Why: Complexity scales with organizational coordination needs

---

### Premium → Enterprise

**Multi-org Management** (non-negotiable)
- Premium: Not available
- Enterprise: Cross-org queues, shared analytics, centralized governance
- Why: Only large organizations need this; creates clear organizational scale gate

**Enterprise Governance Controls** (non-negotiable)
- Premium: Not available
- Enterprise: Fine-grained role-based access, audit trail, compliance controls, change approval workflows
- Why: Compliance/audit mandates are enterprise-only; this is the table-stakes differentiator

**AI Control Tower** (strategic differentiator, post-DC migration)
- Premium: Not available (AI available but ungoverned)
- Enterprise: Cost transparency, predictive modeling, approval workflows, org-wide analytics
- Why: Strategic replacement for DC migration tailwind; creates structural reason for Premium→Enterprise upgrade

---

## Soft Gates (Pebbles)

### Request Intake & Queues
- **Standard:** Basic queue management, simple routing
- **Premium:** Multi-queue orchestration, cross-queue escalation, queue analytics
- **Enterprise:** Org-wide queue network, centralized analytics

**Why pebble:** All customers need queuing. Complexity scales with org size.

### Automation (see also Hard Gates above)
- **Standard:** 10 rules max, basic triggers/actions
- **Premium:** 50 rules, advanced builder, org-level rules
- **Enterprise:** Unlimited, system automation

**Why pebble + meter:** Automation is universal. The 10-rule limit creates upgrade pull.

### Reporting
- **Standard:** OOTB dashboards (volume, velocity, SLA compliance)
- **Premium:** Custom reports, trend analysis, team performance
- **Enterprise:** Org-wide reporting, cross-team analytics, capacity planning

**Why pebble:** All customers need visibility. Depth of analysis scales with org size.

### Forms
- **Standard:** Simple forms, limited custom fields
- **Premium:** Advanced forms, conditional logic, rich form builder
- **Enterprise:** Org-level form sharing, approval forms, audit trail

**Why pebble:** All customers collect data via forms. Sophistication scales with organizational needs.

### Service Level Targets (SLAs)
- **Standard:** Basic SLAs, response/resolution targets
- **Premium:** Advanced SLA chaining, priority-based escalation
- **Enterprise:** Multi-org SLAs, org-level agreements

**Why pebble:** All editions need SLAs. Complexity scales with scale.

---

## Not Yet Gated (Open Design Decisions)

### AI Features (Consumption-Based)
Currently available across all editions but **not** bundled in seat pricing. Gating strategy TBD:
- Options: Per-message credits, org-level usage limits, Premium/Enterprise consumption bundles
- Decision point: FY26-27 when AI cost model stabilizes

### Reporting API / Advanced Analytics
- Premium vs Enterprise: TBD
- Decision point: FY27 when analytics demand clarifies

### Integrations (Third-party, API, Custom)
- Currently not gated; available at all editions
- Future: Possible soft-gate (API rate limits by edition)

---

## Gating Rubric (Applied to New Features)

For any new feature, walk through this process:

1. **Core job for the edition?** Does this feature solve a core job for this edition?
   - Yes → Continue
   - No → Can it go lower?

2. **Structural reason to gate?** Is there a compelling reason to gate this at this edition?
   - Compliance (Enterprise-only)
   - Complexity (Premium-only)
   - Organizational scale (Enterprise-only)
   - Or does it belong lower?

3. **Experience delta.** If spanning editions, what's the experience at each tier?
   - Standard: bare minimum
   - Premium: orchestration-ready
   - Enterprise: org-scale

4. **Upgrade signal.** What signal tells us when to upsell?
   - Usage hitting a limit (meter)?
   - Feature request (soft gate)?
   - Behavior pattern (hard gate)?

5. **Failure mode.** What breaks if we gate it wrong?
   - Too high: $0 uplift, no migration
   - Too low: commoditizes lower edition, breaks pricing
   - Wrong experience: customers buy, don't use, downgrade

6. **Instrumentation.** Can we measure adoption and engagement?
   - If no, we can't validate if the gate works

---

## Current Activation Challenges

**37% of Premium tenants have zero engagement with gated Premium features.** This is the biggest risk to the gating strategy:

- If Premium customers aren't using Change Management, ITAM, or advanced automation, why would Standard customers upgrade?
- If Premium tenants aren't activated, downgrade risk is high
- Enterprise faces the same problem: 42.6% of Enterprise tenants don't use gated features

**Implication:** Hard gates alone aren't enough. We need:
1. Better onboarding for gated features
2. In-product education and activation
3. Continuous measurement of engagement by feature
4. Early intervention when engagement is low

---

## Related pages
- [[rocks-pebbles-meters]] — Detailed framework for gating strategy
- [[edition-positioning]] — The three editions and their jobs
- [[premium-edition]] — Premium features and gating
- [[enterprise-edition]] — Enterprise features and gating

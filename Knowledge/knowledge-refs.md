# Knowledge References

### Service Collection WAC Pricing Page Planning (Planning Context)
- **URL:** https://hello.atlassian.net/wiki/spaces/ITMarketing/pages/5597788877
- **Note:** For current published pricing/limits, always verify against the live website pricing page, not this planning page. Overwrite local reference snapshots in `Knowledge/current-jsm-pricing-page.html` and `Knowledge/current-jsm-pricing-key-limits.txt` when re-checking current limits.

### Service Collection Pricing Website (Current Published Source of Truth)
- **URL:** https://www.atlassian.com/software/jira/service-management/pricing
- **What it covers:** Live published pricing, edition packaging, and current published limits/caps. Use this for current numbers in strategy work.
- **Local working snapshot:** `Knowledge/current-jsm-pricing-page.html` + `Knowledge/current-jsm-pricing-key-limits.txt` (overwrite in place; do not create timestamped copies)
- **What it covers:** Authoritative internal planning doc for the Service Collection public pricing page. Contains the full feature-by-edition comparison table as it appears on atlassian.com/collections/service/pricing. Owned by Blythe Ebersole (PMM).
- **Use for:** Verifying what features are gated at which edition. This is a living doc — always re-read via MCP before making gating claims.
- **⚠️ Snapshot rule:** This page changes as features ship. Add a regular snapshot task to the data refresh agent to keep a known-good local copy of the feature×edition grid.

### Opsgenie Sunset and JSM Migration: Standalone Ops TAM and Packaging Strategies
- **URL:** https://hello.atlassian.net/wiki/spaces/~179069336/pages/6523604148
- **What it covers:** Analysis of the standalone ops/incident management market, why Opsgenie customers resist migrating to JSM, and packaging strategies to serve ops-only buyers within Service Collection. Directly relevant to edition strategy (on-call/incident gating) and Premium positioning.

### R&I Report: SVC Monetization Opportunities
- **URL:** https://hello.atlassian.net/wiki/spaces/rai/pages/6572578085/R+I+Report+SVC+Monetization+Opportunities
- **What it is:** Quantitative research (n≈400 ITSM buyers/admins) on SVC monetization headroom, pricing elasticity, UBP appetite, multi-tier seat licenses, and help-seeker licenses. Includes conjoint analysis of edition feature/price tradeoffs.
- **Key findings for edition strategy:**
  - SVC is uniquely positioned as "high value, lower TCO" — pricing headroom exists
  - 10% annual seat price increase is sustainable (PED <1); 20%+ triggers elastic demand
  - Higher AI limits are the most effective lever to reduce price sensitivity and justify price increases (PED drops from 0.8 to 0.2-0.3 with 10x AI limits)
  - 2027 features (AIOps, HAM/SAM, AI native experiences) do NOT shift preferences on their own when tested in conjoint — positioning/articulation needs work
  - Unlimited AI at Enterprise is a strong pull (10x Standard/Premium + unlimited Enterprise = +7% take-up, +9% revenue)
  - UBP safe zone is 10-20% of TCO; best candidates are API Data Connectors (53.7%) and AI Agents (53.6%); Assets shows highest resistance to UBP (40.4%)
  - Add-ons are NOT preferred (~40% comfortable); customers want simple all-in editions
  - 73% prefer multi-tier seat licenses over single seat type
  - Business Agent (HR/Finance) and Collaborator licenses show >86-90% perceived value
  - Help-seeker licenses ($5-10/employee/month): demand is price-inelastic, but "value/benefit not clear enough" is top barrier — not the pricing model itself

Links to Confluence pages and docs the agent should read when you ask for help. **Read via MCP at the time of the ask** — don't rely on cached copies.

When adding docs: add the link to the section that matches your focus area, or create a new themed section.

## Lenny's Podcast transcripts (local bundle)

- **Path:** `Knowledge/lennys-podcast-transcripts/`
- **What it is:** Episode transcripts plus topic indexes (`index/episodes.md`, `index/{topic}.md`, `episodes/{guest-slug}/transcript.md`). PM doc reviews use this via **`skills/review-pm-doc.md`** to ground feedback in named guests/episodes.
- **How to use:** Read topic indexes for the user's action mode, pick 3–6 episodes, read transcript chunks (frontmatter + keyword search). Archive notes: `Knowledge/lennys-podcast-transcripts/CLAUDE.md`.

## Secoda Documents (Live — Primary Source)

My Secoda documents are the most up-to-date source for customer data, edition strategy, adoption analysis, and churn insights. **Read these directly from Secoda via the Secoda MCP** rather than from any Confluence copies tagged "Secoda Knowledge" — those are stale snapshots.

**How to access:**
- **Discover all my documents:** Use the Python integration's `get_my_documents()` to list all documents owned by the current user. This is the only way to get an owner-filtered list — the MCP cannot filter by owner. Update the table below with any new documents found.
- **Read by topic:** `search_documentation(query)` via Secoda MCP — returns matching documents with full content in the `definition` field.
- **Read by ID:** `retrieve_entity(entity_id)` via Secoda MCP — returns a specific document by its UUID (use the IDs in the table below).
- **Advanced/bulk:** The Python integration (`Knowledge/secoda_integration.py`) with `get_document(id)`, `ask_ai()`, and collection browsing remains available.

**⚠️ Auto-update rule:** Every time documents are pulled from Secoda, update this list to reflect the current set.

**Last synced:** April 25, 2026

| Document | ID | What it covers |
|---|---|---|
| JSM / Service Collection — Edition Strategy | `47fd690b-e974-467a-a858-b34e93d177ca` | Edition value props, upgrade paths, and packaging framework |
| JSM ESM: Wall-to-Wall Adoption Analysis & Sales Motion Review | `e1e03213-0d7d-4456-9c1f-a67579992982` | ESM adoption data, win rates, and blockers |
| JSM Edition Downgrade & Churn Analysis | `f8ea3dfe-845c-4295-aab4-555be31cd4e9` | Downgrade patterns, MRR contraction, churn reasons |

### Confluence — Secoda Knowledge snapshots
| Document | URL | What it covers |
|---|---|---|
| JSM Edition Downgrade Analysis (Auto-Generated) | [Page](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6885774430) | Downgrade volumes and MRR by path (Std/Prem), monthly trend Jul 2025 – Mar 2026, corrected table (Apr 2026) |
| JSM Premium Feature Usage × Edition Movement Analysis | [Page](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6763448082) | Feature usage by edition movement cohort, quarterly trends, HT/LT split, upgrade/downgrade reasons, intervention opportunities (Apr 2026) |

## Service Collection / ServCo

- [Service Collection pricing packaging guidelines](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/4455961015/Service+Collection+pricing+packaging+guidelines) — *You're updating this as part of your work*
- [JSM for HR Pricing Packaging Proposal](https://hello.atlassian.net/wiki/spaces/~495044968/pages/4173316856/JSM+for+HR+Pricing+Packaging+Proposal) — Example packaging
- [Monetisation strategy: working hypotheses](https://hello.atlassian.net/wiki/spaces/SIS/pages/6282950743/Monetisation+strategy+working+hypotheses) — The five monetisation building blocks (single SKU, agent seats as primary lever, UBP for outliers, helpseeker monetisation, vertical add-ons) and constraints validated through qual research. Foundation for the LRP update below.
- [ServCo 3-year monetisation strategy: LRP update](https://hello.atlassian.net/wiki/spaces/SIS/pages/6453755213/ServCo+3-+year+monetisation+strategy+LRP+update) — Revenue sizing, price increase ranges (10% p.a.), edition mix targets (28% CEE by FY29), UBP safe zone (0-20% of bill), and competitive pricing headroom. Depends on editions delivering enough value to justify price trajectory.
- [ASoW – ServCo Decisions](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/4165541103/ASoW+-+ServCo+Decisions) — **Constraints:** Any proposal must not contravene decisions listed here (and child pages). If it would, raise it so we can reevaluate.

## Sales / GTM

### Key findings from Mid-market / Enterprise Sales interviews
- **URL:** https://hello.atlassian.net/wiki/spaces/SIS/pages/6026956794/Key+findings+from+Mid-market+Enterprise+Sales+interviews
- **Date:** Oct 2025
- **What it covers:** 5 AMER sales leader interviews (Corduck, Edenfield, Krant, Spognardi, Zuber) on competitive positioning, pricing risks, edition differentiation, discounting, and AI pricing challenges. Directly relevant to edition strategy Layers 2–5.

- [Service Collection Sales Deck](https://docs.google.com/presentation/d/1gO8wSAV5rhE8LARGhdxaOIddC8dAO7sSvOktfrc4ne8/edit) — Sales positioning deck for Service Collection (Google Slides — open manually)
- [Service Collection Low Touch Business Unit Objectives and Operating Rhythm](https://hello.atlassian.net/wiki/spaces/~296986198/pages/5156732963/Service+Collection+Low+Touch+Business+Unit+Objectives+and+Operating+Rhythm) — LT BU strategy, objectives, and operating rhythm

### JSM Demo Videos (Consensus — overhauled Apr 2026)
Restructured to align with sales plays, shortened, personalized with new ServCo branding. Every video includes a customer story, AI/Rovo use cases, Assets, and reporting. Public links (trackable without Consensus license):
- [C-Level Sizzle Reel](https://play.goconsensus.com/uff3cee51) — <5 min value + key differentiators
- [Intro to the Platform](https://play.goconsensus.com/bfe171105)
- [Service Management for Developers](https://play.goconsensus.com/b3793796f)
- [AI Operations & Incident Management](https://play.goconsensus.com/ac22d952e)
- [Service Management for Business Teams](https://play.goconsensus.com/u122fc699)
- [Service Management for All Teams](https://play.goconsensus.com/a4750988e)
- [HR Service Management](https://play.goconsensus.com/s262442f8)
- [Asset & Configuration Management](https://play.goconsensus.com/b1f30505a)
- [Full End-to-End Overview](https://play.goconsensus.com/a6b2e904a)
- [On-Demand Personalized Experience](https://app.goconsensus.com/play/1a4c84c7?autoplay&utm_medium=email&utm_source=atlcomm&utm_campaign=immediate_general_article&utm_content=topic)
- [More info (Confluence)](https://hello.atlassian.net/wiki/spaces/~313901060/pages/6778111548/Service+Collection+JSM+Demo+Update)
- **Slack source:** https://atlassian.slack.com/archives/C018C1RAWEL/p1775739826298339

## Product Roadmap & Features

- [ITOps Offsite Slide Walkthrough](https://docs.google.com/presentation/d/1Dlw2sQ6gKRySP7z8aheMOK4Qc8YirS2_IYBC-gPTelk/edit?usp=drivesdk) — IT Ops features and strategy (Google Slides — open manually)
- [Jira Service Management 2026: Announcing the AI-Native Era](https://hello.atlassian.net/wiki/spaces/AJS/pages/6003405995/Jira+Service+Management+2026+Announcing+the+AI-Native+Era) — IT Service features and 2026 product vision

## UBP (Usage-Based Pricing)

### UBP LRP EO Review (Mar 2026)
- **URL:** https://hello.atlassian.net/wiki/spaces/acbp/pages/6667961202/UBP+LRP+EO+review+Mar+2026
- **Last read:** Apr 14, 2026
- **Key facts:** Seat growth remains primary revenue; UBP = incremental value capture from top 10–20% of customers by usage. Flex credits carry revenue AND margin risk (pooling lets customers transfer unlicensed seat value to Rovo Credits). Enforcement of new meters planned early/mid FY27. Service Collection UBP revenue modelled separately.

### What You Need to Believe: The UBP Opportunity (Apr 2026)
- **URL:** https://hello.atlassian.net/wiki/spaces/acbp/pages/6748076467/What+You+Need+to+Believe+The+UBP+Opportunity
- **Last read:** Apr 14, 2026
- **Key facts:**
  - **Hybrid model:** Seats remain anchor; usage meters capture incremental value (especially AI/COGS-heavy features)
  - **Base case direct UBP:** FY27 $40M → FY28 $157M → FY29 $315M (3% of Cloud revenue). Total UBP + AI: FY27 $162M → FY29 $767M (8% of Cloud)
  - **Aspirational case direct UBP:** FY27 $43M → FY28 $253M → FY29 $640M (6%). Total: FY29 $1.09B (10%)
  - **Meter mix (base):** Rovo 44%, Automation 19%, Bitbucket 15%, Assets 10%, CSM 10%
  - **3 key assumptions:** (1) Sales execution (aggressive), (2) No seat demand cannibalisation (very aggressive), (3) Project Pepper additive to LRP (reasonable)
  - **CSM signal:** Loom 80% AI resolution (18k convos/month), 11% churn drop. 500+ customers live on CSM Agent. Riot Games, Nordsec, Trekbikes evaluating.
  - **Assets:** 41M billable objects today; platformisation expanded TAM 16x, billable objects 7x to 4.1B. 18% of newly eligible JSM Standard cohort already engaged.
  - **Automation:** 2B+ rule executions/month; top 10% of customers (Prem/Ent) drive ~90% of usage — natural overage opportunity.
  - **Rovo overages today:** Only 1% of domains in overage (300 HT, 2,700 LT) — rate card refresh underway.
  - **Enforcement:** New meter enforcement planned early/mid FY27; acceleration proposal in progress.

## Edition Strategy & Framework

### Feature Engagement in JSM Premium Trial
- **URL:** https://hello.atlassian.net/wiki/spaces/JPA/pages/4227711174/Feature+Engagement+in+JSM+Premium+Trial
- **Date:** Sep 2024 (Jan–Jun 2024 data)
- **Key numbers:** 38% of Premium trialers engage with any Premium feature. Assets drives most conversions (1,056) but lowest rate (25%). Direct-to-Premium = 32% engagement, 12% conversion. Multi-feature engagement doubles conversion (47% vs 23%).

### JSM Free/Evaluation to Paid Journey Feature Usage
- **URL:** https://hello.atlassian.net/wiki/spaces/JPA/pages/3268588720/JSM+Free+Evaluation+to+Paid+Journey+Feature+Usage
- **Date:** Jan 2024 (Jul 2022–Nov 2023 data)
- **Key numbers:** 60% purchase within 90 days. 83% of Free-to-Full were End BSM campaign. Feature usage peaks in Evaluation then drops. Ops usage flat across all stages.

### RT Experience Report: Reverse Trials (Jira, not JSM)
- **URL:** https://hello.atlassian.net/wiki/spaces/researchandinsights/pages/4951179978
- **Date:** Mar 2025 (28 interviews)
- **Key insight:** Four buyer types — intentional, aspirational, uninformed card holder, accidental. Aspirational + uninformed drive small PEU with high churn risk. Will Jenkins shared this as context for "optimising for a KR."

- [Service Collection Editions & Packaging Framework (2026 Update)](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6639043701) — Comprehensive 7-part framework covering strategic context, edition boundaries, verticals, critical changes, decision rubric, and implementation roadmap. Draft for leadership review.
- [Edition Strategy — Full Context](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6856213431/Edition+Strategy+Full+Context) — Edition boundaries, capability positioning, gating principles, worked examples (AI Control Tower, WFO). The detailed strategy doc — deep rationale and evidence live here.
- [Edition Strategy — Executive View v2 (Post-Spar)](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6949208363) — **START HERE for sparring.** The current working page — post Apr 30 spar with Shamik/Abhinaya/Rahul/Vivek. Replaces v1.
- [Edition Strategy — Executive View v1 (Pre-spar)](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6806843957) — Original pre-spar version. Archived — use v2 for all current work. Anand-facing PSR pre-read. Goal-first → ServCo framing → edition-by-edition strategy → motions → rubric. Actively iterated.
- **[Competitive Pricing & Value Map (LOCAL WIKI)](../wiki/topics/edition-strategy/competitive-pricing-map.md)** — **READ FIRST when sparring on edition pricing or competitive positioning.** Cross-edition map (Free→Starter, Std→Std/Growth, Prem→Pro, Ent→Ent), $/value-per-point ratios from scoring matrix, pricing headroom recommendations. Source: `projects/edition-strategy/data/scoring-matrix.csv`.
- [Unified Competitive Synthesis: Edition Positioning & Pricing Strategy](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6677661639) — **START HERE.** Synthesizes insights from both competitive deep dives. Shows how vendors price editions, the 7 key takeaways (outcomes vs. practice depth, ITAM positioning, AI bundling, soft-gating automation, hard-gating governance & change management), and recommended edition framework with pricing strategy. (RovoDev Knowledge)
- [Deep Dive: Competitive Edition Positioning & Feature Gating](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6677081964) — Detailed competitive analysis of how ServiceNow, Freshservice, Zendesk, BMC, and Monday.com position editions and gate features. Includes pricing, AI strategies, ITAM positioning, and recommendations. (RovoDev Knowledge)
- [Competitor ITSM Positioning Deep Dive](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6677695816) — Research on how major ITSM vendors frame their value propositions and packaging (outcome vs. practice depth vs. trust/scale). Includes executive synthesis with 7 key insights, archived ServiceNow positioning, ManageEngine edition ladder, and market signal analysis. (RovoDev Knowledge)
## AI Packaging

- [AI Packaging & Pricing Principles](https://hello.atlassian.net/wiki/spaces/AAI/pages/2673789108/AI+Packaging+%26+Pricing+Principles) — Atlassian-wide guidance on AI edition packaging (Rovo and AI space, 2023). Key principle: start high, work down.
- [LDR - Service Collection AI packaging, Feb/Mar GA](https://hello.atlassian.net/wiki/spaces/~71202046d6c27362164cb7aa242d4e50dd92fd/pages/6480700735) — Lite-touch packaging decisions for 5 ServCo AI features. Notes formal AI edition guidance still pending post-LRP.

## Enterprise edition / CEE

- [Themes for JSM CEE differentiated value](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/5974929369/Themes+for+JSM+CEE+differentiated+value)

## AI / Customer Requests

### Pre-work: AI Customer Findings (AI Next for JSM Workshop)
- **URL:** https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6717224173
- **Replit app:** https://ai-next-servco-insights-hub-v-3-zip.replit.app/ (pwd: AIServCoITG!2026)
- **Slack channel:** `C0AC4DGEXBM` (AI Next for ServCo)
- **Author:** Konstantinos Kazakos (presented Mar 27 2026)
- **Key findings:** (1) Slack-first ops — customers want ops native to Slack. (2) KBs are critical; change management is important. (3) Proving biz value and reducing cognitive load for AI-based solution creation are top customer needs.
- **Also references:** Loom video (https://www.loom.com/share/40e8a64d312a414f8f5857eb47336e41), future of ITSM video (Slack file)

- [INDEX: FDE Customers Rovo Adoption Strategies](https://hello.atlassian.net/wiki/spaces/fde/pages/5943906967/INDEX+FDE+Customers+Rovo+Adoption+Strategies) — Customer requests and adoption strategies around Rovo/AI

## Stakeholder Profiles

- [Anand Narayanan — Decision-Making Profile & Persuasion Playbook](./anand-narayanan-decision-profile.md) — How Anand thinks, makes decisions, and evaluates proposals. **Run every page through the Anand Checklist before it reaches him.** Long-term vision + short-term execution, data + anecdote pairing, revenue-quantified sizing, structural levers, asymmetric competitive framing.
- [Shamik Sharma — Decision-Making Profile & Persuasion Playbook](./shamik-sharma-decision-profile.md) — How Shamik thinks, makes decisions, and evaluates proposals. **Run every page through the Shamik Checklist before it reaches him.** Local file — no MCP fetch needed.

## MRR / $/Seat by Edition (Validated Apr 2026)

- **Source of truth:** `production.segment_sot.vw_segment_movement_summary_reporting_layer`
- **Products:** `jira_serviceManagement` + `service_collection` (both required — JSM alone = $53M, ServCo adds $19M, combined = ~$70M)
- **Forecast version filter:** `forecast_version = 'FY2026 Q3 R4F'` — update each quarter
- **Key filters:** `platform = 'Cloud'`, `movement = 'Closing'`, `reporting_layer_movement_flg = '1'`, `closing_day <= current_date()`
- **Metric types:** `'MRR'` and `'Paid Seats'` (separate CTEs, join on edition + sales_classification)
- **DO NOT use** `dti_metric_movement.vw_cloud_license_metric_movement_summary_combined` for MRR totals — inflates to $44M via CEE parent double-counting
- **SQL query:** `skills/queries/jsm-servco-mrr-per-seat-by-edition-segment.sql`
- **Confluence page:** [JSM + ServCo — $/seat Sanity Check (Mar 2026)](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6881053932)
- **Validated Mar 2026 actuals (FP&A):** Enterprise $18.7/seat | Premium $29.3/seat | Standard $17.5/seat | Blended $22.9/seat | Total MRR $70.3M | Total Paid Seats 3.1M. Full LT/HT split: `Knowledge/snapshots/mrr-per-seat-by-edition-motion-mar2026.md`

## Discounting & Margin

- [Product Profitability Hub](https://hello.atlassian.net/wiki/spaces/ANALYSIS/pages/3199436477/Product+Profitability+Hub) — FP&A's Confluence hub for product profitability data and models.
- [Discretionary Discounting by Product](https://docs.google.com/spreadsheets/d/194JZdYmqiYYs68U6-7sSL6hfRAytFNT6qX37EPkecb0/edit?gid=1153280548#gid=1153280548) — Finance guardrail model: fixed COGS per seat per month by edition, target GM% by TCV bucket, back-solves minimum price / max discount room. JSM tab shows Enterprise $2.92, Premium $2.77, Standard $1.91 COGS inputs.
- [Product Profitability Model FY26 Q2R4F_Final](https://docs.google.com/spreadsheets/d/1MXvm1ak0jUEwKjwFUTK_lpZYzh6IePfyIEy4bxowb3g/edit) — FP&A's GAAP product-level P&L (Google Sheet, Lucy Gregory). Tab "1. GAAP External Summary" → "Jira Service Management" column for JSM GM% (82.7%), COGS breakdown, OM (-20.7%). Also has Jira, Confluence, Loom, Teamwork Collection. **Highly sensitive — do not share externally.**
- [JSM / ServCo — Margin Limits & Discounting Analysis](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6703878295/JSM+ServCo+Margin+Limits+Discounting+Analysis) — Comprehensive analysis of JSM Cloud discounting: framework rules (discount bands, GM% floors, escalation matrix), actual CY2025 discount distributions by segment/edition/motion, and key insights for edition strategy. Published under Secoda Knowledge.
- [JSM Top Customers — Churn Risk vs. Discounting Analysis](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6704060372/JSM+Top+Customers+Churn+Risk+vs.+Discounting+Analysis) — Churn predictions (S360) for 16 top discounted JSM customers. Key finding: heavy discounting does NOT correlate with JSM churn — JSM is green for 9/12 scored customers. Real risk is in Confluence/Jira (cloud adoption, AI usage). Published under Secoda Knowledge.
- [Discretionary Discount Empowerment Framework](https://hello.atlassian.net/wiki/spaces/~7120209a73e0ff70c64f10a900c0529b0a9c69/pages/5790973670/Discretionary+Discount+Empowerment+Framework) — TCV × GM% traffic light model governing all Enterprise discounting. Discount bands (10/20/25/25+), per-line GM% floors, blended deal-level checks, approval matrix by TCV tier.
- [Discretionary Discounting Framework Methodology](https://hello.atlassian.net/wiki/spaces/ANALYSIS/pages/5609042315/Discretionary+Discounting+Framework+Methodology) — FP&A methodology for calculating price floors by Product × Edition × Seat Tier. References Google Sheet with actual GM% targets.
- [Enterprise SaaS Discounting Summary](https://hello.atlassian.net/wiki/spaces/~71202069619f6f30314dc4af778cd922811d9c/pages/5227527225/Enterprise+SaaS+Discounting+Summary) — Historical evolution of Atlassian discounting from on-prem through Cloud transition. Volume, partner, discretionary, and government discount ranges.
- [FY26 Cloud Price Change — Jira, Confluence and JSM](https://hello.atlassian.net/wiki/spaces/Monetization/pages/4864370363/1344+-+FY26+Cloud+Price+Change+Jira+Confluence+and+JSM) — Full JSM Enterprise tier pricing table (post FY26 7.5% increase, effective Oct 2025). Key finding: per-agent monthly equivalent drops 38% from 100→500 agents ($77→$48/agent/mo) purely from the tier structure, before deal-level discounting. Action: relook Enterprise discounting curve — deal-level discounts compound tier compression.
- [2026 - CMK - Discounting Framework](https://hello.atlassian.net/wiki/spaces/ENCRYPT/pages/6186218438/2026+-+CMK+-+Discounting+Framework+-+2026) — CMK-specific concessions (programmatic/discretionary/bespoke). Cautionary tale: 15 deals at -60% collective GM. New framework targets 75%+ CMK margin.

## Curated Knowledge

### New — May 15, 2026 (Knowledge Scout)

#### [PSR] ITOM and Visibility — Enterprise Capability Gap & Lansweeper Strategy [HIGH]
- **URL:** https://hello.atlassian.net/wiki/spaces/ITSOL/pages/7018533802
- **Summary:** Comprehensive PSR making the case for ITOM investment. Automated asset Discovery is the #1 capability gap from Gong data (2,340 sales calls). $36B+ market at 12% CAGR. Proposes deep Lansweeper OEM/partnership as fastest path to enterprise-grade discovery. 10-12 eng team funded from Q1. Competitive teardown vs ServiceNow CMDB, BMC Discovery. Customer interviews (Lendigroup, Riverty, KPMG) validate unanimously.
- **Why it matters:** Directly shapes edition gating (what justifies Enterprise vs Premium — native discovery is the differentiator), ServCo growth strategy (P2), and 1-year investment plan (P1). ITOM/Assets is the #1 deal-loss gap — understanding the investment plan is critical for edition framework and competitive positioning.
- **Action:** Read today — foundational for edition strategy and growth planning.
- **Date found:** 2026-05-15 | **Source:** Confluence ITSOL

#### FY27 Platform + AI L1 KR Definition Alignment [HIGH]
- **URL:** https://hello.atlassian.net/wiki/spaces/AAI/pages/7036451103
- **Summary:** Redefines "Platform + AI" stock metric for FY27 OKRs. Key changes: removes Rovo from breadth requirement (duplicative with AI MAU), raises 3P connector bar to 5+ MAU with full connector (excl. GitHub), adds major-site requirement for enterprise/CEE to prevent sandbox inflation. Active comments debating overlap with Rovo app usage.
- **Why it matters:** How "Platform + AI" is defined directly affects how ServCo AI features are measured and valued. The connector depth requirement and enterprise-site logic are relevant to AI packaging decisions and understanding what AI adoption looks like at scale. Feeds into growth strategy (P2) and 1-year investment plan (P1).
- **Action:** Save for later — monitor as FY27 OKR definitions finalise.
- **Date found:** 2026-05-15 | **Source:** Confluence AAI

### New — May 14, 2026 (Knowledge Scout)

#### Team '26 Enterprise OPM Roundup: What we heard across ~700K Seats [HIGH]
- **URL:** https://hello.atlassian.net/wiki/spaces/CAP2020/blog/2026/05/13/7013009495/Team+26+Enterprise+OPM+Roundup+What+we+heard+across+~700K+Seats+at+Team+26
- **Summary:** 21 executive briefings at Team '26 (Google, JPMC, Charles Schwab, Wells Fargo, Citi, Dell). "Why Cloud" is settled — the question is now "how quickly can I get there." TWG, Strategy Collection, and DX landed well. Gaps: AI governance/cost control narrative, Cloud perf for large migrators, Confluence lifecycle management, Rovo positioning vs Claude/Gemini/ChatGPT.
- **Why it matters:** Direct enterprise customer signal on what's landing and what's not. Cloud migration speed + AI governance gaps are directly relevant to ServCo upgrade framework and edition gating (AI as upgrade lever). Rovo positioning challenge is live and relevant to AI packaging.
- **Action:** Read today — fresh customer voice for upgrade framework and AI packaging decisions.
- **Date found:** 2026-05-14 | **Source:** #ProductManagement (CFGQGGSRH)

#### Rovo & AI Product & Sales OKR Alignment (FY27) [HIGH]
- **URL:** https://hello.atlassian.net/wiki/spaces/AAI/pages/7029516927
- **Summary:** FY27 AI product outcomes require coordinated GTM operating plan across three motions: Connector Adoption, Agent Adoption / Workflow Modernization, and Graph Off-Atlassian Use. Aligns product and sales OKRs for AI.
- **Why it matters:** Defines how AI packaging and GTM will be structured in FY27. Directly relevant to ServCo growth strategy (P2) and 1-year investment plan (P1) — understanding how Rovo/AI motions map to edition tiers and sales plays.
- **Action:** Read today — shapes how AI features map to ServCo editions.
- **Date found:** 2026-05-14 | **Source:** Confluence AAI

#### Service Collection FY27 OKR Structure — Rovo Help as ESM vector [MEDIUM]
- **URL:** https://hello.atlassian.net/wiki/spaces/ITSOL/pages/7000621136/Service+Collection+-+FY27+OKR+Structure
- **Summary:** Active comment thread on FY27 OKR page proposing Rovo Help (fka JSM-lite) as a wall-to-wall ESM play for AI-first customers — distributed with Rovo everywhere, trackable as shipping + adoption metric.
- **Why it matters:** If Rovo Help becomes a tracked acquisition vector, it changes the ServCo growth funnel at the low end. Relevant to growth strategy (P2) and 1-year investment plan (P1).
- **Action:** Save for later — monitor how this shapes up in FY27 OKR finalisation.
- **Date found:** 2026-05-14 | **Source:** Confluence ITSOL

### New — May 12, 2026 (Knowledge Scout)

#### Handling Partner Margin impact to MRR reporting due to uplift [HIGH]
- **URL:** https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6354741612/Handling+Partner+Margin+impact+to+MRR+reporting+due+to+uplift
- **Summary:** Decision doc (Jason D Cruz as driver, approved Jan 30 2026). During JSM→ServCo mid-contract uplift, partner margin is dropped for remaining contract term — inflating ServCo SKU MRR by up to ~$1.4M (~2% of Service Collection MRR). Decision: do nothing; JSM+ServCo are reported as unified "Service Collection" in Finance, so no impact to overall MRR. ServCo SKU Tableau charts may show ~1% noise until renewal. MRR/ARR re-statement threshold is ±2%. Active comments on this page today suggest the question is live again.
- **Why it matters:** Directly affects how uplift MRR is read and reported — critical context when presenting uplift KR numbers to Anand or finance.
- **Date found:** 2026-05-12 | **Source:** ITSOL Confluence

#### Marketing and Product — ServCo Email Campaign Audit [MEDIUM]
- **URL:** https://hello.atlassian.net/wiki/spaces/ITSOL/whiteboard/6858894473
- **Summary:** Active whiteboard auditing onboarding email campaigns for JSM Free, Standard, and ServCo Free/Standard/Premium, including Auxia pilot. Comments today flagging broken links and outdated content in multiple emails.
- **Why it matters:** Signals the GTM/marketing team is actively cleaning up ServCo onboarding flows — relevant to low-touch growth and upgrade motion.
- **Date found:** 2026-05-12 | **Source:** ITSOL Confluence

#### [DRAFT] Rovo Studio Monthly Metric Review — April 2026 [MEDIUM]
- **URL:** https://hello.atlassian.net/wiki/spaces/AAI/pages/6994640443
- **Summary:** L1 KR: Agent & Agentic Skill Invocations at 5.47M, +20% MoM. Agentic automation, manual agent invocations, OOTB/Skills/Tools all tracked. Draft published today with full Databricks dashboard links.
- **Why it matters:** Benchmark for AI product craft — useful context for positioning AI PM expertise and understanding what "good" AI engagement looks like internally.
- **Date found:** 2026-05-12 | **Source:** AAI Confluence

### New — May 9, 2026 (Knowledge Scout)

| Document | URL | Why it matters | Date found | Source |
|---|---|---|---|---|
| Autonomous AI Content Generation With TWC | https://hello.atlassian.net/wiki/spaces/CONF/blog/2025/06/09/5405677374/Autonomous+AI+Content+Generation+With+TWC | Feedback-to-PRD agent demo — turns raw customer feedback into PRDs using Jira+Confluence+Loom+Rovo. Concrete example of proactive-autonomous AI applied to PM craft. | 2026-05-09 | #ProductManagement (CFGQGGSRH) |
| [DRAFT] MMR 2026-04 Studio Monthly Metric Review | https://hello.atlassian.net/wiki/spaces/AAI/pages/6994640443 | Rovo agentic metrics: 5.47M invocations +20% MoM. Discussion on separating organic growth from feature-driven growth — signals Rovo trajectory into FY27. | 2026-05-09 | Confluence AAI |
| JSM Incident View Reimagined (v0 prototype) | https://v0-enterprise-itsm-tool.vercel.app/ | PM reimagined JSM incident view using inverted prompting + v0. Live prototype. Directly ServCo-relevant — shows what AI-native JSM UX could look like. | 2026-05-09 | #AIPM-design-hacks (C085EDZ9C9K) |

*Auto-curated by knowledge scout. Only items that directly affect active goals or decisions.*

| Document | URL | Why it matters | Date found | Source |
|---|---|---|---|---|
| LDR: Packaging of OSC beyond Service Collection | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6693098215) | Directly affects edition gating: Assets capability at Standard vs ITAM practice at Premium. If OSC packaging changes, edition boundaries move. | 2026-03-24 | Confluence (ITSOL) |
| How to Experiment — A Must Know Guide for PMs | [Confluence](https://hello.atlassian.net/wiki/spaces/~832078090/pages/6070033619) | Practical experimentation guide for PMs. Useful reference for validating edition positioning with experiments. | 2026-03-24 | #ProductManagement |
| ServCo LT working group: Fix digital success and onboarding gaps | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6694305889) | Defines ownership of LT digital success/adoption, closes onboarding gaps (post-FFP emails, cross-platform friction). Deliverables due Apr 21. Directly relevant to 1-year investment plan and LT growth strategy. | 2026-03-25 | Confluence (ITSOL) |
| AI-next: The evolution of AI in JSM | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6704871904) | FY27 JSM AI strategy: from assistive AI to AI-native service management. Defines acquisition→activation→retention funnel via AI. Key themes: AI governance/control tower (Enterprise pillar), help-seeker monetization, AI-native onboarding. ITG Apr 15-17, ServCo LT shareout Apr 28. Directly affects edition gating (AI as primary upgrade lever), growth strategy, and 1-year investment plan. | 2026-03-26 | Confluence (ITSOL) |
| Rovo Help: AI-Native Service Management Strategy | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6707796482) | AI-native zero-config help desk as SMB acquisition funnel into JSM. Positions Rovo Help as new growth vector: SMB→JSM upgrade path. Competitive analysis vs Moveworks/Aisera/ServiceNow. Directly relevant to ServCo growth strategy, edition positioning (entry tier), and 1-year investment plan. | 2026-03-26 | Confluence (ITSOL) |
| VE Q4 Roadmap Review – Experiment Priorities & Pivot Readiness | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6702727987) | Q4 FFP experiment roadmap: storage limits, reverse trials, automation upsell, seat assignment. Comments reference Jason's monetisation strategy and call for a page on JSM experience gating logic. Directly relevant to ServCo Uplift (P0), edition gating framework, and 1-year investment plan. | 2026-03-26 | Confluence (ITSOL) |
| AI-next ITG & brainstorming | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6704932808) | FY27 JSM AI strategy planning — ITG Apr 15-17. 9 themes: Rovo Help (SMB), AI-native ops, AI-first UI, AI onboarding, help-seeker monetisation, AI governance/control tower, learning loops. Pre-work due Apr 2. Feeds into edition gating (AI as upgrade lever), growth strategy, and 1-year investment plan. | 2026-03-26 | Confluence (ITSOL) |
| LDR: Service Collection IC & FedRAMP SKUs will initially exclude CSM | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6699305622) | Formal LDR (Driver: Jason D Cruz) documenting sequencing decision: ServCo in IC/FedRAMP launches without CSM to meet L1 KR (100% uplift by Jun 2026). CSM added later — FedRAMP ~Nov 2027, IC TBD. Key context for uplift tracking and SBO comms. | 2026-03-27 | Confluence (ITSOL) |
| Enterprise and Monetization LRP pre-work for FY27-29 | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6490585695) | FY27-29 LRP strategic roadmap for ServCo. Northstar: $2.5B by FY29. LT target: 30% CAGR ($828M ARR in 3 years). HT: $1.7B by FY29 at 48% CAGR. Three priorities: diversify acquisition, engage/retain, revenue acceleration. Detailed roadmap with FY27-29 investment sequencing across land, engage, expand. DIRECTLY feeds your 1-year investment plan (due Mar 31). | 2026-03-28 | Confluence (ITSOL) |
| Conversational first experience - ITSM | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6650578377) | POV doc: "chat as front door, Jira as background infrastructure." Defines AI-native UX for Services (request, access, policy, approvals) and Ops (alert triage, incident coordination) — all in chat without touching the portal. Cross-surface: Rovo Desktop, Slack, Teams. MVP scoped to top-20% high-frequency flows. Directly relevant to AI-native growth strategy, edition gating (what justifies Premium in an AI-first world), and 1-year investment plan. | 2026-03-29 | Confluence (ITSOL) |
| AI Focus Areas for JSM | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6723748447) | Structured overview of JSM's AI focus areas: table of capabilities (What/Why/Who else/What we need to do/Notes). Covers AI triage, AI-native ops, knowledge base AI, service agent evolution. Created Mar 30 — freshest internal signal on where JSM AI investment is headed. Directly relevant to edition gating (which AI capabilities go where) and 1-year investment plan. | 2026-03-31 | Confluence (ITSOL) |
| ServiceCo April 2026 Town Hall – 7th April | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6730463606) | Agenda for Apr 7 ServCo all-hands. Includes Vikram's outlook on Service Collection, Business Pulse from LRP/QBR, Sales and PMM perspectives, and Team '25 demo walkthrough. Slide deck linked in page. Directly relevant to all 3 active goals — signals where leadership is pointing the org post-LRP. | 2026-04-01 | Confluence (ITSOL) |
| AI-first Experiences for JSM — Strategy & Roadmap | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6740783741) | Comprehensive AI-first JSM strategy with multi-quarter roadmap (FY26 Q3 → FY28). Covers automated workflows by default, ticketless deflection, AI governance/Control Tower, learning loops, Solution Composer onboarding. Directly impacts edition gating (AI as primary upgrade lever — Control Tower at Enterprise), growth strategy, and 1-year investment plan. | 2026-04-02 | Confluence (ITSOL) |
| Beyond Vibe Checks: A PM's Complete Guide to Evals | [Lenny's Newsletter](https://www.lennysnewsletter.com/p/beyond-vibe-checks-a-pms-complete) | How to evaluate AI products rigorously — goes beyond gut-feel to systematic evals. Critical skill for anyone building AI features or positioning as an AI PM authority. | 2026-04-05 | #ProductManagement |
| AI Tips + Tricks from the Atlassian PM community | [Confluence](https://hello.atlassian.net/wiki/spaces/PMC/pages/5217126031/AI+Tips+Tricks+from+the+Atlassian+PM+community) | Compiled AI use cases and workflows from Atlassian PMs — prototyping, prompting, tool comparisons. Live page actively updated. Reference for staying current on internal AI PM practice. | 2026-04-05 | #AIPM design hacks |
| AI Utilization in Product at Atlassian (TIP Survey Dec 2024) | [Confluence](https://hello.atlassian.net/wiki/spaces/PeopleInsights/pages/4687921263/AI+Utilization+in+Product+at+Atlassian+Insights+from+the+December+2024+TIP+Survey) | Internal data: 1-in-4 Atlassian PMs saves 2.5–5h/week with AI. Baseline for understanding AI adoption gap and justifying AI enablement work. Informs the AI PM Playbook initiative. | 2026-04-05 | #AIPM design hacks |
| Reduce Steps Post QA Options DACI | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6764313020) | Active DACI (Driver: Dale Baldwin) on reducing friction in Service Collection Premium trial starts — linked directly to ATLAS-99547 (Premium trial KR). Evaluates two options for commerce component changes to enable inline trial UX in Jira template gallery. Decision in progress, comments added Apr 7. Directly relevant to ServCo Uplift (P0). | 2026-04-08 | Confluence (ITSOL) |
| [DRAFT] Rovo Studio MMR March 2026 | [Confluence](https://hello.atlassian.net/wiki/spaces/AAI/pages/6723491332) | March 2026 Studio Monthly Metric Review. Agent & Agentic Skill Invocations: 4.56M, +28.8% MoM, +164K vs forecast. Continued growth after Jan recovery. Live signal on AI feature traction — directly relevant to AI packaging positioning, ServCo growth strategy, and understanding Rovo velocity as a platform bet. | 2026-04-09 | Confluence (AAI) |
| Competitive analysis: AI-native incident management | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6808051132) | Market signals and competitive analysis for AI-native incident management. Covers triad analysis (Shahee/Rishabh/Abhinaya/Sathish/Abhinav). Directly relevant to edition strategy (incident mgmt gating), 1-year investment plan (where to invest in AI-native ops), and growth strategy (competitive positioning vs SNOW/PagerDuty/etc). | 2026-04-16 | Confluence (ITSOL) |
| ServiceNow ITOM Visibility vs. JSM Enterprise — Pillar-by-Pillar Analysis | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6877017565) | Pillar-by-pillar competitive gap analysis (Deeksha Rustagi, Apr 23). JSM strong on service desk + lightweight CMDB. Full gaps: Tag Governance, Certificate Mgmt, Firewall Audits, K8s/cloud-native visibility, Oracle specialised collection. Key build/partner targets: TLS cert mgmt, K8s discovery, cloud tagging engine. Directly feeds edition gating (what justifies Enterprise vs Premium), ServCo growth strategy, and competitive positioning vs SNOW. | 2026-04-24 | Confluence (ITSOL) |
| 23rd April - IT Ops Manager (Customer Research) | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6879415740) | Dovetail-linked customer research session (Apr 23). IT Ops Mgr at 120-person fully-remote company. Key pain patterns: certificates/contracts tracked manually in Excel (not JSM Assets), reporting for execs requires manual data assembly across disconnected systems, software access approval doesn't auto-notify app owners. Strong signal on ITAM gaps and consolidation value prop. Relevant to ServCo growth strategy and edition gating (ITAM capabilities at Premium). | 2026-04-24 | Confluence (ITSOL) |
| Service Collection Public Roadmap — Team'26 US | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6892166998) | Sign-off review page for ServCo public roadmap being socialised May 8. Confirmed items: Solution Composer (AI-native configurator, FY27Q2), HAM (FY27Q1), AI Incident Prevention Center (FY27Q1), Live Chat (GA FY26Q4), AI-first WFO (FY27Q2), Surveys GA + Rovo-powered (FY27Q1), Analytics & Reporting (FY26Q4). Anand sign-off still pending on Solution Composer and Analytics. Directly relevant to ServCo growth strategy and understanding what's committed publicly. | 2026-05-02 | Confluence (ITSOL) |
| Shipping App Editions | [Confluence](https://hello.atlassian.net/wiki/spaces/~638712e23c26ca7fa0d548f3/pages/5341957922/Shipping+App+Editions) | Marketplace/Ecosystem team launched App Editions — partners can now offer differentiated features and pricing across multiple app editions. Direct precedent and potential model for how Atlassian thinks about edition-based tiering in the ecosystem. Relevant to edition gating framework and how partners will align to ServCo editions. | 2026-05-02 | #ProductManagement (Slack) |
| Why Product Managers Must Embrace AI Now | [Confluence](https://hello.atlassian.net/wiki/spaces/PMC/blog/2025/05/26/5322426965/Why+Product+Managers+Must+Embrace+AI+Now) | Internal blog post by Otto Ruettinger shared in #ProductManagement with call to register for AI prototyping tool pilots commencing this week. Relevant to AI PM craft positioning and staying current on internal AI enablement programs. | 2026-05-02 | #ProductManagement (Slack) |
| Anu's AI Insights for Atlassian Product Managers | [Confluence](https://hello.atlassian.net/wiki/x/96MmOwE) | PMC blog (May 2) — Anu discusses the impact of AI on Atlassian and opportunities for PMs to ride the AI wave. Shared by Otto in #ProductManagement this morning. Directly relevant to AI applied to PM work goal — high-signal internal framing on where leadership sees AI going for PMs. | 2026-05-02 | #ProductManagement (Slack) |
| Marketing and Product — Email Campaign Audit | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/whiteboard/6858894473) | Whiteboard audit of JSM/ServCo email nurture campaigns: Standard Eval Nurture, Free Land Onboarding (Auxia Pilot), Standard → Premium upsell. Live signal on what upgrade motion is in market and where gaps may exist. Directly relevant to ServCo upgrade framework (P2) and 1-year investment plan (P1). | 2026-05-02 | Confluence (ITSOL) |
| BerryTwist Open Beta GO/NO-GO | [Confluence](https://hello.atlassian.net/wiki/spaces/AAI/pages/6850632295) | Rovo & AI team's GO/NO-GO for BerryTwist Open Beta (launched ~Apr 29). Relevant to understanding AI packaging decisions, how Rovo features are staged through beta/GA, and what "open beta" means for ServCo AI features. MEDIUM — context for AI packaging work. | 2026-05-02 | Confluence (AAI) |
| ITOps FY26 Q4 R4 Review with ServCo LT | [Confluence](https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6850370293) | R4 review with ServCo LT — fresh comment from Mark O'Shea today separating Bluebird/GCP investment from Enterprise grade reporting. Investment plan signal. Relevant to 1-year investment plan (P1) and understanding what ITOps is committing vs deferring this quarter. | 2026-05-02 | Confluence (ITSOL) |

## Prototyping

- [Setting up your own prototype environment in staging](https://hello.atlassian.net/wiki/spaces/~734276749/pages/6714948448/Setting+up+your+own+prototype+environment+in+staging) — **Current canonical guide** (Mar 2026). Branch-per-prototype model. Each branch gets its own Micros service + live URL (`servco-{branchName}.us-west-2.platdev.atl-paas.net`). No re-cloning needed — just create a new branch, run `./scripts/setup-branch.sh`, push. Branch name ≤26 chars.
- [servco-prototyping repo](https://bitbucket.org/atlassian/servco-prototyping/src/main/) — **Current base repo** for new prototypes. Replaces kg-prototyping. Uses Atlassian internal packages (@atlaskit, @atlassian), AI Gateway, ASAP auth.
- [AI Experimentation Kit — Original Setup Guide](https://hello.atlassian.net/wiki/spaces/~712020bffd994093c8458c89e1e2f0d9abcb3a/pages/5977078534) — Older guide (kg-prototyping base). Still relevant for existing HAM prototype.
- [AI Experimentation Kit Repo (kg-prototyping)](https://bitbucket.org/atlassian/kg-prototyping/src/main/) — Original base repo. Slack: #ai-experimentation-kit

**Creating a new prototype (no re-clone needed):**
```bash
cd ~/jdcruz-prototype
git checkout main && git pull
git checkout -b jdcruz-{name}   # ≤26 chars total
./scripts/setup-branch.sh       # creates Micros service + deploy token (needs VPN)
git push -u origin jdcruz-{name}
# → live at servco-jdcruz-{name}.us-west-2.platdev.atl-paas.net in ~15 min
```

### My Prototypes

**Forge Apps** (deployed to jason-jsm.atlassian.net):
- [jdcruz-forge-apps repo](https://bitbucket.org/jira-service-management/jdcruz-forge-apps) — Forge app source code. Local: `~/jdcruz-forge-apps`
- **AI Usage Dashboard** — [Live URL](https://jason-jsm.atlassian.net/jira/apps/1aca3df7-a481-462a-98a8-4d65d82fe482/c71ddc00-6e6c-44cd-9297-33f392783ce1). Forge global page showing AI resolutions, deflection rate, agent performance, category breakdown.

**HAM Prototype (existing):**
- **Live URL:** [HAM Prototype](https://jsm-ham-jdcruz-prototype.us-west-2.platdev.atl-paas.net/jsm/)
- Local: `~/jdcruz-prototype` — branch `jdcruz-prototype` on `jsm` remote
- [HAM Prototype repo](https://bitbucket.org/jira-service-management/ham-proto) — based on kg-prototyping (original base)

## Slack Channels

- **AI Next for ServCo** — `C0AC4DGEXBM` — AI customer findings, AI Next for JSM workshop channel (Konstantinos Kazakos)

Known channel IDs for Slack API calls. Add new ones here as you discover them via browser.

| Channel | ID | Notes |
|---|---|---|
| #servco-questions | `C09DE7NE3JS` | ServCo uplift questions, 447 members. Workspace: `EE8HJA7RS` |
| #ProductManagement | `CFGQGGSRH` | PM community channel |
| #AIPM-design-hacks | `C085EDZ9C9K` | AI PM design hacks |
| DM self (agent delivery) | `DFFF0J94G` | Agent output delivery channel |
| Industry knowledge sources | `C0305F27406` | Industry knowledge / external signal channel |
| DM Shilpa Koneru | `D0A9UNCF55Y` | PEU / Child Collection, edition strategy |

## Data Sources

### VOC (Voice of Customer)
- **Site:** `hello.atlassian.net`
- **Project key:** `VOC`
- **URL:** https://hello.atlassian.net/browse/VOC
- **Access:** Via Jira MCP (`search_jira_using_jql`, `get_jira_issue`) on `https://hello.atlassian.net`
- **Useful issue types:** Customer Insight, Customer Feedback (FY26), Churn Insights, Sales Blocker or Friction, PM Call Request (FY26), Migration Feedback
- **Example JQL:** `project = VOC AND issuetype = "Customer Insight" AND text ~ "JSM" ORDER BY created DESC`

### Support Tickets (GSAC)
- **Source:** Databricks via Secoda / Socrates MCP
- **Primary table:** `production.support_gsac_analytics.dim_support_issue`
- **Related tables:**
  - `production.support_gsac_analytics.wide_issue` — wide denormalised view of all GSAC tickets
  - `production.support_gsac_analytics.csat` — CSAT survey responses linked by `issue_key`
  - `production.support_gsac_analytics.fact_worklog` — time logged per ticket
  - `production.support_migration_analytics.dim_support_migration_issue` — migration-specific tickets (MOVE)
- **Access:** Via Socrates MCP (`sql_query`, `describe_table`, `sample_table`)
- **Key columns:** `issue_key`, `reporter_domain`, `affected_product`, `request_type`, `issue_status`, `issue_created_timestamp`, `resolution_reason`
- **Example query:** `SELECT issue_key, affected_product, request_type, issue_status FROM production.support_gsac_analytics.dim_support_issue WHERE affected_product = 'Jira Service Management' AND issue_created_timestamp >= '2026-01-01' LIMIT 100`

### Data Artifacts — Domain Notebooks + Dashboards

**Pattern:** One notebook per domain, not per question. Dashboard is the shareable live view. Confluence pages link to both — don't embed numbers inline.

| Question | Notebook § | Dashboard Tab | Confluence |
|---|---|---|---|
| MRR by edition & segment | edition-mix-and-movement §1 | MRR Overview | Exec View |
| $/seat by edition & segment | edition-mix-and-movement §2 | MRR Overview | Exec View |
| Edition mix (% of MRR) over time | edition-mix-and-movement §3 | Edition Mix | Exec View |
| Upgrade signal landscape (Std vs Prem) | edition-mix-and-movement §4 | Upgrade Signals | Upgrade Signals page |
| TWC attach rate by edition | edition-mix-and-movement §5 | — | Exec View |
| Std→Prem readiness distribution | edition-mix-and-movement §6 | — | Upgrade Signals page |
| Feature adoption by edition (template) | edition-mix-and-movement §7 | — | Exec View |
| ServCo uplift KR tracking | edition-mix-and-movement §8 | ServCo Uplift | L1 KR scoring |

#### Consolidated Domain Notebooks

- **Edition Mix & Movement** (primary — edition-level metrics)
  - **Path:** `/Users/jdcruz@atlassian.com/rovo/edition-mix-and-movement`
  - **URL:** https://socrates-workbench-01.cloud.databricks.com#notebook//Users/jdcruz@atlassian.com/rovo/edition-mix-and-movement
  - **Language:** Python (mixed SQL cells) | **Created:** 2026-05-04
  - **Sections:** §0 Shared Definitions, §1 MRR, §2 $/Seat, §3 Edition Mix, §4 Upgrade Signals, §5 TWC Attach, §6 Readiness, §7 Feature Adoption, §8 ServCo Uplift
  - **Dashboard:** [Edition Mix & Movement](https://socrates-workbench-01.cloud.databricks.com/dashboardsv3/01f1479736e81d5c894bbd4b24f2ff04) — 4 tabs: MRR Overview, Edition Mix, Upgrade Signals, ServCo Uplift

#### Legacy Notebooks (pre-consolidation — do not create new ones here)

- **JSM Edition Strategy — Feature Usage & Cohort Analysis**
  - **Path:** `/Users/jdcruz@atlassian.com/rovo/jsm-edition-strategy`
  - **URL:** https://socrates-workbench-01.cloud.databricks.com#notebook//Users/jdcruz@atlassian.com/rovo/jsm-edition-strategy
  - **Language:** SQL | **Created:** 2026-04-13
  - **Contents:** 17 feature activation rates, downgrade/churn cohorts, seat contraction, Jan 2026 spike investigation
  - **Status:** Legacy — fold into edition-mix-and-movement when revisiting these analyses

## Dovetail Research (Live — Primary Source for Qual)

Dovetail is the live source for customer research, qual insights, and interview transcripts. **Always check Dovetail when asked to do any research synthesis, competitive intel, customer understanding, or JTBD work — before querying any other source.**

**Access via MCP:** `mcp__dovetail__invoke_tool`
**How to search:**
- Find projects by title: `get_dovetail_projects` with `filter.title.contains`
- List transcripts in a project: `list_project_data` with `filter.project_id`
- Read a transcript: `get_data_content` with `data_id`
- Get structured insights: `list_project_insights` with `filter.project_id`

**Do NOT use Dovetail for SQL/data queries** — use Socrates/Databricks for those.

**Known ServCo / JSM projects:**

| Project | ID | Author | Date | Notes |
|---|---|---|---|---|
| ServCo PMF & Value | `6ZFfzjtIiVTvUHT8NE1JK2` | Alison Williams | Aug 2025 | 9 interviews (P1–P9, customers + non-customers) |
| ServCo Gong calls | `5qeGb9YIhzBjAXvZEO3Eb9` | Alison Williams | Nov 2025 | Sales call transcripts |
| ServCo Customer Connect Sept 2025 | `7ueQ86FLhNYsCmvHEb9eEA` | Adriana Vargas Saenz | Sep 2025 | Customer connect session |
| ServCo Premium upgrades | `7kpLMSdyUazyqSd2qvXqCR` | Will Jenkins | Oct 2025 | Premium conversion research |
| ServCo AI Teammates | `2VSwj88ZvexMLaOcTxtEeW` | Sophie Wallace | Aug 2025 | AI teammates research |
| JSM Premium: Jobs To Be Done Discovery | `1HTn7DQieeaoukzPU1tBeV` | Simran Talreja | Jul 2025 | 12 interviews (DevOps, SWE, PM, CIO, CISO, IT leads) |
| JSM 3-year monetisation strategy research | `6aJmE0pKBCcXycR8QOV9S3` | Adriana Vargas Saenz | Nov–Dec 2025 | 7 interviews (P1–P7), 1 insight on UU/requester pricing |
| JSM enterprise analytics research | `479Othq6LmlB543sEmycop` | Nithaya | Oct 2025 | Enterprise analytics |
| JSM 3p Connector Time to Value | `6l61RoDVQMzRTy4Uqaqezp` | Gabi Kaplan | Mar 2026 | 3rd party connector TTV |

**Folder reference:** Folder `2sHPnik4HsdjWHjF78RIuQ` contains the main ServCo PMF/monetisation research.

**Total projects in workspace:** 1,917 | **Total insights:** 4,821+

## General / Strategy

### Rovo Dev ROI Calculator
- **URL:** https://hello.atlassian.net/wiki/spaces/~349409947/pages/6820436356/Rovo+Dev+ROI+Calculator
- **What:** 6-layer ROI model (time saved, quality multiplier, strategic leverage, dollar value, agent automation, compounding). Built from session-log.md data. Shareable with leadership.
- **Date found:** Apr 15, 2026

## Upgrade Signals (JSM Std → Premium)
- **Confluence:** [JSM Std → Premium Upgrade Signals](https://hello.atlassian.net/wiki/spaces/~349409947/pages/6865660666) — 2026-04-22
- **Cohort table:** `personal.jdcruz.upgrade_signal_cohort_v10_seg` (Delta, queryable via Socrates)
- **Local analysis:** `Knowledge/upgrade_signals/analysis_2026-04-21.md`
- **Loop script:** `Knowledge/upgrade_signals/autoresearch_loop_v11.py`

## Agent Performance Dashboard
- **URL:** `https://f0acec4a-a44c-4513-bb47-a9c176ba5d19-00-3hmn825517qvn.spock.replit.dev:5000`
- **SSH:** `ssh -i ~/.ssh/replit -p 22 f0acec4a-a44c-4513-bb47-a9c176ba5d19@f0acec4a-a44c-4513-bb47-a9c176ba5d19-00-3hmn825517qvn.spock.replit.dev`
- **Local files:** `projects/agent-dashboard/` — parser, Flask app, templates
- **Data:** `projects/agent-dashboard/agent_runs.json` — regenerated by `parse_agents.py` after each agent run
- **Deploy:** `bash projects/agent-dashboard/deploy_to_replit.sh` — pushes latest code + data to Replit
- **Env var:** `AGENT_DASHBOARD_HOST` in `~/.zshrc` — used by `run-agents.sh` for auto-sync after each run
- **Parser:** `python3 projects/agent-dashboard/parse_agents.py` — parses `Knowledge/session-log.md` → JSON
- **Key findings (May 2026):** Slack Action Scanner 16.5% output rate (182 runs, hourly — waste), Data Refresh 100% error rate, Knowledge Scout 41% error rate, Follow-Up Tracker 42% error rate

## Atlassian Repo Sync
- **Repo:** `atlassian/ds-agent-starter-kit` (Bitbucket)
- **Skills path:** `.rovodev/skills/`
- **Agent:** `agents/atlassian-repo-sync.md` — runs weekly Monday 8am
- **Last checked:** 2026-04-30
- **Last commit hash (main):** `651129a76a991da42926500ff1ce1ea625e31953` (2026-04-28)
- **Skills synced:** `data-insight-checker-for-servco` (PR #59 — `df6d4e24fca867fb568485a4ed64b0d203c1197e`)
- **Note:** PR #59 not yet merged to main. Synced from feature branch. Re-sync when merged.

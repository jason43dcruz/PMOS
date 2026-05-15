# Raw Sources

Drop source material here. PDFs, exported Confluence pages, meeting notes, transcripts, competitive research, SQL findings.

**Rules:**
- Never edit files in this folder manually — they're inputs, not outputs.
- The LLM reads from here and compiles into `topics/`, `decisions/`, and `synthesis/`.
- Supported formats: `.md`, `.pdf`, `.txt`, `.html`

---

## Edition Strategy Sources

### Confluence Pages (live — fetch via MCP before compiling)

| Source | URL | What it covers |
|---|---|---|
| Edition Strategy — Executive View v2 (Post-Spar) | https://hello.atlassian.net/wiki/spaces/~349409947/pages/6949208363 | Current source (May 11). Goal-first → ServCo framing → edition-by-edition → motions → rubric. **Start here.** |
| Edition Strategy — Full Context | https://hello.atlassian.net/wiki/spaces/~349409947/pages/6856213431 | Full six-layer framework, gating principles, worked examples (AI Control Tower, WFO) |
| Edition Strategy Supporting Data | https://hello.atlassian.net/wiki/spaces/~349409947/pages/6773086820 | Data artifacts, Databricks notebook link, live dashboard |
| Unified Competitive Synthesis | https://hello.atlassian.net/wiki/spaces/~349409947/pages/6677661639 | Competitive deep dives — positioning & feature gating across SNOW, Freshservice, Zendesk, BMC, ManageEngine |
| Edition Strategy — Open Questions & First-Cut Answers | https://hello.atlassian.net/wiki/spaces/~349409947/pages/6660203100 | Working answers to open strategic questions |
| Edition Strategy: Goals, Constraints, and Feature Gating Framework | https://hello.atlassian.net/wiki/spaces/~349409947/pages/6668849732 | Original framework draft — goals, constraints, gating rubric |
| JSM/ServCo — Margin Limits & Discounting Analysis | https://hello.atlassian.net/wiki/spaces/~349409947/pages/6703878295 | Discount distributions by segment/edition/motion, GM% floors |

### Confluence Pages (adjacent — relevant context)

| Source | URL | What it covers |
|---|---|---|
| WAC Pricing Page Planning | https://hello.atlassian.net/wiki/spaces/ITMarketing/pages/5597788877 | Pricing page planning context |
| R&I Report: SVC Monetization Opportunities | https://hello.atlassian.net/wiki/spaces/rai/pages/6572578085 | Research & Insights monetisation analysis |
| What You Need to Believe: The UBP Opportunity | https://hello.atlassian.net/wiki/spaces/acbp/pages/6748076467 | UBP business case |
| RT Experience Report: Reverse Trials | https://hello.atlassian.net/wiki/spaces/researchandinsights/pages/4951179978 | Reverse trial data (Jira, not JSM) |
| Opsgenie Sunset & JSM Migration | https://hello.atlassian.net/wiki/spaces/~179069336/pages/6523604148 | Standalone ops TAM, packaging strategies for ops-only buyers |
| AI-Native Incident Management Analysis | https://hello.atlassian.net/wiki/spaces/ITSOL/pages/6808051132 | Competitive analysis for AI-native incident mgmt |

### Databricks / Data

| Source | Location | What it covers |
|---|---|---|
| JSM Edition Strategy Notebook | `/Users/jdcruz@atlassian.com/rovo/jsm-edition-strategy` | SQL notebook — feature usage, cohort analysis, edition movement |
| WAC Pricing Snapshot | `Knowledge/snapshots/wac-pricing-snapshot.md` | Point-in-time pricing reference |

### Secoda (live — fetch via Secoda MCP)

| Source | Entity ID | What it covers |
|---|---|---|
| JSM / Service Collection — Edition Strategy | `47fd690b-e974-467a-a858-b34e93d177ca` | Edition value props, upgrade paths, packaging framework |

### Local Knowledge Files

| Source | Path | What it covers |
|---|---|---|
| JSM Enterprise — Why Customers Buy | `Knowledge/jsm-enterprise-why-customers-buy.md` | Enterprise MRR $22.1M, seat concentration, $23.3M Premium opportunity |
| Upgrade Signal Brief | `Knowledge/upgrade-signal-brief.md` | Signal families, evaluator framework, mutation strategy |
| Upgrade Signal Log | `Knowledge/upgrade-signal-log.md` | Accepted signals (queue config 3.77× lift), rejected candidates, next runs |
| Upgrade Signal System Structure | `Knowledge/upgrade-signal-system-structure.md` | System architecture: agent + notebook + state tables |
| Upgrade Signal Automation Contract | `Knowledge/upgrade-signal-automation-contract.md` | Unattended workflow contract for autoresearch |
| PSR HT Strategy Implications | `Knowledge/psr-ht-strategy-edition-implications.md` | Shamik PSR meeting takeaways — ITOM, cross-flow, module packaging |
| Anand Decision Profile | `Knowledge/anand-narayanan-decision-profile.md` | How Anand thinks, decision format, persuasion playbook |
| Shamik Decision Profile | `Knowledge/shamik-sharma-decision-profile.md` | How Shamik thinks, end-state-first framing, SAM quantification |
| Knowledge References | `Knowledge/knowledge-refs.md` | Master index of all live source URLs and pointers |

### Local Strategy Drafts

| Source | Path | What it covers |
|---|---|---|
| Edition Strategy Master | `projects/edition-strategy/strategy/draft-service-collection-edition-strategy.md` | Six-layer framework, 60+ questions, gating principles |
| Edition Strategy Working | `projects/edition-strategy/strategy/edition-strategy-working.md` | Live Layer 0–3 state |
| Edition Positioning | `projects/edition-strategy/strategy/draft-edition-positioning.md` | Diagnosis, competitive landscape, positioning axes, constraints |
| Gating Framework | `projects/edition-strategy/strategy/draft-edition-gating-framework.md` | Rubric, rocks/pebbles/meters, worked examples |
| Jefferson vs Rubric Critique | `projects/edition-strategy/strategy/jefferson-vs-rubric-critique.md` | Gating methodology comparison |

---

## AI PM Craft Sources

### Local Knowledge Files

| Source | Path | What it covers |
|---|---|---|
| AI Writing Antipatterns | `Knowledge/ai-writing-antipatterns.md` | Kill-on-sight list of AI writing tics |
| Lenny's Greatest Hits | `Knowledge/lennys-greatest-hits.md` | Synthesised PM frameworks from 60 Lenny's Podcast episodes |
| Lenny's Podcast Transcripts | `Knowledge/lennys-podcast-transcripts/` | 150+ full episode transcripts with topic index |
| Efficiency Patterns | `Knowledge/efficiency-patterns.md` | Known failure modes, infrastructure constraints, retry limits |

### Skills

| Source | Path | What it covers |
|---|---|---|
| Strategy Sparring | `skills/strategy-sparring.md` | 10 pressure-testing moves ordered by intensity |
| Create Agent | `skills/create-agent.md` | Agent creation and orchestrator patterns |
| In-Session Orchestration | `skills/in-session-orchestration.md` | Parallel subagent invocation patterns |
| Write Like Me | `skills/write-like-me.md` | Voice, tone, structural preferences |
| Data to Narrative | `skills/data-to-narrative.md` | Converting analysis into recommendations |
| Draft Stakeholder Comm | `skills/draft-stakeholder-comm.md` | Executive communication patterns |

### Agents

| Source | Path | What it covers |
|---|---|---|
| 22+ agent files | `agents/*.md` | Full agent catalogue — briefing, scout, meeting prep, competitive intel, etc. |

---

> **To add new sources:** drop files here (or note URLs above), then run the compilation prompt (see `wiki/PROMPTS.md`).
> **To refresh from Confluence:** fetch live pages via MCP before compiling — don't rely on local copies.

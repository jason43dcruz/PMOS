# LLM Wiki — Index

*A compounding knowledge base for strategic PM work. Two domains: Edition Strategy and AI PM Craft.*

**Last compiled:** Apr 20, 2026
**Total pages:** 23

---

## How to use this wiki

1. **Browse topics** — each page covers one concept with evidence, links, and open questions
2. **Read synthesis pages** — for the current state of beliefs and unresolved tensions
3. **Add new sources** — drop files in `raw/`, then run the compilation prompt from `PROMPTS.md`
4. **Lint periodically** — every ~20 new pages, run the lint prompt to catch orphans, contradictions, and stale evidence

---

## Topics — Edition Strategy

| Page | One-line summary |
|---|---|
| [[edition-gating]] | Framework for deciding which features go in which edition — rocks, pebbles, meters |
| [[rocks-pebbles-meters]] | Classification system replacing soft/hard gates — the unit of gating |
| [[edition-positioning]] | How each edition is framed to buyers — identity, value story, upgrade trigger |
| [[standard-edition]] | Default PLG landing tier — strong, possibly too strong at $20/agent |
| [[premium-edition]] | Mid-tier anchored on ITAM + AIOps + WFO — thickness depends on HAM launch |
| [[enterprise-edition]] | Top tier for governance/compliance — right gates, low conversion (31%) |
| [[upgrade-signals]] | Product behaviours that predict edition upgrades — the 86% mystery |
| [[competitive-gating]] | How ServiceNow, Freshservice, Zendesk, BMC, ManageEngine structure tiers |
| [[competitive-pricing-map]] | **Cross-edition map + $/value math.** Free→Starter, Std→Std/Growth, Prem→Pro, Ent→Ent. Pricing headroom recommendations. |
| [[ai-governance]] | AI Control Tower — the bet for Enterprise-only pull beyond compliance |
| [[servco-constraints]] | Fixed constraints that bound all edition decisions — not choices, walls |

## Topics — AI PM Craft

| Page | One-line summary |
|---|---|
| [[ai-agent-design]] | Patterns for building AI agents that do recurring PM work autonomously |
| [[strategy-sparring]] | 10 moves for pressure-testing strategy with AI, ordered by intensity |
| [[prompt-engineering-for-pms]] | Practical prompting techniques for strategy docs, data analysis, comms |
| [[ai-writing-antipatterns]] | Kill-on-sight list of AI writing tics that undermine credibility |
| [[llm-patterns]] | Six recurring patterns for applying LLMs to PM work |

## Decisions

| Page | What it covers |
|---|---|
| [[edition-strategy-decisions]] | Settled decisions + things explicitly rejected in edition strategy |
| [[ai-pm-craft-decisions]] | Settled decisions about how to apply AI to PM work |

## Synthesis

| Page | What it covers |
|---|---|
| [[what-we-believe]] | Current beliefs across both domains + open tensions between them |
| [[open-questions]] | Questions without good answers yet, each with a path to resolution |
| [[evidence-changelog]] | When significant evidence arrived and which pages it affected |

## Infrastructure

| File | Purpose |
|---|---|
| `PROMPTS.md` | Copy-paste prompts for compiling, linting, refreshing, and publishing |
| `raw/README.md` | Source material index and rules for the raw folder |

---

## Wiki graph (conceptual)

```
edition-gating ←→ rocks-pebbles-meters
     ↕                    ↕
edition-positioning ←→ standard-edition ←→ premium-edition ←→ enterprise-edition
     ↕                    ↕                    ↕                    ↕
competitive-gating    upgrade-signals     ai-governance      servco-constraints
                          ↕
                    what-we-believe ←→ open-questions ←→ evidence-changelog
                          ↕
ai-agent-design ←→ strategy-sparring ←→ prompt-engineering-for-pms
     ↕                                        ↕
llm-patterns                        ai-writing-antipatterns
```

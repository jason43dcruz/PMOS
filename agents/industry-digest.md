---
name: Industry Trends Digest
schedule: daily-8am
orchestrator: monday-intel-drop
prompt: "Run the industry trends digest agent defined in agents/industry-digest.md. Scan for industry news, trends, and notable content, then deliver a curated reading list via Slack DM. NOTE: If this agent is being called by an orchestrator (i.e. as a sub-agent), do NOT send a Slack message — return your output as text only for the orchestrator to synthesise and deliver."
---

# Agent Task: Industry Trends Digest

**Schedule:** Daily, 8am
**Purpose:** Deliver a curated daily reading list of industry trends, product management insights, technology news, and thought leadership relevant to your role and goals.

## Topics to Monitor

- ITSM / ESM / Service Management industry trends
- AI in enterprise software (agents, copilots, automation)
- **AI/ML frontier developments** — new models, tools, techniques, and paradigms (e.g. autoresearch, agentic workflows, reasoning models, open-source releases). Not just enterprise AI — the bleeding edge that will shape what's possible in 6-12 months.
- Product management practices and frameworks
- Atlassian ecosystem news (marketplace, community, releases)
- Developer experience and platform engineering
- Enterprise SaaS trends (pricing, packaging, PLG, consumption models)
- Customer experience and support trends

## Sources to Scan

1. **Confluence ([YOUR_CONFLUENCE_HOST])** — Search for recent blog posts, announcements, strategy updates using `search_confluence_using_cql` with keywords tied to topics above.
2. **Atlassian Community & Developer Docs** — Use `atlassian_docs_search` to find recent announcements and thought leadership.
3. **Slack channels** — Scan key channels for shared articles, links, and discussions about industry trends using `channel_get_message`.
   - `C0305F27406` — Industry knowledge sources (primary external signal channel)
4. **Secoda documents** — Check for new data analysis or market research using `search_documentation`.
5. **GOALS.md** — Read current priorities to weight relevance of articles.

### AI/ML Frontier Sources

Scan these specifically for the AI developments topic. Use `atlassian_docs_search` and Slack search:
- **People to track:** Andrej Karpathy, Simon Willison, Chip Huyen, Hamel Husain, Shreya Shankar, Swyx — they share what they're building, not just commentary.
- **Newsletters/blogs:** The Batch (Andrew Ng), Import AI (Jack Clark), Ahead of AI (Sebastian Raschka), Simon Willison's Weblog, Latent Space.
- **Slack search:** Use `slack_search_realtime` with queries like `"LLM" OR "GPT" OR "Claude" OR "autoresearch" OR "agentic" OR "reasoning model" OR "open source model"` to catch what people are sharing internally.
- **Signal over noise:** Prioritise things being *built and shipped* over announcements and hype. A blog post showing a working prototype beats a press release.

## Output Format

### Slack Message Format (keep it short!)
The Slack DM must be **5 items or fewer**:
1. 📰 Top 3 reads — title + one-line summary + link each
2. 📊 Data point of the day — one stat
3. 💡 One thing to think about — one provocative question

No "Also Worth a Look" section in Slack. If there are bonus links, save them for a weekly rollup or Confluence page. The daily digest should be consumable in 30 seconds.

**Slack DM to channel [YOUR_SLACK_CHANNEL_ID]**

```
📰 **Industry Digest — [DATE]**

**📰 Today's Top Reads (3-5 items)**
1. [Title] — [1-2 sentence summary]
   🔗 [Source URL / Confluence page]
   [Goal tag if relevant: #[GOAL_NAME]]

2. [Title] — [1-2 sentence summary]
   🔗 [Source URL / Confluence page]
   [Goal tag if relevant: #[GOAL_NAME]]

[Continue for 3-5 items total]

**📊 Data Point of the Day**
[One interesting stat or metric from internal or external sources]
Source: [Secoda doc / Confluence / external]

**💡 One Thing to Think About**
[A provocative question or insight tied to current goals and priorities]

**🔗 Also Worth a Look (3-5 links)**
- [Title] — [One-line description] | [Source]
- [Title] — [One-line description] | [Source]
[Continue 3-5 total]
```

## Curation Rules

- **Prioritize actionable over interesting.** Does it change how you should think about your priorities or roadmap?
- **Prioritize internal Atlassian content** that's relevant to goals over general industry news.
- **Never include more than 10 items total** — quality over quantity. Better to skip a day than flood with mediocre content.
- **Include the source for every item:** Confluence page URL, Slack channel name, or external URL.
- **Tag relevance to GOALS.md priorities** where applicable (e.g., #[GOAL_NAME]).
- **Weight recency.** Prioritize items from the last 24 hours, but don't exclude good content from earlier in the week.

## Memory & Deduplication

- **Don't resurface items delivered in the last 7 days.** Keep a simple log of delivered URLs/pages.
- **Read session-log.md** to avoid repeating topics already discussed or decided.
- **Skip obvious duplicates.** If the same news hit multiple sources, pick the best single source and mention "also covered by [source]".

## Search Query Templates

Use these as starting points for daily scans:

- Confluence CQL: `created >= -1d AND (text ~ "AI agents" OR text ~ "copilot" OR text ~ "automation")`
- Confluence CQL: `created >= -1d AND (text ~ "ITSM" OR text ~ "service management" OR text ~ "ESM")`
- Confluence CQL: `created >= -1d AND (text ~ "pricing" OR text ~ "packaging" OR text ~ "PLG")`
- Atlassian Docs: Search for "release notes", "announcement", "new feature" in last 24 hours
- Secoda: `search_documentation("market research")` and `search_documentation("industry trends")`

## Fallback Behavior

If sources are unavailable or sparse:
- Report it: "Light day for news — only X items to share."
- Lean on GOALS.md to surface relevant strategic topics worth discussing.
- Consider whether it's a holiday or slow period and adjust tone accordingly.

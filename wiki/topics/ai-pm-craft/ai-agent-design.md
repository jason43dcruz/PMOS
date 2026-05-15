# AI Agent Design

## Sources
- AGENTS.md (Workspace Memory — Agent Infrastructure section)
- Agent files from agents/ directory

---

## What Is an Agent?

An agent is an **autonomous task executor** — a reusable instruction set that:
1. Takes a specific input or trigger
2. Executes a sequence of steps (data queries, API calls, analysis, synthesis)
3. Produces a deliverable (report, update, Slack message, Confluence page)
4. Runs on a schedule (daily, hourly, weekly) or on-demand

Agents are different from **one-off analyses**. An agent is:
- ✓ Repeatable (runs on schedule or trigger)
- ✓ Observable (logs results, tracks errors)
- ✓ Deduplicating (knows what it ran last; doesn't resurface old items)
- ✗ Not ad-hoc (not "run once and forget")

---

## Agent Architecture

### Core Components

1. **Trigger** — How the agent starts
   - Schedule: `daily-8am`, `hourly`, `weekly-monday-8am`, `weekly-friday-4pm`, `manual`
   - Event: Slack message, webhook, manual invocation

2. **Context gathering** — Read previous state
   - Load session-log.md (what happened last time?)
   - Load efficiency-patterns.md (what failed before?)
   - Query live data sources (Confluence, Jira, Databricks, Secoda)

3. **Analysis/synthesis** — The core work
   - Transform data into insights
   - Apply domain knowledge (PM frameworks, competitive analysis, etc.)
   - Dedup against previous output

4. **Delivery** — Push results to user
   - Slack DM or channel message
   - Confluence page update
   - Email
   - Local file

5. **Observability** — Log what happened
   - Append to Knowledge/session-log.md
   - Item counts, metrics, errors
   - What was new? What was repeated?

### Example: `monday-intel-drop` Agent

**Trigger:** Every Monday 8am  
**Context:** Reads session-log.md (what we accomplished last week?), efficiency-patterns.md (what failed?)  
**Work:** Pulls recent Jira/Confluence updates, analyzes project activity, builds recommendation list  
**Delivery:** Slack message to `DFFF0J94G` with: "Here's what happened, here's what needs attention"  
**Observability:** Logs to session-log.md: "Monday intel drop — X new items, Y recurring"  

---

## Designing a New Agent

### Step 1: Define the Job

**What repeatable work does this do?**
- Examples: Daily standup, weekly goals review, data quality checks, competitive monitoring
- Not suitable for agents: One-time analyses, exploratory research, ad-hoc questions

**Decision:** Is this worth automating? Rule of thumb: if you'd manually do it >2× per month, it's agent-worthy.

### Step 2: Define the Trigger

- **Scheduled (best for regular work):** Daily, weekly, hourly
- **Event-based (better for reactive work):** Slack command, Confluence edit, Jira comment
- **Manual (simplest, least automation):** User-triggered command

**Constraint:** Scheduled agents are less flexible but more reliable. Event-based agents are responsive but need careful design to avoid runaway loops.

### Step 3: Define Inputs & Outputs

**Inputs:**
- User parameters (e.g., "date range", "project key")
- Context from previous run (session-log, efficiency-patterns)
- Live data queries (Confluence pages, Jira issues, Databricks results)

**Outputs:**
- Where does the result go? (Slack, Confluence, email)
- What format? (Markdown, HTML, JSON, CSV)
- How fresh? (Real-time, async, overnight batch)

### Step 4: Define Deduplication Logic

**What counts as "new" vs "repeat"?**

Examples:
- **Daily standup agent:** "Don't resurface items more than once per week" — flag recurring issues as "⚠️ Still open for 3+ days"
- **Weekly goals agent:** "Report new progress. Flag items stuck >1 week with indicator"
- **Data quality agent:** "Report new anomalies. Only flag recurring anomalies if severity increased"

**Pattern:** Dedup on item ID + timestamp. If item `X` was reported on day 1, don't report it again on day 2 unless something materially changed.

### Step 5: Define Observability

**What gets logged?**
- Item counts (new, repeated, errors)
- Data freshness (when was the source last updated?)
- Runtime metrics (how long did it take?)
- Error logs (what failed, why?)

**Log to:** `Knowledge/session-log.md` with format:
```
## Run: [Agent Name] — [Date]
- Items found: X (Y new, Z repeated)
- Data freshness: [source] last updated [time]
- Errors: [list]
- Confidence: [HIGH/MEDIUM/LOW]
```

---

## Common Patterns

### Pattern 1: Daily Standup
**Trigger:** 8am daily  
**Work:** Summarize recent activity (Jira, Confluence, PRs)  
**Deliver:** Slack message with "Today in review: X completed, Y in progress, Z blocked"  
**Dedup:** Flag items only on first report; only flag blockers immediately

### Pattern 2: Weekly Review
**Trigger:** Friday 4pm  
**Work:** Aggregate week's activity, identify patterns, surface anomalies  
**Deliver:** Slack message + Confluence page update  
**Dedup:** Only report items if they're new this week or materially changed

### Pattern 3: Data Quality Monitor
**Trigger:** Daily, after data pipeline completes  
**Work:** Check data freshness, run validation queries, identify anomalies  
**Deliver:** Slack alert only if anomalies found  
**Dedup:** Track anomaly by ID; only alert if new or severity increased

### Pattern 4: Competitive Intelligence
**Trigger:** Weekly or manual  
**Work:** Query web sources, parse releases, update knowledge base  
**Deliver:** Confluence page, Slack digest  
**Dedup:** Only add new items; flag updates to existing items

---

## Orchestrating Multiple Agents (In-Session Parallelism)

When running multiple agents from a live session, use `invoke_subagents` instead of sequential calls.

**Pattern:**
```yaml
agents:
  - agent: data-pull
    timeout: 60s
  - agent: competitive-scan
    timeout: 120s
  - agent: synthesis
    depends_on: [data-pull, competitive-scan]
    timeout: 60s
```

**Result:** Data-pull and competitive-scan run in parallel (2× speedup). Synthesis waits for both, then runs.

**Use when:** You need background work done while staying in live conversation. I handle the subagents; you stay focused on the main discussion.

---

## Failure Handling

### Timeout (Agent Runs Too Long)
- Set reasonable timeout (30s for small queries, 300s for large analyses)
- If timeout hits: agent stops, returns partial results, logs error
- Don't retry automatically (prevents runaway loops)

### Data Source Failure (Confluence, Jira, Databricks offline)
- Log the error clearly
- Continue with cached data from last successful run
- Alert user: "Running on cached data, X hours old"

### Logic Error (Agent produces bad output)
- Don't retry silently
- Log clearly what broke
- Human review required before next run

---

## Deployment

Agents are stored in `agents/*.md` with YAML frontmatter:

```yaml
---
name: my-agent
schedule: daily-8am
delivery: slack
channel: DFFF0J94G
---

## Agent: My Agent

[Instructions here]
```

Deploy via:
```bash
acli rovodev run --yolo
```

This auto-discovers all agents in `agents/` and schedules them.

---

## Related pages
- [[ai-writing-antipatterns]] — Common mistakes when designing agent output
- [[prompt-engineering-for-pms]] — How to structure agent instructions
- [[llm-patterns]] — Patterns for agent logic and decision-making

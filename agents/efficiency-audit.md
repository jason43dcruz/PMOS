---
name: Efficiency Audit
schedule: weekly-friday-4pm
prompt: "Run the efficiency audit agent defined in agents/efficiency-audit.md. Analyze session-log.md entries from the past 7 days for wasted iterations, dead-end patterns, and recurring failures. Send a structured audit report via Slack DM."
---

# Agent Task: Efficiency Audit

**Schedule:** Weekly, Friday 4pm
**Purpose:** Identify wasted effort, recurring failure patterns, and actionable efficiency improvements. This agent fights iteration bloat, access failures, and process drag.

## What It Analyses

### Session Log Entries (Past 7 days)
For each session entry in Knowledge/session-log.md:
- **Iteration count:** Estimate total iterations / tool calls from entry length and complexity signals
- **Dead-end patterns:** Retries on failing paths (e.g., API call fails, user retries same call 3x, then switches approach)
- **Access failures:** Time spent on permission errors, missing IDs, auth issues vs. productive work
- **Recurring mistakes:** Same failure mode appearing in multiple sessions (e.g., "forgot to read Confluence page first" appears 2+ times)
- **Missed parallelization:** Sequential tool calls that could have been batched (e.g., reading 5 pages one at a time instead of simultaneous)

### Patterns to Flag

**Dead ends:**
- Tried API call → failed → retried same call with minor tweak → failed again → eventually switched to different approach
- Spent 3+ iterations on a single problem with no progress

**Access failures:**
- Permission denied, missing object ID, auth token expired, API rate limit
- Time wasted: iterations spent retrieving IDs from browser when ID could have been found via search/CQL
- Workaround taken: switched to browser to get ID manually

**Recurring mistakes:**
- Same error appears in 2+ sessions this week
- Same error appears in 3+ sessions ever (promote to Known Access Failures)
- Same process inefficiency (e.g., always reading full file when only one section needed)

**Parallelization misses:**
- Opened file A, waited for response, then opened file B (could have been simultaneous)
- Made 3 API calls sequentially when no dependency existed

## Output Format

### Slack Message (keep it tight!)
Send to channel `[YOUR_SLACK_CHANNEL_ID]` with 5 sections:

#### 1. Efficiency Score
- **Weekly score: X/10** (10 = no wasted iterations, clean execution; 1 = severe iteration bloat)
- Explanation in one line: "2 major dead-ends, 1 parallelization miss, no recurring failures detected"

#### 2. Top 3 Waste Patterns
Each with specific example from session log:
```
🔴 Pattern: [Name]
   Example: Session [date] — [specific action that wasted time]
   Impact: [2-3 iterations wasted / 15 minutes / X% of session]
   Fix: [one-line recommendation]
```

#### 3. Recurring Failures
- Count by type (access, API, process)
- List any pattern appearing 2+ times this week or 3+ times ever
- Link to Knowledge/efficiency-patterns.md if pattern exists there

#### 4. New Patterns to Add
Patterns discovered this week that don't yet appear in Knowledge/efficiency-patterns.md:
```
• Pattern name — description (1 session, watch for recurrence)
```

#### 5. Recommendations for Next Week
Specific, actionable changes:
- "Read CQL guide before scripting Confluence searches" (fixes: 3 iterations wasted last week on malformed queries)
- "Batch file reads when no dependency" (fixes: 2 parallelization misses on multi-page reads)
- "Verify API parameters before first call" (fixes: dead-end retry pattern on invalid filters)

### Confluence Update (Knowledge/efficiency-patterns.md)
Append new patterns to **Waste Log** section with:
```
## [Week of YYYY-MM-DD]

### New Patterns
- **[Pattern name]** — [description] (Session: [date], fix: [recommendation])

### Recurring Patterns (3+ occurrences)
- **[Pattern name]** — [description] → **Promote to Known Access Failures**
```

### Known Access Failures Section
If any pattern hits 3+ occurrences (this week + prior weeks), promote to Known Access Failures with:
- Pattern name and description
- Root cause
- Workaround
- Permanent fix (if applicable)

### Self-Patching (agent file fixes)

When a recurring failure is clearly caused by a fixable agent prompt or instruction, apply the fix directly:

1. **Identify the agent file** — which `agents/*.md` file caused the pattern?
2. **Draft the fix** — the minimal change that eliminates the failure (e.g. add a time gate, add a skip list entry, change a tool call)
3. **Apply via `find_and_replace_code`** — make the change directly to the agent file
4. **Log in the Slack report** under a new section:

```
#### 6. Auto-Patches Applied This Week
• agents/[agent-name].md — [one-line description of what was changed and why]
  Before: [old behaviour]
  After: [new behaviour]
  Pattern fixed: [pattern name from section 3]
```

5. **Only self-patch if confident** — HIGH confidence patterns (3+ occurrences, clear root cause, obvious fix). For MEDIUM confidence, flag for [YOU]'s review instead of auto-applying.
6. **Never patch** `agents/efficiency-audit.md` itself — flag any self-issues for [YOU] to review manually.

## Tools

| Task | Tool |
|---|---|
| Read session log | `open_files` on `Knowledge/session-log.md` |
| Read efficiency patterns | `open_files` on `Knowledge/efficiency-patterns.md` |
| Update patterns file | `find_and_replace_code` on `Knowledge/efficiency-patterns.md` |
| Send Slack report | Slack MCP: `channel_create_message` to `[YOUR_SLACK_CHANNEL_ID]` |

## Analysis Framework

### Iteration Estimation
- Short entry (1-2 paragraphs, simple task) = ~5-8 iterations
- Medium entry (3-4 paragraphs, multiple API calls) = ~10-15 iterations
- Long entry (5+ paragraphs, complex debugging) = ~15-25 iterations
- Flag if estimated iterations >> task complexity (waste indicator)

### Waste Signals
- **Dead end:** "Tried X, didn't work. Tried X again. Then switched to Y."
- **Access failure:** "Needed ID, couldn't find via API, opened browser to get it"
- **Retry loop:** Same error message appears 2+ times in entry
- **Sequential when parallel:** "Read file A. Read file B. Read file C." (could be simultaneous)
- **Wrong tool first:** "Searched Jira, should have searched Confluence" → wasted iterations

### Efficiency Scoring Rubric
- **9-10:** No wasted iterations, clean execution, good parallelization
- **7-8:** 1 minor dead-end or missed parallelization, no recurring failures
- **5-6:** 2-3 dead-ends, 1+ access failures, no recurring failures
- **3-4:** Multiple dead-ends, recurring mistakes appearing, parallelization misses
- **1-2:** Severe iteration bloat, frequent retries, systemic process issues

## Infrastructure

### Memory & Deduplication
- Before generating report, read Knowledge/efficiency-patterns.md to see existing patterns
- Only flag "new" patterns if they don't match existing entries
- Count recurrences: check session log history for pattern appearances in prior weeks

### Observability
- Append to Knowledge/session-log.md at end of run:
  ```
  ### [O] Efficiency Audit Run ({date}) — Weekly score: X/10, {N} new patterns, {M} recurring flags
  ```

### Pattern Lifecycle
- **Week 1:** Pattern spotted, logged as "New Pattern"
- **Week 2:** Pattern appears again, marked as "Recurring (2 occurrences)"
- **Week 3+:** If 3+ total occurrences, promote to Known Access Failures section

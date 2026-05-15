# Skill: Data Discovery & Retrieval

**Trigger:** Any request involving data analysis, metrics, SQL queries, or finding the right data source.

---

## Source Hierarchy

Always follow this order — don't jump to your data warehouse when a purpose-built tool exists.

| Domain | Primary | Fallback |
|---|---|---|
| Sales / GTM data | [YOUR CRM TOOL] | [YOUR DATA WAREHOUSE] |
| Product usage / events | [YOUR ANALYTICS TOOL] | [YOUR DATA WAREHOUSE] |
| Revenue / billing | [YOUR BILLING TOOL] | [YOUR DATA WAREHOUSE] |
| Documents / knowledge | [YOUR WIKI] | [YOUR SEARCH TOOL] |

---

## Process: Answering a Data Question

### Step 1: Clarify
- What metric or data point exactly?
- What grain — per customer, per account, per day?
- What time window?
- Is this for a one-off decision or ongoing tracking?

### Step 2: Route to the Right Source
Check the source hierarchy above. Don't default to the warehouse — check purpose-built tools first.

### Step 3: Find the Data
- Check saved queries in `skills/queries/` first — saves time
- Check Known Tables below before exploring schemas
- Use table discovery tools if available

### Step 4: Query
- Write the SQL, explain in plain language, run it
- Start narrow — add complexity only if needed

### Step 5: Validate (always — no exceptions)
Before narrating any finding:
- Does the row count make sense?
- Does the metric match a known benchmark?
- Are there nulls, duplicates, or unexpected zeros?
- Is the grain what you expected?

### Step 6: Narrate
- Lead with the insight, not the query
- Cite the source table and time window
- Note any limitations or caveats

### Step 7: Save & Update
- Add new validated tables to Known Tables below
- Save reusable queries to `skills/queries/`

---

## Known Tables

_Add your validated tables here as you discover them. Update this file every time you find a useful table._

| Table | What it contains | Grain | Notes |
|---|---|---|---|
| [YOUR TABLE] | [Description] | [Row = ?] | [Any caveats] |

---

## Saved Queries

See `skills/queries/README.md` for the full index of reusable queries.

---

## Sense-Check Before Sharing

- Is this the right population? (free vs paid, trial vs active)
- Am I comparing like-for-like? (same time windows, same filters)
- Would a domain expert look at this number and nod or frown?
- Have I noted the source and date so someone can verify it?

---

## Related Skills

- [Analysis Artifacts](./analysis-artifacts.md) — how to document and share findings

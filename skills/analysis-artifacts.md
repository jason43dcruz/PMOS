# Skill: Analysis Artifacts — Notebook + Dashboard + Confluence

**Trigger:** Any data analysis that produces SQL queries and findings. After running queries and building narrative, create the full artifact chain: Databricks notebook → Lakeview dashboard (where relevant) → Confluence page linking to both.

**Replaces:** The old pattern of publishing Confluence-only analysis. Every analysis now ships with reusable, refreshable data artifacts.

---

> **🛑 HARD GATE — Do not publish the Confluence page until the Databricks notebook is created and you have its URL. Confluence-only analysis is not allowed. No exceptions.**

---

## Why

A Confluence page captures the *narrative*. A Databricks notebook captures the *method* — rerunnable, auditable, shareable with data teams. A Lakeview dashboard captures the *live view* — no re-runs needed, always current. Together they turn a one-shot analysis into a reusable data product.

---

## Artifact Chain

Every analysis produces up to three linked artifacts:

| Artifact | Always? | What it contains | Who it's for |
|---|---|---|---|
| **Databricks Notebook** | ✅ Always | All SQL queries with markdown context, key findings, table references | You (refresh), data partners, anyone who wants to fork/extend |
| **Lakeview Dashboard** | ⚡ When relevant | Visual charts from key queries — trends, comparisons, distributions | Stakeholders who want a live view without running SQL |
| **Confluence Page** | ✅ Always | Narrative + key data tables + links to notebook and dashboard | Leadership, strategy docs, broader audience |

### When to create a dashboard

Create a Lakeview dashboard when the analysis includes any of:
- **Time series** (e.g., monthly downgrade volume, weekly uplift progress)
- **Comparisons across segments** (e.g., feature usage by edition, churn by cohort)
- **Distributions** (e.g., seat size buckets, signal score distribution)
- **KR/OKR tracking** (e.g., uplift % over time with target line)

Skip the dashboard when:
- The analysis is a one-time investigation with no monitoring value
- Results are a single number or small table that doesn't benefit from visualisation
- The queries are exploratory/validation only (e.g., cross-checking two tables)

---

## Step 1: Create the Databricks Notebook

### Path convention

```
/Users/jdcruz@atlassian.com/rovo/{analysis-slug}
```

Use lowercase, hyphenated slugs. Examples:
- `jsm-edition-strategy`
- `servco-uplift-tracking`
- `premium-downgrade-cohort`
- `standard-premium-readiness`

### Notebook structure

Use SQL language. Follow this cell pattern:

```
Cell 1: %md header
  - Title (# Analysis Name — Description)
  - Owner, last updated date
  - Purpose: 2-3 sentences on what this notebook answers
  - Key tables: table with source tables and their purpose
  - Key findings: bullet summary of top-line results (update each refresh)

Cell 2+: For each analysis section:
  - %md cell: section title + context (what question this answers, key finding)
  - SQL cell: the query
  - (Repeat for sub-queries within section)

Last cell: %md appendix
  - Methodology notes, caveats, known data quality issues
  - Links: Confluence page, dashboard (once created), related notebooks
```

### Notebook content rules

- **Every query gets context.** Never have a bare SQL cell without a preceding markdown cell explaining what it does and what the key finding was.
- **Queries must be self-contained.** Each SQL cell should run independently (no cross-cell dependencies). Use CTEs, not temp tables.
- **Include the date the finding was validated.** Data changes — readers need to know when results were last confirmed.
- **Tag edition gating corrections** if the analysis touches feature-by-edition data. Reference the validated gating list.

### Creating/updating the notebook

```
# Create new notebook
create_notebook(
  path="analysis-slug",           # relative → goes to rovo/ dir
  content="-- Databricks notebook source\n...",
  language="SQL"
)

# Overwrite existing notebook (same call — overwrites by default)
create_notebook(
  path="analysis-slug",
  content="-- Databricks notebook source\n...",
  language="SQL"
)
```

**Cell separator:** Use `-- COMMAND ----------` between cells. Markdown cells start with `-- MAGIC %md`.

### Building notebook content

When constructing the notebook string:

1. Start with `-- Databricks notebook source`
2. First cell is always a `%md` header block
3. Each subsequent section: `%md` context cell → SQL cell
4. Use `\n\n-- COMMAND ----------\n\n` between every cell
5. Write the full content to a local temp file if it's large, then use `content_file` parameter

**Tip:** Build the notebook content in a local file first (`tmp_rovodev_notebook.sql`), then pass it via `content_file`. This keeps LLM context clean for large notebooks.

---

## Step 2: Create the Lakeview Dashboard (When Relevant)

### Path convention

Dashboards live in workspace but are identified by display name:

```
{Analysis Name} — Dashboard
```

Examples:
- `JSM Edition Strategy — Dashboard`
- `Premium Downgrade Trends — Dashboard`

### Dashboard gotchas

- **Charts vs tables use different Lakeview patterns:**
  - **Bar/line/area charts:** `disaggregated: false`, spec `version: 3`. Quantitative fields must use aggregation expressions (e.g., `"name": "sum(col)", "expression": "SUM(\`col\`)"`) and the encoding `fieldName` must match the field `name` exactly. Dimension fields (x-axis, color) stay as plain backtick references.
  - **Tables:** `disaggregated: true`, spec `version: 2`. Fields use plain backtick expressions. Must include `encodings.columns` array listing each column with `fieldName` (and optional `displayName`). Without `encodings.columns`, tables show "Visualization has no fields selected".
- **Always specify `warehouse_id`** on both `create_dashboard` and `publish_dashboard` — otherwise viewers get "No warehouse selected" errors. Use the Dashboards warehouse: `c6201d05b57f3f3a`.
- **Always `DESCRIBE` the table before writing queries.** Column names are inconsistent across tables (e.g., `tenantid` vs `tenant_id`, `edition` vs `entitlement_edition`, `unit_count` vs `seat_count`). Never assume from memory.

### Dashboard structure

Lakeview dashboards use a serialized JSON format. The key structure:

```json
{
  "pages": [
    {
      "name": "page_name",
      "displayName": "Page Title",
      "layout": [
        {
          "widget": {
            "name": "widget_name",
            "queries": [
              {
                "name": "query_name",
                "query": {
                  "datasetName": "dataset_name",
                  "fields": [...],
                  "disaggregated": false
                }
              }
            ],
            "spec": {
              "version": 3,
              "widgetType": "area",  // or "bar", "line", "table", "counter"
              "encodings": {...}
            }
          },
          "position": {"x": 0, "y": 0, "width": 6, "height": 4}
        }
      ]
    }
  ],
  "datasets": [
    {
      "name": "dataset_name",
      "displayName": "Dataset Display Name",
      "query": "SELECT ... FROM ..."
    }
  ]
}
```

### Creating the dashboard

1. **Get an existing dashboard for reference** — use `get_dashboard` on a known dashboard ID to grab a working JSON template.
2. **Build the JSON** — replace datasets with your queries, configure widgets for the right chart types.
3. **Create as draft** — `create_dashboard(display_name="...", serialized_dashboard="...", warehouse_id="c6201d05b57f3f3a")`. Always use the **Dashboards** warehouse (`c6201d05b57f3f3a`).
4. **Publish** — `publish_dashboard(dashboard_id="...", warehouse_id="c6201d05b57f3f3a")` to make it viewable without edit access. Must include the warehouse ID or viewers get "No warehouse selected" errors.

### When to skip

If the dashboard JSON is too complex for the analysis at hand, **skip the dashboard and note it in the Confluence page** as a future enhancement. A notebook + Confluence page is still a major improvement over Confluence-only. Don't let dashboard creation block shipping the analysis.

---

## Step 3: Publish the Confluence Page (with Links)

### Link block

Every Confluence analysis page must include a **Data Artifacts** section near the top (after the TL;DR, before the analysis body):

```html
<h2>📊 Data Artifacts</h2>
<table>
  <tr>
    <th>Artifact</th>
    <th>Link</th>
    <th>Last updated</th>
  </tr>
  <tr>
    <td>🔬 Databricks Notebook</td>
    <td><a href="https://socrates-workbench-01.cloud.databricks.com/#notebook/...">Open notebook</a></td>
    <td>{date}</td>
  </tr>
  <tr>
    <td>📈 Live Dashboard</td>
    <td><a href="https://socrates-workbench-01.cloud.databricks.com/dashboardsv3/...">View dashboard</a></td>
    <td>{date}</td>
  </tr>
</table>
```

If no dashboard was created, omit that row and add a note: *"Dashboard not created — analysis is investigative/one-time."*

### Notebook URL format

After creating a notebook, the URL pattern is:
```
https://socrates-workbench-01.cloud.databricks.com/#workspace/Users/jdcruz@atlassian.com/rovo/{analysis-slug}
```

### Dashboard URL format

After publishing a dashboard, the URL pattern is:
```
https://socrates-workbench-01.cloud.databricks.com/dashboardsv3/{dashboard-id}/published
```

The `dashboard-id` is returned by `create_dashboard`.

---

## Refresh Flow

When refreshing an existing analysis:

1. **Update the notebook** — overwrite with new queries/findings via `create_notebook` (same path).
2. **Update the dashboard** — if it exists, use `update_dashboard` with the same `dashboard_id` and new query content, then `publish_dashboard`.
3. **Update the Confluence page** — overwrite in place (never create v2). Update the "Last updated" dates in the Data Artifacts table.

---

## Process Checklist

When completing any data analysis, run through this:

- [ ] Queries written and validated
- [ ] Notebook created/updated at `/Users/jdcruz@atlassian.com/rovo/{slug}`
- [ ] Dashboard created/updated (if time-series, comparisons, or distributions present)
- [ ] Dashboard published (if created)
- [ ] Confluence page created/updated with narrative
- [ ] Data Artifacts link block added to Confluence page
- [ ] Notebook header updated with latest findings and date
- [ ] Saved queries updated in `skills/queries/` (if reusable template)
- [ ] `data-discovery.md` Known Tables updated (if new tables discovered)

---

## Related Skills

- [Data Discovery](./data-discovery.md) — Finding tables and running queries
- [Data to Narrative](./data-to-narrative.md) — Turning results into a story
- [L1 OKR Scoring](./l1-okr-scoring.md) — Uses saved queries for scoring updates

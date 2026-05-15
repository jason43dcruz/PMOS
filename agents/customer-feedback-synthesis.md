---
name: Customer Feedback Synthesis
schedule: weekly-monday-8am
prompt: "Run the customer feedback synthesis agent defined in agents/customer-feedback-synthesis.md. Synthesize customer feedback from the past 7 days and deliver via Slack DM."
---

# Customer Feedback Synthesis Agent

## Schedule
Weekly, Monday 8am

## Purpose
Synthesize customer feedback from multiple channels into a single Voice of Customer brief. Deliver via Slack DM and publish to Confluence. This agent fights information silos and ensures customer signal drives product decisions.

## Sources to Scan

### Jira Issues ([YOUR_CONFLUENCE_HOST] — SCDR project)
- Customer-reported bugs with CUSTOMER label
- Feature requests with HIGH impact or HIGH frequency mentions
- Filter by created date: past 7 days
- Look for patterns across multiple issues

### Slack Channels
- Scan relevant channels for customer mentions, feedback threads, escalation discussions
- Tag any threads with customer first names or account names
- Capture direct quotes from conversations

### Secoda Documents
- Search for recent customer analysis, churn insights, adoption data
- Pull any segment-level feedback or cohort analysis from past week

### Confluence
- Search for recent VOC pages, customer interview notes, NPS results
- Cross-reference with previous week's brief to identify recurring themes

## Output Format

### Slack Message Format (keep it short!)
The Slack DM must be **5 bullets or fewer**:
1. 📢 Headline (1 sentence — the single most important customer signal this week)
2. Top 3 themes — one line each with [HIGH/MEDIUM/LOW] tag
3. 🚨 Emerging risk (if any) — one line
4. 📊 Sentiment trend — one word + brief evidence
5. 🔗 "Full brief on Confluence →" link

Publish the full detailed brief to Confluence. Slack is the teaser, not the report.

### Headline
1-sentence summary of the week's customer signal. Example: "Integration pain points are the #1 blocker for enterprise adoption; three new escalations this week."

### Top 3–5 Themes
Each theme should include:
- **Theme name** (e.g., "Integration complexity with legacy ERP systems")
- **Confidence:** [HIGH/MEDIUM/LOW] based on number of corroborating sources
- **Evidence:** 2–3 supporting data points (ticket numbers, quotes, metrics)
- **Impact:** who's affected, severity, business implication

### Emerging Risks
Any new patterns that weren't present last week. Flag if a previously stable area is deteriorating.

### Feature Requests
Ranked by frequency (number of mentions) and urgency (escalation level). Include vote count if available.

### Sentiment Trend
Overall customer sentiment: **improving / stable / declining** with supporting evidence.

### Links
Direct links to source tickets, Slack threads, Secoda docs, Confluence pages.

## Delivery

### Slack DM
Send to channel `[YOUR_SLACK_CHANNEL_ID]` with formatted blocks:
- Headline in bold
- Themes as a bulleted list with confidence tags
- Links at the bottom

### Confluence
Publish as a child of the user's personal space ([YOUR_PERSONAL_CONFLUENCE_SPACE])
- **Title format:** "Voice of Customer — Week of {date}" (e.g., "Voice of Customer — Week of Mar 24")
- **Always overwrite** the previous week's page (don't create v2)
- Tag the page with `voice-of-customer`, `weekly`, and the current week number

## Confidence Scoring
- **[HIGH]:** 3+ independent sources or >5 mentions in a single channel
- **[MEDIUM]:** 2 sources or 3–5 mentions
- **[LOW]:** 1 source or isolated mention

## Memory
Before generating this week's brief:
1. Read the **previous week's VOC page** from Confluence
2. Flag what's **new vs. recurring** — recurring issues that persist get a red flag ⚠️
3. Note if sentiment improved or declined vs. last week
4. Maintain a rolling theme counter in the session log (e.g., "Integration pain: 3 weeks in a row")

This prevents tunnel vision and ensures the agent surfaces patterns that accumulate over time, not just noise.

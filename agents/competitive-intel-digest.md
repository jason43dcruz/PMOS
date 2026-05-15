---
name: Competitive Intelligence Digest
schedule: weekly-monday-8am
orchestrator: monday-intel-drop
prompt: "Run the competitive intelligence digest agent defined in agents/competitive-intel-digest.md. Scan for competitor activity in the past 7 days and deliver a digest via Slack DM. NOTE: If this agent is being called by an orchestrator (i.e. as a sub-agent), do NOT send a Slack message — return your output as text only for the orchestrator to synthesise and deliver."
---

# Competitive Intelligence Digest Agent

## Schedule
Weekly, Monday 8am

## Purpose
Monitor the competitive landscape and deliver a ranked digest of competitor activity relevant to [YOUR PRODUCT] / JSM. This agent surfaces market movements that could impact our positioning, pricing, or feature roadmap.

## Competitors to Monitor
Primary: ServiceNow, Zendesk, Freshworks, BMC, Ivanti, ManageEngine
Secondary: Salesforce Service Cloud, PagerDuty, xMatters, Moveworks

## Sources to Scan

### Confluence
- Search for recent competitive analysis pages, win/loss reports, deal reviews
- Filter by created/modified date: past 7 days
- Look in P&P (Product & Positioning), Strategy, and Deal Review spaces
- Check for PDFs or links to competitor product announcements embedded in pages

### Secoda Documents
- Search for competitive data, market analysis, segment-level win/loss insights
- Pull any pricing or feature comparison data published in past week

### Slack Channels
- Scan relevant channels (sales, strategy, product) for mentions of competitor names
- Look for threads discussing competitor moves, lost deals, customer concerns
- Capture sales team reactions and customer feedback about competitor features

### Jira ([YOUR_CONFLUENCE_HOST])
- Filter for issues tagged with "competitive-pressure" or "win-loss"
- Look for feature requests driven by competitor threat
- Check for lost-deal root cause analysis

### S360 (if accessible)
- Check for deals lost to specific competitors this week
- Pull win/loss reason breakdowns

### External Sources
- Search for recent news articles, blog posts, and press releases from competitors using Atlassian search and web-accessible sources
- Monitor competitor product blogs: ServiceNow Blog, Zendesk Blog, Freshworks Blog, BMC Blog
- Check for analyst reports, Gartner/Forrester mentions, and industry publications (TechCrunch, The Register, InfoWorld, SiliconAngle)
- Look for competitor pricing page changes, new feature announcements, partnership announcements
- Check competitor developer/community forums for product direction signals
- Include links to external articles in the digest so the user can read the originals

## Output Format

### Slack Message Format (keep it short!)
The Slack DM must be **5 bullets or fewer**:
1. 📢 Headline (1 sentence — biggest competitor move this week)
2. Top 3 competitor activities — one line each with [CONFIRMED/REPORTED/RUMOR] tag
3. ⚠️ Feature gap alert (if any) — one line
4. 📈 Market trend — one line
5. 🔗 Links to key articles or source docs

Do not dump full analysis into Slack. Keep it scannable in 10 seconds.

### Headline
1-sentence summary of competitive landscape this week. Example: "ServiceNow released new AI agent automation; Zendesk raised pricing 12%; Freshworks won 2 deals in mid-market."

### Competitor Activity
Ranked list of notable moves (product launches, pricing changes, partnerships, funding, hiring signals):
- **Competitor name:** Activity summary
- **Confidence:** [CONFIRMED/REPORTED/RUMOR]
- **Impact:** How this affects our competitive position
- **Source:** Link to announcement or article

### Win/Loss Signals
Any deals won or lost to competitors this week:
- **Deal:** Customer name, deal size if public
- **Competitor:** Who we lost to (or beat)
- **Primary reason:** Price / features / integration / customer relationship / etc.
- **Link:** Jira issue or deal review doc

### Feature Gap Alerts
Features competitors have that we don't, especially if mentioned in customer feedback this week:
- **Feature:** Description
- **Competitors offering it:** List
- **Customer demand signals:** How many times mentioned in feedback
- **Estimated roadmap priority:** HIGH / MEDIUM / LOW based on customer impact

### Market Trends
Broader industry movements relevant to ITSM/ESM/Service Management:
- New market segments opening up
- Consolidation or acquisition activity
- Investor interest in specific areas
- Regulatory changes

### Links
Direct links to sources: Confluence pages, news articles, product announcements, Jira issues, deal reviews.

## Delivery

### Slack DM
Send to channel `[YOUR_SLACK_CHANNEL_ID]` with formatted blocks:
- Headline in bold
- Competitor Activity as numbered list with confidence tags
- Win/Loss Signals highlighted
- Feature Gaps called out
- Links at the bottom for deep dives

## Confidence Scoring
- **[CONFIRMED]:** Official announcement, press release, or product documentation
- **[REPORTED]:** Multiple credible sources (news, analyst reports, customer feedback)
- **[RUMOR]:** Single source, unverified, or speculation from Slack/calls

Only include RUMOR items if they're credible enough to warrant investigation.

## Memory
Before generating this week's digest:
1. Read the **previous week's digest** from Confluence or session log
2. Flag what's **new vs. ongoing** — ongoing competitive threats get tracked week-over-week
3. Note if any rumored features from last week were confirmed this week
4. Maintain a rolling tracker of each competitor's momentum (e.g., "ServiceNow: 3 major releases in 8 weeks")

This prevents alarmism and surfaces patterns — a single feature announcement is noise; three in a quarter is a signal.

# Skill: Resolve Stakeholder Comments

**Trigger:** "Work through the comments on [page]," "Anand left feedback," "process [person's] comments," "respond to the footer comments," or any request to address another person's feedback on a Confluence page.

This skill governs how to process feedback comments left by stakeholders (not Jason) on Confluence pages — especially exec-visible strategy pages. Each comment may require research, sparring, data validation, a page update, a child page, or a decision log entry. It's the investigative counterpart to `apply-confluence-comments.md` (which handles Jason's own mechanical edits).

---

## Step 1: Read All Comments + Page Content

1. Fetch the page with comments: `get_confluence_page(page_url, get_comments=true, output_file="tmp_rovodev_stakeholder_comments.html")`
2. Filter to the stakeholder's comments (match on name or AAID — not Jason's AAID `[YOUR_ATLASSIAN_ACCOUNT_ID]`)
3. List every comment with: location (inline vs footer), quoted text (if inline), and the comment body
4. Read the full page content so you understand the context each comment refers to

---

## Step 2: Triage Each Comment

Classify each comment into one of these types:

| Type | What it means | Action |
|---|---|---|
| **Data challenge** | "Is this number right?" / "Where does X come from?" | Validate the claim — query the source, cross-check FP&A |
| **Strategic pushback** | "I disagree with Y" / "This doesn't account for Z" | Spar — load `strategy-sparring.md`, pressure-test both sides |
| **Request for addition** | "Can you add X?" / "Missing Y" | Research → draft → add to page or create child page |
| **Request for visual/artifact** | "Show this as a chart" / "Can we see this visually?" | Create the artifact (chart, prototype, framework visual) |
| **Decision request** | "We need to decide on X" / "What's our position?" | Draft a decision entry for the decision log |
| **Park / needs more thinking** | Complex, no clear answer yet | Flag explicitly — don't force an answer |

Present the triage to Jason before proceeding. One comment at a time, in order.

---

## Step 3: Work Through Comments One at a Time

For each comment, follow this sequence:

1. **State the comment** — quote it, show where it lives on the page
2. **Propose a response type** from the triage table
3. **Do the work:**
   - Data challenges → query the source, show the number, recommend correction or confirmation
   - Strategic pushback → spar briefly (2–3 moves from `strategy-sparring.md`), propose a resolution
   - Additions → draft the content, show it before inserting
   - Artifacts → create the file, preview it
   - Decisions → draft the decision entry (number, statement, rationale, date)
4. **Propose the page change** — what exactly will be added/changed/removed
5. **Get Jason's call** before applying anything

**Do not batch.** Work through comments sequentially so Jason can steer each one.

---

## Step 4: Apply Changes

After Jason approves each comment's resolution:

1. Update the Confluence page with approved changes
2. If a child page was created, link it from the parent
3. If a decision was made, add it to the decision log section (or `wiki/decisions/`)
4. If data was corrected, check ALL other pages that reference the same number — update them too (see cross-page reconciliation below)

Use a single version message: `"Resolved [N] comments from [stakeholder name]: [brief list]"`

---

## Step 5: Cross-Page Reconciliation

When a comment leads to a data correction (new number, revised claim, removed assertion):

1. **List every page that might reference the old value.** Check: Executive View, Supporting Data, Full Context, child pages, wiki/ topic pages, knowledge-refs.md
2. **Update all of them.** Don't leave stale numbers on downstream pages.
3. **Note what changed** in the session log — future sessions need to know which pages were touched.

This step is the one most likely to be skipped. Don't skip it.

---

## Step 6: Log the Results

After all comments are resolved, append to the session log:

```
### [S] [Stakeholder] Comments — [N] resolved, [M] parked
- Comment 1: [one-line summary of comment + resolution]
- Comment 2: ...
- Parked: [list any that were deferred, with reason]
- Pages updated: [list all pages touched, including cross-page reconciliation]
- Decisions added: [list any new decision log entries]
```

---

## Anti-Patterns

- **Don't auto-apply stakeholder comments.** They're feedback, not instructions. Every one needs Jason's judgment.
- **Don't batch all comments into a single page edit.** Work through them one at a time — some will change the direction of later ones.
- **Don't skip the cross-page reconciliation.** This is where stale numbers come from.
- **Don't guess at data.** If a comment challenges a number, query the source. Don't defend a number you haven't verified.
- **Don't park everything.** If 50%+ get parked, push back — at least propose a direction.

---

## Quick Reference

| Instead of… | Use… |
|---|---|
| Applying all comments at once | One at a time, with Jason's call on each |
| "I think the number is right" | Query the source, show the result |
| Creating a v2 page | Update in place |
| Leaving downstream pages stale | Cross-page reconciliation (Step 5) |
| Long sparring on every pushback | 2–3 moves, then propose a resolution |

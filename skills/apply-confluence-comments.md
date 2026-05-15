# Skill: Apply Confluence Comments

## When to use

When the user says something like:
- "Apply my comments on [page]"
- "Read my feedback and update the page"
- "Process my inline comments"
- "Apply my edits from the comments"

## How it works

1. **Read the page comments** using `get_confluence_page(page_url, get_comments=true)`.
2. **Filter to only the user's comments.** Match on the user's AAID (`[YOUR_ATLASSIAN_ACCOUNT_ID]`). Ignore comments from other people.
3. **Read the page content** using `get_confluence_page(page_url, output_file="tmp_rovodev_comment_edits.html")`.
4. **For each of the user's comments:**
   - If it's an **inline comment** (attached to specific text): find the referenced text and apply the feedback directly.
   - If it's a **footer comment**: interpret as a general instruction — apply it to the most relevant section.
   - Types of feedback to handle:
     - **Rewrite/rephrase** ("Change this to...", "Rephrase this as...", "Say X instead")
     - **Delete** ("Remove this", "Cut this section", "Don't need this")
     - **Add** ("Add X here", "Include Y", "Missing Z")
     - **Move** ("Move this to...", "This belongs in...")
     - **Question** ("Is this right?", "Should we...") — flag for user, don't auto-apply
5. **Show the user a summary** of changes before publishing:
   - List each comment and the change it triggered
   - Flag any comments that were ambiguous or couldn't be applied
   - Flag any questions (don't auto-apply)
6. **Wait for user approval**, then publish with `update_confluence_page`.
7. **Clean up** temp files.

## Rules

- **Only process the user's comments.** Never apply feedback from other people.
- **Never delete content without the user explicitly saying to.** "This is wrong" means rephrase, not delete, unless they say "remove" or "cut".
- **Preserve formatting.** Don't reformat sections that aren't being changed.
- **One version message** that summarises all changes: "Applied N inline comments: [brief list of changes]".
- **Can't resolve comments via API.** The Confluence MCP tools don't support resolving comments. After publishing, tell the user which comments were applied so they can resolve them manually. If browser copilot is available, offer to resolve them via the browser.
- **If a comment is ambiguous**, ask the user before applying. Don't guess.

## Example workflow

```
User: "Apply my comments on [YOUR_PERSONAL_CONFLUENCE_SPACE]

Agent:
1. Reads comments → finds 4 from user (AAID [YOUR_ATLASSIAN_ACCOUNT_ID])
2. Reads page content to tmp_rovodev_comment_edits.html
3. Applies changes:
   - Inline on "rocks not pebbles": "Change to 'value pillars, not feature lists'" → applied
   - Inline on "Option A": "Remove the A/B framing, just pick efficiency" → applied
   - Footer: "Add a note about competitive pricing room for Standard" → applied to Layer 1
   - Inline on "automation caps": "Is this still accurate?" → flagged as question, not applied
4. Shows summary to user
5. User approves → publishes
6. Cleans up tmp_rovodev_comment_edits.html
```

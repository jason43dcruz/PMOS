# Wiki Maintenance Prompts

Copy-paste these prompts when maintaining the wiki. They work with Claude, ChatGPT, or any capable LLM.

---

## 1. Compile New Sources

Use when you've added new files to `wiki/raw/` (or new source material anywhere in the workspace).

```
Read all files in wiki/raw/ (or the specific files I've just added). Then:

1. For each key concept, create or UPDATE a topic page in wiki/topics/. Each page should cover exactly one concept with: definition, why it matters, key evidence, contradictions/open questions, related pages (as [[wiki-links]]), and sources.

2. If a topic page already exists, ENRICH it — don't replace. Add new evidence, update contradictions, add new links.

3. Update wiki/synthesis/evidence-changelog.md with what changed and when.

4. Check wiki/synthesis/what-we-believe.md — does any belief need updating based on new evidence?

5. Check wiki/synthesis/open-questions.md — did any question get answered?

Existing pages in wiki/topics/:
[list them or say "read the directory"]
```

---

## 2. Lint Pass (run every ~20 new pages)

```
Read every page in wiki/topics/, wiki/decisions/, and wiki/synthesis/. Then:

1. Find orphan pages — pages with no incoming [[wiki-links]] from other pages. Either add links or flag for deletion.

2. Find broken links — [[wiki-links]] that point to pages that don't exist. Either create the missing page or remove the link.

3. Find contradictions — claims on one page that conflict with claims on another. Flag each with the two pages and the conflicting claims.

4. Find stale evidence — data or claims that reference dates more than 3 months old without a "last verified" note. Flag for refresh.

5. Find duplicate coverage — two pages covering the same concept. Merge into one.

6. Update wiki/index.md with any new or removed pages.

Output a summary: orphans found, broken links fixed, contradictions flagged, stale items flagged, duplicates merged.
```

---

## 3. Synthesis Refresh

```
Read all pages in wiki/topics/ and wiki/decisions/. Then rewrite:

1. wiki/synthesis/what-we-believe.md — fresh synthesis of current beliefs based on ALL topic pages. Don't recycle the existing text — derive from source pages.

2. wiki/synthesis/open-questions.md — update with any new questions surfaced and mark any resolved ones.

3. wiki/synthesis/evidence-changelog.md — add a row for this refresh.
```

---

## 4. Quick Add (single concept)

```
I want to add a wiki page for: [CONCEPT NAME]

Read the existing wiki pages in wiki/topics/ to understand the linking structure. Then create a new page at wiki/topics/[appropriate-subfolder]/[concept-name].md with:
- What it is (1-2 sentences)
- Why it matters
- Key evidence or details
- Contradictions / open questions
- Related pages (as [[wiki-links]] to existing pages)
- Sources

Then update wiki/index.md and add [[wiki-links]] to this new page from any existing pages that should reference it.
```

---

## 5. Publish to Confluence

```
Read wiki/synthesis/what-we-believe.md and wiki/synthesis/open-questions.md.

Create (or update) a Confluence page with:
- Title: "LLM Wiki — Current Beliefs & Open Questions"
- Parent: [specify parent page URL]
- Content: the two synthesis pages formatted as clean HTML

This is the shareable view of the wiki's current state.
```

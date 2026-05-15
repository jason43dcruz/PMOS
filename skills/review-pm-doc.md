# Skill: Review PM Document (Atlassian + Lenny advisor)

**Triggers:** "Review this PRD," "Critique this Confluence page," "Lenny-style feedback on…," "Post advisor comments on…," same modes as the public skill (strategy, branding, growth, GTM, leadership, prioritization, positioning, design/UX).

Use for **Confluence-hosted PM artifacts** when the user wants feedback **grounded in Lenny's Podcast transcripts** (bundled at **`Knowledge/lennys-podcast-transcripts/`**) **and/or** Atlassian-internal context (goals, writing style, knowledge refs, data docs).

**Companion:** `skills/write-like-me.md` (voice for suggested rewrites). **Posting comments:** Atlassian Confluence MCP — `createConfluenceInlineComment`, `createConfluenceFooterComment`, after `getConfluencePage`.

---

## Lenny transcript pack

**Canonical root in this repo:** `Knowledge/lennys-podcast-transcripts/` (verify `index/episodes.md` exists before episode routing).

Relative structure: `{root}/index/episodes.md`, `{root}/index/{topic}.md`, `{root}/episodes/{guest-name}/transcript.md`. Conventions and search tips: `Knowledge/lennys-podcast-transcripts/CLAUDE.md`.

**Override:** If the user points to another root (e.g. `~/PRD-advisor-board/lennys-podcast-transcripts/`), use that path instead for the session.

Use the **same action-mode → topic mapping** as `pm-os-public/skills/review-pm-doc.md` (identical table — do not duplicate here; read that file if you need the full matrix).

If `index/episodes.md` is **missing** at the canonical path and no override was given, continue with: GOALS, product-context, think-like-me, knowledge-refs, Secoda (for data claims) — label non-episode claims **[MEDIUM]** or **[LOW]** confidence as appropriate.

---

## Atlassian-specific grounding (read before reviewing)

1. **`GOALS.md`** — tie feedback to stated goals; flag misalignment.
2. **`Knowledge/product-context.md`** — stakeholder tendencies, audience.
3. **`skills/think-like-me.md`** — how this PM reasons; match their bar for rigor.
4. **`Knowledge/knowledge-refs.md`** — pull live Confluence via MCP when the doc references canonical internal pages (edition strategy, ServCo decisions, etc.).
5. **Data-backed claims:** **`skills/data-discovery.md`** + **Secoda MCP** — verify or flag unsubstantiated numbers; never present guesses as internal facts.
6. **Packaging / positioning / ServCo:** If the doc touches SKU, edition, or Services & Co, check **ASoW ServCo Decisions** (and children) per `AGENTS.md` — do not endorse proposals that contradict published decisions without flagging.

**Brainstorming rule:** Check sources before asserting org facts; if inferring, say so.

---

## Instructions

### Step 1 — Fetch the Confluence page

- Use **`getConfluencePage`** with the URL or page ID the user provides; read full content.
- Resolve **cloudId** / **pageId** per Atlassian MCP patterns (tiny links, `/wiki/spaces/.../pages/...`).

Classify: doc type, problem/opportunity, claims/decisions, gaps.

### Step 2 — Lenny episode selection and reads

Same as public skill: 3–6 episodes from index + transcripts using **`{root}`** (default `Knowledge/lennys-podcast-transcripts/` unless the user overrides).

### Step 3 — Synthesize

Same principles: diagnose first, synthesize across guests, practical, improve the idea, surface tradeoffs.

### Step 4 — Deliver + post to Confluence (when user wants comments on-page)

**Always** show the full review in chat first (see structure below). **If** the user asked to post on Confluence (or confirms when you offer), add comments in two phases.

#### Part A — Inline comments (4–6)

Use **`createConfluenceInlineComment`** with:

- `body` — short markdown/plain text; suggested prefix: `🎙️ Lenny advisor — [section topic]`
- `inlineCommentProperties`:
  - **`textSelection`** — short **exact** substring from the page (plain ASCII preferred; avoid curly quotes and em-dashes in the selection if the API match fails).
  - **`textSelectionMatchCount`** — count how many times `textSelection` appears in the page body you fetched (must match reality).
  - **`textSelectionMatchIndex`** — 0-based index of which occurrence to attach to (usually `0` unless anchoring a repeated phrase).

**If** inline creation fails (no match), tell the user the anchor string that failed; do not spam retries with different guesses without confirmation.

#### Part B — Footer comment

One **`createConfluenceFooterComment`** with the full synthesis — same scaffold as the public skill's footer (What's working, Key concerns, Recommendations, Questions, Episode references, closing line). Omit `inlineCommentProperties`. Use `contentFormat: "markdown"` when plain structure suffices.

**If** the user only wanted a private review, **skip MCP posting** and stop after chat delivery.

---

## Chat delivery structure (always)

1. **TL;DR** — 2–3 sentences.
2. **Inline-style anchors** — for human readability, mirror what you posted (or would post) on Confluence.
3. **Footer block** — full structured summary (emoji dividers ok in markdown).
4. **Section table** — | Section | Issue | Suggestion |
5. **What's strong** / **The big thing to fix** / **Stakeholder risk forecast** (use named stakeholders from product-context when available).

---

## Quality bar

**Do:** Name guests when citing Lenny transcripts; verify internal/data claims against Secoda or cited sources; respect ServCo/edition decision boundaries.

**Don't:** Invent quotes; post inline comments without verifying match counts; soften the one critical gap.

---

## Tone

Match **`write-like-me`**: first person where appropriate for suggested rewrites, blunt and specific, British spellings if natural, no AI-tell vocabulary.

---

## Difference from `apply-confluence-comments.md`

- **This skill:** You **write** advisor feedback as new comments from scratch.
- **Apply Confluence comments:** You **interpret the user's existing** comments and **edit the page body**. Do not confuse the two flows.

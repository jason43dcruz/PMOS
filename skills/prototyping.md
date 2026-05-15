# Prototyping Skill

Build interactive HTML prototypes to explore ideas, test assumptions, and communicate concepts to stakeholders.

## Trigger

Use this skill when the user asks to:
- Build a prototype, interactive demo, or clickable mockup
- Create a visual tool for exploration (e.g., sliders, calculators, comparisons)
- Show stakeholders a concept in action
- Visualise data or decisions interactively
- Test a user flow or decision logic

## What This Covers

- **Interactive calculators & sliders** — Adjust variables and see impact in real-time (e.g., edition value calculators, pricing sliders)
- **Comparison tools** — Side-by-side exploration of options (e.g., price comparisons, feature matrices)
- **Visual rubrics & scoring matrices** — Weighted criteria, scoring logic, gate decisions
- **Decision flow prototypes** — Step through branching logic, gate outcomes, qualification flows
- **Value visualisation slides** — Charts, metrics, impact dashboards
- **Data exploration tools** — Filter, sort, drill-down into sample data sets

## How to Build

### Core Pattern
- **Single HTML file** with inline CSS and JavaScript (no external dependencies)
- **Self-contained** — opens directly in a browser, no build step or server needed
- **Clean, modern styling** — use Atlassian design tokens where appropriate (grays, blues, sans-serif typography)
- **Semantic HTML** — form controls, buttons, proper structure
- **Interactivity first** — sliders, toggles, dropdowns, click handlers, hover states
- **Sample data** — realistic examples so stakeholders can play with it immediately

### Technical Approach
1. Start with a clean HTML5 boilerplate
2. Add inline `<style>` block for all CSS
3. Add inline `<script>` block for all JavaScript (vanilla JS, no frameworks unless absolutely necessary)
4. Use variables, state objects, and event listeners to manage interactivity
5. Include sample/realistic data baked into the HTML
6. Test locally in a browser before sharing

### Styling Guidelines
- Use a consistent color palette (Atlassian grays: #161B22, #424956, #738496; blues: #0055CC, #0052CC)
- Typography: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto (system fonts)
- Spacing: 8px, 16px, 24px grid
- Buttons: 8px padding, 2px border, subtle hover state
- Cards: light background (#FAFBFC or #FFFFFF), border (#DFE1E6), rounded corners (4px)
- Keep layouts simple: full-width on mobile, max-width 1200px on desktop

### Example Structure
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Prototype Title</title>
  <style>
    /* All CSS here */
  </style>
</head>
<body>
  <!-- All HTML here -->
  <script>
    // All JavaScript here
  </script>
</body>
</html>
```

## When to Use vs Other Skills

| Need | Skill | When to Use |
|------|-------|-----------|
| **Interactive exploration** | Prototyping | User needs to play with sliders, see real-time impact, test scenarios. Quick feedback loop. |
| **Linear presentation** | [html-deck-style-guide](html-deck-style-guide.md) | Stakeholders need slides, a story, or a narrative flow (keynote, pitch, walkthrough). |
| **Formulas & scenarios** | create-excel-model | User needs financial modelling, complex formulas, scenario tables, export to Excel. |
| **Broad publishing** | Confluence | Prototype needs versioning, comments, permissions, discoverability, Slack integration. |

**Hybrid approach:** Build the prototype to validate the concept quickly, then publish findings to Confluence when ready to share more formally.

## Output & Storage

- **Save location:** Project folder → `prototypes/` subfolder
  - Example: `projects/edition-strategy/prototypes/gate-prototype-itam.html`
  - Example: `projects/pricing/prototypes/edition-value-slider.html`
- **Naming:** Descriptive, lowercase with hyphens
  - ✅ `gate-prototype-itam.html`, `price-comparison-tool.html`, `edition-value-slider.html`
  - ❌ `prototype.html`, `tool.html`, `test.html`
- **Sharing:** Open the file directly in a browser (no server needed) or attach to Confluence/Slack
- **Update in place:** If the user asks for changes, edit the same file — don't create v2

## Quick Checklist

Before sharing a prototype:
- [ ] Opens in a browser without errors
- [ ] All interactions work (sliders move, buttons click, dropdowns open)
- [ ] Sample data is realistic and representative
- [ ] Styling is clean and scannable
- [ ] No console errors (open DevTools to check)
- [ ] Mobile-friendly or explicitly desktop-only (set viewport accordingly)
- [ ] File name is descriptive

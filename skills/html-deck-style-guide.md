# HTML Presentation Style Guide

Use this guide when creating HTML slide decks. It defines two styles — **Official** and **Flashy** — both derived from real Atlassian brand assets. Default to **Official** unless the user asks for something more dynamic or event-style.

## Sources

- **Official:** Atlassian Presentation Template 2024 (PDF in `Knowledge/`)
- **Flashy:** Team25 Founders Keynote (`.key` in `Knowledge/`) — the event/conference style with bold color collages and dark backgrounds
- **Existing deck example:** `projects/edition-strategy/edition-strategy-deck.html`

---

## Shared Foundation (Both Styles)

### Typography

Per ADS (Atlassian Design System), the correct font tokens are:

- **Brand fonts** (for presentations/marketing): Charlie Display (headings), Charlie Text (body)
- **App fonts** (for product UI): Atlassian Sans (headings + body), Atlassian Mono (code)

For HTML decks (which are presentation/brand context), use the brand fonts with ADS app font fallbacks:

```css
/* ADS font tokens */
--font-heading: 'Charlie Display', 'Atlassian Sans', ui-sans-serif, -apple-system, BlinkMacSystemFont, 'Segoe UI', Ubuntu, 'Helvetica Neue', sans-serif;
--font-body: 'Charlie Text', 'Atlassian Sans', ui-sans-serif, -apple-system, BlinkMacSystemFont, 'Segoe UI', Ubuntu, 'Helvetica Neue', sans-serif;
```

- **Headings:** Use `--font-heading`. Headlines are **bold, large, and often left-aligned**.
- **Body text:** Use `--font-body` (sans-serif).
- **Eyebrow labels:** Uppercase, small, blue `#1868DB`, often inside a thin-bordered pill/box. Font: `--font-heading`.

**Logo:** Use the official Atlassian SVG from `@atlaskit/logo` (`AtlassianLogo` component). The `inverse` appearance (white) is used on blue/dark backgrounds. Extract the SVG from the npm package for inline use in HTML decks.

### Type Scale

| Role | Size | Weight | Notes |
|------|------|--------|-------|
| Title (cover slide) | 3.5rem+ | 800 | Dominates the slide |
| H1 (big statement) | 2.5rem | 700 | Used for impact slides |
| H2 (section heading) | 1.75rem | 700 | Content slide headers |
| H3 (subhead / card title) | 1.25rem | 600 | Bold, Atlassian Blue or black |
| Body | 1rem | 400 | Line-height 1.6 |
| Small / caption | 0.875rem | 400 | Subtle gray |
| Eyebrow | 0.75rem | 700 | Uppercase, letter-spacing 0.05em |

### Color Palette

**Primary (use these 80% of the time):**

| Name | Hex | Usage |
|------|-----|-------|
| Atlassian Blue | `#1868DB` | Primary brand, headlines on white, CTAs, links, eyebrows, blue backgrounds |
| Black | `#1D2125` | Headings on light backgrounds, body text |
| White | `#FFFFFF` | Text on dark/blue backgrounds, light slide backgrounds |
| Off-white / Light Gray | `#F0F1F2` | Content panel backgrounds, right-column tint |
| Light Blue Tint | `#E2ECFE` | Subtle right-column backgrounds, agenda tint, info panels |
| Dark Navy | `#0C2340` | Deep accent for overlap/shadow shapes in flashy style |

**Secondary (use sparingly for accents, chapter markers, data viz):**

| Name | Hex | Usage |
|------|-----|-------|
| Lime Green | `#8DB600` | Chapter accent (ch. 01), data viz |
| Orange / Amber | `#E8912D` | Chapter accent (ch. 02), data viz, stats |
| Purple / Violet | `#B07CD8` | Chapter accent (ch. 03), data viz |
| Deep Blue | `#1558BC` | Gradients (dark slide variant) |
| Deep Green / Teal | `#1B5E37` | Overlap shapes, geometric accents |
| Hot Pink | `#D963D2` | Flashy style shapes only |

### Spacing Tokens

```css
--space-100: 8px;
--space-150: 12px;
--space-200: 16px;
--space-300: 24px;
--space-400: 32px;
--space-600: 48px;
--space-800: 64px;
```

### Border Radius

- Cards: `12px`
- Buttons / small elements: `8px`
- Screenshots: `19px` (per official template)
- Lozenges: `4px`

---

## Style: Official

Use for: **internal stakeholder decks, walkthroughs, strategy reviews, 1:1 prep, data narratives.**

### Slide Types & Patterns

#### Title Slide (Cover)
- **Background:** Solid Atlassian Blue (`#1868DB`)
- **Layout:** Atlassian logo (white, top-left), large monospace title (white, bottom-left aligned), subtitle in lighter weight
- **Speaker info:** Name + title + department, small, bottom-left
- **Variant:** Split layout — white left panel (logo + speakers) / blue right panel (title)

```html
<div class="slide title-blue">
  <div class="logo">▲ ATLASSIAN</div>
  <h1>Talk title goes here</h1>
  <p class="subtitle">Subtitle for context</p>
  <div class="speaker">Name · Title, Department</div>
</div>
```

#### Chapter / Section Divider
- **Background:** White, with a thick **color accent stripe** on the right edge
- Each chapter gets a distinct accent color (green → orange → purple → blue → navy → etc.)
- **Layout:** Large chapter number (e.g., "01") + section title + brief description, left-aligned in the left half

```html
<div class="slide chapter" style="--chapter-color: #8DB600;">
  <span class="chapter-number">01</span>
  <h2>Section title goes here</h2>
  <p>Brief description of this section.</p>
</div>
```

#### Content Slide (Two-Column)
- **Layout:** Left ~40% heading area, Right ~60% content area with light tint background (`#E2ECFE` or `#F0F1F2`)
- Heading is large, left-aligned, black
- Body text in the tinted right panel
- Clean, scannable

#### Agenda Slide
- **Layout:** Left column = "Agenda" title + numbered list of sections; Right column = tinted panel with overview text
- Section items shown in Atlassian Blue as links/subheads

#### Content + Graphics (Talking Points with Icons)
- 3-column or 4-column grid
- Each column: icon/illustration (top) + blue subhead + description
- Headline centered above

#### Big Statement Slide
- **Background:** White or Blue
- **Text:** Huge monospace headline, centered
- Optional "CONTEXT" or "WE BELIEVE" eyebrow above in blue (when on white) or white (when on blue)
- Blue keyword emphasis with underline decoration

#### Quote Slide
- Large pull-quote marks `"` in Atlassian Blue (icon-style, not text)
- Quote text in large monospace, centered
- On white or blue background
- Attribution below in smaller text

#### Statistics Slide
- 3-across layout with big blue numbers + description labels below
- Numbers in oversized monospace font (3rem+)
- Separated by thin vertical dividers
- Optional headline above

#### Table Slide
- Standard data table with light header row
- Header row: Blue background (`#1868DB`) with white text, OR neutral gray with border
- Alternating row shading (white / `#F8F9FA`)
- Title above the table

#### From → To Slide
- Split layout: Left panel (white/gray) = "From" state, Right panel (blue) = "To" state
- Clear visual separation via background color

#### Screenshot Slide
- Screenshot with **19px border-radius** in a rounded container
- Optional title above
- Light blue placeholder background (`#BDD4FE`) when no image

#### Closing Slide
- White Atlassian logo centered on blue background
- Or "Thank you!" in large monospace on white/blue

### CSS Structure (Official)

```css
/* --- OFFICIAL STYLE --- */
.slide { background: #FFFFFF; }

/* Title/closing slides */
.slide.title-blue, .slide.closing-blue {
  background: #1868DB;
  color: #FFFFFF;
}

/* Chapter divider with accent stripe */
.slide.chapter {
  background: #FFFFFF;
  border-right: 48px solid var(--chapter-color, #1868DB);
}

/* Two-column split */
.slide .split-left { width: 40%; }
.slide .split-right {
  width: 60%;
  background: #E2ECFE;
  padding: var(--space-600);
}

/* Eyebrow */
.eyebrow {
  font-family: var(--font-heading);
  font-size: 0.75rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: #1868DB;
  border: 1px solid #1868DB;
  padding: 2px 10px;
  border-radius: 4px;
  display: inline-block;
  margin-bottom: var(--space-200);
}

/* Blue-background eyebrow */
.slide.title-blue .eyebrow {
  color: #FFFFFF;
  border-color: rgba(255,255,255,0.5);
}
```

---

## Style: Flashy

Use for: **keynotes, demos, customer events, Team/company all-hands, anything that needs energy.**

### Key Differences from Official

| Aspect | Official | Flashy |
|--------|----------|--------|
| Backgrounds | White, blue, light gray | Dark gradients, vibrant colors, photo backgrounds |
| Typography | Clean monospace headings | Same monospace but BIGGER, bolder, more dramatic |
| Graphics | Icons, illustrations | Colorful geometric collages (circles, triangles, rectangles in brand colors), B&W photography overlaid with color shapes |
| Color usage | Restrained (blue + black) | Full palette — green, orange, purple, pink, blue, dark navy all appear together |
| Layout | Structured two-column | More expressive — asymmetric, overlapping elements, angled shapes |
| Stats | Clean centered numbers | Numbers on dark/colored backgrounds with more drama |

### Flashy-Specific Patterns

#### Title Slide (Event Style)
- Full-bleed photo or colorful geometric collage background
- Large white headline over dark/busy background
- Optional dark overlay for readability

#### Dark Content Slide
- Background: Dark navy or black
- White/light text
- Blue accent elements (icons in filled circles, stat numbers in blue)
- Product screenshots floating with subtle shadows

#### Stats / Data Impact
- Full-blue background
- Massive white numbers (4rem+)
- Description in smaller white text below
- Grid of 2-4 stats

#### Icon Grid (Ecosystem/Integration)
- Dark background with a grid of colorful app/product icons
- Clean white rounded-square containers for each icon

### CSS Additions (Flashy)

```css
/* --- FLASHY STYLE ADDITIONS --- */

/* Dark slide */
.slide.dark {
  background: linear-gradient(135deg, #1558BC 0%, #0C2340 100%);
  color: #FFFFFF;
}
.slide.dark h1, .slide.dark h2, .slide.dark h3,
.slide.dark p, .slide.dark li {
  color: #FFFFFF;
}

/* Full-color background variants */
.slide.bg-green { background: #8DB600; }
.slide.bg-orange { background: #E8912D; }
.slide.bg-purple { background: #B07CD8; }

/* Geometric accent shapes (CSS-only) */
.slide.flashy::before {
  content: '';
  position: absolute;
  top: -60px; right: -40px;
  width: 300px; height: 300px;
  background: #E8912D;
  transform: rotate(15deg);
  border-radius: 8px;
  z-index: 0;
  opacity: 0.9;
}
.slide.flashy::after {
  content: '';
  position: absolute;
  bottom: -80px; right: 60px;
  width: 200px; height: 200px;
  background: #8DB600;
  border-radius: 50%;
  z-index: 0;
  opacity: 0.85;
}

/* Giant stat numbers (flashy) */
.stat-giant .number {
  font-size: 4rem;
  font-weight: 800;
  color: #FFFFFF;
  font-family: var(--font-heading);
}
```

---

## Shared Components (Both Styles)

### Cards

```css
.card {
  background: #FFFFFF;
  border: 1px solid rgba(11,18,14,0.14);
  border-radius: 12px;
  padding: var(--space-300);
  box-shadow: 0 1px 3px rgba(0,0,0,0.08);
}
.card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 32px rgba(0,0,0,0.12);
}
/* Edition-color left borders */
.card.free { border-left: 4px solid #6B6E76; }
.card.standard { border-left: 4px solid #1868DB; }
.card.premium { border-left: 4px solid #B07CD8; }
.card.enterprise { border-left: 4px solid #E8912D; }
```

### Lozenges / Badges

```css
.lozenge {
  display: inline-block;
  padding: 2px 8px;
  border-radius: 4px;
  font-size: 0.75rem;
  font-weight: 600;
}
.lozenge.success { background: #DCFFF1; color: #216E4E; }
.lozenge.warning { background: #FFF5DB; color: #9E4C00; }
.lozenge.danger { background: #FFECEB; color: #AE2E24; }
.lozenge.info { background: #E9F2FE; color: #1558BC; }
.lozenge.discovery { background: #F8EEFE; color: #803FA5; }
```

### Callouts / Panels

```css
.callout {
  border-left: 4px solid #1868DB;
  background: #E9F2FE;
  padding: var(--space-200) var(--space-300);
  border-radius: 0 8px 8px 0;
  margin: var(--space-200) 0;
}
.callout.warn { background: #FFF5DB; border-left-color: #E06C00; }
.callout.success { background: #DCFFF1; border-left-color: #6A9A23; }
.callout.danger { background: #FFECEB; border-left-color: #E2483D; }
```

### Tables

```css
table { width: 100%; border-collapse: collapse; font-size: 0.875rem; }
th {
  text-align: left;
  padding: 12px 16px;
  font-weight: 600;
  color: #FFFFFF;
  background: #1868DB;
}
/* Alt: neutral header */
th.neutral { background: #F0F1F2; color: #1D2125; border-bottom: 2px solid #1868DB; }
td {
  padding: 12px 16px;
  border-bottom: 1px solid rgba(11,18,14,0.14);
  vertical-align: top;
}
tr:nth-child(even) td { background: #F8F9FA; }
```

---

## Slide Deck Infrastructure (JS)

Always include this navigation system:

- **Arrow keys** (← →) and **spacebar** for navigation
- **Touch/swipe** support
- **Progress bar** at top
- **Slide counter** at bottom-left
- **Nav buttons** at bottom-right
- **Click-reveal** support for progressive disclosure (add `class="click-reveal"` to elements)
- **Staggered animations** (fadeUp) for child elements with `class="anim"`

The full JavaScript from `projects/edition-strategy/edition-strategy-deck.html` is the canonical implementation. Copy it directly.

---

## Decision Guide: Which Style?

| If the deck is for... | Use |
|-----------------------|-----|
| Anand walkthrough / 1:1 | Official |
| Strategy review | Official |
| Data narrative | Official |
| Customer-facing demo/keynote | Flashy |
| All-hands / team event | Flashy |
| Executive sponsor update | Official |
| Conference talk | Flashy |
| Edition strategy / pricing | Official |

---

## Quick Start Checklist

When the user asks for an HTML deck:

1. Read this style guide
2. Ask "official or flashy?" if not clear from context (default: official)
3. Copy the CSS tokens and deck infrastructure from above
4. Build slides using the patterns described
5. Use `class="anim"` on child elements for staggered entrance animations
6. Use `class="click-reveal"` for progressive disclosure
7. Test keyboard (arrows), touch (swipe), and progress bar

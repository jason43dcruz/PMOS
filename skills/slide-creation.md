# Slide Creation Skill

End-to-end pipeline for creating high-quality HTML slide decks with AI-generated visuals.
Slides can be used as a live presentation OR rendered into video (see `skills/video-creation.md`).

---

## Pipeline Overview

```
Brief → HTML Deck → AI Backgrounds → AI Illustrations → Screenshot → Present or Video
```

---

## Step 1 — Build the HTML Deck

Read `skills/html-deck-style-guide.md` for brand tokens, typography, and layout patterns.
Two styles: **Official** (Atlassian 2024 brand) and **Flashy** (event/keynote).

**Key principles:**
- One clear thought per slide — 20 words max of narration if going to video
- Dark backgrounds with high-contrast text
- Use case slides: left = text/steps, right = visual/terminal/illustration
- Navigation: `→` / Space = next, `←` = back, `F` = fullscreen

**Serve locally for development:**
```bash
cd projects/pm-os-video && python3 -m http.server 3000
# Open: http://localhost:3000/presentation.html
```

---

## Step 2 — AI Backgrounds (Modal GPU)

Full-bleed background images — abstract, no focal point, dark with colour accent.

```bash
# Generate all slide backgrounds
modal run scripts/generate_backgrounds.py

# Generate specific slides only
modal run scripts/generate_backgrounds.py --slides hero,data,strategy

# Output: projects/pm-os-video/slide-images/ai-backgrounds/
```

**Wire into HTML:**
```css
#s1 {
  background: linear-gradient(rgba(7,71,166,0.65), rgba(0,82,204,0.6)),
    url('slide-images/ai-backgrounds/hero.png') center/cover no-repeat;
}
```
The gradient overlay preserves text readability. Adjust opacity (0.6–0.85) to taste.

**Available backgrounds:** hero, problem, capabilities, agents, data, strategy, financial, writing, forge, graphics, flowchart, setup, cta

---

## Step 3 — AI Illustrations (Modal GPU)

Content-specific visuals — placed inside slide panels, not full-bleed.
Best candidates: use case slides with text-heavy right panels, hero concept slides.

```bash
# Generate test illustrations
modal run scripts/generate_illustrations.py --slides morning-briefing,strategy-sparring,data-analysis

# Output: projects/pm-os-video/slide-images/illustrations/
```

**Prompt pattern for good illustrations:**
```
[Subject] + [visual style: minimalist/abstract/digital art] + 
[color: teal/purple/blue on dark background] + 
[composition: centered/floating/flowing] + 
[no text, no people, no logos]
```

**When to use illustrations vs backgrounds:**
- **Background:** behind all content, full-bleed, abstract, no focal point
- **Illustration:** replaces a text-heavy panel element, has a clear subject, ~1024×1024px

**Wire into HTML (replaces a panel):**
```html
<div class="uc-right">
  <img src="slide-images/illustrations/morning-briefing.png" 
       style="width:100%;height:100%;object-fit:contain;border-radius:16px">
</div>
```

---

## Step 4 — Screenshot Slides

Use Chrome DevTools MCP to capture each slide as 1920×1080 PNG.

**CRITICAL: Always capture slides sequentially — never parallel subagents.**

```javascript
// For each slide i (0-indexed):
evaluate_script: "() => { show(i); return 'ok'; }"
take_screenshot: { filePath: "...slide-NN.png", fullPage: false }
```

Name files `slide-01.png` through `slide-NN.png` (zero-padded).

If serving locally, navigate to `http://localhost:3000/presentation.html` in the DevTools browser first.

---

## Step 5 — Present or Export to Video

**Live presentation:** Open `http://localhost:3000/presentation.html` in browser.

**Export to video:** See `skills/video-creation.md` — slide PNGs + audio segments → MP4.

---

## Modal Scripts Reference

| Script | Command | Output |
|--------|---------|--------|
| `scripts/generate_backgrounds.py` | `modal run scripts/generate_backgrounds.py` | `ai-backgrounds/*.png` |
| `scripts/generate_hero_images.py` | `modal run scripts/generate_hero_images.py` | `heroes/*.png` |
| `scripts/generate_illustrations.py` | `modal run scripts/generate_illustrations.py` | `illustrations/*.png` |

**First run:** ~5 mins (model download ~6GB). Subsequent runs: ~2-3 mins (cached).
**GPU:** A10G (Modal free tier includes ~30 GPU-hours/month).

---

## File Conventions

```
projects/pm-os-video/
├── presentation.html              # Live HTML deck
├── slide-images/
│   ├── slide-01.png               # 1920×1080 slide screenshots
│   ├── ai-backgrounds/            # Full-bleed AI backgrounds
│   │   ├── hero.png
│   │   └── data.png
│   ├── heroes/                    # Dramatic hero images (main, cta etc)
│   │   ├── main-hero.png
│   │   └── cta-hero.png
│   └── illustrations/             # Content-specific visuals
│       ├── morning-briefing.png
│       └── strategy-sparring.png
```

---

## Common Issues

| Issue | Fix |
|-------|-----|
| AI background too bright/washes out text | Increase gradient overlay opacity (0.7 → 0.85) |
| Illustration has wrong aspect ratio | Generate at 1024×1024, display with `object-fit:contain` |
| Modal cold start slow | First run downloads model (~6GB) — subsequent runs cached |
| Screenshot order wrong | Never use parallel subagents — always sequential evaluate+screenshot |
| `xformers` error on Modal | Remove `enable_xformers_memory_efficient_attention()`, use `enable_attention_slicing()` |
| Images not tracked by git | Add `*.png` exceptions to .gitignore only for slide-images folder |

---

## Extending to New Decks

1. Copy `presentation.html` structure
2. Update slide IDs and ORDER array in JS
3. Write new background/illustration prompts matching slide themes
4. Run `modal run scripts/generate_backgrounds.py` with new slide names
5. Capture screenshots + present or export to video

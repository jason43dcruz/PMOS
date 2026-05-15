# Skill: HTML Deck to PDF

Convert an HTML slide deck into a page-per-slide PDF, with optional slide exclusion.

## When to Use
- User asks to export an HTML presentation as a PDF
- User wants to share a deck without the interactive navigation
- User wants to exclude specific slides (e.g., "remove the ask section")

## Prerequisites
- `playwright-cli` available (for browser rendering + screenshots)
- `fpdf2` Python package (install with `pip3 install --break-system-packages fpdf2` if needed)
- Local HTTP server to serve the HTML file

## Steps

### 1. Serve the HTML locally
```bash
cd <directory-containing-html> && python3 -m http.server <port> &
```

### 2. Open in Firefox (headed, persistent)
```bash
playwright-cli open "http://localhost:<port>/<filename>.html" --headed --persistent --browser firefox
sleep 1
playwright-cli resize 1920 1080
```
Use 1920×1080 for good resolution. For higher DPI, use 2560×1440.

### 3. Screenshot each slide using keyboard navigation
Use `ArrowRight` to advance slides. Do NOT use JavaScript `eval` to toggle slide classes — it often doesn't trigger animations or render correctly.

```bash
# Slide 0 (already visible)
playwright-cli screenshot --filename tmp_rovodev_s0.png
sleep 0.3

# For each subsequent slide:
playwright-cli press ArrowRight
sleep 0.5
playwright-cli screenshot --filename tmp_rovodev_s<N>.png
```

**Excluding slides:** Simply stop capturing before the excluded slides, or skip the `ArrowRight` + `screenshot` for those slide numbers. Know your slide count beforehand by reading the HTML.

### 4. Combine screenshots into PDF
```python
python3 << 'PYEOF'
from fpdf import FPDF

slide_count = <N>  # number of slides captured
pdf = FPDF(orientation='L', unit='mm', format='A4')  # A4 landscape = 297×210mm

for i in range(slide_count):
    pdf.add_page()
    w = 297
    h = 297 * (1080 / 1920)  # maintain 16:9 aspect ratio = ~167mm
    y_offset = (210 - h) / 2  # center vertically on page
    pdf.image(f"tmp_rovodev_s{i}.png", x=0, y=y_offset, w=w, h=h)

pdf.output("<output-path>.pdf")
print(f"PDF created: {slide_count} pages")
PYEOF
```

**Aspect ratio adjustments:**
- 1920×1080 (16:9): `h = 297 * (1080/1920)` = 167mm, centered vertically
- 1280×720 (16:9): same ratio, just lower resolution screenshots
- Custom: adjust `h = 297 * (height/width)`

### 5. Clean up
```bash
playwright-cli close 2>/dev/null
rm -f tmp_rovodev_s*.png
# Kill the HTTP server if no longer needed
kill <server-pid> 2>/dev/null
```

## Gotchas
- **Use Firefox** — Chromium headless supports `pdf` command natively but may not be installed. Firefox requires the screenshot approach.
- **Use keyboard navigation** (`press ArrowRight`), not JavaScript eval to switch slides. Eval often doesn't trigger CSS transitions/animations properly, resulting in duplicated or broken slides.
- **Wait between slides** — `sleep 0.5` after each `ArrowRight` to let transitions complete.
- **fpdf2 install** — may need `--break-system-packages` flag on managed Python environments.
- **Resolution** — 1920×1080 is the sweet spot. Higher res = bigger file size but sharper text.
- **Nav elements** — The slide counter, nav buttons, and progress bar will appear in screenshots. If you want them hidden, use `eval` to set `display:none` on `.nav`, `.slide-counter`, `.progress-bar` BEFORE starting the screenshot loop.

## Example: Exclude slides 9-11 from a 12-slide deck
```bash
# Capture slides 0-8 only (9 slides)
for i in $(seq 0 8); do
  if [ $i -gt 0 ]; then
    playwright-cli press ArrowRight
    sleep 0.5
  fi
  playwright-cli screenshot --filename tmp_rovodev_s${i}.png
done
```
Then combine with `slide_count = 9` in the Python script.

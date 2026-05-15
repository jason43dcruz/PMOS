# Video Creation Skill

A complete pipeline for creating narrated videos — from HTML slide decks, live browser walkthroughs, or a combination of both.

---

## Two Core Formats

### Format A: Slide-Based Video
Static slides with synced voiceover. Best for: product overviews, strategy presentations, demos where content > motion.

### Format B: Browser Walkthrough Video
Live browser session recorded with voiceover. Best for: product demos, feature walkthroughs, "show don't tell" content.

### Format C: Hybrid (Slides + Live Demo)
Slides for context/framing, browser recordings for demos. Best for: full product presentations where you want both narrative arc and live feel.

---

## Format A: Slide-Based Video

### Step 1 — Build the HTML Deck
Read `skills/html-deck-style-guide.md` for style guide. Two styles: **Official** (Atlassian brand) and **Flashy** (event/keynote).

Key principles:
- Write one clear thought per slide — ~20 words max of narration per slide
- 15 slides × 7s = ~105s = ~2 min video
- Navigation: `→` / Space = next, `←` = back, `F` = fullscreen

Serve locally for screenshots:
```bash
cd projects/pm-os-video && python3 -m http.server 3000
```

### Step 2 — Capture Slide Screenshots
Use Chrome DevTools MCP to capture each slide as 1920×1080 PNG.

**CRITICAL: Always capture slides sequentially yourself — never use parallel subagents for this. They will capture the wrong slide.**

```python
# For each slide i (0-indexed):
evaluate_script: "() => { show(i); return 'ok'; }"
take_screenshot: filePath="...slide-NN.png", fullPage=false
```

Name files `slide-01.png` through `slide-NN.png` (zero-padded).

### Step 3 — Generate Voiceover
Write narration as one segment per slide. Each segment = one clear sentence, ~7 seconds at natural pace.

**Option A: edge-tts (generic, fast, no dependencies)**
```python
import asyncio, edge_tts

async def gen():
    communicate = edge_tts.Communicate(
        text="Your narration here.",
        voice="en-AU-WilliamNeural",
        rate="+5%",
        pitch="-2Hz"
    )
    await communicate.save("seg-01.mp3")

asyncio.run(gen())
```
Good voices: `en-AU-WilliamNeural` (Australian male), `en-US-GuyNeural` (US male), `en-GB-RyanNeural` (UK male)

**Option B: F5-TTS voice cloning (sounds like you, needs GPU)**
See Voice Cloning section below.

### Step 4 — Assemble Video
Each slide holds for exactly the duration of its audio segment — perfect sync guaranteed.

```bash
OUT_IMG="path/to/slide-images"
OUT_AUD="path/to/audio-segments"
> /tmp/concat.txt

for i in $(seq 1 15); do
  NUM=$(printf '%02d' $i)
  DUR=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$OUT_AUD/seg-${NUM}.mp3")
  PART="/tmp/part_${NUM}.mp4"
  ffmpeg -y -loglevel error \
    -loop 1 -i "$OUT_IMG/slide-${NUM}.png" \
    -i "$OUT_AUD/seg-${NUM}.mp3" \
    -c:v libx264 -tune stillimage -pix_fmt yuv420p \
    -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:black" \
    -c:a aac -b:a 192k -shortest "$PART"
  echo "file '$PART'" >> /tmp/concat.txt
done

ffmpeg -y -loglevel error -f concat -safe 0 -i /tmp/concat.txt "output/My Video.mp4"
rm -f /tmp/part_*.mp4 /tmp/concat.txt
```

**Use `.wav` extension in the ffprobe/ffmpeg commands if audio is WAV (F5-TTS output).**

---

## Format B: Browser Walkthrough Video

Use playwright-cli to record a live browser session. See `skills/browser-copilot.md` for full playbook.

```bash
# Start recording
playwright-cli video-start

# ... navigate, click, demonstrate ...

# Stop and save
playwright-cli video-stop --filename tmp_rovodev_demo.webm

# Convert to MP4
ffmpeg -y -i tmp_rovodev_demo.webm -c:v libx264 -preset fast -crf 23 output/demo.mp4
```

**To add voiceover to a browser recording:**
```bash
ffmpeg -y \
  -i output/demo.mp4 \
  -i voiceover.mp3 \
  -c:v copy -c:a aac -b:a 192k -shortest \
  output/demo-with-voice.mp4
```

---

## Format C: Hybrid (Slides + Browser)

Combine slide clips and browser recording clips into one video using ffmpeg concat.

```bash
# Build slide sections (Format A pipeline)
# Build browser sections (Format B pipeline)
# Then concat in order:

> /tmp/hybrid_concat.txt
echo "file 'slide-intro.mp4'" >> /tmp/hybrid_concat.txt
echo "file 'browser-demo.mp4'" >> /tmp/hybrid_concat.txt
echo "file 'slide-cta.mp4'" >> /tmp/hybrid_concat.txt

ffmpeg -y -loglevel error -f concat -safe 0 -i /tmp/hybrid_concat.txt \
  -c:v libx264 -c:a aac output/hybrid-video.mp4
```

**Resolution normalisation** — if slides are 1920×1080 and browser recording is a different size, normalise first:
```bash
ffmpeg -y -i browser-demo.webm \
  -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:black" \
  -c:a copy browser-demo-1080.mp4
```

---

## Voice Cloning

To make the narration sound like you (not a generic TTS voice).

### Reference audio
- Use `voice-sample-12s.wav` — 12 seconds of clean speech, no music/noise
- Located at: `projects/pm-os-video/voice-sample-12s.wav`
- **F5-TTS clips reference audio to 12s automatically — no benefit to longer files**

### Option A: Google Colab (recommended — GPU, fast)
Notebook: `projects/pm-os-video/PMOS_Voice_Clone_Colab.ipynb`

1. Upload to [colab.research.google.com](https://colab.research.google.com)
2. Runtime → Change runtime type → **T4 GPU**
3. Run all cells, upload `voice-sample-12s.wav` when prompted
4. Download `pmos-cloned-voice.zip`
5. Extract to `projects/pm-os-video/audio-cloned/`
6. Tell Rovo Dev: "voice segments ready in audio-cloned, rebuild the video"

**Speed:** ~20-30s per segment on T4 GPU = 15 segments in ~7 mins.

### Option B: Local F5-TTS overnight (CPU, slow but free)
```bash
# CRITICAL: Always unset PYTHONPATH — rovodev voice-deps pollutes numpy
env -i HOME="$HOME" PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin" LANG="en_AU.UTF-8" \
  projects/pm-os-video/.venv-f5/bin/python tmp_rovodev_f5_overnight.py \
  > /tmp/f5_overnight.log 2>&1 &
```

**Speed:** ~60s per segment on CPU = 15 segments in ~15-20 mins.

### Known F5-TTS mispronunciations (fix phonetically in text)
- "morning" → sometimes pronounced "mourning" — try "mor-ning" or restructure sentence
- Em-dashes `—` → confuse phonemizer — replace with `, ` or `. `
- Abbreviations → spell out (e.g. "PM" → "product manager", "[YOUR PRODUCT]" → "J S M")

### Venv locations
- F5-TTS: `projects/pm-os-video/.venv-f5/`
- Coqui XTTS v2: `projects/pm-os-video/.venv/` (lower quality voice clone)

---

## File Conventions

```
projects/pm-os-video/
├── presentation.html          # Live HTML deck
├── script.json                # Scene/narration mapping
├── voice-sample.wav           # Full voice recording (3 min)
├── voice-sample-12s.wav       # Trimmed reference (12s, use this)
├── slide-images/
│   ├── slide-01.png           # 1920×1080 screenshots of each slide
│   └── slide-15.png
├── audio-segments/            # edge-tts segments (generic voice)
│   ├── seg-01.mp3
│   └── seg-15.mp3
├── audio-cloned/              # F5-TTS segments (cloned voice)
│   ├── seg-01.wav
│   └── seg-15.wav
├── output/
│   └── PMOS - Jason D Cruz.mp4       # Final video
└── PMOS_Voice_Clone_Colab.ipynb      # Colab notebook
```

---

## Common Issues

| Issue | Fix |
|-------|-----|
| `ModuleNotFoundError: numpy` | PYTHONPATH polluted — use `env -i` to launch Python |
| Slides captured out of order | Never use parallel subagents for screenshots — always sequential |
| Video ends before audio | Add 2-3s to last slide duration or use `-shortest` flag |
| Audio not synced to slides | Write one narration segment per slide, use per-segment assembly |
| F5-TTS saves to wrong path | Use absolute paths (`/content/audio-cloned/`) not relative |
| QR code wrong URL | Regenerate: `pip install qrcode[pil]` then `qrcode.make(url).save('qr.png')` |

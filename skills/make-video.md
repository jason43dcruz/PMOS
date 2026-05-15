# Skill: Make Video (Kokoro TTS + ffmpeg)

Generate narrated explainer videos from a script + screenshots.
Uses Kokoro TTS (bm_george voice) + ffmpeg. No browser recording needed for static content.

## Pipeline

```
Script (text) → Kokoro TTS (George) → WAV per scene
Screenshots → PNG per scene
ffmpeg → scene MP4 per scene (image + audio)
ffmpeg concat → final MP4
```

## Usage

```bash
python3 skills/make_video.py \
  --script scripts/my-video-script.json \
  --output output/my-video.mp4
```

## Script format (JSON)

```json
[
  {
    "scene": 1,
    "image": "path/to/screenshot.png",
    "narration": "Your narration text here."
  },
  ...
]
```

## Voice options
- bm_george — British male (default, recommended)
- am_michael — American male
- am_adam — American male, deeper
- af_heart — American female
- bf_emma — British female

## Audio timing
- `lead_pad=1.2` — 1.2s silence before narration starts (slide appears first)
- `tail_pad=1.5` — 1.5s silence after narration ends (no cut-off)
- Video duration set explicitly from padded audio duration — NOT using `-shortest` (which cuts audio)

## Known working settings
- Speed 1.3x = natural pace, ~90-120s for 8 scenes
- Speed 1.2x = slightly slower, ~120s for 8 scenes
- Speed 1.4x = fast but intelligible, ~75s for 8 scenes

## Model files
- /tmp/kokoro-v1.0.onnx
- /tmp/voices-v1.0.bin

To persist models (avoid re-downloading):
```bash
mkdir -p ~/kokoro-models
cp /tmp/kokoro-v1.0.onnx /tmp/voices-v1.0.bin ~/kokoro-models/
```

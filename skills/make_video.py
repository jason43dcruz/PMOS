#!/usr/bin/env python3
"""
make_video.py — Narrated explainer video generator
Uses Kokoro TTS (local, free) + ffmpeg to stitch scenes into a final MP4.

Usage:
  python3 skills/make_video.py --script path/to/script.json --output output/video.mp4

Script format (JSON):
  [
    { "scene": 1, "image": "path/to/image.png", "narration": "Text to speak." },
    ...
  ]
"""

import sys
import os
import json
import argparse
import subprocess
import tempfile

sys.path.insert(0, '/Users/jdcruz/.rovodev/voice-deps')

KOKORO_MODEL = os.path.expanduser("~/kokoro-models/kokoro-v1.0.onnx")
KOKORO_VOICES = os.path.expanduser("~/kokoro-models/voices-v1.0.bin")

# Fallback to /tmp if not moved yet
if not os.path.exists(KOKORO_MODEL):
    KOKORO_MODEL = "/tmp/kokoro-v1.0.onnx"
if not os.path.exists(KOKORO_VOICES):
    KOKORO_VOICES = "/tmp/voices-v1.0.bin"


def generate_audio(text, voice, output_wav, speed=1.0):
    from kokoro_onnx import Kokoro
    import soundfile as sf
    kokoro = Kokoro(KOKORO_MODEL, KOKORO_VOICES)
    samples, sample_rate = kokoro.create(text, voice=voice, speed=speed, lang="en-us")
    sf.write(output_wav, samples, sample_rate)
    return output_wav


def get_audio_duration(wav_path):
    """Get duration of a WAV file in seconds."""
    result = subprocess.run(
        ["ffprobe", "-v", "error", "-show_entries", "format=duration",
         "-of", "default=noprint_wrappers=1:nokey=1", wav_path],
        capture_output=True, text=True
    )
    return float(result.stdout.strip())


def make_scene_video(image_path, audio_wav, output_mp4, tail_pad=1.5, lead_pad=1.2):
    """Combine a static image + audio into a video clip, with lead and tail padding."""
    # Pad audio: silence before (so slide appears first) + silence after (no cut)
    padded_wav = audio_wav.replace(".wav", "_padded.wav")
    pad_cmd = [
        "ffmpeg", "-y", "-i", audio_wav,
        "-af", f"adelay={int(lead_pad*1000)}|{int(lead_pad*1000)},apad=pad_dur={tail_pad}",
        "-c:a", "pcm_s16le",
        padded_wav
    ]
    subprocess.run(pad_cmd, check=True, capture_output=True)

    # Get exact duration of padded audio — use this to set video length explicitly
    duration = get_audio_duration(padded_wav)

    cmd = [
        "ffmpeg", "-y",
        "-loop", "1", "-i", image_path,
        "-i", padded_wav,
        "-c:v", "libx264", "-tune", "stillimage",
        "-c:a", "aac", "-b:a", "128k",
        "-pix_fmt", "yuv420p",
        "-t", str(duration),  # Explicit duration — no cutting
        output_mp4
    ]
    subprocess.run(cmd, check=True, capture_output=True)


def render_html_slides(html_path, output_dir, slide_ids, width=1920, height=1080):
    """Render HTML slides to PNGs headlessly using node playwright. No browser window opens."""
    import textwrap
    script = textwrap.dedent(f"""
        import {{ chromium }} from '/Users/jdcruz/jdcruz-prototype/node_modules/playwright/index.mjs';
        const browser = await chromium.launch({{ headless: true }});
        const context = await browser.newContext({{ viewport: {{ width: {width}, height: {height} }}, deviceScaleFactor: 1 }});
        const page = await context.newPage();
        await page.goto('file://{html_path}');
        await page.waitForTimeout(1500);
        for (const i of {slide_ids}) {{
            await page.evaluate((id) => document.getElementById(`slide-${{id}}`).scrollIntoView(), i);
            await page.waitForTimeout(400);
            await page.screenshot({{ path: `{output_dir}/slide-${{i}}.png`, clip: {{ x: 0, y: 0, width: {width}, height: {height} }} }});
        }}
        await browser.close();
    """)
    script_path = "/tmp/tmp_rovodev_render_slides.mjs"
    with open(script_path, "w") as f:
        f.write(script)
    result = subprocess.run(["node", script_path], capture_output=True, text=True)
    os.unlink(script_path)
    if result.returncode != 0:
        raise RuntimeError(f"Slide render failed: {result.stderr}")


def make_title_card(title, subtitle, output_png, width=1920, height=1080):
    """Generate a title card using PIL."""
    from PIL import Image, ImageDraw, ImageFont

    img = Image.new("RGB", (width, height), color=(0, 82, 204))  # Atlassian blue
    draw = ImageDraw.Draw(img)

    # Try to use a system font, fall back to default
    try:
        font_title = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", 80)
        font_subtitle = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", 44)
    except Exception:
        font_title = ImageFont.load_default()
        font_subtitle = ImageFont.load_default()

    # Title
    bbox = draw.textbbox((0, 0), title, font=font_title)
    tw, th = bbox[2] - bbox[0], bbox[3] - bbox[1]
    draw.text(((width - tw) / 2, height / 2 - th - 30), title, fill="white", font=font_title)

    # Subtitle
    bbox2 = draw.textbbox((0, 0), subtitle, font=font_subtitle)
    sw, sh = bbox2[2] - bbox2[0], bbox2[3] - bbox2[1]
    draw.text(((width - sw) / 2, height / 2 + 20), subtitle, fill=(179, 212, 255), font=font_subtitle)

    img.save(output_png)


def concat_videos(scene_mp4s, output_mp4):
    """Concatenate scene videos into final MP4."""
    with tempfile.NamedTemporaryFile(mode='w', suffix='.txt', delete=False) as f:
        for path in scene_mp4s:
            f.write(f"file '{os.path.abspath(path)}'\n")
        concat_file = f.name

    cmd = [
        "ffmpeg", "-y",
        "-f", "concat", "-safe", "0",
        "-i", concat_file,
        "-c", "copy",
        output_mp4
    ]
    subprocess.run(cmd, check=True, capture_output=True)
    os.unlink(concat_file)


def main():
    parser = argparse.ArgumentParser(description="Generate narrated explainer video")
    parser.add_argument("--script", required=True, help="Path to JSON script file")
    parser.add_argument("--output", required=True, help="Output MP4 path")
    parser.add_argument("--voice", default="bm_george", help="Kokoro voice (default: bm_george)")
    parser.add_argument("--speed", type=float, default=1.0, help="Voice speed (default: 1.0, try 1.2-1.3 to shorten)")
    parser.add_argument("--keep-tmp", action="store_true", help="Keep temp files for debugging")
    args = parser.parse_args()

    with open(args.script) as f:
        scenes = json.load(f)

    os.makedirs(os.path.dirname(args.output) if os.path.dirname(args.output) else ".", exist_ok=True)

    tmp_dir = tempfile.mkdtemp(prefix="tmp_rovodev_video_")
    scene_mp4s = []

    print(f"🎬 Generating {len(scenes)} scenes with voice: {args.voice}")

    for scene in scenes:
        n = scene["scene"]
        narration = scene["narration"]
        image_path = scene.get("image")

        print(f"  Scene {n}: generating audio...")
        audio_wav = os.path.join(tmp_dir, f"scene_{n}.wav")
        generate_audio(narration, args.voice, audio_wav, speed=args.speed)

        # Generate title card if no image provided
        if not image_path or not os.path.exists(image_path):
            print(f"  Scene {n}: generating title card...")
            image_path = os.path.join(tmp_dir, f"scene_{n}.png")
            title = scene.get("title", f"Scene {n}")
            subtitle = scene.get("subtitle", "")
            make_title_card(title, subtitle, image_path)

        print(f"  Scene {n}: rendering video clip...")
        scene_mp4 = os.path.join(tmp_dir, f"scene_{n}.mp4")
        make_scene_video(image_path, audio_wav, scene_mp4)
        scene_mp4s.append(scene_mp4)

    print(f"🔗 Concatenating {len(scene_mp4s)} scenes...")
    concat_videos(scene_mp4s, args.output)

    if not args.keep_tmp:
        import shutil
        shutil.rmtree(tmp_dir)

    print(f"✅ Done! Video saved to: {args.output}")


if __name__ == "__main__":
    main()

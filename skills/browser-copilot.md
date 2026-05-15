# Skill: Browser Copilot

Use playwright-cli to give an AI assistant eyes on a live browser session. The assistant can inspect pages via accessibility snapshots, explain UI state, interact with elements, and guide you through complex web admin flows — no more describing what's on screen.

## When to use this

- Configuring unfamiliar admin screens (JSM, Assets, Jira, Confluence)
- Debugging UI state or layout issues
- Walking through multi-step setup wizards
- Learning a new tool by having the assistant explain what it sees
- Internal demos where you want narrated walkthroughs

## Tools

| Tool | What it does |
|------|-------------|
| `playwright-cli` | Primary. CLI-based browser control — open, snapshot, click, fill, navigate. Works via bash. |
| `chrome-devtools-mcp` | Fallback. MCP server for deep DevTools inspection (network, perf, console). |

## Prerequisites

| Requirement | Minimum version | Check command |
|-------------|----------------|---------------|
| Node.js | 20.19.0+ (LTS) | `node --version` |
| `@playwright/cli` | latest | `playwright-cli --version` |
| Chrome | Any recent (playwright manages its own) | — |

## Setup

### Step 1 — Upgrade Node (if needed)

If your Node version is below 20.19.0:

```bash
nvm install 20
nvm use 20
nvm alias default 20
```

### Step 2 — Install playwright-cli

```bash
npm install -g @playwright/cli@latest
playwright-cli --version
```

### Step 3 — (Optional) Add chrome-devtools-mcp for deep inspection

Add to your MCP config (`~/.rovodev/mcp.json`, `~/.cursor/mcp.json`, etc.):

```json
"chrome-devtools": {
  "command": "npx",
  "args": ["-y", "chrome-devtools-mcp@latest", "--isolated"]
}
```

### Step 4 — Verify

```bash
playwright-cli open https://example.com --headed
playwright-cli snapshot
playwright-cli close
```

You should see a browser open and get an accessibility tree snapshot of the page.

## How it works

Playwright-cli uses an **accessibility snapshot** model:

1. `snapshot` captures the full page as an accessibility tree
2. Every interactive element gets a **ref** (e.g. `e184`)
3. The agent reads the tree to understand the page
4. The agent can interact using refs: `click e184`, `fill e184 "text"`, etc.

This is more efficient than screenshots — the agent gets structured, semantic page content.

## Core commands

```bash
# Browser lifecycle
playwright-cli open [url] --headed     # open browser (use --headed to see it)
playwright-cli close                   # close browser
playwright-cli close-all               # close all sessions

# Page inspection
playwright-cli snapshot                # accessibility tree with refs
playwright-cli screenshot [ref]        # screenshot of page or element
playwright-cli eval <js> [ref]         # run JS on page or element

# Navigation
playwright-cli goto <url>              # navigate to URL
playwright-cli go-back                 # browser back
playwright-cli go-forward              # browser forward
playwright-cli reload                  # reload page

# Interaction
playwright-cli click <ref>             # click element
playwright-cli fill <ref> <text>       # fill input field
playwright-cli type <text>             # type into focused element
playwright-cli select <ref> <value>    # select dropdown option
playwright-cli check <ref>             # check checkbox
playwright-cli uncheck <ref>           # uncheck checkbox
playwright-cli hover <ref>             # hover over element
playwright-cli press <key>             # press key (Enter, Tab, etc.)

# Tabs
playwright-cli tab-list                # list open tabs
playwright-cli tab-new [url]           # open new tab
playwright-cli tab-close [index]       # close tab

# Sessions
playwright-cli list                    # list all sessions
playwright-cli -s=myname open <url>    # named session
playwright-cli show                    # visual dashboard (see all sessions)
```

## Operating modes

Use these explicitly when starting a browser copilot workflow.

### Mode 1 — Inspect only (default)

Use for: unfamiliar screens, admin config, anything high-risk.

```bash
playwright-cli open https://your-site.atlassian.net --headed
playwright-cli snapshot
```

Then ask the agent: *"Read this snapshot and explain what's on screen. What are the key actions available?"*

The agent reads the accessibility tree and guides you. No interaction.

### Mode 2 — Guided walkthrough

Use for: step-by-step config where you want the agent to lead.

Agent reads the snapshot, explains each field, recommends values, and proposes one action at a time. You approve before each interaction.

Pattern:
```bash
playwright-cli snapshot          # agent reads
# agent says: "I see field X (ref e42). It controls Y. I recommend value Z."
# you say: "go ahead"
playwright-cli fill e42 "Z"     # agent acts
playwright-cli snapshot          # agent verifies
```

### Mode 3 — Explain this page

Use for: learning, onboarding, documentation.

```bash
playwright-cli open <url> --headed
playwright-cli snapshot
```

Ask: *"Explain this page to me like I've never seen it before. What is it for? What are the key sections? What should I be careful about?"*

### Mode 4 — Visual monitoring

Use for: watching what the agent does in real time.

```bash
playwright-cli show
```

Opens a dashboard showing all active browser sessions with live screencasts. You can click into any session to take over mouse/keyboard. Press Escape to release control.

## Prompt recipes

### Assets / CMDB configuration
> Open a browser to my JSM Assets page. Take a snapshot and tell me: what object schema am I looking at, what object types exist, and what attributes are configured on the currently selected type. Don't change anything.

### Jira project settings
> Navigate to my Jira project settings. Snapshot the page and walk me through each settings section. For each one, tell me what it controls and whether the current configuration looks standard or unusual.

### Confluence space permissions
> Go to my Confluence space permissions page. Snapshot and list all groups and users with access, their permission levels, and flag anything overly permissive.

### General "what am I looking at?"
> Take a snapshot. Summarize the key elements, current state, and available actions. Keep it brief.

## Session management

Name sessions to keep different workflows separate:

```bash
playwright-cli -s=assets open https://jason-jsm.atlassian.net/jira/assets --headed
playwright-cli -s=jira-admin open https://jason-jsm.atlassian.net/jira/settings --headed
playwright-cli list   # see both sessions
```

Use `--persistent` to save cookies/state across browser restarts. **Always use Firefox** for persistent sessions — Chrome is blocked by Atlassian MDM (DevTools remote debugging disabled, ChromeEnterprise conflicts).

```bash
# Default persistent command (Firefox — no MDM conflicts, sessions persist)
playwright-cli open https://your-site.atlassian.net --headed --persistent --browser firefox

# Chrome persistent (BROKEN on Atlassian-managed Macs — do not use)
# playwright-cli open https://your-site.atlassian.net --headed --persistent
```

**First use:** User must authenticate manually (SSO + MFA). After that, the session persists — no re-auth needed.
**User data dir:** `~/Library/Caches/ms-playwright/daemon/*/ud-default-firefox`

## Guardrails

### Always do
- Start in inspect-only mode (snapshot first, don't interact)
- Use `--headed` so you can see what the browser is doing
- Ask the agent to snapshot after each meaningful change
- Review proposed actions before approving

### Never do
- Let the agent interact freely on production admin screens
- Skip the approval step on destructive actions (delete, permission changes, schema changes)
- Point it at pages with credentials, tokens, or billing info visible

### Risk levels

| Action type | Risk | Approach |
|-------------|------|----------|
| Snapshot / read page | Low | Always OK |
| Navigate between pages | Low | OK with awareness |
| Fill form fields | Medium | Propose first, approve each |
| Click submit/save | Medium-High | Always approve explicitly |
| Delete / remove / revoke | High | Inspect-only, you click manually |
| Permission / auth changes | High | Inspect-only, you click manually |

## Hybrid Workflows

When an API can do part of the job but not all of it — or when the browser is the only path — chain them together. Don't bounce the problem back to the user.

### Decision framework: API vs browser vs hybrid

Ask in this order:

1. **Can the API do it entirely?** → Use the API. Faster, scriptable, no auth risk.
2. **Can the API do it but the browser is simpler for a one-off?** → Still use the API. One-offs become two-offs. Browser interactions are fragile — refs change across page loads, UI redesigns break flows silently.
3. **Does the API not exist for this step?** → Use the browser for that step, API for everything else. This is a hybrid workflow.
4. **Is the API flaky or undocumented but the UI works?** → Browser is fine as a tactical choice. Log it — these are gaps worth reporting or scripting around later.
5. **Are you unsure if an API exists?** → Check MCP tools first, then the product's REST/GraphQL API docs. Don't default to browser out of laziness. Browser is the escape hatch, not the front door.

**Rule of thumb:** API is the default. Browser is for gaps, visual tasks, and file uploads. If you find yourself reaching for the browser more than once for the same task, that's a signal to find or request the API.

### Chaining pattern: API → browser → API

When a workflow requires both, follow this template:

```
1. Do everything you can via API first (create, configure, query)
2. Identify the gap — what can't the API do?
3. Open browser, navigate to the thing you just created/need to configure
4. Snapshot → verify you're on the right page
5. Perform the browser-only step(s) — one action at a time, snapshot after each
6. Extract any data you need (IDs from URLs, confirmation states)
7. Return to API for remaining steps
8. Close browser when done
```

**Example — Create a request type with custom form:**
```
API:  Create request type via JSM REST API → get request type ID
GAP:  Form builder has no API — must configure in UI
Browser: Open request type settings → snapshot → add fields one by one
Browser: Snapshot to confirm form looks right
API:  Update request type with remaining config (SLA, automation rules)
```

**State tracking between steps:**
- Keep a mental checklist: what's done via API, what's pending in browser, what comes after.
- If a browser step produces an ID or value needed later, extract it immediately (usually from the URL or page content) and note it before moving on.
- If the workflow fails mid-chain, you can resume — the API steps are already done. Just reopen the browser to the right URL.

### Auth interrupts: handling login walls

The browser launches with no cookies (unless `--persistent`). You will hit login screens. Here's how to handle it.

**On first open (expected):**
```bash
playwright-cli open <url> --headed --persistent --browser firefox
playwright-cli snapshot
```
If the snapshot shows a login/SSO page:
1. Tell the user: "I've opened the browser but you'll need to log in. I'll wait."
2. **Poll with snapshots** — every 10–15 seconds, take a snapshot to check if login is complete.
3. Once the snapshot shows the target page (not the login form), continue the workflow.

```bash
# Wait loop pattern
playwright-cli snapshot   # shows login page
# → "Waiting for you to log in..."
# (pause 15 seconds)
playwright-cli snapshot   # still login page
# (pause 15 seconds)
playwright-cli snapshot   # shows target page → continue
```

**Mid-workflow session expiry (unexpected):**
If a snapshot suddenly shows a login page or redirect during a workflow:
1. Stop immediately — don't try to interact with the login form.
2. Tell the user: "Session expired. Please re-authenticate in the browser window. I'll resume where we left off."
3. Poll with snapshots until auth is complete.
4. Re-snapshot the target page to reacquire element refs (they'll have changed).
5. Resume from the last incomplete step.

**Persistent sessions (avoid the problem):**
Always use `--persistent --browser firefox` for workflows that may take more than a few minutes. This survives browser restarts and reduces re-auth friction. After first login, subsequent opens skip SSO entirely.

**Never do:**
- Try to fill in login forms programmatically (credentials, MFA codes)
- Assume auth will "just work" — always snapshot-verify before acting
- Continue a workflow after auth redirect without re-snapshotting (refs are stale)

## Screen Capture & Recording

Capture screenshots and record demos. **Default to browser-window-only** when demoing web workflows — full-screen recording captures unnecessary desktop clutter.

### Static screenshot

```bash
# Full screen
screencapture -x screenshot.png

# Browser window only (preferred for web demos)
WINDOW_ID=$(osascript -e 'tell app "Google Chrome" to id of window 1')
screencapture -x -l$WINDOW_ID screenshot.png
```

Then `open_files` to view it. Built-in, instant, no dependencies.

### Playwright viewport recording → MP4 (preferred for web demos)

Records only the browser viewport via Playwright's built-in video capture. **No window overlap issues** — other windows on top won't bleed into the recording. No crop math, no Retina scaling headaches, no fixed duration timer.

```bash
# Start recording
playwright-cli video-start

# ... perform your demo actions ...

# Stop and save (webm format)
playwright-cli video-stop --filename tmp_rovodev_demo.webm

# Convert to MP4 (optional — for wider compatibility)
ffmpeg -y -i tmp_rovodev_demo.webm -c:v libx264 -preset fast -crf 23 tmp_rovodev_demo.mp4
```

**Tradeoff:** Captures page content only — no browser chrome (address bar, tabs). This is fine for most demos and arguably looks cleaner.

### ffmpeg window crop recording → GIF (fallback)

Records the screen and crops to the browser window bounds. Use when you need browser chrome visible, or for non-Playwright browsers. **Caveat:** other windows overlapping the browser will be captured too.

```bash
# Step 1: Get the browser window bounds
BOUNDS=$(osascript -e 'tell app "Google Chrome" to get bounds of window 1')

# Step 2: Parse bounds into crop dimensions
X=$(echo $BOUNDS | cut -d',' -f1 | tr -d ' ')
Y=$(echo $BOUNDS | cut -d',' -f2 | tr -d ' ')
X2=$(echo $BOUNDS | cut -d',' -f3 | tr -d ' ')
Y2=$(echo $BOUNDS | cut -d',' -f4 | tr -d ' ')
W=$((X2 - X))
H=$((Y2 - Y))

# Step 3: Record full screen, crop to browser window (adjust -t for duration)
ffmpeg -f avfoundation -framerate 15 -i "3:" -t 30 \
  -vf "crop=$W:$H:$X:$Y,scale=1920:-1" -y tmp_rovodev_demo.mp4

# Step 4: Convert to GIF
ffmpeg -i tmp_rovodev_demo.mp4 -vf "fps=10,scale=1280:-1" tmp_rovodev_frames_%04d.png
gifski -o tmp_rovodev_demo.gif --fps 10 --width 1280 tmp_rovodev_frames_*.png
```

**Note on Retina displays:** macOS reports logical pixels but captures at physical (2x) resolution. Double X, Y, W, H values if the crop is off.

### Full screen recording → GIF (fallback)

Use when you need to capture non-browser apps or the full desktop.

```bash
# Record (adjust -t for duration in seconds)
ffmpeg -f avfoundation -framerate 10 -i "3:" -t 5 -vf "scale=1920:-1" -y recording.mp4

# Convert to GIF
ffmpeg -i recording.mp4 -vf "fps=10,scale=1920:-1" frames_%04d.png
gifski -o recording.gif --fps 10 --width 1920 frames_*.png
```

**Dependencies:** `brew install ffmpeg gifski`

**Device note:** `3:` = Capture screen 0. Verify with `ffmpeg -f avfoundation -list_devices true -i ""`

### Sharing recordings

MCP tools **cannot upload binary files** (GIFs, MP4s) to Confluence, Slack, or Loom. Options for sharing:

1. **Browser upload (recommended):** Use playwright-cli to open Confluence/Loom in the browser and attach the file via the web UI
2. **Manual drag-and-drop:** User attaches the file to Confluence page or Slack message
3. **Link sharing:** User uploads manually, then agent shares the resulting link via Slack/Confluence API

### When to use which

| Need | Tool | Why |
|------|------|-----|
| See what's on screen right now | `screencapture -x` | Instant, zero overhead |
| Screenshot browser window only | `screencapture -l<windowID>` | Clean, focused capture |
| **Record a browser demo** | **`playwright-cli video-start/stop`** | **Viewport-only, no overlap, no crop math** |
| Record with browser chrome visible | `ffmpeg` (cropped) → `gifski` | When you need address bar/tabs in frame |
| Record full screen workflow | `ffmpeg` (full) → `gifski` | When you need the whole desktop |
| Inspect a web page semantically | `playwright-cli snapshot` | Structured accessibility tree with refs |
| Interact with a web page | `playwright-cli click/fill` | Can read and write to the page |

### Recording demo workflows (scripted)

When recording a multi-step web workflow (e.g., creating an object in Assets):

1. **Use `playwright-cli video-start` / `video-stop`** — preferred method. Records viewport only, no window overlap, stops when you're done (no fixed timer).
2. **Use `fill` to clear fields, then `type` to simulate typing** — `fill` is instant (good for clearing), `type` types character-by-character (looks natural on screen). Pattern: `playwright-cli fill $REF ""` → `playwright-cli type "text"`.
3. **Add pauses between actions** (`sleep 2-3`) so viewers can see what happened.
4. **Script the whole demo in one bash command** — avoids stale refs from intermediate snapshots. Use `playwright-cli snapshot > /dev/null` to refresh refs mid-script.
5. **Grep for dynamic refs** in snapshots — don't hardcode refs. Pattern: `SNAP=$(ls -t .playwright-cli/page-*.yml | head -1); REF=$(grep 'pattern' "$SNAP" | grep -o 'ref=e[0-9]*' | head -1 | cut -d= -f2)`.
6. **Watch for non-obvious element names** — e.g., a "Portal group" combobox might be `combobox "Portal group Information about portal groups"`. Test grep patterns before the recording run.

### Voiceover with TTS

```bash
# Generate narration segments
say -v Samantha -r 170 -o tmp_rovodev_vo1.aiff "Your narration for segment one."
say -v Samantha -r 170 -o tmp_rovodev_vo2.aiff "Your narration for segment two."

# Convert to wav
for i in 1 2; do
  ffmpeg -y -i tmp_rovodev_vo${i}.aiff -ar 44100 -ac 1 tmp_rovodev_vo${i}.wav 2>/dev/null
done

# Assemble with delays (ms) — align to demo actions
ffmpeg -y \
  -i tmp_rovodev_vo1.wav -i tmp_rovodev_vo2.wav \
  -filter_complex "[0]adelay=0|0[a];[1]adelay=8000|8000[b];[a][b]amix=inputs=2:duration=longest[out]" \
  -map "[out]" -ar 44100 -ac 1 tmp_rovodev_voiceover.wav

# Merge Playwright recording (webm) + voiceover → MP4
ffmpeg -y \
  -i tmp_rovodev_demo.webm -i tmp_rovodev_voiceover.wav \
  -c:v libx264 -preset fast -crf 23 -c:a aac -b:a 128k \
  -shortest tmp_rovodev_demo_final.mp4
```

### Uploading files to Confluence via browser

MCP tools can't upload binary files, but playwright-cli can:

```bash
# 1. Open page in edit mode
playwright-cli click $EDIT_REF

# 2. Click "Add image, video, or file" toolbar button
playwright-cli click $MEDIA_REF

# 3. Click "Upload" in the Media picker dialog to trigger file chooser
playwright-cli click $UPLOAD_REF

# 4. Use playwright-cli upload command (only works when file chooser is open)
playwright-cli upload path/to/file.mp4

# 5. Click Update to save
playwright-cli click $UPDATE_REF
```

### API-first principle

**Use APIs for CRUD operations, browser for recording/uploading.** Deleting a request type via the JSM REST API is one call; via the browser it's 4 clicks + confirmation + error-prone ref hunting. Reserve the browser for:
- Visual workflows that need to be *seen* (recording demos)
- File uploads (no API support)
- Reading data not available via API

For everything else (create, delete, update), use the REST API or MCP tools.

### External web pages: bash first, browser fallback

For **public external pages** (competitor pricing, docs, blog posts, help centers), try a lightweight fetch via bash first — e.g. `curl` or Python requests — before opening a browser. This is usually faster and good enough for static HTML pages.

Use the browser if:
- The fetched HTML is missing the actual content
- The site is heavily JavaScript-rendered
- Pricing or packaging details only appear after page load or interaction
- The page blocks non-browser requests or requires cookies/session state
- You need to verify what a human actually sees, not just raw source

**Rule of thumb:**
1. Try bash fetch for simple public pages
2. Check whether the needed text is really present
3. Fall back to browser if rendering, interaction, or completeness is in doubt

For strategic work like competitor pricing, prefer the browser whenever the bash result looks incomplete or ambiguous. Bad extraction is worse than slower extraction.

**Do not** use bash scraping for authenticated internal tools when proper MCP/API/browser options exist.

### Cleanup rules

- **Always delete screenshot/recording/frame files after viewing.** Never leave them in the workspace.
- Use `tmp_rovodev_` prefix for any temp capture files so they're easy to identify and clean up.
- For frame files (can be hundreds), use bash: `rm tmp_rovodev_frames_*.png`

## Known limitations


### Corporate browser restrictions
- **Dia browser**: Atlassian IT policy blocks `--remote-debugging-port` on Dia. Use playwright-cli instead — it launches its own Chrome instance and bypasses this restriction.
- **Managed Chrome**: If your corporate Chrome also blocks remote debugging, playwright-cli still works because it launches Chrome for Testing, not your managed Chrome install.

### Authentication
- Playwright-cli launches a fresh browser with no cookies. You'll need to log in.
- Use `--persistent` to save your session across browser restarts.
- For SSO/SAML flows, log in manually in the headed browser, then start snapshotting.

## Troubleshooting

### playwright-cli not found
```bash
npm install -g @playwright/cli@latest
```

### Node version too old
```bash
nvm install 20
nvm use 20
```

### Browser won't open
Make sure you have Chrome installed, or run:
```bash
playwright-cli install chrome
```

### Can't see the browser
Always use `--headed`:
```bash
playwright-cli open https://example.com --headed
```

## Architecture

```
┌─────────────┐     ┌──────────────────────┐     ┌─────────────────┐
│   You        │────▶│  Rovo Dev / Agent     │────▶│  Chrome          │
│  (prompts)   │     │                      │     │  (headed, live)  │
│              │◀────│  playwright-cli       │◀────│                  │
│  (reads      │     │  (bash commands)     │     │  accessibility   │
│   guidance)  │     │                      │     │  tree + refs     │
└─────────────┘     └──────────────────────┘     └─────────────────┘
```

The agent uses `playwright-cli` commands via bash to control and inspect a headed Chrome instance. Page state is captured as accessibility tree snapshots. Every element gets a ref the agent can use to interact.

## Replication

To replicate this setup on any machine:

1. Install Node ≥20.19.0
2. `npm install -g @playwright/cli@latest`
3. `playwright-cli open https://example.com --headed`
4. `playwright-cli snapshot`

No API keys. No MCP config required. No custom code. Works with any MCP client that has bash access.

## Comparison: playwright-cli vs chrome-devtools-mcp vs agent-browser

| | playwright-cli | chrome-devtools-mcp | agent-browser (Vercel) |
|---|---|---|---|
| Integration | CLI via bash | MCP server | CLI via bash + SKILL |
| Browser | Own Chrome instance | Connects to running Chrome | Own Chrome for Testing |
| Strength | Visual dashboard, sessions, headed mode | Deep DevTools (network, perf, console) | Fast Rust CLI, token-efficient |
| Corporate browser | Bypasses restrictions | Needs debug port (may be blocked) | Bypasses restrictions |
| Best for | Interactive guidance, admin workflows | Deep debugging, network inspection | Automated testing, coding agents |
| Install | `npm install -g @playwright/cli` | `npx chrome-devtools-mcp@latest` | `npm install -g agent-browser` |

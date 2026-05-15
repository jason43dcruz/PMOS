# Skill: Design Prototyping

**Trigger:** When the user wants to build a product prototype that runs on Atlassian staging infrastructure — a real, interactive UI prototype with Atlaskit components, AI Gateway access, and a live URL.

## When to Use This vs Other Options

| Need | Use |
|---|---|
| Quick interactive concept (slider, calculator, comparison) | `skills/prototyping.md` (HTML prototype) |
| Full product prototype on staging with Atlaskit + AI | **This skill** (design prototyping) |
| Forge app deployed to a real Jira/JSM site | `skills/forge-apps.md` |
| Presentation deck | `skills/html-deck-style-guide.md` |

## Setup

**Repo:** [servco-prototyping](https://bitbucket.org/atlassian/servco-prototyping/src/main/)  
**Local path:** `~/jdcruz-prototype`  
**Guide:** [Setting up your own prototype environment in staging](https://hello.atlassian.net/wiki/spaces/~734276749/pages/6714948448/Setting+up+your+own+prototype+environment+in+staging)  
**Slack:** #ai-experimentation-kit

## Creating a New Prototype

No re-clone needed. Branch-per-prototype model — each branch gets its own Micros service and live URL.

```bash
cd ~/jdcruz-prototype
git checkout main && git pull
git checkout -b jdcruz-{name}   # branch name ≤26 chars total
./scripts/setup-branch.sh       # creates Micros service + deploy token (needs VPN)
git push -u origin jdcruz-{name}
# → live at servco-jdcruz-{name}.us-west-2.platdev.atl-paas.net in ~15 min
```

## What's Available

- **Atlaskit components** — full Atlassian design system
- **AI Gateway** — ASAP auth, AI-powered features
- **Atlassian internal packages** — @atlaskit, @atlassian
- **Live URL** — each branch auto-deploys to `servco-{branchName}.us-west-2.platdev.atl-paas.net`

## Active Prototypes

| Prototype | Branch | Live URL |
|---|---|---|
| HAM Prototype | `jdcruz-prototype` | [jsm-ham-jdcruz-prototype.us-west-2.platdev.atl-paas.net/jsm/](https://jsm-ham-jdcruz-prototype.us-west-2.platdev.atl-paas.net/jsm/) |

## Constraints

- Branch name must be ≤26 characters
- `setup-branch.sh` requires VPN connection
- Deploy takes ~15 minutes after push
- Prototypes run on Atlassian staging — not production
- The workspace folder is `~/jdcruz-prototype`, which is OUTSIDE the PMOS workspace. Navigate there via bash.

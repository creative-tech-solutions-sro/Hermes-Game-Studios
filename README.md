<p align="center">
  <h1 align="center">Hermes Game Studios</h1>
  <p align="center">
    Turn a single Hermes Agent session into a full game development studio.
    <br />
    49 agents. 72 skills. One coordinated AI team.
  </p>
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License"></a>
  <a href=".hermes/agents"><img src="https://img.shields.io/badge/agents-49-blueviolet" alt="49 Agents"></a>
  <a href=".hermes/skills"><img src="https://img.shields.io/badge/skills-72-green" alt="72 Skills"></a>
  <a href=".hermes/hooks"><img src="https://img.shields.io/badge/hooks-12-orange" alt="12 Hooks"></a>
  <a href=".hermes/rules"><img src="https://img.shields.io/badge/rules-11-red" alt="11 Rules"></a>
  <a href="https://hermes-agent.nousresearch.com/docs"><img src="https://img.shields.io/badge/built%20for-Hermes%20Agent-f5f5f5?logo=github" alt="Built for Hermes Agent"></a>
  <a href="https://www.buymeacoffee.com/donchitos3"><img src="https://img.shields.io/badge/Buy%20Me%20a%20Coffee-Support%20this%20project-FFDD00?logo=buymeacoffee&logoColor=black" alt="Buy Me a Coffee"></a>
  <a href="https://github.com/sponsors/Donchitos"><img src="https://img.shields.io/badge/GitHub%20Sponsors-Support%20this%20project-ea4aaa?logo=githubsponsors&logoColor=white" alt="GitHub Sponsors"></a>
</p>

---

## Why This Exists

Building a game solo with AI is powerful — but a single chat session has no structure. No one stops you from hardcoding magic numbers, skipping design docs, or writing spaghetti code. There's no QA pass, no design review, no one asking "does this actually fit the game's vision?"

**Hermes Game Studios** solves this by giving your AI session the structure of a real studio. Instead of one general-purpose assistant, you get 49 specialized agents organized into a studio hierarchy — directors who guard the vision, department leads who own their domains, and specialists who do the hands-on work. Each agent has defined responsibilities, escalation paths, and quality gates.

The result: you still make every decision, but now you have a team that asks the right questions, catches mistakes early, and keeps your project organized from first brainstorm to launch.

---

## Table of Contents

- [What's Included](#whats-included)
- [Studio Hierarchy](#studio-hierarchy)
- [Skills (Slash Commands)](#skills-slash-commands)
- [Does it produce games, or documents?](#does-it-produce-games-or-documents)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [Project Structure](#project-structure)
- [How It Works](#how-it-works)
- [Design Philosophy](#design-philosophy)
- [Customization](#customization)
- [Platform Support](#platform-support)
- [Community](#community)
- [Supporting This Project](#supporting-this-project)
- [License](#license)

---

## What's Included

| Category | Count | Description |
|----------|-------|-------------|
| **Agents** | 49 | Specialized subagents across design, programming, art, audio, narrative, QA, and production |
| **Skills** | 72 | Workflow commands for every phase (`/start`, `/brainstorm`, `/design-system`, `/create-epics`, `/dev-story`, `/story-done`, etc.) |
| **Hooks** | 12+ | Automated validation on commits, asset changes, session lifecycle, agent audit trail |
| **Rules** | 11 | Path-scoped coding standards enforced when editing gameplay, engine, AI, UI, network code |
| **Templates** | 39 | Document templates for GDDs, UX specs, ADRs, sprint plans, HUD design, accessibility |

## Studio Hierarchy

Agents are organized into three tiers, matching how real studios operate:

### Directors (3) — Vision & Decisions
| Agent | Role |
|-------|------|
| `creative-director` | Highest creative authority — vision, tone, aesthetic direction |
| `technical-director` | Highest technical authority — architecture, engine, performance |
| `producer` | Production authority — scope, schedule, resource allocation |

### Department Leads (9) — Domain Ownership
| Agent | Domain |
|-------|--------|
| `game-designer` | Core mechanics, systems, progression, balance |
| `art-director` | Visual identity, style guides, asset pipeline |
| `audio-director` | Sound design, music, voice, implementation |
| `narrative-director` | Story, worldbuilding, characters, dialogue |
| `lead-programmer` | Code quality, architecture enforcement, tech debt |
| `qa-lead` | Test strategy, evidence standards, release gates |
| `ux-designer` | Player-facing flows, HUD, menus, accessibility |
| `devops-engineer` | CI/CD, build pipeline, deployment, tooling |
| `community-manager` | Player communication, feedback loops, live ops |

### Specialists (37) — Hands-On Execution

**Design & Systems**
- `systems-designer` — System architecture, dependencies, data flow
- `level-designer` — Level layout, pacing, encounter design
- `economy-designer` — Resources, currencies, sinks, progression curves
- `live-ops-designer` — Events, seasons, retention, monetization
- `writer` — Dialogue, lore, item descriptions, UI text
- `localization-lead` — i18n pipeline, cultural adaptation, LQA

**Programming**
- `gameplay-programmer` — Mechanics, player systems, AI behavior
- `engine-programmer` — Core engine subsystems, rendering, physics
- `network-programmer` — Multiplayer, replication, lag compensation
- `ui-programmer` — Menus, HUD, input handling, animation
- `tools-programmer` — Editor tools, pipeline automation, content tools
- `performance-analyst` — Profiling, optimization, budgets
- `analytics-engineer` — Telemetry, events, funnels, A/B testing
- `security-engineer` — Anti-cheat, data protection, platform compliance
- `ai-programmer` — Behavior trees, utility AI, ML integration
- `prototyper` — Throwaway prototypes, mechanic validation

**Art & Audio**
- `technical-artist` — Shaders, VFX, rigging, pipeline tools
- `sound-designer` — SFX, ambience, implementation, middleware
- `world-builder` — Environment composition, set dressing, lighting
- `accessibility-specialist` — a11y compliance, testing, remediation

**Engine Specialists** (choose your engine set)
- **Godot**: `godot-specialist`, `godot-gdscript-specialist`, `godot-csharp-specialist`, `godot-gdextension-specialist`, `godot-shader-specialist`
- **Unity**: `unity-specialist`, `unity-dots-specialist`, `unity-addressables-specialist`, `unity-ui-specialist`, `unity-shader-specialist`
- **Unreal**: `unreal-specialist`, `ue-blueprint-specialist`, `ue-gas-specialist`, `ue-replication-specialist`, `ue-umg-specialist`

## Skills (Slash Commands)

Type `/` in Hermes to access all 72 skills:

**Onboarding & Navigation**
- `/start` — Guided onboarding for new projects
- `/help` — Browse all skills with context-aware suggestions
- `/project-stage-detect` — Analyze an existing project
- `/setup-engine` — Configure Godot/Unity/Unreal
- `/adopt` — Migrate existing files to studio format

**Game Design**
- `/brainstorm` — Explore game ideas from scratch or with a hint
- `/map-systems` — Decompose concept into systems with dependencies
- `/design-system` — Author per-system GDDs (guided, section-by-section)
- `/quick-design` — Rapid design iteration for small changes
- `/review-all-gdds` — Holistic consistency check across all GDDs
- `/propagate-design-change` — Cascade a design change to affected domains

**Architecture & Technical**
- `/create-architecture` — Master architecture document
- `/architecture-decision` — Document ADRs (one per decision)
- `/architecture-review` — Validate completeness, dependencies, engine fit
- `/create-control-manifest` — Flat programmer rules from ADRs
- `/test-setup` — Scaffold test framework + CI
- `/ux-design` — Accessibility, interaction patterns, UX specs

**Production**
- `/create-epics` — Translate GDDs+ADRs into epics (per layer)
- `/create-stories` — Break epics into implementable stories
- `/sprint-plan` — Plan sprints with prioritized stories
- `/dev-story` — Implement a story (routes to correct specialist)
- `/code-review` — Architectural code review
- `/story-done` — Verify acceptance criteria, close story
- `/story-readiness` — Pre-implementation readiness check
- `/smoke-check` — Build health gate per sprint
- `/regression-suite` — Regression testing
- `/qa-plan` — QA test plan per epic/sprint
- `/bug-report` / `/bug-triage` — Bug logging and prioritization
- `/scope-check` — Detect scope creep
- `/sprint-status` — Quick sprint progress snapshot
- `/retrospective` — Post-sprint review

**Polish & Release**
- `/perf-profile` — CPU/GPU/memory profiling
- `/balance-check` — Game balance analysis
- `/asset-audit` — Naming, formats, size budgets
- `/playtest-report` — Structured playtest sessions
- `/security-audit` — Security review
- `/localize` — Localization QA
- `/release-checklist` — Pre-release validation
- `/launch-checklist` — Final launch readiness
- `/changelog` / `/patch-notes` — Internal and player-facing notes
- `/team-release` — Coordinated release deployment

**Team Orchestration** (multi-agent features)
- `/team-combat` — Combat feature coordination
- `/team-narrative` — Narrative feature coordination
- `/team-ui` — UI feature coordination
- `/team-audio` — Audio feature coordination
- `/team-level` — Level feature coordination
- `/team-live-ops` — Live ops coordination
- `/team-qa` — QA coordination
- `/team-polish` — Polish pass coordination
- `/team-release` — Release coordination

**Quality Gates**
- `/gate-check` — Phase gate verification (Concept→Systems Design→Technical Setup→Pre-Production→Production→Polish→Release)
- `/design-review` — Per-system design validation
- `/consistency-check` — Cross-GDD contradiction scan
- `/vertical-slice` — Build and validate a vertical slice
- `/prototype` — Throwaway prototype for mechanic validation

**Maintenance**
- `/settings` — View/change project settings (rigor, automation, etc.)
- `/skill-improve` — Improve a skill from usage feedback
- `/skill-test` — Test a skill against its contract

## Does it produce games, or documents?

A fair question, and the answer is a measurement rather than a sample project.
Four games were built from one brief at different `modes.rigor` levels and the
documents each wrote **before its first line of game code** were counted:

| `modes.rigor` | Docs before first line of game code | Time |
|---|---:|---:|
| `minimal` | **1** (the one-page brief) | 0 min |
| `standard` | 30 | 58 min |

All of them produced a running, tested game. Two blind reviewers and a human
playtest then ranked the `standard` build **last** — the extra 29 documents
bought traceability, not a better game.

### It runs the game and looks at it

The measurement above is about cost. The other half is whether the thing works,
and for a game that means someone has to *look* at it — a passing test says
nothing about a menu drawn off-screen. So a story that changes anything the
player sees is not closed until the game has been launched, observed, and a
screenshot retained in `production/qa/evidence/`. A parse check is not a run.
This holds at every rigor level, including `minimal`, where automated tests are
waived but the look is not.

The games themselves are deliberately **not** shipped here: this is a template
you clone to start your own project, and somebody else's game in your repo is
clutter, not evidence.

## Getting Started

### Prerequisites

- [Git](https://git-scm.com/)
- [Hermes Agent](https://hermes-agent.nousresearch.com/docs) — `curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash`
- [Python 3](https://www.python.org/) — reads `project.yaml` for every skill
- Bash — runs helper scripts; built into macOS and Linux, and on Windows it comes with [Git for Windows](https://git-scm.com/downloads/win)
- **Recommended**: [yq](https://github.com/mikefarah/yq/) (for config helpers), [jq](https://jqlang.github.io/jq/)

### Setup

1. **Clone or use as template**:
   ```bash
   git clone https://github.com/your-org/Hermes-Game-Studios.git my-game
   cd my-game
   ```

2. **Open Hermes Agent in the project's root folder** (the one holding
   `HERMES.md` and `project.yaml`) and start a session:
   ```bash
   hermes
   ```
   Starting it in a subfolder such as `src/` skips the project's configuration.

3. **Run `/start`** — the system asks where you are (no idea, vague concept,
   clear design, existing work) and guides you to the right workflow. No assumptions.

   Or jump directly to a specific skill if you already know what you need:
   - `/brainstorm` — explore game ideas from scratch
   - `/setup-engine godot 4.6` — configure your engine if you already know
   - `/project-stage-detect` — analyze an existing project

## Configuration

`project.yaml` at the repo root is the single source of truth for how the
studio behaves on your project — engine, naming conventions, and a `modes`
block that controls how much process every skill enforces. `/start` writes it
for you; you rarely need to hand-edit it.

The one question that matters most is **`modes.rigor`** — `minimal`, `standard`,
or `full`. It's a single front door over six separate knobs (`workflow` —
which GDD sections are required, `docs.density`, `qa.level`,
`story_granularity`, `review_mode` — how many director agents review your work,
and `team.size`), so `/start` asks it once instead of six times:

- **`minimal`** (default) — jam-game speed. No GDDs required, terse docs, minimal QA evidence, solo review. `/start` → `/setup-engine` → `/brainstorm` (a one-page brief) → `/create-stories` → `/dev-story` ↔ `/story-done`.
- **`standard`** — 5 required GDD sections, balanced doc depth, standard QA evidence, lean review.
- **`full`** — all 8 GDD sections, thorough docs, full QA evidence on every story type, full director review.

`minimal` is the default because the heavier tier costs more to reach working
code without producing a better result, and gives nothing back when someone new
picks the project up. Raise it in one `/settings` call when your project grows
— `/help` and `/gate-check` will suggest it when they see the signs.

Two escape hatches keep one setting from being a blunt instrument.
**`system_overrides`** holds a single system to a higher standard than the rest
of the project — your combat system gets the full treatment while everything
else stays light. **`testing.strict`** sets, per test type (logic, integration,
visual, UI, config), whether missing evidence blocks a story or merely warns.

Any of the six underlying knobs can still be set individually if you want a mix
(e.g. `workflow: full` with `docs.density: terse` — comprehensive but compact).
Two of them — `review_mode` (`full` / `lean` / `solo`) and `team.size` — are
also **personal**: rigor sets the team-wide default, but you can override them
per-developer in a gitignored `project.local.yaml` without touching the shared
config. `modes.automation` (how often the AI pauses to ask before it acts) sits
outside rigor and is likewise personally overridable.

View or change any setting with the `/settings` skill:

```
/settings                              # view effective config
/settings modes.review_mode            # view one setting
/settings modes.rigor=full             # write to project.yaml (team-wide)
/settings --local modes.review_mode=solo   # write to project.local.yaml (just you)
```

Full schema and per-setting behavior: `.hermes/docs/settings-guidance.md`.

## Project Structure

```
my-game/
├── HERMES.md                    # Master configuration
├── project.yaml                 # Machine-readable project config (engine, modes, stage)
├── project.yaml.example         # Template for new projects
├── .hermes/                     # Agents, skills, hooks, rules, docs, scripts
├── src/                         # Game source code (Godot)
│   # OR Assets/ for Unity
│   # OR Source/<Module>/ for Unreal
├── assets/                      # Game assets (art, audio, vfx, shaders, data)
├── design/                      # Game design documents (gdd, narrative, levels, balance)
│   ├── gdd/                     # Game Design Documents
│   ├── art/                     # Art bible, style guides
│   ├── ux/                      # UX specs, interaction patterns
│   ├── assets/                  # Asset specs, entity inventory
│   └── accessibility-requirements.md
├── docs/                        # Technical documentation
│   ├── architecture/            # Architecture docs, ADRs, control manifest
│   └── engine-reference/        # Curated engine API snapshots
├── tests/                       # Test suites (unit, integration, performance, playtest)
├── tools/                       # Build and pipeline tools
├── prototypes/                  # Throwaway prototypes (isolated from src/)
├── production/                  # Production management
│   ├── session-state/           # Ephemeral session state (active.md — gitignored)
│   ├── session-logs/            # Session audit trail (gitignored)
│   ├── sprints/                 # Sprint plans
│   ├── epics/                   # Epic definitions and stories
│   ├── qa/                      # QA evidence, playtests, smoke checks
│   ├── security/                # Security audit reports
│   └── milestones/              # Milestone definitions
└── studio-tests/                # QA for the skills/agents themselves
```

### Testing your customizations

HGS is a template you are meant to edit. `studio-tests/` is how
you check that an edited or newly written skill still holds up — a catalog of all
72 skills and 49 agents, per-category quality rubrics, behavioral specs, and
templates for writing specs of your own.

```
/skill-test static [name]     # structural linter — 7 compliance checks
/skill-test category [name]   # category-specific quality rubric
/skill-test spec [name]       # behavioral spec assertions
/skill-test audit             # coverage report across skills and agents
/skill-improve [name]         # test-fix-retest loop; keeps or reverts on score change
```

It tests the *framework*, never your game — game tests live in `tests/`.

## How It Works

### Agent Coordination

Agents follow a structured delegation model:

1. **Vertical delegation** — directors delegate to leads, leads delegate to specialists
2. **Horizontal consultation** — same-tier agents can consult each other but can't make binding cross-domain decisions
3. **Conflict resolution** — disagreements escalate up to the shared parent (`creative-director` for design, `technical-director` for technical)
4. **Change propagation** — cross-department changes are coordinated by `producer`
5. **Domain boundaries** — agents don't modify files outside their domain without explicit delegation

### Collaborative, Not Autonomous

This is **not** an auto-pilot system. Every agent follows a strict collaboration protocol:

1. **Ask** — agents ask questions before proposing solutions
2. **Present options** — agents show 2-4 options with pros/cons
3. **You decide** — the user always makes the call
4. **Draft** — agents show work before finalizing
5. **Approve** — nothing gets written without your sign-off

You stay in control. The agents provide structure and expertise, not autonomy.

### File-Backed State

**The file is the memory, not the conversation.** Conversations are ephemeral and
will be compacted or lost. Files on disk persist across compactions and session crashes.

- `production/session-state/active.md` — session checkpoint (read first after any compaction/crash)
- `.hermes/scripts/` — deterministic helpers that emit observations, not verdicts
- Subagents for research/exploration to keep main session clean

### Automated Safety

Hooks run on session events (start, stop, pre/post tool use, compaction):
- `session-start.sh` — restores context from `active.md`
- `validate-commit.sh` / `validate-push.sh` — git safety
- `validate-read.sh` / `validate-write.sh` — file operation guards
- `validate-assets.sh` — asset data validation
- `log-agent.sh` / `log-agent-stop.sh` — agent audit trail

## Design Philosophy

This template is grounded in professional game development practices:

- **MDA Framework** — Mechanics, Dynamics, Aesthetics analysis for game design
- **Self-Determination Theory** — Autonomy, Competence, Relatedness for player motivation
- **Flow State Design** — Challenge-skill balance for player engagement
- **Bartle Player Types** — Audience targeting and validation
- **Verification-Driven Development** — Tests first, then implementation

## Customization

This is a **template**, not a locked framework. Everything is meant to be customized:

- **Add/remove agents** — delete agent files you don't need, add new ones for your domains
- **Edit agent prompts** — tune agent behavior, add project-specific knowledge
- **Modify skills** — adjust workflows to match your team's process
- **Add rules** — create new path-scoped rules for your project's directory structure
- **Tune hooks** — adjust validation strictness, add new checks
- **Pick your engine** — use the Godot, Unity, or Unreal agent set (or none)
- **Tune process weight** — `modes.rigor` and its underlying knobs in `project.yaml` (see [Configuration](#configuration)). Override per-run with `--review solo` on any skill.

## Platform Support

| Platform | Status |
|----------|--------|
| Linux | ✅ Full support |
| macOS | ✅ Full support |
| Windows (WSL2) | ✅ Full support |
| Windows (native) | ⚠️ Path differences, see `.hermes/docs/windows-quirks.md` |

## Community

- **GitHub Discussions** — Questions, ideas, show & tell
- **Issues** — Bug reports, feature requests
- **Contributing** — PRs welcome for new agents, skills, templates, fixes

---

## Supporting This Project

Hermes Game Studios is free and open source. If it saves you time or helps you ship your game, consider supporting continued development:

<p>
  <a href="https://www.buymeacoffee.com/donchitos3"><img src="https://img.shields.io/badge/Buy%20Me%20a%20Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black" alt="Buy Me a Coffee"></a>
  &nbsp;
  <a href="https://github.com/sponsors/Donchitos"><img src="https://img.shields.io/badge/GitHub%20Sponsors-ea4aaa?style=for-the-badge&logo=githubsponsors&logoColor=white" alt="GitHub Sponsors"></a>
</p>

- **[Buy Me a Coffee](https://www.buymeacoffee.com/donchitos3)** — one-time support
- **[GitHub Sponsors](https://github.com/sponsors/Donchitos)** — recurring support through GitHub

Sponsorships help fund time spent maintaining skills, adding new agents, keeping up with Hermes Agent and engine API changes, and responding to community issues.

---

*Built for Hermes Agent. Maintained and extended — contributions welcome via GitHub Discussions.*

## License

MIT License. See [LICENSE](LICENSE) for details.
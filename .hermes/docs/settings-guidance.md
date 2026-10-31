# Settings Guidance

Reference for `/settings`, `/start`, and any skill that reads or writes
`project.yaml` knobs.

## Knob Reference

| Key | Type | Values | Default | Controls |
|---|---|---|---|---|
| `modes.rigor` | enum | `minimal`, `standard`, `full` | `minimal` | How much design/architecture/evidence is required before code. Expands to 6 other knobs (see Rigor Expansion). |
| `modes.automation` | enum | `guided`, `collaborative`, `autonomous` | `guided` | How much skills confirm before acting. See `automation-modes.md`. |
| `modes.review_mode` | enum | `solo`, `lean`, `full` | derived | How design reviews run. `minimal`→`solo`, `standard`→`lean`, `full`→`full`. Overrideable. |
| `modes.workflow` | enum | `minimal`, `standard`, `full` | derived | GDD/ADR requirements. Mirrors rigor by default. Overrideable. |
| `docs.density` | enum | `sparse`, `normal`, `dense` | derived | Verbosity of generated docs. `minimal`→`sparse`, `standard`→`normal`, `full`→`dense`. |
| `qa.level` | enum | `minimal`, `standard`, `full` | derived | Test evidence requirements. `minimal`→`minimal`, `standard`→`standard`, `full`→`full`. |
| `modes.story_granularity` | enum | `coarse`, `standard`, `fine` | derived | Story size. `minimal`→`coarse`, `standard`→`standard`, `full`→`fine`. |
| `team.size` | enum | `solo`, `small`, `medium`, `large` | `solo` | Team size for sprint planning, review assignments, parallel tracks. |

## Rigor Expansion

When `modes.rigor` is written, the helper expands it to the six derived knobs
above **only if they are not already set**. A written value pins that knob over
the rigor expansion, and a mirror file outranks both.

Example: User sets `modes.rigor: full` but previously ran `/settings` and set
`qa.level: standard`. The `qa.level` stays `standard` — the user's explicit
choice wins.

## Signals for Inferring Rigor (used by `/start` Phase 4)

| The user's words mention | Rigor |
|---|---|
| open world, RPG, sim, sandbox, factions, crafting, economy, MMO, multiplayer, many systems | `full` |
| release, commercial, Steam, one clear core loop | `standard` |
| jam, weekend, prototype, first game, small, just trying | `minimal` |
| nothing above, or no idea yet | `minimal` (the default) |

A path B hint is still a description: "some kind of open-world survival sim" is
`full`.

## Stage Reference

| Stage | Description | Typical Rigor |
|---|---|---|
| `Concept` | No engine, or nothing beyond a concept | Any |
| `Systems Design` | 1+ GDDs, 0 ADRs | `standard`+`full` |
| `Technical Setup` | 1+ ADRs | `standard`+`full` |
| `Pre-Production` | Architecture done, UX specs, prototypes | `standard`+`full` |
| `Production` | Sprint-based feature development | `standard`+`full` |
| `Polish` | Performance, balance, playtesting | `standard`+`full` |
| `Release` | Launch prep, certification | `standard`+`full` |

`minimal` projects never leave `Concept` stage — they skip `/gate-check` entirely.

## Engine Reference

| Engine | Code Root | Language Options | Version Format |
|---|---|---|---|
| `Godot` | `src/` | `GDScript`, `C#` | `4.x` |
| `Unity` | `Assets/` | `C#` | `2022.x`, `6.x` |
| `Unreal` | `Source/<Module>/` | `C++`, `Blueprint` | `5.x` |

`/setup-engine` writes `project.engine` block and the specialist mapping.
# Config Resolution

Single source of truth: **`project.yaml` at repo root**.

All skills that need project config must read it via the helpers below, not by
parsing the file directly. The helpers handle fallbacks, type coercion, and
provenance tracking.

## Resolution Order

For any config key, the effective value is the first one found in this order:

1. **`project.yaml`** — written by skills (`/setup-engine`, `/settings`, `/config-set.sh`)
2. **`.hermes/docs/technical-preferences.md`** — legacy fallback, read on demand
3. **Hardcoded defaults** — documented in each skill, used only when both above are absent

## Reading Config (Bash Helpers)

```bash
# Get a single value (prints empty string if absent)
bash .hermes/scripts/config-get.sh modes.rigor

# Get with default
bash .hermes/scripts/config-get.sh modes.rigor minimal

# Get all config as JSON (for programmatic use)
bash .hermes/scripts/config-get.sh --json
```

Output format (single key):
```
value|source
# e.g.: standard|project.yaml
```

Sources: `project.yaml`, `technical-preferences.md`, `default`.

## Reading Config (Python)

```python
from hermes_tools import resolve_config

# Returns (value, source) — source is one of: project.yaml, technical-preferences.md, default
rigor, src = resolve_config("modes.rigor")
```

## Writing Config

Only these helpers may write `project.yaml`:

- `bash .hermes/scripts/config-set.sh <key> <value>` — single key
- `bash .hermes/scripts/config-set.sh --batch key1=val1 key2=val2 ...` — multiple

They handle:
- YAML formatting (quotes, lists, nested maps)
- Type inference (bool, int, float, string)
- Provenance: every written key gets a `_provenance` sibling in a sidecar
- Mirror files: `project.stage` → `production/stage.txt`, `modes.rigor` → legacy mirror

**Skills must not write `project.yaml` directly.** If a skill needs to persist a
value, call the helper and confirm the write with the user first.

## Key Schema

```yaml
project:
  name: string
  stage: Concept | Systems Design | Technical Setup | Pre-Production | Production | Polish | Release
  engine:
    name: Godot | Unity | Unreal
    version: string
    language: GDScript | C# | C++ | Blueprint
  code_root: string              # resolved from engine.name
  specialists:                   # written by /setup-engine
    gameplay: string
    engine: string
    graphics: string
    audio: string
    network: string
    ui: string
    tools: string

modes:
  rigor: minimal | standard | full
  automation: guided | collaborative | autonomous
  review_mode: solo | lean | full      # derived from rigor, overrideable
  workflow: minimal | standard | full  # derived from rigor, overrideable
  story_granularity: coarse | standard | fine
  team_size: solo | small | medium | large

docs:
  density: sparse | normal | dense

qa:
  level: minimal | standard | full

testing:
  strict:
    logic: true | false
    integration: true | false
    visual: true | false
    ui: true | false
    config: true | false

performance:
  cpu_budget_ms: number
  gpu_budget_ms: number
  memory_budget_mb: number

platforms:
  - Windows
  - Linux
  - macOS
  # ... etc
```

## Provenance Sidecar

Every key written to `project.yaml` gets an entry in `.hermes/config-provenance.json`:

```json
{
  "modes.rigor": {
    "source": "user",
    "skill": "start",
    "timestamp": "2026-01-15T14:32:11Z",
    "previous": "minimal"
  }
}
```

Skills that need to know *why* a value is set (e.g., `/settings` comparing
configured rigor vs. observed practice) read this sidecar.

## Legacy Mirrors

| project.yaml key | Mirror file | Direction |
|---|---|---|
| `project.stage` | `production/stage.txt` | yaml → mirror (skills write yaml, hook syncs mirror) |
| `engine.name` | `.hermes/docs/technical-preferences.md` | yaml → mirror (only **Engine** line) |

Mirrors are **read-only fallbacks**. If `project.yaml` has the key, the mirror is
ignored. Mirrors exist only for pre-`project.yaml` projects and for hooks that
haven't been migrated.

## Validation

Run `bash .hermes/scripts/config-validate.sh` to check:
- Required keys present for current stage
- No unknown keys
- Type consistency
- Engine/code_root agreement

`/setup-engine` and `/settings` run this automatically after writes.
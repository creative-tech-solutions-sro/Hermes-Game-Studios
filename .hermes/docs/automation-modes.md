# Automation Modes

`modes.automation` in `project.yaml` controls how much the skills confirm with the
user before acting. It does **not** change what skills are allowed to do — every
skill runs at any mode; the mode only changes the confirmation cadence.

## Modes

| Mode | Value | Behavior |
|---|---|---|
| **Guided** | `guided` | Skill decides small things (formatting, internal refactors, helper scripts) and stops for big ones: scope changes, deletions, schema changes, new files outside the named output path, commits. Default for most solo devs. |
| **Collaborative** | `collaborative` | Skill asks before each significant step and shows drafts before writing. Every file write, every structural decision, every agent spawn gets explicit consent. Slower, more control. |
| **Autonomous** | `autonomous` | Skill proceeds and logs decisions, stopping only for the **always-ask** categories below. Fastest, most tokens. Use when you trust the pipeline and want velocity. |

## Always-Ask Categories (all modes)

Regardless of `modes.automation`, skills **must** ask before:

1. **Deleting files or directories** — `rm`, `rm -rf`, `git clean -f`, etc.
2. **Schema changes** — modifying `project.yaml` structure, adding required fields, changing ADR format, GDD section schema.
3. **Scope changes** — adding/removing epics, stories, or features not in the current sprint plan.
4. **Commits and pushes** — no automatic commits; user always instructs.
5. **Cross-domain writes** — an agent writing outside its designated directories (requires delegation).
6. **External side effects** — opening PRs, filing issues, posting to Discord/Slack, deploying, publishing.
7. **Model tier escalation** — when a skill would invoke an `opus` agent in a `sonnet` session (cost impact).
8. **Breaking changes** — renaming public APIs, changing data formats, removing config keys.

## Mode Transitions

Change anytime with `/settings` or:

```bash
bash .hermes/scripts/config-set.sh modes.automation collaborative
```

The change takes effect immediately for the next skill invocation.

## Skill Authoring: Respecting Automation Mode

Every skill that writes files or spawns agents must check `modes.automation`:

```bash
AUTOMATION=$(bash .hermes/scripts/config-get.sh modes.automation | cut -d'|' -f1)
```

Then branch:

```bash
if [[ "$AUTOMATION" == "autonomous" ]]; then
  # Proceed, log decision to active.md
else
  # Ask / show draft / wait for approval
fi
```

**Exception — orchestrated runs.** If a skill spawns a subagent and *names the
destination path* in the spawn prompt, the subagent may write that path without
a separate approval — the user approved the destination when they approved the
phase. This holds **only** for a new artifact under `production/`, `docs/` or
`tests/`; never an edit to existing source or config, and never a path the
subagent chose itself.

## Mode vs. Rigor

| | `minimal` | `standard` | `full` |
|---|---|---|---|
| **Default automation** | `guided` | `guided` | `collaborative` |
| **What changes** | Fewer docs, coarser stories, tests optional | Standard docs, standard QA | All docs, validation builds, evidence everywhere |

Rigor and automation are independent. A `full` rigor project can run
`autonomous` if the user wants velocity; a `minimal` project can run
`collaborative` if the user wants control. `/start` suggests the default pair
but the user chooses both.
#!/usr/bin/env bash
# config-validate.sh — Validate project.yaml structure and required keys

set -euo pipefail

PROJECT_YAML="project.yaml"

if [[ ! -f "$PROJECT_YAML" ]]; then
  echo "Error: $PROJECT_YAML not found"
  exit 1
fi

if ! command -v yq >/dev/null 2>&1; then
  echo "Warning: yq not installed, skipping validation"
  exit 0
fi

errors=0
warnings=0

# Required keys for all stages
required_keys=(
  "project.name"
  "project.stage"
  "modes.rigor"
  "modes.automation"
)

for key in "${required_keys[@]}"; do
  value=$(yq -r ".$key // \"\"" "$PROJECT_YAML")
  if [[ -z "$value" || "$value" == "null" ]]; then
    echo "ERROR: Missing required key: $key"
    ((errors++))
  fi
done

# Stage-specific requirements
stage=$(yq -r ".project.stage // \"\"" "$PROJECT_YAML")
engine_name=$(yq -r ".project.engine.name // \"\"" "$PROJECT_YAML")

case "$stage" in
  "Systems Design"|"Technical Setup"|"Pre-Production"|"Production"|"Polish"|"Release")
    if [[ -z "$engine_name" || "$engine_name" == "null" ]]; then
      echo "ERROR: Stage '$stage' requires engine to be configured"
      ((errors++))
    fi
    ;;
esac

# Engine-specific: code_root must match
if [[ -n "$engine_name" && "$engine_name" != "null" ]]; then
  expected_root=""
  case "$engine_name" in
    Godot) expected_root="src/" ;;
    Unity) expected_root="Assets/" ;;
    Unreal) expected_root="Source/" ;;
  esac
  actual_root=$(yq -r ".project.code_root // \"\"" "$PROJECT_YAML")
  if [[ -n "$expected_root" && "$actual_root" != "$expected_root" ]]; then
    echo "WARNING: code_root ($actual_root) doesn't match engine $engine_name (expected $expected_root)"
    ((warnings++))
  fi
fi

# Rigor-derived keys check
rigor=$(yq -r ".modes.rigor // \"\"" "$PROJECT_YAML")
derived_keys=(
  "modes.review_mode"
  "modes.workflow"
  "docs.density"
  "qa.level"
  "modes.story_granularity"
  "team.size"
)

for key in "${derived_keys[@]}"; do
  value=$(yq -r ".$key // \"\"" "$PROJECT_YAML")
  if [[ -z "$value" || "$value" == "null" ]]; then
    echo "INFO: Derived key not set (will use rigor default): $key"
  fi
done

# Validate rigor value
if [[ "$rigor" != "minimal" && "$rigor" != "standard" && "$rigor" != "full" ]]; then
  echo "ERROR: Invalid rigor value: $rigor (must be minimal, standard, or full)"
  ((errors++))
fi

# Validate automation value
automation=$(yq -r ".modes.automation // \"\"" "$PROJECT_YAML")
if [[ "$automation" != "guided" && "$automation" != "collaborative" && "$automation" != "autonomous" ]]; then
  echo "ERROR: Invalid automation value: $automation (must be guided, collaborative, or autonomous)"
  ((errors++))
fi

if [[ $errors -gt 0 ]]; then
  echo "Validation failed with $errors error(s) and $warnings warning(s)"
  exit 1
elif [[ $warnings -gt 0 ]]; then
  echo "Validation passed with $warnings warning(s)"
  exit 0
else
  echo "Validation passed"
  exit 0
fi
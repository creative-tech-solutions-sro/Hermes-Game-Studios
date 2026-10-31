#!/usr/bin/env bash
# config-set.sh — Set a value in project.yaml
# Usage: config-set.sh <key> <value>  OR  config-set.sh --batch key1=val1 key2=val2 ...

set -euo pipefail

PROJECT_YAML="project.yaml"
PROVENANCE=".hermes/config-provenance.json"

if [[ ! -f "$PROJECT_YAML" ]]; then
  echo "Error: $PROJECT_YAML not found" >&2
  exit 1
fi

if ! command -v yq >/dev/null 2>&1; then
  echo "Error: yq is required but not installed" >&2
  exit 1
fi

# Ensure provenance file exists
if [[ ! -f "$PROVENANCE" ]]; then
  echo "{}" > "$PROVENANCE"
fi

set_key() {
  local key="$1"
  local value="$2"
  local previous

  # Get previous value for provenance
  previous=$(yq -r ".$key // \"\"" "$PROJECT_YAML" 2>/dev/null || echo "")

  # Write the value
  yq -i ".$key = \"$value\"" "$PROJECT_YAML"

  # Update provenance
  local timestamp
  timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  local skill="${HERMES_SKILL:-manual}"
  local source="user"

  yq -i ".\"$key\" = {\"source\": \"$source\", \"skill\": \"$skill\", \"timestamp\": \"$timestamp\", \"previous\": \"$previous\"}" "$PROVENANCE"

  echo "Set $key = $value (was: ${previous:-<none>})"
}

if [[ "${1:-}" == "--batch" ]]; then
  shift
  for pair in "$@"; do
    key="${pair%%=*}"
    value="${pair#*=}"
    set_key "$key" "$value"
  done
else
  if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <key> <value>  OR  $0 --batch key1=val1 key2=val2 ..." >&2
    exit 1
  fi
  set_key "$1" "$2"
fi

# Validate
bash .hermes/scripts/config-validate.sh
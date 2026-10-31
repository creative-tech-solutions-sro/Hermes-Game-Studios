#!/usr/bin/env bash
# config-get.sh — Get a value from project.yaml with fallback to technical-preferences.md
# Usage: config-get.sh <key> [default]
# Output: value|source

set -euo pipefail

KEY="${1:-}"
DEFAULT="${2:-}"

if [[ -z "$KEY" ]]; then
  echo "Usage: $0 <key> [default]" >&2
  exit 1
fi

PROJECT_YAML="project.yaml"
TECH_PREFS=".hermes/docs/technical-preferences.md"

# Try project.yaml first (using yq if available, otherwise grep/sed)
get_from_yaml() {
  local key="$1"
  if command -v yq >/dev/null 2>&1; then
    yq -r ".$key // \"\"" "$PROJECT_YAML" 2>/dev/null || echo ""
  else
    # Simple fallback for flat keys only
    grep -E "^\s*${key//./\.\s*}:" "$PROJECT_YAML" 2>/dev/null | head -1 | sed 's/.*: *//' | sed 's/^"//;s/"$//' || echo ""
  fi
}

# Try technical-preferences.md (legacy)
get_from_tech_prefs() {
  local key="$1"
  case "$key" in
    project.engine.name)
      grep -E '^\*\*Engine\*\*:' "$TECH_PREFS" 2>/dev/null | sed 's/.*: *//' | sed 's/\[TO BE CONFIGURED\]//' | xargs || echo ""
      ;;
    project.engine.version)
      grep -E '^\*\*Engine\*\*:' "$TECH_PREFS" 2>/dev/null | grep -oE '[0-9]+\.[0-9]+' | head -1 || echo ""
      ;;
    project.engine.language)
      grep -E '^\*\*Language\*\*:' "$TECH_PREFS" 2>/dev/null | sed 's/.*: *//' | sed 's/\[TO BE CONFIGURED\]//' | xargs || echo ""
      ;;
    modes.rigor)
      grep -E '^\*\*Rigor\*\*:' "$TECH_PREFS" 2>/dev/null | sed 's/.*: *//' | sed 's/\[TO BE CONFIGURED\]//' | xargs || echo ""
      ;;
    *)
      echo ""
      ;;
  esac
}

value=$(get_from_yaml "$KEY")
source="project.yaml"

if [[ -z "$value" ]]; then
  value=$(get_from_tech_prefs "$KEY")
  source="technical-preferences.md"
fi

if [[ -z "$value" && -n "$DEFAULT" ]]; then
  value="$DEFAULT"
  source="default"
fi

echo "${value}|${source}"
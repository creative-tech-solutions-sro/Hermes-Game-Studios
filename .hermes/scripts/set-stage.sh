#!/usr/bin/env bash
# set-stage.sh — Set project stage in project.yaml and mirror to production/stage.txt
# Usage: set-stage.sh <stage>

set -euo pipefail

STAGE="${1:-}"

if [[ -z "$STAGE" ]]; then
  echo "Usage: $0 <stage>" >&2
  echo "Valid stages: Concept, Systems Design, Technical Setup, Pre-Production, Production, Polish, Release" >&2
  exit 1
fi

VALID_STAGES=("Concept" "Systems Design" "Technical Setup" "Pre-Production" "Production" "Polish" "Release")
valid=false
for s in "${VALID_STAGES[@]}"; do
  if [[ "$s" == "$STAGE" ]]; then
    valid=true
    break
  fi
done

if [[ "$valid" == "false" ]]; then
  echo "Error: Invalid stage '$STAGE'" >&2
  exit 1
fi

# Write to project.yaml
bash .hermes/scripts/config-set.sh project.stage "$STAGE"

# Mirror to production/stage.txt
mkdir -p production
echo "$STAGE" > production/stage.txt

echo "Stage set to: $STAGE"
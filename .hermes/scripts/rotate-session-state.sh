#!/usr/bin/env bash
# rotate-session-state.sh — Rotate the narrative portion of active.md to session-logs
# Usage: rotate-session-state.sh [--dry-run]

set -euo pipefail

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
fi

ACTIVE="production/session-state/active.md"
LOGS_DIR="production/session-logs"

if [[ ! -f "$ACTIVE" ]]; then
  echo "No active.md found"
  exit 0
fi

# Count lines after CHECKPOINT
checkpoint_end=$(grep -n '<!-- /CHECKPOINT -->' "$ACTIVE" | cut -d: -f1)
if [[ -z "$checkpoint_end" ]]; then
  echo "No CHECKPOINT marker found"
  exit 1
fi

total_lines=$(wc -l < "$ACTIVE")
narrative_lines=$((total_lines - checkpoint_end))

if [[ $narrative_lines -lt 200 ]]; then
  echo "Narrative is $narrative_lines lines (threshold: 200), no rotation needed"
  exit 0
fi

# Create logs dir
mkdir -p "$LOGS_DIR"

# Generate log filename
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
log_file="$LOGS_DIR/session-$timestamp.md"

if [[ "$DRY_RUN" == "true" ]]; then
  echo "Would rotate $narrative_lines lines to $log_file"
  echo "Checkpoint (lines 1-$checkpoint_end) would remain in active.md"
  exit 0
fi

# Extract narrative (everything after CHECKPOINT)
tail -n "+$((checkpoint_end + 1))" "$ACTIVE" > "$log_file"

# Truncate active.md to just the CHECKPOINT section
head -n "$checkpoint_end" "$ACTIVE" > "$ACTIVE.tmp"
mv "$ACTIVE.tmp" "$ACTIVE"

echo "Rotated $narrative_lines lines to $log_file"
#!/usr/bin/env bash
# project-state.sh — Report current project state for /start and other skills
# Output: TSV rows (key<TAB>value)

set -euo pipefail

# Helper: check if file exists and is non-empty
file_exists() {
  [[ -f "$1" && -s "$1" ]]
}

# Helper: count files matching glob
count_files() {
  local pattern="$1"
  local count=0
  shopt -s nullglob
  for f in $pattern; do
    [[ -f "$f" ]] && ((count++))
  done
  shopt -u nullglob
  echo "$count"
}

# Engine
engine_name=""
engine_version=""
if [[ -f "project.yaml" ]]; then
  engine_name=$(bash .hermes/scripts/config-get.sh project.engine.name | cut -d'|' -f1)
  engine_version=$(bash .hermes/scripts/config-get.sh project.engine.version | cut -d'|' -f1)
fi

# Code root and source files
code_root=""
source_files="0"
if [[ -n "$engine_name" ]]; then
  case "$engine_name" in
    Godot) code_root="src/" ;;
    Unity) code_root="Assets/" ;;
    Unreal) code_root="Source/" ;;
  esac
  if [[ -d "$code_root" ]]; then
    source_files=$(find "$code_root" -type f \( -name "*.gd" -o -name "*.cs" -o -name "*.cpp" -o -name "*.h" -o -name "*.uasset" -o -name "*.umap" \) 2>/dev/null | wc -l)
  else
    source_files="unknown"
  fi
else
  code_root="unknown"
  source_files="unknown"
fi

# Concept
concept="false"
if file_exists "design/gdd/game-concept.md" || file_exists "design/game-brief.md"; then
  concept="true"
fi

# GDD files
gdd_files=$(count_files "design/gdd/*.md")

# ADRs
adr=$(count_files "docs/architecture/adr-*.md")

# Prototypes
prototype="false"
if [[ -d "prototypes" ]] && [[ -n "$(ls -A prototypes 2>/dev/null)" ]]; then
  prototype="true"
fi

# Sprints
sprint="false"
if [[ -d "production/sprints" ]] && [[ -n "$(ls -A production/sprints 2>/dev/null)" ]]; then
  sprint="true"
fi

# Milestones
milestone="false"
if [[ -d "production/milestones" ]] && [[ -n "$(ls -A production/milestones 2>/dev/null)" ]]; then
  milestone="true"
fi

# Stories
story="false"
if [[ -d "production/epics" ]] && [[ -n "$(find production/epics -name "story-*.md" 2>/dev/null | head -1)" ]]; then
  story="true"
fi

# Origin URL
origin_url=""
if git remote get-url origin >/dev/null 2>&1; then
  origin_url=$(git remote get-url origin)
fi

# Stage
stage=""
if [[ -f "project.yaml" ]]; then
  stage=$(bash .hermes/scripts/config-get.sh project.stage | cut -d'|' -f1)
fi
if [[ -z "$stage" && -f "production/stage.txt" ]]; then
  stage=$(cat production/stage.txt)
fi

# Phase inferred (from file counts)
phase_inferred="Concept"
if [[ "$source_files" != "unknown" && "$source_files" -gt 0 && "$gdd_files" -eq 0 ]]; then
  phase_inferred="Code Only"
elif [[ "$gdd_files" -ge 1 && "$adr" -eq 0 ]]; then
  phase_inferred="Systems Design"
elif [[ "$adr" -ge 1 ]]; then
  phase_inferred="Technical Setup"
fi

# Rigor and automation (from project.yaml)
rigor=""
automation=""
if [[ -f "project.yaml" ]]; then
  rigor=$(bash .hermes/scripts/config-get.sh modes.rigor | cut -d'|' -f1)
  automation=$(bash .hermes/scripts/config-get.sh modes.automation | cut -d'|' -f1)
fi

# Output TSV
printf "engine\t%s\n" "$engine_name"
printf "engine_version\t%s\n" "$engine_version"
printf "code_root\t%s\n" "$code_root"
printf "source_files\t%s\n" "$source_files"
printf "concept\t%s\n" "$concept"
printf "gdd_files\t%s\n" "$gdd_files"
printf "adr\t%s\n" "$adr"
printf "prototype\t%s\n" "$prototype"
printf "sprint\t%s\n" "$sprint"
printf "milestone\t%s\n" "$milestone"
printf "story\t%s\n" "$story"
printf "origin_url\t%s\n" "$origin_url"
printf "stage\t%s\n" "$stage"
printf "phase_inferred\t%s\n" "$phase_inferred"
printf "rigor\t%s\n" "$rigor"
printf "automation\t%s\n" "$automation"
#!/bin/zsh
set -eu

readonly ROOT="${0:A:h:h:h}"
readonly SOURCES="$ROOT/Packages/FitnessAICore/Sources"

if rg -n '\b(CREATE TABLE|DatabaseMigrator|create\(table:|HKHealthStore|WCSession|CMMotionManager|URLSession|API[_-]?KEY)\b' "$SOURCES"; then
  print -u2 "Speculative schema, integration, or secret-like content found"
  exit 1
fi

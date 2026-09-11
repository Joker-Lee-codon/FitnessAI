#!/bin/zsh
set -eu

readonly ROOT="${0:A:h:h:h}"
readonly PACKAGE="$ROOT/Packages/FitnessAICore"
readonly FORBIDDEN='^(import|@testable import) (SwiftUI|GRDB|HealthKit|WatchConnectivity|CoreMotion|Application|OpenAI|Anthropic|GoogleGenerativeAI)([[:space:]]|$)'

[[ ! -d "$PACKAGE/Sources/Utils" ]] || { print -u2 "Generic Utils target is forbidden"; exit 1; }
for target in Contracts Domain PersistencePorts SyncContracts SafetyRules Analysis; do
  [[ -d "$PACKAGE/Sources/$target" ]] || { print -u2 "Missing boundary target: $target"; exit 1; }
  if grep -ERn "$FORBIDDEN" "$PACKAGE/Sources/$target"; then
    print -u2 "Forbidden outward import in $target"
    exit 1
  fi
done

grdb_imports="$(grep -ERl '^import GRDB([[:space:]]|$)' "$PACKAGE/Sources" || true)"
[[ "$grdb_imports" == "$PACKAGE/Sources/PersistenceGRDB/GRDBAdapterSeed.swift" ]] || {
  print -u2 "GRDB must be isolated to PersistenceGRDB"; exit 1
}

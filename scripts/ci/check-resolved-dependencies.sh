#!/bin/zsh
set -eu

readonly ROOT="${0:A:h:h:h}"
readonly LOCK="$ROOT/FitnessAI.xcworkspace/xcshareddata/swiftpm/Package.resolved"

[[ -f "$LOCK" ]] || { print -u2 "Missing workspace Package.resolved"; exit 1; }
/usr/bin/plutil -extract pins json -o - "$LOCK" 2>/dev/null | \
  /usr/bin/python3 -c 'import json,sys; p=json.load(sys.stdin); assert any(x.get("identity")=="grdb.swift" and x.get("state",{}).get("version")=="7.11.1" for x in p)'

#!/bin/zsh
set -eu

readonly ROOT="${0:A:h:h:h}"
for check in compile domain schema safety persistence sync ai-contract secret; do
  print -- "==> $check"
  "$ROOT/scripts/ci/run-check.sh" "$check"
done

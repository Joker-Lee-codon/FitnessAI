#!/bin/zsh
set -eu

readonly ROOT="${0:A:h:h:h}"
cd "$ROOT"

readonly SECRET_PATTERN='(BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY|AIza[0-9A-Za-z_-]{20,}|sk-(proj-)?[A-Za-z0-9]{20,}|gh[opsu]_[A-Za-z0-9]{20,})'

git grep -n -I -E "$SECRET_PATTERN" -- . \
  ':(exclude)**/Package.resolved' \
  ':(exclude)scripts/ci/check-secrets.sh' && {
    print -u2 "Potential secret found"
    exit 1
  }
exit 0

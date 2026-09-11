#!/bin/zsh
set -eu

readonly ROOT="${0:A:h:h:h}"
cd "$ROOT"

tracked="$(git ls-files)"
[[ -n "$tracked" ]] || tracked="$(find . -type f -not -path './.git/*' -not -path './.build/*' -not -path './DerivedData/*')"
print -r -- "$tracked" | rg -v '(^|/)(Package\.resolved|check-secrets\.sh)$' | \
  xargs rg -n -I '(BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY|AIza[0-9A-Za-z_-]{20,}|sk-(proj-)?[A-Za-z0-9]{20,}|gh[opsu]_[A-Za-z0-9]{20,})' && {
    print -u2 "Potential secret found"
    exit 1
  }
exit 0

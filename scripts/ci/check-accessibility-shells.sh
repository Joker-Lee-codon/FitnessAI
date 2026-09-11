#!/bin/zsh
set -eu

readonly ROOT="${0:A:h:h:h}"
readonly IPHONE="$ROOT/Apps/iPhone"
readonly WATCH="$ROOT/Apps/Watch"

for catalog in "$IPHONE/Assets.xcassets" "$WATCH/Assets.xcassets"; do
  for token in BackgroundCanvas TextPrimary TextSecondary ActionPrimary; do
    [[ -f "$catalog/$token.colorset/Contents.json" ]] || { print -u2 "Missing semantic token $token"; exit 1; }
    rg -q '"luminosity"' "$catalog/$token.colorset/Contents.json" || { print -u2 "Token $token lacks Dark Mode variant"; exit 1; }
  done
done

rg -q 'iphone\.root\.tabs' "$IPHONE/IPhoneRootView.swift"
rg -q 'iphone\.truthful-empty-state' "$IPHONE/IPhoneRootView.swift"
rg -q 'watch\.no-delivered-plan' "$WATCH/WatchRootView.swift"
rg -q 'accessibilityLabel\("No Plan delivered\.' "$WATCH/WatchRootView.swift"
rg -q 'font\(\.(headline|footnote|title2)\)' "$WATCH/WatchRootView.swift"

if rg -n '\.(gesture|digitalCrownRotation|animation)\(|withAnimation|UIWebView|WKWebView' "$IPHONE" "$WATCH"; then
  print -u2 "Seed shell must not rely on gesture, Crown, motion, or web content"
  exit 1
fi

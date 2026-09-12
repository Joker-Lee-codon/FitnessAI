#!/bin/zsh
set -eu

readonly ROOT="${0:A:h:h:h}"
readonly IPHONE="$ROOT/Apps/iPhone"
readonly WATCH="$ROOT/Apps/Watch"

for catalog in "$IPHONE/Assets.xcassets" "$WATCH/Assets.xcassets"; do
  for token in BackgroundCanvas Surface TextPrimary TextSecondary ActionPrimary PlanMark PlanText ActualMark ConfirmedText PendingText OnFilled; do
    [[ -f "$catalog/$token.colorset/Contents.json" ]] || { print -u2 "Missing semantic token $token"; exit 1; }
    grep -Eq '"luminosity"' "$catalog/$token.colorset/Contents.json" || { print -u2 "Token $token lacks Dark Mode variant"; exit 1; }
  done
done

grep -Eq 'iphone\.root\.tabs' "$IPHONE/IPhoneRootView.swift"
for surface in today-ledger session-review history-ledger; do
  grep -Eq "iphone\.$surface" "$IPHONE/IPhoneRootView.swift"
done

for surface in workout-entry active-workout rest-resolution finish-review recovery; do
  grep -Eq "watch\.$surface" "$WATCH/WatchRootView.swift"
done

grep -Eq 'Nothing is saved or synchronized' "$IPHONE/IPhoneRootView.swift"
grep -Eq 'UI PREVIEW · NO DATA SAVED' "$WATCH/WatchRootView.swift"
grep -Eq 'minHeight: 52' "$IPHONE/IPhoneRootView.swift"
grep -Eq 'minHeight: 48' "$WATCH/WatchRootView.swift"

if grep -ERn '\.(gesture|animation)\(|withAnimation|UIWebView|WKWebView|URLSession|https?://' "$IPHONE" "$WATCH"; then
  print -u2 "UI preview must not rely on hidden gestures, motion, web content, or networking"
  exit 1
fi

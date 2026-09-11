# Watch — Rest Resolution

## 1. Purpose and Authority

Resolves uncertainty or editable facts only during a verified `restSafeForInteraction` pause. It preserves sibling facts, interruption budget, and the user's right to defer.

## 2. Entry and Exit

- Entry: one eligible pending fact during a verified safe rest.
- Exit: confirm, change, Later, safe-state withdrawal, or exact-field iPhone handoff.

## 3. Composition

1. Safe-rest context and rest time.
2. Amber issue label + literal question.
3. Retained same-set facts.
4. Shortest confirmation, Change, and Later.
5. Draft/commit state when adjusting load/RPE.

## 4. Components

`CorrectionBoundary`, `CrownAdjustableValue`, `RPEVerificationPrompt`, `ActualSetLedgerRow`, `SupportBoundaryNotice`.

## 5. Required States

Not safe/deferred; safe with none/one/multiple pending; Later; corrected; manual fallback; RPE disabled/verification/drift/abstention; unsupported load semantic; commit failure.

## 6. Interaction and Accessibility

Initial VoiceOver focus lands on retained facts, then issue and choices. Crown/touch update the same draft; only Confirm commits. Losing safe rest closes the prompt and preserves pending data. No countdown and no dense RPE grid.

## 7. Requirements and Flows

FR-007, FR-011–FR-015, FR-019–FR-027, FR-061–FR-062; UJ-1, UJ-3, Flow 8.

## 8. Preview and Validation

Preview: `../previews/watch-pages-review.png`, screen 03. Validate safe-state withdrawal, Crown/touch equivalence, 140% text, Later, and commit failure.

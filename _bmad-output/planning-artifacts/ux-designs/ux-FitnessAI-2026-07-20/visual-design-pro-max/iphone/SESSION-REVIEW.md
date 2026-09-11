# iPhone — Session Review

## 1. Purpose and Authority

Provides complete field-level review/correction, provenance, revision history, completion state, and exact plan reconciliation for one Workout Session.

## 2. Entry and Exit

- Entry: Watch completion handoff, Training History, pending-field deep link, conflict route.
- Exit: commit correction, resolve required fields, accept/edit/decline plan diff, return with exact context.

## 3. Composition

1. Session identity + Complete/Incomplete boundary.
2. Set/volume/duration summary derived from Actual Sets.
3. Exercise sections with `ActualSetLedgerRow` values and provenance.
4. Inline pending/corrected/conflict boundary.
5. Field editor or split/merge/insert/delete route.
6. `PlanDiffReview` and one completion action.

## 4. Components

`ActualSetLedgerRow`, `FactStateLabel`, `CrownAdjustableValue` visual equivalent, `RPEVerificationPrompt`, `PlanDiffReview`, `SyncBoundaryIndicator`.

## 5. Required States

Loading; Complete; Incomplete; corrected; pending RPE; auto-used RPE; conflict; stale Analysis; correction committing/failed; sync pending.

## 6. Interaction and Accessibility

Every correction targets one field/revision unless split/merge/insert/delete is explicit. Prior value/provenance remains auditable. Focus returns to the edited row. Fixed completion action reserves safe area. No plan change occurs without explicit acceptance.

## 7. Requirements and Flows

FR-006–FR-007, FR-026, FR-029, FR-033–FR-035, FR-040–FR-041, FR-061–FR-063; UJ-1, UJ-3, Flow 7, Flow 8.

## 8. Preview and Validation

Preview: `../previews/iphone-core-pages-review.png`, screen 03. Validate all field operations, conflict preservation, keyboard, 200% text, failed commit, and stale Analysis.

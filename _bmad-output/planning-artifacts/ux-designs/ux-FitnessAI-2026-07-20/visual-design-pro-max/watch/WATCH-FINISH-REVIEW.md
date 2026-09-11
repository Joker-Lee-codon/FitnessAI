# Watch — Finish Review

## 1. Purpose and Authority

Confirms the manual finish boundary, displays Complete or Incomplete outcome, preserves unresolved facts, and separates local completion from synchronization.

## 2. Entry and Exit

- Entry: deliberate manual Finish; gated forgotten-Finish question only if its release gate passes.
- Exit: commit Finish, return to session, or open exact iPhone review.

## 3. Composition

1. “结束训练？” boundary and session duration.
2. Complete/Incomplete summary with set count and trained body areas.
3. Visible pending fields/sets.
4. Local and sync boundary.
5. One Finish confirmation; Continue remains clear.

## 4. Components

`ActualSetLedgerRow`, `FactStateLabel`, `DurabilityRail`, `SyncBoundaryIndicator`, `TitaniumPrimaryAction`.

## 5. Required States

Complete; Incomplete; finish committing; local finish failure; saved locally/sync pending; synchronized; gated forgotten-Finish question.

## 6. Interaction and Accessibility

Manual Finish is authoritative. Unresolved required fields create an editable Incomplete session, never a discarded or Complete session. Success appears only after local commit. No celebration animation; success haptic is brief and commit-bound.

## 7. Requirements and Flows

FR-004–FR-007, FR-029, FR-033–FR-034, FR-062–FR-063; UJ-1, UJ-3, Flow 6.

## 8. Preview and Validation

Preview: `../previews/watch-pages-review.png`, screen 05. Validate Incomplete outcome, sync failure after local success, Return/Continue, and gated forgotten-Finish absence.

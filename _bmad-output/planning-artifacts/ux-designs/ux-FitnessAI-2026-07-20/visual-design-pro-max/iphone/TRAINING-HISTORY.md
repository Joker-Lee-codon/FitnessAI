# iPhone — Training History

## 1. Purpose and Authority

Browses planned and ad-hoc Workout Sessions, Complete/Incomplete boundaries, revisions, deletion states, and restoration progress without losing historical facts.

## 2. Entry and Exit

- Entry: History tab, Analysis drill-down, restoration route.
- Exit: Session Review, reuse as new draft, filter period/type, open restoration/deletion state.

## 3. Composition

1. Period/filter controls.
2. Literal period summary: sessions and exercises.
3. Chronological session ledger grouped by date/week.
4. Each row: planned/ad-hoc, Complete/Incomplete, sets/duration, revision/sync state.
5. Restoration/deletion boundaries inline with affected rows.

## 4. Components

Session ledger row, `FactStateLabel`, `SyncBoundaryIndicator`, `LifecycleRequestRow`, `SystemStatePanel`.

## 5. Required States

Cold load; ready; empty; offline cached; restoration in progress/failed; deleted/tombstoned; revision pending; conflict.

## 6. Interaction and Accessibility

Back navigation preserves filters and scroll. Deleted items retain visible lifecycle state where required; old replay cannot restore them. Rows group session facts for VoiceOver and expose Review/Reuse actions.

## 7. Requirements and Flows

FR-035–FR-041, FR-045–FR-046, FR-063, FR-067–FR-068; UJ-2, UJ-3, UJ-5.

## 8. Preview and Validation

Preview: `../previews/iphone-core-pages-review.png`, screen 04. Validate empty period, offline cache, tombstone, restoration failure, filter retention, and history reuse.

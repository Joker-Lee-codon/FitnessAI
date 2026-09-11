# iPhone — Sync & Recovery

## 1. Purpose and Authority

Coordinates restoration, synchronization retries, revision conflicts, duplicate/reordered delivery, deletion replay protection, and concurrent sessions while preserving local recording authority.

## 2. Entry and Exit

- Entry: visible sync issue, restoration, account sign-in, conflict deep link, Watch recovery coordination.
- Exit: Retry, inspect exact object, choose effective revision, resume local use, coordinate distinct concurrent sessions.

## 3. Composition

1. Overall copy-scoped status, never generic “all synced.”
2. Active issues ordered by record integrity consequence.
3. Lifecycle ledger rows with object/device, state, surviving data, next action.
4. Conflict comparison preserving both revisions.
5. Completed/restored scope and remaining exceptions.

## 4. Components

`SyncBoundaryIndicator`, `LifecycleRequestRow`, `RecoveryChoiceSheet`, revision comparison, `SystemStatePanel`.

## 5. Required States

No issues; sync pending; offline; retrying; delayed/reordered/duplicate replay; revision conflict; restoration accepted/in progress/completed/failed; concurrent sessions; deletion replay blocked.

## 6. Interaction and Accessibility

Retry is idempotent. Device time is informational, not decisive. Conflict resolution requires explicit user choice and keeps dependent Analysis/proposals stale until effective. Each lifecycle row is one focus group; polling does not reannounce.

## 7. Requirements and Flows

FR-043–FR-048, FR-063–FR-070; UJ-5, Flow 6, Flow 7.

## 8. Preview and Validation

Preview: `../previews/iphone-system-pages-review.png`, screen 02; state details in `../previews/states-review.png`. Validate airplane mode, duplicate replay, conflict, concurrent Watch sessions, and partial restoration.

# Watch — Recovery

## 1. Purpose and Authority

Restores the latest durably committed active Workout Session after interruption and preserves partial/ambiguous facts without duplication or silent loss.

## 2. Entry and Exit

- Entry: app termination, Watch restart, recoverable battery/sensor interruption, disconnect/reconnect, concurrent session discovery.
- Exit: Resume, Finish as incomplete, confirmed Discard, or iPhone conflict coordination.

## 3. Composition

1. Recovery status and session identity.
2. Latest durable boundary: Exercise, set, time, local state.
3. Visible pending fragment when present.
4. Resume as primary; Finish incomplete secondary; Discard last and separated.

## 4. Components

`RecoveryChoiceSheet`, `ActualSetLedgerRow`, `DurabilityRail`, `SyncBoundaryIndicator`, `TitaniumPrimaryAction`.

## 5. Required States

Exact recovery; partial write; ambiguous set boundary; restart; disconnect; concurrent session; committing; recovery failure; discard confirmation.

## 6. Interaction and Accessibility

Initial focus is the recovered identity and durable boundary. Resume is first action; Discard is last and requires explicit consequences. Replay is idempotent. A partial write becomes one pending Actual Set, never several guessed sets.

## 7. Requirements and Flows

FR-043, FR-046, FR-064–FR-066; UJ-5, Flow 6, Flow 7.

## 8. Preview and Validation

Preview: `../previews/watch-pages-review.png`, screen 04. Validate restart, partial write, duplicate replay, concurrent Watch sessions, and VoiceOver focus.

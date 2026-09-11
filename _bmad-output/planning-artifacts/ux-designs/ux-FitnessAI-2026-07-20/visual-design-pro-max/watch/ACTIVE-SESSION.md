# Watch — Active Session

## 1. Purpose and Authority

The primary in-workout surface. It presents the current Exercise, set context, Actual Load, repetitions target/context, local durability, and one explicit set/session action while remaining quiet during formal sets.

## 2. Entry and Exit

- Entry: successful local session start, Resume, return from a safe correction.
- Exit: Complete Set → rest state; manual Finish route; record-integrity recovery route.

## 3. Composition

1. Exercise + set order header.
2. Dominant Actual Load with literal source.
3. Independent repetitions target/current context.
4. Thin set/durability rail.
5. One “完成本组” action; Finish remains a deliberate secondary route.

## 4. Components

`InstrumentReadout`, `DurabilityRail`, compact `FactStateLabel`, `TitaniumPrimaryAction`, `SyncBoundaryIndicator`.

## 5. Required States

Active set; resting; accepted/uncertain/unresolved fact; sensor gap; offline; low storage/resource warning; committing locally; local-write failure.

## 6. Interaction and Accessibility

No proactive uncertainty prompt during a formal set unless capture integrity is threatened. Completing a set reports success only after local commit. Actual Load never says “detected”; Crown editing is entered deliberately and commits explicitly. Always On preserves Exercise, set, load/reps, and local boundary.

## 7. Requirements and Flows

FR-002–FR-004, FR-008–FR-010, FR-016–FR-019, FR-043, FR-061; UJ-1, UJ-3, Flow 6, Flow 8.

## 8. Preview and Validation

Preview: `../previews/watch-pages-review.png`, screen 02; theme variants in `../previews/themes-review.png`. Validate two-second glance, sweat touch, Always On, sensor gap, and local-write failure.

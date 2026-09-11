# iPhone — Training Plans

## 1. Purpose and Authority

Views and deliberately edits structured Training Plans, substitutions, and history-derived drafts while keeping planned content separate from Actual Sets.

## 2. Entry and Exit

- Entry: Today plan card, plan library, reuse historical session, plan-diff proposal.
- Exit: save draft/revision, select for Today, accept/decline substitute, discard draft with confirmation.
- V1.1-only exit: open `TRAINING-PLAN-PORTABILITY-V1-1.md` for one-plan export/import. This route is absent in MVP.

## 3. Composition

1. Plan identity, revision, selected/draft state.
2. Weekly structure and ordered Exercise ledger.
3. Planned sets/reps/load/optional target RPE, explicitly labelled.
4. Substitute difference panel: primary target, movement, equipment, secondary/range differences.
5. Revision consequence and one Save/Select action.

## 4. Components

Plan ledger, `PlanDiffReview`, `SupportBoundaryNotice`, editable field rows, `TitaniumPrimaryAction`.

## 5. Required States

View; selected; edit draft; validation error; substitute proposal; accepted/declined; stale revision; conflict; commit failure; historical reuse draft.

V1.1 adds a contextual portability action and imported-source provenance only after phase activation; it does not change MVP states or add a top-level destination.

## 6. Interaction and Accessibility

No substitution or future-plan update applies silently. Field errors remain adjacent and focusable. Historical reuse creates a new draft and never mutates source history. Large text changes multi-column rows into labelled stacks.

## 7. Requirements and Flows

FR-028–FR-035; UJ-1, UJ-2, UJ-3, Flow 8.

## 8. Preview and Validation

Preview: `../previews/iphone-core-pages-review.png`, screen 02. Validate substitute differences, decline preserving Actual Sets, stale revision, and unsaved-draft dismissal.

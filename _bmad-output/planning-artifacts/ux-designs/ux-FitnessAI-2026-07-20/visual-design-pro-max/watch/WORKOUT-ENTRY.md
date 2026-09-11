# Watch — Workout Entry

## 1. Purpose and Authority

Starts a planned or ad-hoc Workout Session and exposes prerequisites/support limits. It cannot imply that starting on iPhone transfers active-session authority away from Watch.

## 2. Entry and Exit

- Entry: app open, selected Training Plan handoff, recoverable session route.
- Primary exits: Start planned session, Start ad-hoc session, Resume recovery, open exact support fallback.

## 3. Composition

1. Context header: date and Watch readiness.
2. Selected plan or “自由训练” title.
3. Compact plan facts: exercises, sets, expected duration; planned values explicitly labelled.
4. Support/capability boundary when relevant.
5. One full-width Start/Resume action.

## 4. Components

`TitaniumPrimaryAction`, `SupportBoundaryNotice`, `SyncBoundaryIndicator`, compact plan ledger.

## 5. Required States

Cold load; no plan/ad-hoc; selected plan; offline; unsupported device/Exercise; required capability missing; recoverable session; start/local-commit failure.

## 6. Interaction and Accessibility

Start is disabled only with a visible reason and available fallback. VoiceOver reads selected mode, plan facts, support boundary, then Start. Offline recording remains available. No horizontal page carousel during entry.

## 7. Requirements and Flows

FR-001, FR-028, FR-030–FR-032, FR-043, FR-049; UJ-1, UJ-3, Flow 8.

## 8. Preview and Validation

Preview: `../previews/watch-pages-review.png`, screen 01. Validate small Watch case, offline start, longest Chinese plan name, and unsupported fallback.

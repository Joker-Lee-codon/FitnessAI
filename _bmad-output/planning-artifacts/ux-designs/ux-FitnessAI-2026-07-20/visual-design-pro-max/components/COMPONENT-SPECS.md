# FitnessAI Titanium Measure Component Specifications

## 1. Scope and Authority

These specifications define the confirmed visual form and SwiftUI-facing contract. Behavioral invariants remain owned by the PRD and `EXPERIENCE.md`. Tokens come from `design-system/fitnessai/tokens.json`.

## 2. Shared Component Contract

- Minimum frequent/consequential hit target: 44 × 44 pt; adjacent targets: 8 pt minimum.
- States use symbol + literal text + structural treatment; color is redundant.
- Success is shown only after local durable commit. Synchronization has an independent indicator.
- Pressed state uses a 100 ms opacity/state layer and never changes layout bounds.
- All components support Dynamic Type, VoiceOver, Increase Contrast, Reduce Motion, and dark/light appearance.

## 3. Component Inventory

### 3.1 `TitaniumPrimaryAction`

**Anatomy:** label, optional leading SF Symbol, optional progress indicator, full-width action surface.

**Variants:** primary, secondary outline, quiet text, destructive confirmation.

**States:** idle, pressed, disabled-with-reason, committing-locally, committed, failed-preserving-draft.

**Visual:** cyan fill for the single primary action; 8–12 pt radius; 48 pt preferred height. Destructive never shares the primary cyan hierarchy.

**SwiftUI:** `Button` with semantic role; `ProgressView` replaces the leading symbol while committing; `.disabled` plus visible reason.

### 3.2 `InstrumentReadout`

**Anatomy:** value, unit, fact label, source/authority line, optional draft marker.

**Variants:** Actual Load dominant, repetitions secondary, RPE adjustable, duration.

**States:** planned prefill, copied from prior set, history prefill, user-entered, predicted, confirmed, corrected, unresolved.

**Visual:** tabular bold value, unit on baseline, source below; never displays “detected load.”

**Accessibility:** one grouped summary; editable variants expose native increment/decrement and value/source.

### 3.3 `DurabilityRail`

**Anatomy:** 2–4 segments, text boundary, optional sync symbol.

**States:** editing, committing locally, saved locally, sync pending, synchronized, failed.

**Visual:** 4 pt rail; solid completed segments, outlined pending segment, interrupted failure segment. Text states remain visible.

**Rule:** local saved segment stays complete if cloud synchronization later fails.

### 3.4 `FactStateLabel`

**Anatomy:** SF Symbol, literal state, optional provenance suffix.

**States:** accepted, uncertain, corrected, unresolved, pending, stale, conflict, manual-only, unsupported.

**Visual:** compact inline label or 4 pt left boundary for high attention. It merges with the affected fact rather than floating as a generic badge.

### 3.5 `ActualSetLedgerRow`

**Anatomy:** set order, reps, Actual Load, RPE/effective provenance, completeness, revision state.

**Variants:** compact Watch summary, iPhone ledger row, expanded editable group.

**States:** confirmed, auto-used RPE, corrected, pending required field, deleted/tombstoned, revision conflict.

**Visual:** rules and baseline alignment, not a card. Pending uses amber rail + literal label; corrected uses a revision marker plus old/current values.

### 3.6 `CorrectionBoundary`

**Anatomy:** issue label, retained sibling facts, shortest correction choice, Change, Later.

**States:** safe, deferred, committing, committed, commit failed, safe-state withdrawn.

**Visual:** amber left rail, strong question, retained-facts ledger, one high-emphasis confirmation.

**Invariant:** Later and safe-state loss preserve the pending fact; no countdown.

### 3.7 `CrownAdjustableValue`

**Anatomy:** committed value/source, draft value, unit, Crown hint, touch alternatives, explicit Confirm.

**States:** unchanged, drafting, limit reached, unsupported semantic, committing, failed.

**SwiftUI:** `.focusable()`, `.digitalCrownRotation`, native accessibility-adjustable action, and an explicit `Button` commit.

### 3.8 `RPEVerificationPrompt`

**Anatomy:** predicted value and provenance, editable integer, verification-window state, Confirm, Change/Later.

**States:** disabled, first-five verification, passed/offered auto-use, recalibrating, auto-used, drift, abstained, missing signal.

**Visual:** literal integer; no dense 10-button Watch grid and no unvalidated anchor copy.

### 3.9 `PlanDiffReview`

**Anatomy:** affected future plan/revision, field, planned/current/proposed values, consequence, Accept/Edit/Decline.

**States:** proposal, edited proposal, accepted, declined, stale, conflict, commit failed.

**Visual:** three-column ledger at standard text sizes; stacked field groups at accessibility sizes.

### 3.10 `SyncBoundaryIndicator`

**Anatomy:** copy/device scope, state symbol/text, last event, optional next action.

**States:** saved locally, phone received, sync pending, synchronized, offline, retrying, failed, conflict.

**Visual:** nonmodal status row; active-set sync-only updates do not interrupt.

### 3.11 `RecoveryChoiceSheet`

**Anatomy:** recovered session identity, durable boundary, recoverable fragment, Resume, Finish as incomplete, confirmed Discard.

**States:** exact recovery, partial write, ambiguous boundary, concurrent session, committing, failed.

**Focus:** summary first, Resume second, destructive Discard last.

### 3.12 `SupportBoundaryNotice`

**Anatomy:** named device/Exercise/signal, support state, retained fields, available fallback.

**States:** supported, limited, manual-only, unsupported, low confidence, matrix unavailable.

**Visual:** inline boundary row before the affected action. Unsupported uses symbol + text, not disabled silence.

### 3.13 `LifecycleRequestRow`

**Anatomy:** request type, exact copy scope, state, timestamp/progress, exception, next action.

**States:** accepted, in progress, scoped completion, failed, offline device pending, retained/legal exception.

**Rule:** polling does not create repeated announcements; completion names what is and is not complete.

### 3.14 `TrendEvidenceChart`

**Anatomy:** conclusion, time control, plot, direct point label, exclusion note, table alternative.

**Variants:** primary Exercise load trend, weekly volume, duration, set count.

**States:** loading skeleton, ready, empty, pending inputs excluded, stale conflict, calculation failed.

**Visual:** solid confirmed line, dashed excluded/pending region, outlined corrected point, 3:1 minimum mark contrast.

### 3.15 `SystemStatePanel`

**Anatomy:** SF Symbol, exact object/state, cause, surviving data, one next action.

**Variants:** loading, empty, offline cached, error, unsupported, restoration, local-write failure.

**Rule:** never replace useful cached/local content with a full-screen generic error when the content remains valid.

### 3.16 `PlanExchangeReview` (V1.1)

**Anatomy:** file/source identity, schema/catalog/plan revision, included/excluded scope, complete plan ledger, validation result, mapping/omission rows, duplicate state, consequence, Create New Draft, Cancel.

**States:** export ready/creating/failed; validating; compatible; unsupported/newer; malformed/executable/over-limit; duplicate; mapping required; explicit omission; ready; committing; committed; failed preserving review.

**Visual:** ledger composition, not a generic file card. Amber rail marks unresolved mapping/omission; destructive rail marks invalid input. Original and canonical Exercise names remain visible together.

**Invariant:** preview precedes mutation; import never merges, overwrites, or revises an existing plan. The component is unavailable in MVP.

### 3.17 `StructuredInputDraft` (Future Boundary)

**Anatomy:** source modality, observable capture/transcription state, parsed field/value/unit, ambiguity/provenance, conflicting committed fact, edit/confirm/reject/cancel actions.

**States:** unavailable/permission state, listening, interrupted, transcribing, ambiguous, draft, conflict, edited, confirmed, committing, committed, rejected/cancelled, failed.

**Visual:** muted draft ledger with a literal source label; amber draft rail; split comparison and destructive rail for conflict. The committed fact remains visually primary until replacement commits.

**Invariant:** non-implementing pattern for Post-MVP voice or third-party import. No continuous-listening animation, no MVP instantiation, and no automatic replacement of a confirmed fact.

## 4. Component-State Composition Rules

| Situation | Composition |
|---|---|
| Active Set | `InstrumentReadout` + `DurabilityRail` + one `TitaniumPrimaryAction`; no proactive correction |
| Safe Rest | retained `ActualSetLedgerRow` + `CorrectionBoundary` or adjustable component |
| Finish | boundary summary + set ledger + durability/sync + one finish confirmation |
| iPhone Review | ledger rows + inline fact states + plan diff + fixed completion action |
| Sync/Privacy | scoped lifecycle rows; no generic success banner |
| Analysis | conclusion + trend evidence + exclusions + decision note |
| V1.1 Plan Portability | source/version + complete preview + mapping/omission ledger + one Create New Draft action |
| Future Structured Input | committed fact + source-labelled draft + conflict/ambiguity + explicit confirm/edit/reject/cancel |

## 5. Required Device Validation

Validate component geometry and feedback on 40/41 mm and 44/45/46/49 mm Watch classes, small and large supported iPhones, portrait/landscape where applicable, largest text sizes, VoiceOver, Increase Contrast, Reduce Motion, Always On, sweat/one-hand interaction, and offline/local-write failure.

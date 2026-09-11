# iPhone — Training Plan Portability (V1.1, Not MVP)

## 1. Purpose and Authority

Defines round-trip export and import of one Training Plan in the FitnessAI-owned versioned format. This surface is V1.1 scope under FR-071–FR-073 and NFR-PORT-001; it must not appear in MVP navigation or stories.

## 2. Entry and Exit

- Export entry: contextual action from one Training Plan detail.
- Import entry: iOS document picker/file open or contextual plan-library action after V1.1 activation.
- Exit: share/save exported artifact, create one new editable draft, cancel, or return to the exact validation/mapping failure.

## 3. Composition

1. Phase and action boundary: Export One Plan or Import as New Draft.
2. Source identity: file name, format/schema version, Exercise-catalog version, plan revision, producing version, and provenance.
3. Complete Training Plan ledger: days, Exercises, sets, repetitions, load/unit, optional target RPE, and plan metadata.
4. Explicit exclusions: Workout Sessions, Actual Sets, health information, account credentials, and data outside the selected plan.
5. Validation ledger: compatible/unsupported/newer/malformed/over-limit, duplicate identity, unknown Exercise, incompatible field/unit, required omission, and parser diagnostic.
6. Canonical Exercise mapping with original value, proposed mapping, confidence not treated as authority, Change, Omit, and Cancel.
7. One final `Create New Draft` action; no merge, replace, or revise-existing action.

## 4. Components

`PlanExchangeReview`, plan ledger, `FactStateLabel`, `SupportBoundaryNotice`, `SystemStatePanel`, `TitaniumPrimaryAction`, `DurabilityRail`.

## 5. Required States

Export ready/creating/failed; file unopened/validating; compatible; unsupported or newer version; malformed/executable/over-limit; duplicate; unknown Exercise; unresolved unit/field mapping; explicit omission; partial preview; ready; creating new draft; committed locally; cancelled; failed preserving review.

## 6. Interaction, Trust, and Accessibility

The file is untrusted and is never executed. Preview precedes mutation. Unknown mappings are never invented; a partial plan is never called complete without explicit omissions. Cancel, validation failure, or local-commit failure leaves all existing plans unchanged. VoiceOver order is source/version, validation result, complete plan summary, issues, consequences, then Create Draft or Cancel. At 200% text, mapping rows become labelled stacks and retain original/source values.

## 7. Requirements and Flows

FR-071–FR-073 (V1.1), NFR-PORT-001, DV-007; Flow 10.

## 8. Preview and Validation

No production preview is promoted for MVP. Before V1.1 stories enter acceptance, freeze DV-007 parser limits and validate compatible export/re-import, malformed and compressed-bomb input, newer version, duplicate, unknown Exercise, unit mismatch, explicit omission, cancellation, local-commit failure, VoiceOver, Full Keyboard Access, and largest text.

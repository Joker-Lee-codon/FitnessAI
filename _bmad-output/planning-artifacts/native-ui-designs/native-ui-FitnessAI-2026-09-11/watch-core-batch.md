# FitnessAI Watch Core Screen Batch

## Document State

- Stage: `ND-03 Screens`
- Batch: `Watch core`
- State: accepted and frozen by the Product Owner on 2026-09-12
- Direction: `Training Ledger`
- Frozen tokens: `0.2.0-nd02-accepted`
- Authoritative inputs: `prd.md`, `EXPERIENCE.md`, `native-ui-spec.md`

## Batch Thesis

The Watch is a durable training ledger, not a miniature dashboard. Every surface answers one immediate question: what can I safely do next without losing or misrepresenting a workout fact? The left `training-rail` is the sole bold device. It carries sequence and durable-commit state; all other geometry stays quiet.

The Watch defaults to OLED dark during an active workout. Review, correction, and recovery may use the cream light appearance when the user is stationary. Appearance never changes authority or state meaning.

## Flow Map

```text
Approved Plan ──Start──> Active Workout ──Complete Set──> durable local commit
     │                         │                              │
     └─Start Ad-hoc            ├─Edit Actual Set              ├─success → next set
                               ├─manual Finish                └─failure → retry, input retained
                               └─restSafeForInteraction → Rest Resolution

Interruption ──restore──> Watch Recovery ──Resume──> Active Workout
                                      └─Finish incomplete / confirmed Discard

Active Workout ──Finish──> Finish Review ──Finish workout──> Local Save Result
```

## Shared Layout Rules

- Content is left aligned; the current Actual metric may be centered to improve glanceability.
- The top row contains context and one explicit escape or Finish action, never a decorative title bar.
- The bottom safe region contains one primary action. Secondary actions remain text buttons or separate rows.
- Exercise names, Actual values, units, unresolved counts, and consequences do not truncate.
- Active movement surfaces suppress recognition, RPE, and Finish-reminder prompts. Those enter only at `restSafeForInteraction`.
- A proactive recognition/RPE/correction question consumes the shared five-prompt budget; Later preserves the pending fact.

## Surface WC-01 — Approved Plan / Workout Entry

**Purpose.** Start the last fully delivered compatible Plan Revision or create a distinct ad-hoc session.

**Entry / exit.** Enter from the Watch app root after full revision receipt. `Start planned workout` creates the session identity and immutable Start snapshot, then exits to WC-02. `Start ad-hoc workout` creates a separate session without pretending a plan exists.

**Traceability.** `FR-001`, `FR-028`, `FR-029`, `FR-043`; `UJ-1`, `Flow 2`.

**Hierarchy.** Revision and delivery state → session name → ordered Exercise overview → planned sets/reps/loads/RPE → primary Start → secondary ad-hoc entry.

**Components / tokens.** `training-rail` in Plan state; `durable-state-label`; `session-control`; `canvas`, `planText`, `textPrimary`, `confirmedText`, `watchExercise`, `watchMeta`, `watchAction`.

**States.**

| State | Contract |
|---|---|
| Default | Show revision name, digest-short label, Exercise count, and full planned facts before Start. |
| Loading | Keep the last fully delivered plan visible while checking receipt; never show a partial new revision. |
| Empty | “No delivered plan on this Watch.” Offer `Start ad-hoc workout`; plan creation stays on iPhone. |
| Offline / delivery failed | Name the last usable revision and allow Start; new pending content is not exposed. |
| Conflict | Do not merge plans on Watch. Name “Resolve plan delivery on iPhone”; last complete revision remains usable. |
| Accessibility | The rail announces “4 Exercises, not started.” Each Exercise announces order, sets, reps, load, and target RPE. |
| Appearance | Dark and light preserve ordering and state labels; Increase Contrast adds shape/stroke. |

**SwiftUI constraints.** Typed navigation; Start is idempotent; snapshot identity is created only after a durable local start commit. A loading overlay cannot cover the last usable plan.

## Surface WC-02 — Active Workout

**Purpose.** Complete the current Actual Set with minimal interaction while preserving Plan/Actual separation.

**Entry / exit.** Enter after WC-01 Start, WC-05 Resume, or successful set commit. Complete Set commits locally before advancing. Edit opens WC-03. Finish opens WC-05.

**Traceability.** `FR-002–004`, `FR-007–011`, `FR-016–020`, `FR-029`, `FR-043`; `UJ-1`, `Flow 2`; `NFR-REC-002`, `NFR-RES-002`.

**Hierarchy.** Elapsed time + Finish → current Exercise → `training-rail` → Actual Load → planned reps/RPE reference → recognition/manual state → Complete Set.

**Components / tokens.** `training-rail`, `actual-set-primary-action`, `durable-state-label`, `recognition-state-chip`; `actualMark`, `planText`, `confirmedText`, `pendingText`, `watchMetric`.

**States.**

| State | Contract |
|---|---|
| Default | Current set notch is outlined; Complete Set is the sole primary action. |
| Automatic capture pending | Keep the manual action available; do not announce continuously during movement. |
| Unsupported / abstained | Say “Manual recording”; never style it as a recognition failure or success. |
| Save pending | Disable duplicate semantic submission while preserving idempotent replay; say “Saving on this Watch…” |
| Save success | Fill the notch only after durable commit; announce once, then advance. |
| Save failure | Keep Exercise, reps, load, RPE, timing, and order on screen; Retry does not duplicate prior sets. |
| Offline | No visual degradation; local recording remains primary. iPhone receipt is a separate state. |
| Accessibility | One merged rail value: “3 of 5 sets saved, set 4 current.” Complete, Edit, and Finish remain usable without Crown. |

**SwiftUI constraints.** Model updates are coalesced. Ordinary recognition changes do not steal VoiceOver focus. Save completion is driven by durable-store acknowledgement, not button-tap completion.

## Surface WC-03 — Edit Actual Set

**Purpose.** Correct one current-set field without changing planned values or sibling facts.

**Entry / exit.** Enter from WC-02. Save returns to WC-02 after durable commit. Cancel restores the last durable Actual value.

**Traceability.** `FR-013`, `FR-016–019`, `FR-026`, `FR-061–063`; `UJ-1`, `Flow 2`.

**Hierarchy.** Set identity → field name → Plan reference/source → Actual value → controls → explicit Save.

**Components / tokens.** `metric-stepper`, `durable-state-label`; `actualMark`, `planText`, `watchMetric`, `watchUnit`, `watchAction`.

**States.**

| State | Contract |
|---|---|
| Load | Visible −/+ targets, Digital Crown acceleration, and adjustable action. User value is authoritative. |
| Repetitions | Integer stepper with no hidden gesture requirement. |
| RPE | Only present when enabled; distinguish target, predicted, confirmed, corrected, and effective Actual RPE. |
| Exercise correction | Opens only at a safe pause; correcting the label preserves reps, load, RPE, timing, and order. |
| Partial / failed save | Keep edited input and exact field; show Retry. Other durable fields remain effective. |
| Accessibility | Announces “Actual load, 77.5 kilograms, planned 80”; increment/decrement are equivalent to visible controls. |

**SwiftUI constraints.** Each field writes an auditable revision. Do not put all set fields into one dense form. Unit conversion is outside this surface; use canonical stored units supplied by the domain layer.

## Surface WC-04 — Rest Resolution

**Purpose.** Resolve one uncertain fact only when interaction is safe, starting with the facts already preserved.

**Entry / exit.** Enter automatically or from a pending state only at `restSafeForInteraction`. Confirm/Correct commits the resolution, then returns to WC-02. Later keeps the pending fact and returns without false success.

**Traceability.** `FR-010–015`, `FR-020–026`; `UJ-1`, `Flow 2`; `SM-INT-001`, `NFR-RPE-002–013`, `NFR-REC-002`.

**Hierarchy.** Rest-safe context + prompt count → preserved facts → one uncertain field → Confirm → Correct / Manual / Later.

**Components / tokens.** `rest-resolution-banner`, `recognition-state-chip`, `rpe-verification-prompt`; `surface`, `pendingText`, `confirmedText`, `actualMark`.

**States.**

| State | Contract |
|---|---|
| Exercise uncertain | “5 reps and 80 kg preserved.” Ask whether the Exercise label is correct. |
| Reps uncertain | Preserve Exercise/load/timing; ask for the Actual repetition count. |
| RPE verification | Show predicted provenance and integer 1–10 value only when RPE is enabled and the set is eligible. |
| Later | Leave one visible pending field; do not count it as confirmed or complete. |
| Prompt budget exhausted | Defer to manual/pending resolution without another proactive interruption. |
| Unsafe / active movement | Suppress the surface entirely; retain pending facts. |
| Accessibility | VoiceOver reads preserved facts before the uncertainty and choices. One prompt produces one announcement. |

**SwiftUI constraints.** Rest safety and prompt budget are inputs from domain policy, not view heuristics. Use a native sheet/push presentation with a stable escape path.

## Surface WC-05 — Finish Review & Local Save

**Purpose.** Let the user manually finish with an exact view of durable and unresolved facts, then report local completion independently from iPhone return.

**Entry / exit.** Enter from WC-02 Finish or the eligible two-signal reminder. Continue returns to WC-02. Finish performs a durable session commit, then shows Complete or Incomplete result. Session Review ownership transfers to iPhone after receipt, but Watch keeps the authoritative local state until then.

**Traceability.** `FR-003–007`, `FR-033`, `FR-041`, `FR-062`; `UJ-1`, `Flows 2, 4`; `NFR-SESSION-001–005`.

**Hierarchy.** Manual/reminder reason → saved Exercise/set totals → unresolved-field count and exact items → Finish consequence → primary Finish / Continue → local save result → iPhone return state.

**Components / tokens.** `session-control`, `durable-state-label`, `forgotten-finish-prompt`; `confirmedText`, `pendingText`, `destructive`, `watchAction`.

**States.**

| State | Contract |
|---|---|
| Complete | “18 sets saved, 0 unresolved.” Primary: `Finish workout`. |
| Incomplete | Name each missing/pending field. Primary explicitly says `Finish as incomplete`; no fact is discarded. |
| Reminder eligible | Ask “Finished training?” with Finish and Continue; never auto-finish. |
| Reminder suppressed | Show nothing. Manual Finish remains available. |
| Local save pending / failed | Never say finished until commit succeeds. Retain the entire session and offer Retry. |
| Saved, return pending | “Saved on this Watch · Waiting to send to iPhone.” Local use remains complete. |
| Return failed / received | Failed offers idempotent Retry; received says “Received by iPhone” without changing local truth. |
| Accessibility | Summary announces complete/incomplete first, then unresolved count, consequence, and action. |

**SwiftUI constraints.** Finish is idempotent. The two-signal reminder and cooldown are policy outputs. Body areas trained appear only after durable completion and derive from effective Actual Sets.

## Surface WC-06 — Watch Recovery

**Purpose.** Restore the latest durable active session and one recoverable pending fragment after interruption.

**Entry / exit.** Enter after app termination, Watch restart, recoverable battery/sensor interruption, or reconnection when an active session exists. Resume returns to WC-02. Finish creates an Incomplete session through WC-05. Discard requires a second explicit confirmation.

**Traceability.** `FR-043`, `FR-046`, `FR-064–066`; `UJ-1`, `Flow 4`; `NFR-RECOV-001`, `NFR-COMPAT-002`.

**Hierarchy.** “Workout recovered” → durable saved summary → pending fragment → Resume → Finish incomplete → Discard.

**Components / tokens.** `recovery-action-group`, `durable-state-label`, `actual-set-row`; `confirmedText`, `pendingText`, `destructive`.

**States.**

| State | Contract |
|---|---|
| Durable session only | Name last saved Exercise/set and elapsed context. Resume is primary. |
| Pending fragment | Show one fragment with known facts and unresolved boundary; never duplicate or drop it. |
| Concurrent sessions | Keep each identity distinct. Watch does not merge; unsafe resolution routes to iPhone. |
| Loading | “Restoring workout…” with durable summary retained when available. |
| Recovery failed | Explain what remains durable and offer Retry; local recording is not replaced by an empty state. |
| Discard | Second confirmation names saved and unsent facts; destructive styling is isolated from Resume. |
| Accessibility | Initial focus lands on the recovery summary. Actions announce their exact consequence. |

**SwiftUI constraints.** Recovery is event-identity based and idempotent; device time cannot resolve conflicting revisions. A pending fragment has a stable identity separate from committed sets.

## Shared Exceptional-State Contract

| State | Watch core behavior |
|---|---|
| Permission unavailable | Automatic support may become manual-only; Start, Complete Set, Edit, and Finish remain usable. |
| Unsupported Exercise/device/signal | Name unsupported scope; offer manual recording; never imply automatic coverage. |
| iPhone disconnected | No interruption to active recording. Return state changes only after local commit. |
| Newer plan delivered mid-session | Current Start snapshot stays fixed; the new revision is future-only. |
| Conflict requiring full comparison | Preserve facts and route resolution to iPhone; Watch shows a literal pending/conflict label. |
| Reduce Motion / Differentiate Without Color | Immediate state transition; shape, text, fill, and symbol remain redundant. |

## Visual Self-Critique

The Claude cream/terracotta combination can look generic when used as a lifestyle shell. This batch limits cream to stationary review and recovery, uses terracotta only for Plan provenance, and makes the training-specific sequence rail—not the palette—the identity. Rounded containers are reserved for controls and explicit containment; workout facts remain on the canvas rather than in repeated cards. Decorative stats, gradients, sensor waveforms, Activity Rings, and “AI listening” motion were removed.

## Core-Flow Acceptance Gate

On 2026-09-12, the Product Owner accepted WC-01 through WC-06 as one coherent Watch flow, including Plan/Actual separation, durable-save feedback, rest-safe interruption, manual Finish, incomplete completion, and recovery consequences. The Watch core batch is frozen. ND-03 remains in progress until the remaining configured MVP batches are accepted.

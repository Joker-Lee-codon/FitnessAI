# FitnessAI Native UI Direction Selection

## Stage and Basis

- Current stage: `ND-01 Direction`
- State: awaiting Product Owner direction selection
- Authoritative product inputs: `prd-FitnessAI-2026-07-19/prd.md`, `SPEC.md`, and `epics.md`
- Authoritative behavior inputs: `ux-FitnessAI-2026-07-20/EXPERIENCE.md` and its 2026-09-08 reconciliation
- Explicit visual override: `prototypes/iphone-trust-ledger/design-direction.md`

The Product Owner explicitly requested that existing designed pages not be used as references. This run therefore does not inherit the visual expression of the old native UI run, old previews, existing SwiftUI pages, or the old design system. Product scope, IA, states, recovery, trust, and accessibility remain constrained by the PRD, SPEC, and `EXPERIENCE.md`.

## Invariants That Must Survive

- Watch owns the active Workout Session and locally durable Actual Sets when selected as the recording device.
- Manual Start and Finish remain authoritative; the system never starts or finishes automatically.
- Start binds a fixed Plan Revision snapshot; planned facts and Actual facts stay separate.
- Saved appears only after a successful local durable commit; iPhone return is a separate state.
- Recognition, RPE, and finish prompts appear only at `restSafeForInteraction` and share the interruption budget.
- Uncertain and unsupported paths fall back to manual control; correction cannot discard reps, load, RPE, time, or order.
- Frequent controls are at least 44 × 44 pt. Digital Crown is not the only input. Color, motion, and haptics all have textual or VoiceOver equivalents.

## Visual Decisions That May Be Discarded

- Previous direction names, color systems, materials, card structures, and Watch compositions.
- Activity rings, fitness scores, neon gradients, and dense multi-metric dashboards.
- Persistent sensor or model animation intended merely to appear intelligent.

## Shared Visual Foundation

| Role | Value | Direction use |
|---|---:|---|
| Claude cream | `#F4F1EA` | Light surfaces and iPhone continuity |
| Deep brown ink | `#3D3929` | Text, structure, and dark Watch canvas |
| Claude terracotta | `#D97757` | Plan facts, plan rail, and navigation semantics |
| Claude muted purple | `#6B5778` | Actual facts, correction, and complete-set action |
| Claude moss | `#788C5D` | Durable saved and confirmed states |
| Claude amber | `#BA7517` | Uncertain, pending, and incomplete states |

Watch Chinese text uses the system `SF Pro/PingFang SC` mapping. Load, repetitions, time, and set order use an `Avenir Next Condensed`-like narrow numeric mapping. Numerals do not use a monospace face. Every Watch screen has one primary task and one consequential primary action.

## Selected Direction

- Selection: `A — Training Ledger`
- Confirmed: 2026-09-12
- Confirmed by: Product Owner
- State: `ND-01 completed`

This selection establishes sequence position as the core Watch visual grammar. Active Workout first answers which set the user has reached, then exposes the current Actual Load, target reps/RPE, and durable-save state. Load and repetition editing moves to the dedicated `Edit Actual Set` surface, protecting the low-interruption active surface and its single primary action.

This is an explicit visual override. It replaces the old native UI run, prior `DESIGN.md` visual tokens, and prior Watch previews as the authority for material, color, geometry, and page composition, while preserving `EXPERIENCE.md` IA, behavior, state, accessibility, and cross-device authority boundaries. Direction B remains an evaluated but unselected exploration and does not enter ND-02 token freezing.

## Direction A — Training Ledger

### Audience and Context

For trainees who follow a clear plan and need to progress set by set under sweat and elevated heart rate while verifying that each set is durably saved.

### Single Primary Job

Complete the current Actual Set without entering edit mode and confirm that it has been persisted locally on Watch.

### Visual Thesis

Compress the iPhone training rail into a four-notch set scale on the left edge of Watch. A notch fills only after durable commit, the current notch uses an outline, and future notches remain empty. Position is legible without reading a dashboard.

```text
┌──────────────────┐
│ 18:42      Finish│
│ Back squat       │
│ ●                │
│ ●      80 kg     │
│ ●      Target 5  │
│ ◇      RPE 8     │
│ 3 sets saved     │
│ [ Complete set ] │
└──────────────────┘
```

### Design Posture

- Type: primary value centered; exercise and state left aligned; set scale remains asymmetric.
- Color: dark brown OLED canvas, cream text, terracotta Plan scale, muted-purple Actual action, moss saved state.
- Material: no glass or shadow; OLED black, solid fills, and 1 pt structural rules only.
- Geometry: squared notches instead of rings; primary action follows the Watch bottom edge.
- Motion: current notch fills once after durable commit; immediate change under Reduce Motion.
- Data: Actual Load receives the sole emphasis; reps and target RPE are secondary facts.
- Aesthetic risk: an asymmetric left scale replaces the familiar centered circular workout composition.
- Anti-patterns: continuous sensor animation, automatic-completion implication, color-only saved state, or recognition prompts during an active set.

### iPhone Continuity

Maps directly to the vertical rail on iPhone Today & Plans. Watch set notches map to iPhone Actual Set rows with matching color and fact semantics, without copying iPhone information density.

## Direction B — Movement Bench

### Audience and Context

For trainees who regularly adjust load or repetitions based on the day and need rapid Actual-value editing on Watch while keeping planned values visible.

### Single Primary Job

Check or adjust Actual Load and reps on the same screen, then complete the current set.

### Visual Thesis

Treat Watch as a dual-parameter equipment bench: load on the left, repetitions on the right. Selecting a value lets Digital Crown accelerate adjustment, while visible minus/plus controls and an accessibility-adjustable action provide equivalent input.

```text
┌──────────────────┐
│ Back squat  Set 4/4│
│                  │
│  Load       Reps │
│  80         5    │
│  kg         reps │
│ Plan 80   Plan 5 │
│ 3 sets saved     │
│ [ Complete set ] │
└──────────────────┘
```

### Design Posture

- Type: exercise and set order align left/right at the top; two Actual values form stable columns; primary action sits at the bottom.
- Color: cream surface, brown ink, muted-purple editable Actual values, terracotta Plan references, moss saved state.
- Material: a flat equipment-nameplate surface; each value is not wrapped in its own rounded card.
- Geometry: one strong rule divides the two adjustment regions; focus is identified by an outline and the words “Adjusting.”
- Motion: focus changes only alter the structural rule and label; no inertial number-wheel animation.
- Data: Actual and Plan stay adjacent but separate; units remain visible.
- Aesthetic risk: two authoritative Actual controls are available on the primary page, increasing control density without adding a second consequential action.
- Anti-patterns: presenting plan-prefill as sensor measurement, Crown-only editing, or turning the two columns into four small cards.

### iPhone Continuity

Maps to planned/actual comparison rows in iPhone Session Review and Analysis. Watch retains the same terracotta/purple semantics but includes only the two editable facts for the current set; full correction remains on iPhone.

## Direction Difference Summary

| Dimension | Direction A: Training Ledger | Direction B: Movement Bench |
|---|---|---|
| Primary recognition | Where am I in the sequence? | What did I actually do? |
| Core structure | Left sequence scale plus one primary value | Dual-column Actual adjustment bench |
| Default action | Complete directly | Check/edit, then complete |
| Best fit | Stable plan execution | Frequent in-session adjustment |
| Main risk | Editing is one level deeper | Higher primary-screen control density |

## Selection Gate

The Product Owner selected `A Training Ledger`; this gate is closed. `ND-02` will run one `ui-ux-pro-max` search and freeze SwiftUI semantic tokens. The full Watch core batch—Approved Plan, Active Workout, Edit Actual Set, Rest Resolution, Watch Recovery, and Finish & Local Save—can expand only after the system and representative surfaces are accepted.

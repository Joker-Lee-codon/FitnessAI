# FitnessAI Native UI Specification

## Document State

- Stage: `ND-02 SwiftUI design system`
- State: accepted and frozen by the Product Owner on 2026-09-12
- Selected direction: `Training Ledger`
- Token version: `0.2.0-nd02-accepted`
- Visual override: this specification replaces the old native UI run and prior `DESIGN.md` visual tokens, materials, geometry, and page composition. PRD and `EXPERIENCE.md` scope, behavior, state, accessibility, and authority boundaries remain in force.

## Search Input and Ruling

ND-02 ran the local `ui-ux-pro-max` search exactly once, explicitly passing SwiftUI, Apple Watch, strength training, Chinese users, low interaction, glanceability, trustworthy local recording, OLED, and low motion. The search incorrectly matched Voice Recorder / Webinar Registration and returned a purple-pink builder palette, Google Font, and hover animation.

Only the OLED dark canvas, Chinese legibility, touch clarity, and low-motion candidates were accepted. Webinar/landing structure, the purple-pink palette, Google Font, glow, hover, and GSAP were rejected because they conflict with watchOS, the selected direction, and project requirements.

## Design Principles

1. **Sequence before dashboard.** The left `training-rail` answers current set position; it is not decorative numbering.
2. **Facts before inference.** Plan, Actual, durable save, and iPhone return use distinct tokens and literal states.
3. **Active sets stay quiet.** Recognition, RPE, and Finish prompts appear only at `restSafeForInteraction`.
4. **Unknown beats guessing.** Uncertain and unsupported paths become pending/manual fallback, never fabricated success.
5. **One page, one consequential action.** Active Workout has Complete Set as its sole primary action; editing, Finish, and recovery are separate.
6. **Color is not evidence.** Every semantic color is paired with text, symbol, or structural change.

## Color System

See `tokens.json` for the complete machine mapping.

| Semantic role | Light | Dark | Use |
|---|---:|---:|---|
| `canvas` | `#F4F1EA` | `#171510` | Page canvas |
| `surface` | `#FFFDFA` | `#242119` | Explicit content surface |
| `textPrimary` | `#3D3929` | `#F4F1EA` | Primary copy and metrics |
| `textSecondary` | `#655E50` | `#BBB3A4` | Secondary explanation |
| `planMark` | `#D97757` | `#E08A6B` | Plan rail and large marks |
| `planText` | `#94462F` | `#F0A085` | Small Plan text |
| `actualMark` | `#6B5778` | `#AD95B8` | Actual, correction, and Complete Set |
| `confirmedText` | `#4F623C` | `#BED39D` | Confirmed and durably saved text |
| `pendingText` | `#81500E` | `#F0B968` | Uncertain, incomplete, and pending text |
| `destructive` | `#A33D38` | `#F18F83` | Explicit destructive actions and errors |

`#D97757` does not carry small white body text directly. Filled primary actions use the deeper `planAction` or `actualMark` to preserve contrast. Watch defaults to dark, while Light remains fully usable. Increase Contrast uses darker/brighter text roles and a 2 pt focus stroke rather than saturation alone.

## Typography System

Chinese text uses system `SF Pro/PingFang SC`, avoiding external font loading and glyph fallback. Metrics use system bold with condensed width. Monospace is avoided, preserving compact equipment-scale character without resembling a developer console.

| Token | SwiftUI mapping | Use |
|---|---|---|
| `watchExercise` | `.headline.weight(.semibold)` | Current exercise, two lines maximum |
| `watchMetric` | `.largeTitle.weight(.bold).fontWidth(.condensed)` | Current Actual Load / reps |
| `watchUnit` | `.caption.weight(.semibold)` | `kg`, reps, and RPE units |
| `watchMeta` | `.caption2` | Plan reference, time, and provenance |
| `watchState` | `.caption2.weight(.medium)` | Literal saved/pending/failed state |
| `watchAction` | `.body.weight(.semibold)` | Primary button and explicit recovery actions |
| `phoneTitle/body/metric` | Native Dynamic Type styles | iPhone continuity |

Exercise names, consequences, values, units, and states are never truncated. At large sizes, nonessential plan explanation hides before Actual value, unit, state, or primary action. The page scrolls where required and never shrinks copy below readability.

## Spacing, Geometry, and Material

- Use a `4 / 8 / 12 / 16 / 20 / 24 pt` rhythm.
- Frequent Watch controls are at least `44 × 44 pt`; preferred primary height is `48 pt`; adjacent targets have at least `8 pt` separation.
- Watch `training-rail` is 8 pt wide with 7 pt notches. A completed notch fills only after durable commit.
- Radius communicates containment: state 7 pt, adjustment control 12 pt, primary action 16 pt, sheet 20 pt. Training data is not fragmented into a card wall.
- Watch uses no shadow, glass, blur, or transparent overlays; use OLED dark, solid fills, and structural rules.
- iPhone may use the cream canvas and soft-white surfaces without decorative elevation.

## Icons, Charts, and Content Assets

- Icons use SF Symbols only and default to monochrome. One hierarchy level keeps one stroke/rendering treatment.
- Small, medium, and large icons are `14 / 18 / 22 pt`; hit targets expand independently to 44 pt.
- Saved uses `checkmark.circle.fill` plus “Saved on this Watch.” Failure uses `exclamationmark.triangle.fill` plus a specific failure explanation.
- Watch Active Workout has no chart, Activity Ring, body illustration, or sensor waveform.
- Analysis charts belong to iPhone and require text/table equivalents.

## Motion and Haptics

| Event | Visual | Haptic | Reduce Motion |
|---|---|---|---|
| Press | 100 ms opacity/tint feedback with no layout movement | Native selection optional | Immediate state feedback remains |
| Durable save | Current rail notch fills over 180 ms and state becomes “Saved on this Watch” | One `.success` after commit | Fill immediately |
| Rest resolution appears | 240 ms native sheet transition | One notification at rest-safe boundary | Transition without displacement |
| Save failed | Error summary replaces pending without shaking | Failure plus visible/VoiceOver equivalent | Same |

There is no page-load choreography, looping model animation, inertial number wheel, or hover. Haptics are never the sole signal.

## State Grammar

| State | Visual and copy contract | Action contract |
|---|---|---|
| `loading` | Keep available durable content; literal “Restoring record…” | Name Cancel when available |
| `pending` | Amber mark + “Not saved yet / Needs confirmation” | Never show success; resolve at safe boundary |
| `success` | Moss mark + “Saved on this Watch” | iPhone return remains separate |
| `warning` | Amber plus explicit consequence | Offer one recovery action |
| `error` | Destructive plus failure summary | Retry preserves input and saved facts |
| `incomplete` | Amber plus missing-field count | Name Finish as incomplete explicitly |
| `conflict` | “Resolve conflict on iPhone” | Watch never adjudicates silently |
| `disabled` | Reduced emphasis + literal “Off” | Native disabled semantics |
| `unavailable` | Explain unsupported capability/device | Offer manual fallback, not a fake switch |

## Component Contracts

### `training-rail`

A sequence component, not decoration. `complete`, `current`, `future`, and `pending` states use fill, outline/shape, and accessibility value together. Complete count is derived from durable Actual Sets.

### `durable-state-label`

Must distinguish not saved, saved on Watch, local save failed, waiting to return to iPhone, and received by iPhone. One generic “Synced” label cannot summarize multiple boundaries.

### `actual-set-primary-action`

The sole Active Workout primary action. Tap enters pending. Only successful commit fills the rail and announces saved. Duplicate taps/replay remain idempotent.

### `metric-stepper`

Provides visible minus/plus controls, ≥44 pt tap targets, Digital Crown acceleration, and an accessibility adjustable action. User input is authoritative Actual fact; plan prefill is labeled Plan.

### `rest-resolution-banner`

Appears only at `restSafeForInteraction`. First states preserved facts, then the uncertain field, then Confirm, Correct, or Later. Resolve one primary question at a time.

### `recovery-action-group`

Resume is the default primary action. Finish as incomplete and Discard remain separate. Discard requires explicit second confirmation naming locally saved facts not yet returned.

## Watch and iPhone Deltas

| Capability | Watch | iPhone |
|---|---|---|
| Active Session | Current set, quick Actual edit, rest resolution, local save | Equivalent phone-only path or returned-session review |
| Plan | Last complete delivered revision only | Creation, AI proposal, Diff, approval, and delivery state |
| Correction | Quick current-set reps/load/exercise correction | Split, merge, insert, delete, and conflict resolution |
| Analysis | No charts | Weekly/monthly and Primary Exercise trend |
| State density | One task per screen | Linear review of complete facts and consequences |

## Representative Surface Contracts

### Active Workout

Hierarchy: Finish entry → Exercise → `training-rail` + Actual Load → target reps/RPE → durable state → Complete Set. Complete Set is the only primary action. Recognition/RPE prompts never appear during active movement.

```text
┌──────────────────┐
│ 18:42      Finish│
│ Back squat       │
│ ●                │
│ ●      80 kg     │
│ ●      Target 5  │
│ ◇      RPE 8     │
│ 3 sets saved     │
│ [ Complete set 4]│
└──────────────────┘
```

### Rest Resolution

First state “5 reps preserved,” then ask about uncertain Exercise or RPE. Confirm is primary; Correct and Later are secondary. The prompt consumes the shared interruption budget.

### Edit Actual Set

Edit one field at a time. Plan value remains reference, Actual value uses `metric-stepper`, and successful save is required before Active Workout can regain a success state.

### Local Save Failed

Preserve user input and three previously saved sets. Error focus lands on “Set 4 is not saved,” then Retry. Never fill the fourth notch or claim iPhone receipt.

### iPhone Continuity

The iPhone Today & Plans exercise rail maps to the Watch set scale. Session Review Actual Set rows receive Watch-committed facts. Color and terminology remain consistent while density and controls are not mirrored.

## SwiftUI Mapping

| Token/component | SwiftUI guidance |
|---|---|
| semantic colors | Asset Catalog named light/dark colors + `Color` extension; no raw hex in Views |
| Dynamic Type | Semantic `Font` styles; metrics use `.fontWidth(.condensed)` without fixed-scaling body copy |
| `training-rail` | `Canvas` or lightweight `Shape`, with one merged accessibility value for all notches |
| primary actions | Native `Button` + `.buttonStyle`; pressed state changes opacity/tint only |
| sheets/navigation | Typed `NavigationStack` / native sheet; no custom web-style modal |
| Digital Crown | `.digitalCrownRotation` + on-screen stepper + `.accessibilityAdjustableAction` |
| Reduce Motion | `@Environment(\.accessibilityReduceMotion)` selects immediate state updates |
| Differentiate Without Color | Shape, fill, text, and symbol all change together |
| focus | Error focuses summary; success focuses durable result; ordinary state updates do not steal focus |

## ND-02 Acceptance Gate

On 2026-09-12, the Product Owner accepted Claude color mapping across Watch light/dark themes, `training-rail`, typography hierarchy, primary action, state grammar, motion/haptics, and representative surfaces. ND-02 is frozen; the ND-03 Watch core screen batch is ready.

---
title: FitnessAI Native UI — ND-01 Replacement Directions
status: selected
stage: ND-01
iteration: 2
updated: 2026-08-08
---

# FitnessAI Native UI — ND-01 Replacement Directions

## 1. Decision Gate

The first comparison set, Quiet Orbit and Set Blocks, was explicitly rejected by the user. Those renders remain diagnostic evidence only and have no visual authority. The second comparison set contained Direction C and Direction D.

The user explicitly selected **Direction D — Kinetic Type** on 2026-08-08 for the earlier comparison run. ND-01 remains historically complete. On 2026-09-08 the authoritative bilingual `DESIGN.md` confirmed **Titanium Measure 1.1.0** as the private-Alpha implementation system and required a separate test-ready iPhone visual/layout contract. That later confirmed spine supersedes Direction D for production while preserving this document as decision history.

### 1.1 Final private-Alpha visual disposition — 2026-09-09

Titanium Measure is the selected implementation direction. Its current expression is minimalist native utility with editorial ledgers, explicit provenance, bounded attention rails, and restrained cyan user-action emphasis. The prior rejection diagnosis in Section 3 applies only to the older dense telemetry expression; it does not reopen or reject the confirmed 1.1.0 system. Production iPhone layouts are in `previews/iphone-core-alpha-final-v1.html` and `native-ui-spec.md`.

## 2. Authority and Preserved Contract

PRD scope/version boundaries and `EXPERIENCE.md` behavior continue unchanged. Both candidates preserve:

1. Apple Watch as active-session authority and iPhone as companion.
2. A quiet formal-set state with one primary action.
3. Actual facts over plan, prediction, automation, and synchronization metadata.
4. Distinct draft, local durable commit, pending sync, and synchronized states.
5. User-authoritative correction without loss of sibling facts or provenance.
6. Offline capture, interruption recovery, visible incomplete facts, manual Finish, and exact-field handoff.
7. Dynamic Type, VoiceOver, Reduce Motion, Increase Contrast, Always On, redundant state cues, and 44 × 44 pt consequential targets.
8. FR-001–FR-007, FR-008–FR-027, FR-028–FR-035, FR-042–FR-048, FR-061–FR-070, UJ-1, UJ-3, and Flow 6.
9. MVP navigation limited to Today & Plans, Training History, and Analysis. V1.1 and Post-MVP destinations remain absent.

## 3. Updated Rejection Diagnosis

### 3.1 Prior Titanium Measure

The prior system equated trust with a dense telemetry ledger: black fields, thin rails, low-contrast micro-labels, repeated rows, and detached cyan action slabs. It flattened Watch and iPhone into one visual grammar and made Today feel like a specification table rather than a lived day.

### 3.2 Rejected replacement set

| Rejected candidate | What it tried | Why it is now discarded |
|---|---|---|
| Quiet Orbit | Reduce the Watch to one central fact and connect the iPhone plan through a continuous runway. | The orbit remained an authored instrument metaphor. It asked the user to accept a new visual concept before simply reading the workout. |
| Set Blocks | Turn sets and Exercises into large tactile planes. | The block language was visually forceful and poster-like. It risked making information containers feel like a design exercise or implying that every plane was interactive. |

### 3.3 Revised design target

The next comparison removes both telemetry and diagrammatic UI. Direction C asks how little visual authorship FitnessAI needs to feel premium and unmistakably Apple-native. Direction D asks how far typography and rhythm—not containers, rings, or dashboards—can carry a distinct athletic brand.

## 4. Direction C — Native Breath

### 4.1 Audience and use context

For regular lifters who value immediate comprehension, calm confidence, and an interface that feels native on day one. It is optimized for quick wrist checks, bright or dim gyms, large Chinese text, and users who distrust “designed-looking” dashboards.

### 4.2 Single primary job

- **Watch Active Session:** read the current Actual Set and complete it without interpreting a visual metaphor.
- **iPhone Today & Plans:** see today's plan, its Watch readiness, and the exercise order in one natural scroll.

### 4.3 Memorable visual thesis

**Confidence through breathing room.** FitnessAI uses native typography, alignment, separators, controls, and material with unusually disciplined whitespace. Brand recognition comes from pacing: one large fact, one quiet evidence line, one action—never from a signature shape.

### 4.4 Visual posture

| Dimension | Direction C posture |
|---|---|
| Typography | Native San Francisco and Simplified Chinese fallback; `.largeTitle`, `.title2`, `.body`, and tabular figures; wide hierarchy jumps with almost no micro-uppercase. |
| Color | Adaptive cloud white / soft charcoal canvas; graphite text; restrained deep jade for action and durable-local confirmation; amber/error colors remain semantic only. |
| Material | Native grouped background and toolbar material; one subtle raised session surface on iPhone; Watch remains visually flat. |
| Geometry | Native rectangles, separators, safe areas, and one full-width button; small set-progress dots are discrete and literal. No custom rings or connected blocks. |
| Imagery | None on Active Session. Today may use a small SF Symbol for Watch readiness; no exercise photography or decorative illustration. |
| Motion | Native navigation and press feedback; a short text/value crossfade after local commit. No custom choreography. |
| Data display | Actual Load is largest, reps and set order are supporting. Source and local durability appear as one readable sentence. iPhone uses a spacious agenda list. |

### 4.5 Justified aesthetic risk

Extreme restraint can appear generic. The mitigation is not extra decoration: it is a consistent “breath ratio” between fact, evidence, and action; distinctive deep-jade action language; precise Chinese line breaks; and rigorous platform-specific typography.

### 4.6 Explicit anti-patterns

- No orbit, gauge, telemetry rail, block collage, decorative gradient, glass card stack, or fitness illustration.
- No small low-contrast trust metadata.
- No custom control when a native SwiftUI control expresses the behavior.
- No empty space without a clear reading rhythm; restraint must not become unfinished layout.

### 4.7 Representative surfaces

#### Apple Watch — Active Session

1. Exercise name and “第 3 / 4 组” form one top reading group.
2. `80 kg` is centered and dominant; “8 次” follows as a separate supporting line.
3. Four literal set dots sit beneath the values; the first three are filled and are accompanied by “3 / 4,” so progress never depends on shape alone.
4. “已保存到本机 · 负重来自上一组” is a single evidence sentence.
5. A native full-width “完成本组” button is the only action.
6. Always On removes the button and preserves Exercise, set, load, reps, and local durability text.

#### iPhone — Today & Plans

1. Native large title “今天” and date establish the day.
2. The selected session appears as one quiet raised surface containing title, duration, exercise/set totals, Watch readiness, and one explicit launch action.
3. “训练顺序” is a spacious native list with ordinal, Exercise, sets × reps, and load. Optional target RPE reflows beneath.
4. Offline cache, stale revision, or Watch unavailable appears as an inline native status row beside the affected launch boundary.
5. Today/History/Analysis remain the only primary destinations.

### 4.8 Preview

Direct preview: `previews/direction-c-native-breath.png`; editable source: `previews/direction-c-native-breath.svg`.

## 5. Direction D — Kinetic Type

### 5.1 Audience and use context

For lifters who want FitnessAI to feel energetic and ownable without becoming game-like. It is optimized for fast recognition under effort, decisive sweat-touch actions, and a companion app that feels like a contemporary training publication rather than a system settings panel.

### 5.2 Single primary job

- **Watch Active Session:** recognize Exercise, load, and next action through bold typographic rhythm.
- **iPhone Today & Plans:** feel the day's training intent immediately, then scan the sequence without reading cards.

### 5.3 Memorable visual thesis

**The typography performs the movement.** Oversized numerals and cropped Exercise language create momentum; a single vertical cadence mark ties set order, local truth, and the next action together. iPhone reads like a training cover flowing into an editorial program, while interaction remains native.

### 5.4 Visual posture

| Dimension | Direction D posture |
|---|---|
| Typography | Native bold/rounded display roles with intentionally cropped decorative duplicates; all semantic text remains uncropped and Dynamic Type safe. Tabular values stay exact. |
| Color | Near-black ink, mineral-white text, high-energy vermilion action, and a cool periwinkle secondary accent; semantic pending/error roles remain distinguishable by text and symbol. |
| Material | Opaque fields and native modal material only. No blur or faux depth on the representative surfaces. |
| Geometry | Large typographic fields, a narrow vertical cadence mark, and edge-to-edge editorial sections. Buttons remain native rounded rectangles and never become diagonal hit regions. |
| Imagery | Typography is the image. No photography, body silhouette, mascot, or synthetic athlete imagery. |
| Motion | On local commit, the decorative type shifts by a few points while semantic values crossfade; Reduce Motion removes displacement. |
| Data display | Values are separated by scale rather than containers. The iPhone plan uses numbered editorial sections with strong baselines and no cards. |

### 5.5 Justified aesthetic risk

Oversized cropped display type can threaten legibility or accessibility. It is permitted only as `accessibilityHidden(true)` decoration behind a complete, uncropped semantic reading order; at large Dynamic Type sizes the decoration disappears.

### 5.6 Explicit anti-patterns

- No motivational slogans, streaks, flames, badges, confetti, or aggression-coded copy.
- No diagonal or cropped semantic text.
- No saturated color for noninteractive decoration during a formal set.
- No animation before or during effort; motion happens only after confirmed local commit.

### 5.7 Representative surfaces

#### Apple Watch — Active Session

1. A quiet semantic header states “杠铃卧推 · 第 3 / 4 组.”
2. A large decorative “80” sits behind the foreground Actual Load; the foreground `80 kg` remains complete and readable.
3. Reps appear as a strong secondary line: “8 次.”
4. A slim vertical cadence mark has three solid stops and one outline; literal “第 3 / 4 组” remains visible.
5. “已保存到本机” is attached to the last completed stop, not encoded by color alone.
6. A vermilion native “完成本组” action anchors the lower safe edge. Always On removes decoration and saturation.

#### iPhone — Today & Plans

1. An editorial masthead combines the literal title “今天训练,” session name, and oversized decorative weekday characters.
2. The explicit Watch launch action sits directly after the session summary and names device readiness.
3. Exercises form numbered full-width editorial sections separated by strong baselines; no card or table enclosure is used.
4. A narrow cadence mark beside each item holds local status, stale/pending edge, or support limitation with literal copy.
5. Plan management follows the sequence as a native text action; it does not compete with launch.
6. Native Today/History/Analysis navigation remains unchanged and future destinations remain absent.

### 5.8 Preview

Direct preview: `previews/direction-d-kinetic-type.png`; editable source: `previews/direction-d-kinetic-type.svg`.

## 6. Structural Comparison

| Question | Direction C — Native Breath | Direction D — Kinetic Type |
|---|---|---|
| Watch structure | Native typographic stack with discrete set dots | Layered type field with a vertical cadence mark |
| iPhone structure | Quiet session surface followed by a native agenda | Editorial masthead followed by numbered full-width sections |
| Emotional character | Calm, premium, familiar, almost invisible | Energetic, distinctive, contemporary, controlled |
| Brand mechanism | Whitespace, pacing, Chinese typography, deep jade action | Typographic scale, cadence, vermilion action, editorial baselines |
| Main risk | May feel too generic | Display type may overpower semantic content |
| Best fit | Maximum clarity and Apple-native confidence | Stronger brand identity without dashboard metaphors |

## 7. Selection Outcome

Selected visual direction:

- **Direction D — Kinetic Type**

Selection clarification incorporated: the earlier right-side device frame was too wide and visually ambiguous. The corrected preview uses an unmistakable portrait iPhone silhouette with Dynamic Island, iOS status bar, native Tab Bar, and Home Indicator. This correction changes presentation only; the representative surface remains iPhone Today & Plans and no ND-02 system work has begun.

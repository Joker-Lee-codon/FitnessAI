---
name: FitnessAI Accessibility & Exertion Context Review
status: complete
reviewed: 2026-07-20
lens: Accessibility & Exertion Context
reviewed_artifacts:
  - DESIGN.md
  - EXPERIENCE.md
  - DESIGN.zh-CN.md
  - EXPERIENCE.zh-CN.md
  - .memlog.md
  - all five frontmatter sources
---

# FitnessAI Accessibility & Exertion Context Review

## Verdict

**Needs revision before the UX spines are finalized.** The current contracts have a strong accessibility foundation: active-set silence, native platform behavior, VoiceOver semantics, Dynamic Type, Reduce Motion, non-color state cues, manual fallback, and local-first recovery are all present. However, four high-severity gaps leave core Watch operation non-testable under exertion. The most important are the undefined meaning of a safe rest window, an unvalidated Digital Crown dependency, non-numeric target-size requirements, and the missing announcement/focus policy for capture-threatening failures.

This is a specification review, not a WCAG conformance claim. WCAG 2.2 is used as the AA floor where applicable to native UI, alongside Apple's platform accessibility guidance.

## Severity Count

| Severity | Count |
|---|---:|
| Critical | 0 |
| High | 4 |
| Medium | 5 |
| Low | 2 |

## Highest Risks

1. A set-end detection can incorrectly be treated as a safe correction window during supersets, circuits, or minimal-rest work, causing a prompt during the next active set.
2. Load, repetition, and RPE correction depends on an unvalidated Digital Crown assumption with no fully specified equivalent path.
3. “Native minimum target sizes” is not an acceptance criterion and does not protect high-frequency Watch controls used with sweat, motion, tremor, or reduced precision.
4. Sensor gaps and local-write failure are listed as states, but the contract does not say which failures interrupt immediately, which wait until rest, or how VoiceOver focus and recovery work.

## Findings

### High

#### H1 — “Rest” is not defined as a safe interaction state

**Location:** `EXPERIENCE.md:31`, `EXPERIENCE.md:81-83`, `EXPERIENCE.md:124`, `EXPERIENCE.md:199-200`, `EXPERIENCE.md:223-226`, `EXPERIENCE.md:338`; mirrored in `EXPERIENCE.zh-CN.md`. Upstream constraints: `brief.md:28`, `prd.md:37`, `prd.md:192`, `prd.md:306-310`.

**Problem:** Corrections are routed to a detected rest period, but the spine leaves the rest-safe window open. In a superset, circuit, drop set, or minimal-rest sequence, a detected set end may be immediately followed by another active set. The prompt can therefore violate active-set silence and demand precise input when the user is already moving.

**Implementable fix:** Add a `restSafeForInteraction` contract distinct from `resting`. A proactive prompt may appear only while the safe state remains true and must disappear or defer before the next set starts. Provide a one-action “Later” path; never expire or discard the pending fact; never use a countdown; route unresolved items to the next safe pause or iPhone batch review. Add acceptance scenarios for supersets, circuits, drop sets, equipment waits, long rests, and no-rest transitions. Verify zero prompt remains visible or is newly announced after the next active set begins, while preserving the shared five-prompt budget.

#### H2 — Core Watch numeric editing relies on an unvalidated Digital Crown assumption

**Location:** `DESIGN.md:189-190`, `EXPERIENCE.md:82-83`, `EXPERIENCE.md:126`, `EXPERIENCE.md:178`, `EXPERIENCE.md:337`, `EXPERIENCE.md:342`; mirrored in both Chinese spines.

**Problem:** The Crown is described as the primary primitive for load, repetition, and RPE values. Discoverability, increments, units, per-side/assisted semantics, and accidental rotation are all unresolved, but no equivalent operable path is required. This risks blocking VoiceOver, Switch Control, AssistiveTouch, users with reduced dexterity, and users who cannot reliably rotate the Crown during exertion.

**Implementable fix:** Define the Crown as an optional accelerator, never the sole means of changing a value. Every numeric control must expose native accessibility-adjustable increment/decrement actions and a touch-operable equivalent; the iPhone handoff must retain the exact field and draft. An accidental Crown rotation must not commit without explicit confirmation. Test both wrist orientations, Crown sides, dominant/non-dominant hand use, VoiceOver, Switch Control/AssistiveTouch, rapid motion, and edit recovery.

#### H3 — Target size and spacing are not measurable; the 1–10 RPE choice is especially exposed

**Location:** `DESIGN.md:185-195`, `EXPERIENCE.md:83`, `EXPERIENCE.md:137`, `EXPERIENCE.md:140`; mirrored in both Chinese spines.

**Problem:** “Native minimum target sizes and adequate spacing” provides no number or exception rule. It cannot be checked in mockups or implementation. A compact ten-choice RPE control, steppers, or adjacent Finish/Continue actions can become difficult to hit on a small Watch while sweating, moving, or trembling.

**Implementable fix:** Make 44 × 44 pt the default hit region for frequent and consequential Watch/iPhone controls; do not shrink primary workout actions below it. Record an explicit exception policy for secondary controls, never below Apple's 28 × 28 pt platform minimum and always satisfying WCAG 2.2 SC 2.5.8's 24 × 24 CSS-pixel floor or spacing/equivalent exception. Specify spacing between adjacent controls and forbid a dense ten-button RPE grid on Watch; use one accessible selection control at a time. Add smallest-supported-Watch physical tests with motion, sweat, tremor/reduced precision, and accidental-tap measurements. Official references: [Apple Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility), [W3C SC 2.5.8](https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum).

#### H4 — Capture-threatening failures have no announcement, focus, or urgency policy

**Location:** `EXPERIENCE.md:108-111`, `EXPERIENCE.md:124-130`, `EXPERIENCE.md:134-139`, `EXPERIENCE.md:153-160`, `EXPERIENCE.md:259-269`; mirrored in `EXPERIENCE.zh-CN.md`. Upstream integrity constraints: `prd.md:181-185`, `prd.md:314-315`, `prd.md:321-323`.

**Problem:** Active Session includes sensor gap, low-resource warning, and local-write failure, while active-set silence suppresses announcements. The spine does not distinguish a harmless sync delay from a failure that means new work is not being durably captured. VoiceOver users may miss the latter; repeated announcements may disrupt the set; recovery focus after relaunch is undefined.

**Implementable fix:** Add an event-priority matrix. Network/cloud sync states wait until rest or finish. A local-write failure, capture stop, or unrecoverable sensor state issues one immediate, coalesced multimodal alert, persists visually, requires no fine-motor dismissal, and preserves the recoverable fragment. Rapid rep/timer changes are never spoken automatically. On Watch Recovery, initial accessibility focus lands on recovered-session identity and durable boundary, followed by the safe `Resume` action; after dismissal, focus returns to the affected set/status. Test with VoiceOver on/off, wrist down/up, Reduce Motion, app termination, and repeated failure events.

### Medium

#### M1 — Dynamic Type is required but has no scale or reflow acceptance criteria

**Location:** `DESIGN.md:148-156`, `EXPERIENCE.md:136`, `EXPERIENCE.md:142`, `EXPERIENCE.md:179`; mirrored in both Chinese spines.

**Problem:** The documents prohibit critical truncation but do not name test scales, smallest devices, reflow behavior, or failure criteria for dense components such as `actual-set-row`, `plan-diff-review`, and lifecycle consequences.

**Implementable fix:** Require at least 200% text enlargement on iPhone and 140% on watchOS, consistent with Apple guidance. At the largest supported accessibility sizes, essential content must remain available without clipping, overlap, or horizontal panning; dense rows reflow into a linear reading order and nonessential detail can move behind an explicit detail action. Test every key surface on the smallest supported Watch and iPhone with Chinese strings. Official reference: [Apple Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility/).

#### M2 — VoiceOver semantics do not define grouping, focus return, or update throttling by component

**Location:** `EXPERIENCE.md:78-88`, `EXPERIENCE.md:134-135`; mirrored in `EXPERIENCE.zh-CN.md`.

**Problem:** Naming object, value, unit, source, state, and action is a good baseline, but reading every field on every focus/update can create long, repetitive speech. The spine does not specify whether state chips are separate focus stops, where sheets receive initial focus, or where focus returns after correction.

**Implementable fix:** Add a per-component accessibility contract covering label, value, hint, traits, adjustable/custom actions, grouping, initial focus, focus return, and announcement cadence. Group an Actual Set into a concise default summary; expose provenance/details through actions instead of duplicate focus stops; coalesce rapid changes; return focus to the edited field/set after a sheet closes.

#### M3 — Permission denial has a fallback state but no accessible permission journey

**Location:** `EXPERIENCE.md:107`, `EXPERIENCE.md:118`, `EXPERIENCE.md:130`, `EXPERIENCE.md:141`, `EXPERIENCE.md:164-169`; mirrored in `EXPERIENCE.zh-CN.md`.

**Problem:** Contextual permissions and manual fallback are specified, but the focus transition into and back from system permission UI, denied/revoked explanation, Settings route, and repeated-prompt prevention are not.

**Implementable fix:** Before each system request, provide a short purpose and what remains usable if denied. After return, restore focus to the initiating context and announce the resulting state once. A denial/revocation surface must offer one clear manual fallback and, where useful, one labeled Settings action; do not repeatedly trigger the system prompt. Verify the full path with VoiceOver and large text, online and offline.

#### M4 — Chinese microcopy is principled but not an implementable cognitive-load contract

**Location:** `EXPERIENCE.md:53-70`, `EXPERIENCE.md:134-142`; mirrored in `EXPERIENCE.zh-CN.md`.

**Problem:** The examples establish truthfulness, but there is no release inventory for the high-risk Watch states. Technical domain words and multi-clause provenance can become difficult under exertion or through speech, especially when the user must decide quickly.

**Implementable fix:** Add a bilingual state-copy table for active capture, rest correction, permission denial, offline/local-save, sync pending, recovery, conflict, and incomplete finish. Each state needs a short visual Chinese label, a complete spoken label, one consequence, and at most one primary next action. Require one-to-one glossary mapping and comprehension testing on physical devices under elevated heart rate/background noise; keep technical English out of user-facing Chinese unless the glossary explicitly requires it.

#### M5 — The WCAG 2.2 AA floor is not mapped to release evidence

**Location:** `DESIGN.md:142-144`, `EXPERIENCE.md:132-142`; mirrored in both Chinese spines.

**Problem:** Contrast, target size, motion, and VoiceOver are mentioned, but there is no auditable surface/state checklist. Relevant requirements such as focus visibility/order, labels in names, status messages, error identification/recovery, alternative input, and prevention of destructive data errors can still be missed.

**Implementable fix:** Add a native-app accessibility acceptance matrix for every IA surface and critical state, mapping at least WCAG 2.2 AA-equivalent expectations for structure/order, text and non-text contrast, text resize/reflow, keyboard/alternative input, visible focus, label-in-name, target size, errors, status messages, and reversible/destructive data actions. Record device/OS, appearance, text size, assistive technology, pass/fail evidence, and defect link. Include VoiceOver, Switch Control, Voice Control/AssistiveTouch where supported, and Full Keyboard Access on iPhone. Official reference: [WCAG 2.2](https://www.w3.org/TR/WCAG22/).

### Low

#### L1 — Custom focus, pressed, and disabled states are not consistently specified

**Location:** `DESIGN.md:61-121`, `DESIGN.md:144`, `DESIGN.md:183-195`; mirrored in `DESIGN.zh-CN.md`.

**Problem:** The contrast target names focus indicators, but component tokens do not define custom focus/pressed/disabled treatment consistently. This is safe only while every control remains fully native.

**Implementable fix:** State explicitly that native states are mandatory unless a custom control documents focused, pressed, selected, disabled, and error behavior. Any custom visible focus/state mark must preserve the 3:1 non-text contrast target and remain distinct without color alone.

#### L2 — Haptic intent is sound, but the event vocabulary and verification remain open

**Location:** `DESIGN.md:210`, `EXPERIENCE.md:127`, `EXPERIENCE.md:139`, `EXPERIENCE.md:343`; mirrored in both Chinese spines.

**Problem:** Haptics are optional and have visual/spoken equivalents, but set boundary, attention, and local-commit patterns are not mapped or tested. Similar patterns can become indistinguishable during lifting.

**Implementable fix:** Define a small event-to-haptic table, user control/disable behavior, visual and spoken equivalent for each event, and a rule preventing repeated haptics for the same unresolved state. Validate distinguishability during representative workouts on physical devices.

## Confirmed Strengths and Passes

- Active-set silence and the five-prompt budget are explicit and source-backed.
- Color is never the only state cue; text, symbol, and accessibility value are required.
- Destructive actions are labeled and confirmed; swipe-only deletion and hidden long-press actions are banned.
- VoiceOver, Dynamic Type, Reduce Motion, manual fallback, offline recording, recovery, and cross-device conflict preservation are present in both languages.
- The published light/dark foreground pairs were independently calculated from the frontmatter tokens. All reviewed normal-text pairs exceed 4.5:1; the lowest reviewed pair is `{colors.action}` on white at approximately 5.69:1. Rendered component states, focus indicators, transparency/materials, Always-On dimming, and physical-device output still require measurement.
- English and Chinese spines preserve the same section structure and the reviewed accessibility conclusions.

## Exit Criteria for This Lens

This lens can pass after H1-H4 are incorporated into the spines, M1-M5 are either incorporated or recorded as owned implementation acceptance work, and physical-device accessibility tests cover at least: smallest supported Watch, largest supported text, VoiceOver, Reduce Motion, alternative input, active set, rest-safe correction, superset/minimal-rest deferral, permission denial, offline recording, local-write failure, interruption recovery, and incomplete finish.


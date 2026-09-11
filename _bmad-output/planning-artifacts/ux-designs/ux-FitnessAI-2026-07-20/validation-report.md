# Validation Report — FitnessAI

- **DESIGN.md:** `/Users/seanlee/Documents/Code/FitnessAI/_bmad-output/planning-artifacts/ux-designs/ux-FitnessAI-2026-07-20/DESIGN.md`
- **EXPERIENCE.md:** `/Users/seanlee/Documents/Code/FitnessAI/_bmad-output/planning-artifacts/ux-designs/ux-FitnessAI-2026-07-20/EXPERIENCE.md`
- **Run at:** 2026-07-20T11:21:07+08:00

## Overall verdict

The spine pair is **adequate as an in-progress Fast-path contract, but not ready for finalization**. Flow, component, state, and bilingual structural coverage are strong; all five source journeys and FR-001–FR-070 are traceable. Token inheritance, active-session behavior, accessibility acceptance criteria, and destructive data-lifecycle truth still require committed rules.

The accessibility and trust reviews materially strengthen the rubric verdict. No critical defect was found, but high-severity issues affect training-time interruption safety, HealthKit state truthfulness, deletion scope, account isolation, dark-mode generation, and native/custom inheritance. Counts below preserve each reviewer's findings; overlapping concerns remain separate because they identify different downstream failure modes.

## Category verdicts

- Flow coverage — adequate
- Token completeness — thin
- Component coverage — strong
- State coverage — strong
- Visual reference coverage — strong
- Bloat & overspecification — adequate
- Inheritance discipline — thin
- Shape fit — strong

## Findings by severity

### Critical (0)

No critical finding.

### High (13)

**[Rubric R-H1 · Flow coverage] — Active-session behavior is not yet one implementable contract** (`EXPERIENCE.md` § Open Questions 2, 3, 5, 7)  
Watch/iPhone correction ownership, rest-safe timing, forgotten-Finish thresholds, and load semantics remain open.  
Fix: phase or resolve each rule and update flows, component behavior, and state transitions together.

**[Rubric R-H2 · Flow coverage] — HealthKit copy/deletion behavior does not close Flow 9** (`EXPERIENCE.md` § Permissions, Privacy, and Sensitive Data; § Open Questions 6)  
Fix: define detachment/deletion scope, provenance, user choices, completion, failure, and retry.

**[Rubric R-H3 · Token completeness] — Component tokens are light-mode only** (`DESIGN.md` frontmatter `components`)  
Dark colors exist only in prose, so a machine consumer can render light surfaces in dark appearance.  
Fix: add explicit dark appearance properties or another spec-valid machine-readable mapping.

**[Rubric R-H4 · Inheritance discipline] — Native inheritance conflicts with custom geometry** (`DESIGN.md` frontmatter; §§ Shapes, Components)  
Fix: classify every component as native-as-is, native-with-delta, or fully custom and remove conflicting properties.

**[Accessibility A-H1] — `resting` is not a safe interaction contract** (`EXPERIENCE.md` Rest Resolution, State Patterns, Key Flows)  
Supersets, circuits, drop sets, and minimal-rest work can receive a prompt during the next active set.  
Fix: define `restSafeForInteraction`, deferral, one-action Later behavior, and zero-active-set-prompt acceptance scenarios.

**[Accessibility A-H2] — Numeric editing depends on an unvalidated Digital Crown assumption** (`DESIGN.md` Components; `EXPERIENCE.md` Component Patterns, Interaction Primitives)  
Fix: make Crown an optional accelerator; require touch and accessibility-adjustable alternatives, explicit commit, and exact-field iPhone handoff.

**[Accessibility A-H3] — Target size and spacing are not measurable** (`DESIGN.md` Components; `EXPERIENCE.md` Accessibility Floor)  
Fix: set 44 × 44 pt as the default frequent/consequential hit region, define exceptions and spacing, and forbid a dense ten-button Watch RPE grid.

**[Accessibility A-H4] — Capture-threatening failures lack announcement and focus priority** (`EXPERIENCE.md` State Patterns, Interaction Primitives, Accessibility Floor)  
Fix: distinguish deferable sync states from immediate local-write/capture failures; define coalesced multimodal alerts and recovery focus order.

**[Trust TPS-01] — HealthKit read denial is modeled as observable** (`EXPERIENCE.md` State Patterns; Permissions, Privacy, and Sensitive Data)  
Apple does not expose whether HealthKit read access was denied.  
Fix: split permission state families and use `data available / no accessible data / query error` for HealthKit reads.

**[Trust TPS-02] — Deletion completion lacks copy-by-copy scope** (`EXPERIENCE.md` Account & Privacy; Flow 9)  
Fix: enumerate Watch/iPhone raw data, synchronized records, personalization state, research data, offline devices, backups, and legal exceptions before claiming completion.

**[Trust TPS-03] — Retained local data is not sealed from a new account** (`EXPERIENCE.md` Permissions, Privacy, and Sensitive Data; Flow 9)  
Fix: require prior-account-bound encryption, invisibility under another account, suspended queues, and explicit transfer eligibility.

**[Trust TPS-04] — Deletion tombstones collapse multiple truth boundaries** (`EXPERIENCE.md` Offline, Synchronization, and Recovery; Flow 9)  
Fix: distinguish device commit, cloud acceptance, known-device application, offline-device pending, retention exception, and failure/retry.

**[Trust TPS-05] — Forgotten-Finish lacks the source-mandated two-signal release gate** (`EXPERIENCE.md` `session-control`, UJ-1, Open Questions 5)  
Fix: require sustained physiological recovery and sustained absence of strength activity; missing/unreliable signals suppress reminders; keep disabled until physical-device thresholds pass.

### Medium (12)

**[Rubric R-M1] — Primary MVP validation cohort is undeclared.** Fix: name the regular progression-focused Apple Watch lifter as primary or explicitly choose another cohort while preserving broader eligibility.

**[Rubric R-M2] — Post-MVP plan-proposal cadence is unresolved.** Fix: gate UJ-4 until post-session, weekly, and cycle-end precedence is defined.

**[Rubric R-M3] — Load-bearing visual and interaction assumptions remain unvalidated.** Fix: validate on physical devices or remove the custom delta and inherit native behavior.

**[Rubric R-M4] — The promised bilingual canonical glossary is missing.** Fix: add an English↔Chinese state and provenance terminology table.

**[Accessibility A-M1] — Dynamic Type has no scale/reflow acceptance criteria.** Fix: define physical-device sizes, enlargement targets, linear reflow, and no-clipping requirements.

**[Accessibility A-M2] — VoiceOver grouping, sheet focus, focus return, and update throttling are unspecified by component.** Fix: add per-component accessibility semantics and announcement cadence.

**[Accessibility A-M3] — Permission fallback lacks an accessible journey.** Fix: define pre-permission purpose copy, return focus, one-time result announcement, fallback, Settings route, and repeat-prompt prevention.

**[Accessibility A-M4] — High-risk Chinese Watch microcopy is not an implementable inventory.** Fix: add short visual labels, complete spoken labels, one consequence, and one primary next action for critical states.

**[Accessibility A-M5] — WCAG 2.2 AA floor is not mapped to auditable release evidence.** Fix: add a per-surface/state acceptance matrix with device, OS, appearance, text size, assistive technology, evidence, and defect link.

**[Trust TPS-06] — Research-consent withdrawal lacks a downstream lifecycle.** Fix: define capture/upload stop, unsent local chunks, server withdrawal, deletion limits, and ordinary-recording continuity.

**[Trust TPS-07] — Export status exists but export inventory and exclusions are absent.** Fix: name format, Plans, Sessions, Actual Sets, revisions, RPE provenance, account metadata, and excluded raw/research/HealthKit data.

**[Trust TPS-08] — Mid-session permission revocation lacks ordered degradation.** Fix: preserve committed facts, stop only the affected stream, abstain dependent inference, retain manual recording, and explain the consequence at a safe pause.

### Low (4)

**[Rubric R-L1] — Trust invariants are repeated across sections.** Fix: keep one normative statement and use cross-references during polish.

**[Accessibility A-L1] — Custom focus, pressed, selected, disabled, and error states are incomplete.** Fix: inherit native states or document every custom state with non-color cues and contrast.

**[Accessibility A-L2] — Haptic vocabulary and verification remain open.** Fix: add a small event mapping, user control, equivalent cues, deduplication, and physical-workout validation.

**[Trust TPS-09] — Highest-risk compound states lack canonical Chinese-first copy.** Fix: add copy for auto-used versus confirmed RPE, abstention, HealthKit no-accessible-data, partial deletion, research withdrawal, and retained local raw data.

## Reviewer files

- `review-rubric.md`
- `review-rubric.zh-CN.md`
- `review-accessibility.md`
- `review-accessibility.zh-CN.md`
- `review-trust-privacy-safety.md`
- `review-trust-privacy-safety.zh-CN.md`

## Post-review disposition

Focused re-verification after spine revision found **no residual High blocker**. Eleven High findings are resolved; `R-H1` and `TPS-05` are safely gated because unapproved load semantics and Forgotten-Finish remain unavailable until their explicit physical-device/release gates pass. The original severity counts above describe the initial reviews and are retained for auditability. Medium and Low findings are either incorporated into acceptance contracts or remain owned physical-device validation and polish work.

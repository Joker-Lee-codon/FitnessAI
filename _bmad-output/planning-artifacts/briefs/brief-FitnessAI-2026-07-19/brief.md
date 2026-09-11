---
title: "Product Brief: FitnessAI"
status: complete
created: 2026-07-19
updated: 2026-07-19
---

# Product Brief: FitnessAI

## Purpose and Evidence Posture

**[ASSUMPTION] Intended use:** internal product definition and input to the PRD and validation plan, not an investor-grade market-sizing document. The current decision is **Conditional GO**: fund sequential Apple Watch evidence gates, and narrow or stop the promise if the recording loop cannot become both trustworthy and materially easier than manual logging.

## Executive Summary

FitnessAI is a near-zero-interaction strength-training recorder for Chinese users, validated first on Apple Watch. It automatically captures sets, repetitions, rest, and supported exercise categories when confidence is sufficient, while keeping active sets free from prompts. Uncertainty is handled during rest through quick confirmation, correction, or a pending record; recognized data is preserved instead of silently discarded.

The product exists because current strength logging forces users to choose between manual completeness and fragile automation. Manual loggers preserve history but interrupt training. Automatic products prove that wrist-based capture is possible, yet users still encounter missed sets, low-wrist-motion blind spots, difficult correction, incomplete histories, and sync or data-loss failures. For progression, a trustworthy complete record matters more than an impressive isolated recognition demo.

FitnessAI will not claim technical novelty or automatic external-load sensing. Its execution thesis is a Chinese-first experience built around reversible automation, data integrity, transparent support boundaries, and an affordable path to long-term history and intelligence. A small exercise set may prove the technology, but public launch requires comprehensive practical coverage of mainstream strength training.

## Target User and Primary Job

The primary user is a Chinese Apple Watch owner who strength trains regularly, wants an accurate history for progression, and currently logs with another app, notes, or memory—or abandons logging because it disrupts the workout.

> When I am strength training, I want the app to capture the workout with almost no manual interaction and produce an accurate daily record afterward, so I can stay focused during the session.

Near-zero interaction is not zero touch. The user starts and finishes the workout. During active sets the system stays silent. High-confidence results save automatically; uncertain results appear during rest; failed recognition asks only for missing fields; unanswered items remain pending. User corrections are authoritative.

## Product Promise and Core Experience

1. **Start once.** The user starts a workout on Apple Watch, optionally with a planned routine.
2. **Capture quietly.** The watch records motion and workout signals and detects set boundaries, repetitions, rest, and supported exercises.
3. **Resolve uncertainty between sets.** Only low-confidence or plan-deviation cases request a quick confirmation; partial success is preserved.
4. **Record external load honestly.** Plan or history may prefill load, but the user manually records or confirms the actual dumbbell, barbell, machine, cable-stack, or assisted load. The watch never presents load as sensed.
5. **Finish with a trustworthy record.** The iPhone companion provides complete review, correction, history, export, and recovery. Confirmed history may improve the current user's personalization.

## What Makes This Different

| Market reality | FitnessAI response |
|---|---|
| Motra and others already show that automatic strength capture is possible; recognition alone is not a moat. | Compete on Chinese taxonomy and UX, trusted recovery, transparent capability boundaries, price fit, and execution quality. |
| Automatic products can create false facts or omit hard-to-detect sets. | Use confidence-driven states, pending records, field-level correction, and undo/edit history; never silently discard recognized fields. |
| Manual leaders remain strong because their records are complete and controllable. | Preserve manual authority while using automation to reduce total interaction rather than remove control. |
| Watch platforms and device models expose different capabilities. | Validate Apple Watch first; later ship only on named Xiaomi devices and a separately proven Huawei/HarmonyOS path with explicit support tiers. |

## Scope and Release Gates

### Apple Watch Technical Validation

- Build a minimal watchOS workout/capability probe plus iPhone receiver before a broad fitness UI.
- Verify full-session motion and heart-rate access, sampling and loss, battery impact, interruption recovery, local persistence, and Watch-to-iPhone transfer.
- Use a small representative exercise set that includes confusing classes and low-wrist-motion cases, not only easy upper-body movements.
- Prototype with suitable public wrist-IMU data, calibrate on 10 complete personal Apple Watch sessions, freeze the pipeline, and evaluate on 5 untouched sessions. This is N=1 feasibility evidence only.

### China Apple Product Validation

- Deliver the complete recording loop: confidence states, pending queue, fast field-level correction, manual-load prefill/confirmation, recovery, and export.
- Test with Chinese Apple Watch strength users against their current logging method.
- Validate lower net interaction, trust in the resulting record, repeated 7-day and 28-day use, and credible willingness to pay.

### Public-Launch Requirement

Public launch must provide comprehensive practical coverage of mainstream gym routines across major muscle groups, free weights, common machines, and bodyweight movements. “Comprehensive” means broad coverage of the target user's real training, not every possible exercise. Launch requires a published per-exercise/per-device matrix for supported, limited, and manual-only behavior, fast fallback, multi-user evidence, full-session reliability, privacy readiness, export/recovery, and support readiness.

### Explicitly Out of Scope for Initial Validation

- Automatic sensing of external load.
- Claims of recognizing every possible strength exercise.
- Precise joint angles, full-body form, true bar path, or true bar velocity from wrist sensors.
- An expansive AI coach, recovery score, content library, social feed, or commerce layer before recording integrity is proven.
- Xiaomi or Huawei product promises inferred from Apple Watch success.

## Success Criteria

| Gate | Evidence required |
|---|---|
| **G-00 Platform viability** | Pre-register thresholds for complete-session capture, sensor gaps, battery use, termination/recovery, local persistence, and Watch-to-iPhone transfer; proceed only if typical strength sessions can be captured reliably. |
| **G-01 Personal algorithm feasibility** | On the frozen five-session N=1 test: set start/end detection at least 80%, supported-exercise classification at least 75%, and repetition error within ±2; also report silent misses, false sets, and results by exercise/failure family. |
| **G-02 Interaction and trust** | Meaningfully fewer watch taps, phone unlocks, and correction seconds than the same user's current logger, without material silent loss or corruption; numeric thresholds must be fixed before testing. |
| **G-03 Product demand** | Chinese Apple Watch users complete repeated workouts, return at 7 and 28 days, trust the record, and show credible willingness to pay; cohort thresholds must be fixed before the pilot. |
| **G-04 Launch readiness** | Comprehensive mainstream-routine coverage, multi-user performance, fast manual fallback, transparent support matrix, recovery/export, privacy/store compliance, sustainable support, and no unresolved critical failure family. |

## Business Direction and Strategic Route

Use a free core that proves complete recording and correction, with paid long-term history, advanced analysis, planning, and deeper personalization. Exact pricing remains a hypothesis and must be tested; low price alone is not differentiation and must not hide unsustainable support, store, or service costs.

The platform sequence is Apple Watch validation for Chinese users, selected Xiaomi devices after Apple gates pass, and a separate Huawei/HarmonyOS capability path. Apple success validates only the Apple beachhead; each later device family requires its own sensor, runtime, battery, distribution, and record-parity evidence.

## Key Risks and Open Questions

| Risk or unknown | Required response |
|---|---|
| Full-session Apple Watch access, transfer, or battery is inadequate. | Run G-00 before broad product work; stop or narrow automatic capture if reliability is insufficient. |
| A small demo set is mistaken for launch coverage. | Maintain separate validation and launch catalogs; define launch coverage by real routine coverage and failure families. |
| Load confirmation or correction becomes tedious. | Use history/plan prefill and one-tap edits; measure total correction burden rather than model accuracy alone. |
| Recognition corrupts training history. | Prefer unknown/pending over forced classification; preserve partial fields, recovery, export, and auditable edits. |
| Health and motion data create privacy or regulatory exposure. | Minimize permissions and collection, favor local/on-device processing, and define consent, encryption, deletion, export, and SDK controls before launch. |
| Pricing and retention are unproven. | Test cohorts after the trustworthy loop works; do not lock price or expand platforms from technical feasibility alone. |

## Vision

If FitnessAI succeeds, it becomes the trusted canonical strength record across Chinese wearable ecosystems: each device contributes only capabilities it can prove, while users retain a consistent history, transparent control, and progressively better personal assistance. Training-cycle planning and deeper intelligence are earned on top of reliable data; they do not precede it.

## Source Basis

- **S-01:** [English brainstorming outcome](../../../brainstorming/brainstorm-ios-apple-watch-fitness-app-2026-07-17/brainstorming-session-results.md) and [Chinese brainstorming outcome](../../../brainstorming/brainstorm-ios-apple-watch-fitness-app-2026-07-17/brainstorming-session-results.zh-CN.md).
- **S-02:** [English market research](../../research/market-fitnessai-near-zero-interaction-strength-training-research-2026-07-18.md) and [Chinese market research](../../research/market-fitnessai-near-zero-interaction-strength-training-research-2026-07-18.zh-CN.md).
- **S-03:** User-supplied scope and decisions captured in this brief's [.memlog.md](.memlog.md).

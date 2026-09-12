---
title: 'Launchable final UI preview for iPhone and Apple Watch'
type: 'feature'
created: '2026-09-12'
status: 'done'
review_loop_iteration: 0
baseline_commit: 'a93f0b49abd7a418a0581fcffef4ee798491dd75'
context:
  - '_bmad-output/planning-artifacts/native-ui-designs/native-ui-FitnessAI-2026-09-11/native-ui-spec.md'
  - '_bmad-output/planning-artifacts/native-ui-designs/native-ui-FitnessAI-2026-09-11/iphone-review-batch.md'
  - '_bmad-output/planning-artifacts/native-ui-designs/native-ui-FitnessAI-2026-09-11/watch-core-batch.md'
---

<frozen-after-approval reason="human-owned intent — do not modify unless human renegotiates">

## Intent

**Problem:** The Xcode workspace launches only truthful empty shells, so the Product Owner cannot yet see or exercise the accepted `2026-09-11` Training Ledger UI on iPhone and Apple Watch.

**Approach:** Replace the empty shells with launchable SwiftUI preview flows backed by deterministic in-memory fixtures. Implement representative iPhone Today, Session Review, and History navigation plus the Watch workout-entry, active-set, rest-resolution, finish-review, and recovery path without claiming persistence, transfer, sensor, or AI behavior.

## Boundaries & Constraints

**Always:** Treat `native-ui-FitnessAI-2026-09-11` as authoritative; preserve Plan/Actual/confirmed/pending semantics; use native navigation and controls; retain accessible labels, Dynamic Type behavior, dark appearance, minimum control targets, and literal preview-only state. Both Xcode schemes must compile and their state tests must pass.

**Ask First:** Any Xcode target restructuring, deployment-target change, dependency addition, destructive change to the prototype or accepted design package, or expansion into persistence, connectivity, HealthKit, sensors, AI, accounts, or backend work.

**Never:** Modify or depend on the obsolete `2026-08-08` UI package; present a tap or fixture as a durable save or successful sync; redesign the frozen UI; add networking, third-party UI dependencies, speculative production architecture, or Chinese duplicate documents.

## I/O & Edge-Case Matrix

| Scenario | Input / State | Expected Output / Behavior | Error Handling |
|----------|---------------|----------------------------|----------------|
| iPhone preview | App launches with fixture plan and sessions | Today is visible and routes to review/history | All facts are labelled as preview data; no sync claim |
| Watch preview | App launches with delivered fixture plan | User can traverse entry, active set, rest, finish, and recovery surfaces | Save/return states remain simulated and literal |
| Accessibility | Dark mode or large Dynamic Type | Core content remains readable and controls remain operable | Layout scrolls instead of truncating essential facts |

</frozen-after-approval>

## Code Map

- `Apps/iPhone/IPhoneAppState.swift` -- typed preview routes and deterministic ledger fixtures.
- `Apps/iPhone/IPhoneRootView.swift` -- iPhone Training Ledger root and review/history surfaces.
- `Apps/Watch/WatchAppState.swift` -- Watch preview phases and fixture facts.
- `Apps/Watch/WatchRootView.swift` -- Watch core-flow surfaces and interactions.
- `Apps/*/Assets.xcassets` -- semantic colors aligned with accepted tokens.
- `Tests/iPhone/IPhoneAppStateTests.swift` -- iPhone state and rendering coverage.
- `Tests/Watch/WatchAppStateTests.swift` -- Watch phase and rendering coverage.

## Tasks & Acceptance

**Execution:**
- [x] Update semantic colors from `tokens.json` for light and dark appearances.
- [x] Implement the iPhone Today → Session Review / History preview with stable typed navigation.
- [x] Implement the Watch entry → active → rest / finish / recovery preview state machine.
- [x] Extend state and accessibility rendering tests without introducing production side effects.

**Acceptance Criteria:**
- Given the iPhone scheme launches, when the preview is operated, then the accepted Training Ledger hierarchy and Today/review/history routes are visible using fixture data.
- Given the Watch scheme launches, when primary and secondary preview controls are operated, then the WC core surfaces can be exercised without implying real persistence or transfer.
- Given either target uses large Dynamic Type or dark appearance, when rendered, then essential facts and actions remain available.
- Given CLI verification runs, when both schemes and tests complete, then the build exits successfully without new dependencies.

## Spec Change Log

## Design Notes

This milestone is intentionally a visual interaction carrier, not the product data layer. State types name preview phases explicitly so later durable domain/application state can replace fixtures without leaving false completion semantics in the UI.

## Verification

**Commands:**
- `xcodebuild -workspace FitnessAI.xcworkspace -scheme FitnessAI-iPhone -sdk iphonesimulator CODE_SIGNING_ALLOWED=NO build test` -- expected: iPhone build and tests succeed.
- `xcodebuild -workspace FitnessAI.xcworkspace -scheme FitnessAI-Watch -sdk watchsimulator CODE_SIGNING_ALLOWED=NO build test` -- expected: Watch build and tests succeed.
- `scripts/ci/run-all.sh` -- expected: all configured automated checks succeed.

## Suggested Review Order

**iPhone interaction carrier**

- Starts at the final Training Ledger root and exposes the three testable review surfaces.
  [`IPhoneRootView.swift:3`](../../Apps/iPhone/IPhoneRootView.swift#L3)

- Keeps preview fixtures typed, deterministic, and replaceable by later domain state.
  [`IPhoneAppState.swift:41`](../../Apps/iPhone/IPhoneAppState.swift#L41)

**Watch interaction carrier**

- Routes the complete preview state machine through one native Watch root.
  [`WatchRootView.swift:3`](../../Apps/Watch/WatchRootView.swift#L3)

- Encodes deterministic entry, active, rest, finish, and recovery transitions.
  [`WatchAppState.swift:3`](../../Apps/Watch/WatchAppState.swift#L3)

**Automated evidence**

- Verifies iPhone default state and large-text dark rendering.
  [`IPhoneAppStateTests.swift:6`](../../Tests/iPhone/IPhoneAppStateTests.swift#L6)

- Verifies the Watch flow transitions and accessible rendering.
  [`WatchAppStateTests.swift:6`](../../Tests/Watch/WatchAppStateTests.swift#L6)

- Gates final semantic assets, surfaces, touch heights, and preview truthfulness.
  [`check-accessibility-shells.sh:9`](../../scripts/ci/check-accessibility-shells.sh#L9)

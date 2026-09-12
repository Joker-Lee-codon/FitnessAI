---
title: 'Make the preview adaptive and Simplified Chinese first'
type: 'bugfix'
created: '2026-09-12'
status: 'done'
review_loop_iteration: 0
baseline_commit: 'ac87c5ce3e7d265083aab279bcb80a83d13bff23'
context:
  - '_bmad-output/implementation-artifacts/spec-final-ui-preview.md'
  - '_bmad-output/planning-artifacts/native-ui-designs/native-ui-FitnessAI-2026-09-11/native-ui-spec.md'
---

<frozen-after-approval reason="human-owned intent — do not modify unless human renegotiates">

## Intent

**Problem:** The first preview does not present a convincing adaptive layout across different iPhone and Apple Watch screen sizes, and its primary interface language is English.

**Approach:** Convert all user-facing iPhone and Watch preview copy to Simplified Chinese using Apple system typography, and make containers, spacing, navigation, scrolling, and compact variants respond to available width, height, orientation, and Dynamic Type.

## Boundaries & Constraints

**Always:** Keep the frozen Training Ledger hierarchy and semantic colors; use system SwiftUI layouts and PingFang-compatible semantic fonts; retain readable essential facts and reachable actions on small screens; center and width-limit content on large screens; preserve preview-only truth labels; test representative compact, regular, landscape, and accessibility sizes.

**Ask First:** Deployment-target changes, target restructuring, third-party fonts or layout dependencies, or removal of existing surfaces.

**Never:** Use fixed device-specific pixel coordinates, shrink essential text below Dynamic Type, truncate exercise/state/consequence text, turn this preview into production persistence or synchronization, or add duplicate Chinese planning documents.

## I/O & Edge-Case Matrix

| Scenario | Input / State | Expected Output / Behavior | Error Handling |
|----------|---------------|----------------------------|----------------|
| Compact iPhone | 320–375 pt width or landscape height | Content remains scrollable, width-safe, and actions remain reachable | Nonessential spacing compacts before text truncates |
| Large iPhone/iPad-width host | Wide regular-width container | Ledger content is centered and capped at a readable width | No stretched full-width cards |
| Compact Watch | 42 mm-class screen | Current purpose and next action remain reachable through compact layout/scroll | Secondary detail yields before primary facts |
| Large text | Accessibility Dynamic Type | Essential Chinese content wraps and scrolls without overlap | No fixed-height content containers |

</frozen-after-approval>

## Code Map

- `Apps/iPhone/IPhoneAppState.swift` -- Chinese fixture labels and tab names.
- `Apps/iPhone/IPhoneRootView.swift` -- adaptive iPhone containers and Chinese surfaces.
- `Apps/Watch/WatchRootView.swift` -- compact/regular Watch presentation and Chinese surfaces.
- `Tests/iPhone/IPhoneAppStateTests.swift` -- multi-size iPhone rendering evidence.
- `Tests/Watch/WatchAppStateTests.swift` -- multi-size Watch rendering evidence.
- `scripts/ci/check-accessibility-shells.sh` -- Chinese-first and adaptive-layout static gate.

## Tasks & Acceptance

**Execution:**
- [x] Translate every visible preview string to Simplified Chinese and set Chinese locale at app roots.
- [x] Add width-limited, orientation-safe iPhone composition with scrollable essential content.
- [x] Add compact-height/width-aware Watch composition with reachable primary actions.
- [x] Test small/large/landscape iPhone and 40/42/46/49 mm-class Watch rendering plus accessibility sizes.

**Acceptance Criteria:**
- Given either target launches, when its first and secondary surfaces appear, then Simplified Chinese is the primary visible language and Apple system fonts render it.
- Given representative supported screen sizes and orientations, when each root renders, then no essential fact or action depends on a single fixed screen size.
- Given large Dynamic Type, when either target renders, then content wraps or scrolls without overlapping fixed containers.
- Given the eight automated checks run, when verification completes, then every check passes.

## Spec Change Log

- 2026-09-12: Simulator inspection exposed legacy letterboxing despite successful view rendering; enabled generated launch screens and added a regression gate while preserving the adaptive SwiftUI composition.

## Design Notes

Adaptive behavior uses available geometry only to choose density and readable maximum width. It does not maintain per-device model tables, so future screen sizes inherit the same rules.

## Verification

**Commands:**
- `scripts/ci/run-all.sh` -- passed all eight checks, including both simulator schemes and multi-size render tests.

**Simulator evidence:**
- iPhone 17e and iPhone 17 Pro Max launch full-screen without legacy letterboxing.
- Apple Watch SE 3 (40mm) renders Chinese-first content without horizontal clipping; longer content remains scrollable.

## Suggested Review Order

**Adaptive composition**

- Start with the iPhone readable-width, scrolling ledger composition.
  [`IPhoneRootView.swift:51`](../../Apps/iPhone/IPhoneRootView.swift#L51)

- Review the Watch geometry-aware scrolling container.
  [`WatchRootView.swift:216`](../../Apps/Watch/WatchRootView.swift#L216)

- Confirm modern full-screen launch behavior is enabled in both configurations.
  [`project.pbxproj:96`](../../FitnessAI.xcodeproj/project.pbxproj#L96)

**Chinese-first interface**

- Confirm the iPhone app root enforces Simplified Chinese locale.
  [`FitnessAIApp.swift:3`](../../Apps/iPhone/FitnessAIApp.swift#L3)

- Confirm Watch surfaces use Chinese primary copy and system typography.
  [`WatchRootView.swift:24`](../../Apps/Watch/WatchRootView.swift#L24)

**Regression evidence**

- Check compact, regular, landscape, and accessibility iPhone render coverage.
  [`IPhoneAppStateTests.swift:15`](../../Tests/iPhone/IPhoneAppStateTests.swift#L15)

- Check representative Watch size and accessibility render coverage.
  [`WatchAppStateTests.swift:23`](../../Tests/Watch/WatchAppStateTests.swift#L23)

- Verify Chinese, adaptive, touch-target, and full-screen static gates.
  [`check-accessibility-shells.sh:25`](../../scripts/ci/check-accessibility-shells.sh#L25)

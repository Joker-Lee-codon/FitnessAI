---
title: 'Compact the iPhone header and page Watch content with the crown'
type: 'bugfix'
created: '2026-09-12'
status: 'done'
review_loop_iteration: 0
baseline_commit: 'f1ad2d4'
context:
  - '_bmad-output/implementation-artifacts/spec-adaptive-simplified-chinese-ui.md'
---

<frozen-after-approval reason="human-owned intent — do not modify unless human renegotiates">

## Intent

**Problem:** The iPhone Today screen leaves too much space between the status area and its title. Watch content uses continuous scrolling, but the intended interaction is full-screen, crown-driven page navigation.

**Approach:** Use a compact iPhone navigation title. Replace every Watch `ScrollView` with native vertical page-style `TabView` composition, splitting dense states into concise full-screen information and action pages.

## Boundaries & Constraints

**Always:** Preserve Chinese-first copy, semantic colors, preview-only truth labels, existing phase transitions, readable essential facts, and large touch targets. Each Watch page fills the available display and the Digital Crown advances one snapped page at a time.

**Ask First:** Changing deployment targets, removing a state or action, or introducing custom crown physics.

**Never:** Retain continuous vertical scrolling on Watch, place essential content beyond the bounds of a page, rely on device-model lookup tables, or add persistence/network behavior.

## I/O & Edge-Case Matrix

| Scenario | Input / State | Expected Output / Behavior | Error Handling |
|----------|---------------|----------------------------|----------------|
| iPhone Today | Any supported iPhone | “今日” uses compact system navigation spacing | Content remains below safe areas |
| Watch crown | Crown rotates downward | Current full-screen page snaps to the next page | First/last page stays bounded |
| Compact Watch | 40–42mm display | Each page fits without continuous scrolling | Dense states split into more pages |
| Large text | Accessibility Dynamic Type | Page copy remains readable and actions remain available | Concise page variants prevent overlap |

</frozen-after-approval>

## Code Map

- `Apps/iPhone/IPhoneRootView.swift` -- Today navigation-title presentation.
- `Apps/Watch/WatchRootView.swift` -- Watch page containers and per-state page breakdown.
- `Tests/Watch/WatchAppStateTests.swift` -- page-style multi-size rendering coverage.
- `scripts/ci/check-accessibility-shells.sh` -- prohibit Watch scrolling and require vertical paging.

## Tasks & Acceptance

**Execution:**
- [x] Compact the iPhone Today title without changing its ledger content.
- [x] Replace Watch adaptive scrolling with crown-controlled, full-screen vertical paging.
- [x] Split dense Watch phases into bounded information/action pages.
- [x] Add automated gates and render tests for the new paging structure.

**Acceptance Criteria:**
- Given Today opens, when the screen appears, then its title uses compact navigation-bar spacing.
- Given any Watch phase, when the user rotates the crown, then navigation moves between discrete full-screen pages rather than continuously scrolling content.
- Given representative 40–49mm layouts, when pages render, then essential Chinese text and actions fit their page.
- Given the eight automated checks run, when verification completes, then all checks pass.

## Spec Change Log

## Design Notes

Native watchOS vertical page-style `TabView` owns crown focus and snapping. Information is grouped by purpose instead of squeezed into a single vertically scrolling surface.

## Verification

**Commands:**
- `scripts/ci/run-all.sh` -- passed all eight checks.

**Simulator checks:**
- iPhone 17e verified compact title spacing.
- Apple Watch SE 3 (40mm) verified a full-screen first page, paging indicator, and crown instruction.

## Suggested Review Order

**Crown-driven Watch paging**

- Start with the native vertical paging container and full-screen page boundary.
  [`WatchRootView.swift:253`](../../Apps/Watch/WatchRootView.swift#L253)

- Review how the workout entry is separated into overview, plan, and action pages.
  [`WatchRootView.swift:24`](../../Apps/Watch/WatchRootView.swift#L24)

- Review active-workout data and controls split across discrete pages.
  [`WatchRootView.swift:71`](../../Apps/Watch/WatchRootView.swift#L71)

**iPhone header spacing**

- Confirm Today now uses compact system navigation-title spacing.
  [`IPhoneRootView.swift:117`](../../Apps/iPhone/IPhoneRootView.swift#L117)

**Regression gates**

- Confirm continuous Watch scrolling is prohibited and vertical paging required.
  [`check-accessibility-shells.sh:29`](../../scripts/ci/check-accessibility-shells.sh#L29)

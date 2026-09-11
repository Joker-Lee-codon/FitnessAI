# SwiftUI Implementation Mapping

## 1. Purpose

This is an implementation specification, not production App code. It maps the confirmed visual system to native iOS 18+ and watchOS 11+ primitives.

## 2. Token Layer

Create semantic color assets for every role in `design-system/fitnessai/tokens.json`, including Any, Dark, and High Contrast appearances. Expose them through a small `TitaniumTheme` value type; page code must not contain raw hex values.

Use semantic text styles plus `@ScaledMetric` for dominant training figures:

```swift
@ScaledMetric(relativeTo: .largeTitle) private var metricSize: CGFloat = 56

Text(value)
    .font(.system(size: metricSize, weight: .bold, design: .default))
    .monospacedDigit()
```

## 3. Environment Inputs

```swift
@Environment(\.accessibilityReduceMotion) private var reduceMotion
@Environment(\.accessibilityDifferentiateWithoutColor) private var differentiateWithoutColor
@Environment(\.accessibilityContrast) private var accessibilityContrast
@Environment(\.colorScheme) private var colorScheme
@Environment(\.isLuminanceReduced) private var isLuminanceReduced // watchOS
```

Always On switches semantic mappings and action presentation; it does not create an unrelated layout.

## 4. Navigation

- iPhone: `TabView` for Today, History, Analysis; `NavigationStack` with typed `navigationDestination(for:)` for details.
- Watch pre-session: native navigation. Active session: a shallow state-driven surface without exploratory tabs.
- Watch→iPhone handoff payload identifies session, set, field, draft, provenance, and return context.

## 5. Native Primitive Mapping

| Visual component | SwiftUI primitive |
|---|---|
| Primary/secondary action | `Button`, `ButtonStyle`, semantic `role` |
| Adjustable load/RPE | `Stepper` or custom buttons + `digitalCrownRotation` + accessibility adjustable action |
| Status/provenance | `Label`, `accessibilityElement(children: .combine)` |
| Ledger rows | `Grid` on iPhone, `VStack/HStack` adaptive on Watch |
| Trend chart | `Chart`, `LineMark`, `BarMark`, `RuleMark`, `PointMark` |
| Loading | `ProgressView` or geometry-preserving skeleton |
| Correction/recovery | `sheet`, state-driven full surface on Watch where space requires |
| Confirmation | `confirmationDialog`/`alert` for destructive consequences |
| Settings/lifecycle | `Form` semantics with custom titanium row styling |

## 6. State Ownership

UI state must distinguish `draft`, `localCommit`, and `sync` phases. A recommended view model shape is:

```swift
enum LocalCommitState { case editing, committing, saved, failed }
enum SyncState { case notRequired, pending, synchronized, failed, conflict }
```

Never derive one enum from the other. The view may show “已存于本机 · 等待同步” simultaneously.

## 7. Animation and Haptics

Use explicit value-driven animation only:

```swift
.animation(reduceMotion ? nil : .easeOut(duration: 0.18), value: state)
```

Prefer crossfade/opacity replacement. Do not animate during active sets except direct press feedback or record-integrity warning. Trigger haptics from successful state transitions, not taps.

## 8. Accessibility

- Use literal Chinese `accessibilityLabel`, `accessibilityValue`, and consequence-bearing `accessibilityHint`.
- Group a compact Actual Set row by default; add custom actions for Edit, repetitions, load, and RPE.
- Restore focus using `AccessibilityFocusState` after correction/handoff.
- Charts expose a summary before individual points and an accessible data list.
- At large text sizes, switch grids to stacked layouts using `ViewThatFits`, size category, or layout protocol.

## 9. Planned Extensions

### V1.1 plan-file extension

Use native `fileImporter`/`fileExporter` or document APIs with a declared FitnessAI plan content type. Parse off the main actor under the bounded DV-007 limits; reject executable or malformed structures before constructing view state. The view model separates `validation`, `mappingDraft`, and `localCommit`, and exposes no merge/replace-existing command. Security-scoped access is released promptly; diagnostics contain no credentials or unrelated workout data.

### Future structured-input extension

Reserve source/provenance, draft, ambiguity, duplicate/conflict, and local-commit states without adding an MVP permission or voice dependency. If voice is later activated, microphone/speech permission and audio lifetime belong to a capability-specific adapter; `StructuredInputDraft` receives parsed structured values and never treats raw transcription as committed truth.

## 10. Verification Targets

Preview and test at small/large iPhone, supported Watch cases, dark/light, High Contrast, largest content size categories, VoiceOver, Reduce Motion, Always On, offline, local-write failure, and conflict states. Production acceptance still requires physical devices.

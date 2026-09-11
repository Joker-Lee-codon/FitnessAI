# iPhone — Support Matrix

## 1. Purpose and Authority

Names supported, limited, manual-only, and unsupported combinations for Watch, iPhone, OS, Exercise, signal, and approved load semantics.

## 2. Entry and Exit

- Entry: onboarding, Workout Entry boundary, Exercise Catalog, support/settings.
- Exit: exact manual fallback, compatible-device guidance, canonical Exercise correction, return to affected action.

## 3. Composition

1. Matrix version and last verified date.
2. Filter by device/OS/Exercise/semantic.
3. Comparison ledger with symbol + literal state.
4. Exact limitation, retained fields, and fallback per row.
5. Matrix unavailable state that does not invent support.

## 4. Components

Filter controls, `SupportBoundaryNotice`, comparison ledger, `FactStateLabel`, `SystemStatePanel`.

## 5. Required States

Loading; supported; limited; manual-only; unsupported combination; low confidence; matrix version unavailable; offline cached matrix.

## 6. Interaction and Accessibility

No color-only heatmap. Each row groups device/Exercise, state, limitation, and fallback. Filters retain state on back navigation. Unsupported never becomes a dead disabled control without explanation.

## 7. Requirements and Flows

FR-049–FR-053 and the PRD load-semantics/device release gates; Flow 8.

## 8. Preview and Validation

Preview: `../previews/iphone-system-pages-review.png`, screen 04. Validate matrix unavailable, offline cached version, manual-only fallback, largest Chinese labels, and screen-reader table order.

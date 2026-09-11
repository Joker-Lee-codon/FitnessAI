# iPhone — Account & Privacy

## 1. Purpose and Authority

Manages FitnessAI Account, capability-specific permissions, research consent, export, deletion, sign-out local-data choice, and account-switch consequences with exact copy scopes.

## 2. Entry and Exit

- Entry: settings/account route, sign-in restoration, lifecycle notification.
- Exit: sign in/out, manage capability, request export/deletion, withdraw research consent, retain/remove local data, preview account switch.

## 3. Composition

1. Account identity and restoration/sync boundary.
2. Capability rows with observable state and fallback.
3. Data-copy inventory: local structured, synchronized, Apple Health-owned, research upload, local raw streams.
4. Export/research/deletion lifecycle rows.
5. Spatially separated sign-out/account deletion actions with consequence preview.

## 4. Components

`LifecycleRequestRow`, `SyncBoundaryIndicator`, capability state row, copy-scope ledger, destructive confirmation.

## 5. Required States

Signed out/in; restoration; HealthKit share states; HealthKit read states; motion/notification states; consent lifecycle; export lifecycle; deletion boundaries; offline device pending; sign-out choice; account-switch preview.

## 6. Interaction and Accessibility

HealthKit read never claims denial. Sign-out asks retain encrypted local account data or remove it and previews unsynchronized impact. Account switch never merges history silently. Lifecycle completion names included and excluded copies.

## 7. Requirements and Flows

FR-042–FR-048, FR-067–FR-070; UJ-5, Flow 9.

## 8. Preview and Validation

Preview: `../previews/iphone-system-pages-review.png`, screen 03. Validate HealthKit wording, export scope, offline deletion device, research withdrawal, sign-out, and account switch.

# iPhone — Today & Plans

## 1. Purpose and Authority

Shows today's selected Training Plan, starts the Watch route, and provides access to plan management without becoming active-session authority.

## 2. Entry and Exit

- Entry: app open, Today tab, restored navigation state.
- Exit: Start on Watch, plan detail/edit, create from history, open sync/support issue.

## 3. Composition

1. Date and “今天训练” title.
2. Selected-plan working surface with exercises, sets, duration, and target RPE opt-in state.
3. Full-width “在 Watch 上开始” action.
4. Ordered exercise timeline with planned labels.
5. Device/sync boundary near the affected plan, not as a global toast.

## 4. Components

`TitaniumPrimaryAction`, plan ledger, `SyncBoundaryIndicator`, `SupportBoundaryNotice`, empty/loading `SystemStatePanel`.

## 5. Required States

Cold load; selected plan; no plan; draft; offline cached; stale plan revision; plan load failure; Watch unavailable.

## 6. Interaction and Accessibility

The start action names Watch explicitly. Offline cached plan remains readable. At 200% text, exercise rows stack planned fields. VoiceOver reads plan identity and total before individual exercises.

## 7. Requirements and Flows

FR-028, FR-035, FR-043–FR-045; UJ-1, UJ-2, UJ-3.

## 8. Preview and Validation

Preview: `../previews/iphone-core-pages-review.png`, screen 01; themes in `../previews/themes-review.png`. Validate no-plan, offline cache, stale revision, and Watch unavailable.

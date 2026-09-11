# iPhone Planning and Review Page Overrides

## Scope

Applies to private-Alpha Plan Home, AI Plan Chat, Remote AI Authorization, Proposal Review, Approval/Commit/Delivery, Training Plans, Training History, Session Review, proactive review, and first-party Plan Exchange.

## Composition

- Use a stable native navigation title and 20 pt compact-width content inset.
- Reserve raised surfaces for the selected plan, a blocking review boundary, or a modal editor. Lists and session facts use rules, alignment, and whitespace.
- Place the current plan/action first, followed by ordered exercise facts. Never visually merge planned values with Actual Sets.
- Session Review uses a ledger: boundary status → summary → Actual Sets → provenance/revisions → plan diff → one completion action.
- Plan Exchange uses a source/version header → complete plan ledger → mapping/omission ledger → one Create New Draft action. It never offers merge or replace-existing.
- AI planning uses conversation → default-off authorization → complete proposal/diff → separate approval → local commit → Watch delivery; none of these boundaries share one optimistic success state.
- Fixed bottom actions reserve the home-indicator safe area and equivalent scroll inset.

## Navigation

- Today, History, and Analysis are top-level tabs with SF Symbol plus text label.
- Plan detail/editor and Session Review use `NavigationStack`; back restores scroll and edited draft state.
- Plan Exchange is contextual to plan detail or iOS file open; it is never a top-level tab.
- Deep links identify the exact Workout Session, Actual Set, field, revision, or Training Plan.

## Data and State

- Actual values use `text.primary`; planned reference values use secondary treatment and explicit “计划” label.
- Pending, corrected, auto-used, confirmed, and conflict states use symbol + literal text + structural marker.
- Conflict and stale Analysis boundaries use a full-width attention row, not a toast.
- Offline cached content remains usable and names its last known/sync state.

## Accessibility

- At 200% text size, metric groups and ledger columns become stacked field groups.
- Actual Set rows expose a grouped summary plus Edit and field-specific custom actions.
- Full Keyboard Access order follows the ledger; focus returns to the edited row/field.
- Destructive actions remain separated from the primary completion action.

## Preview Authority

See `iphone-core-pages-review.png` and `themes-review.png` in the confirmed visual delivery.

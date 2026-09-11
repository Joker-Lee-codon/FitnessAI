# Watch Training Page Overrides

## Scope

Applies to Workout Entry, Active Session, Rest Resolution, Watch Recovery, and Watch Finish Review. `MASTER.md` remains authoritative unless this file is more specific.

## Composition

- Use the full safe display area; avoid a persistent navigation shell during an active Workout Session.
- Keep one dominant fact or question in the optical center and one full-width primary action near the lower safe edge.
- Use rails and alignment, not stacked cards. A modal boundary is reserved for destructive confirmation or system-required permission UI.
- Preserve a stable exercise/set header between Active Session, Rest Resolution, and recovery transitions.

## Watch-Specific Type

- Actual Load is the largest value when it is relevant; repetitions are secondary but remain independently readable.
- Exercise names allow two lines before reducing decorative metadata.
- Timer and sync metadata use `.caption2`; they never displace Exercise, load, repetitions, or the primary action.
- Always apply `monospacedDigit()` to load, reps, rest time, set order, and RPE.

## Interaction

- Frequent or consequential actions use at least 44 × 44 pt.
- Digital Crown adjusts a draft only. Touch and accessibility-adjustable actions must provide equivalent control.
- Formal-set state suppresses noncritical prompts, chart motion, celebration, and sync announcements.
- Rest Resolution appears only in `restSafeForInteraction`; losing the safe state dismisses it without losing pending facts.
- Primary action press feedback uses opacity/state fill without changing bounds.

## Always On

- Preserve Exercise, set number, Actual Load, repetitions, and saved boundary.
- Replace filled cyan controls with a noninteractive outline/label and lower noncritical rail luminance.
- Do not show rapidly updating seconds unless platform energy guidance permits; use minute-level or static rest context.

## Accessibility

- VoiceOver order: context → dominant fact → source/authority → durability → primary action.
- Group Actual Set facts into a concise default element; expose adjustable or custom actions for fields.
- At 140% text size, reflow the load/reps split into stacked values before clipping.
- Increase Contrast raises secondary rails to 2 pt and adds an outline around attention regions.

## Preview Authority

See `visual-design-pro-max/previews/watch-pages-review.png` and `themes-review.png` in the confirmed visual delivery.

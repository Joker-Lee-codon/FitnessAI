# FitnessAI iPhone Review Screen Batch

## Document State

- Stage: `ND-03 Screens`
- Batch: `iPhone review`
- State: accepted and frozen by the Product Owner on 2026-09-12
- Direction: `Training Ledger`
- Frozen tokens: `0.2.0-nd02-accepted`
- Surfaces: `IR-01 Today & Plans`, `IR-02 Session Review`, `IR-03 Training History`

## Batch Thesis

The iPhone is the place where training facts become understandable, correctable, and reusable. It does not enlarge the Watch or lead with motivational analytics. The page behaves like a calm training register: the left ledger spine preserves sequence, horizontal rules separate evidence, and Plan/Actual columns make differences explicit.

Cream is the document surface, ink carries durable facts, terracotta marks Plan provenance, muted violet marks Actual/correction, moss marks confirmed local facts, and amber marks incomplete or pending evidence. The ledger spine—not the Claude-like palette—is the distinctive element.

## Shared Layout

```text
┌──────────────────────────────────┐
│ large native title        action │
│ context / literal state          │
├─ ledger spine ───────────────────┤
│ one dominant object              │
│ evidence rows / Plan ↔ Actual    │
│                                  │
│ contextual next action           │
└──────────────────────────────────┘
```

- Left alignment is the default. Metrics align by value and unit, not by decorative center alignment.
- The first viewport identifies the current effective plan or selected session before showing derived summaries.
- The ledger spine continues the Watch `training-rail`: Exercise order on Plan Home, Actual Set order in Session Review, and chronological session order in History.
- Use native lists, disclosure rows, navigation, refresh, search, and sheets. Custom drawing is limited to the ledger spine and Plan/Actual delta rule.
- No dashboard mosaic, hero gradient, Activity Ring, decorative streak, generic insight card, or floating AI orb.

## Surface IR-01 — Today & Plans

**Purpose.** Establish the current effective Plan Revision, its Watch delivery truth, the next executable session, and returned sessions requiring review.

**Entry / exit.** This is the private-Alpha root. Start on Watch remains a Watch action. `Review session` opens IR-02; `View history` opens IR-03; plan creation/revision enters the separate AI planning flow.

**Traceability.** `FR-028–035`, `FR-043–046`, `FR-054–060`, `FR-078–087`; `UJ-4`, `Flows 2–4`.

**Hierarchy.** Today/date → current effective revision → literal Watch delivery state → next session and ordered Exercises → returned-session review queue → create/revise actions.

**Primary action.** When a returned session needs attention, `Review returned session`; otherwise `Open next session`. AI creation/revision remains contextual and never competes with a pending truth-resolution action.

**Components / tokens.** `plan-revision-header`, `sync-state-indicator`, phone `training-rail`, `session-control`; `canvas`, `surface`, `planText`, `confirmedText`, `pendingText`, `phoneTitle`, `phoneBody`, `phoneMetric`.

| State | Contract |
|---|---|
| Default | Name the effective revision, next session, and Watch delivery separately. |
| Loading | Keep the current effective plan and cached returned sessions visible; refresh state stays inline. |
| Empty | “No effective plan yet.” Offer `Create a plan` and distinct `Start phone-only workout`; do not invent a recommendation. |
| Watch pending | “Revision 8 is waiting to reach Watch. Revision 7 remains available there.” |
| Watch failed/offline | Preserve Revision 7, name failure, offer idempotent Retry, and never show partial Revision 8. |
| Returned session pending | Show Watch authority and receipt state without blocking plan access. |
| Conflict | Name the affected session/revision; resolve through an explicit comparison, not device time. |
| Permission unavailable | Plan access and local workout remain available; optional capability status stays subordinate. |
| Accessibility | The revision header announces effective identity and delivery state; Exercise rail has one summary plus navigable rows. |
| Appearance | Light is default; dark preserves document hierarchy without switching to glowing dashboard chrome. |

**Ownership / handoff.** iPhone owns plan truth, delivery inspection, and returned-session routing. Watch owns an active Watch-captured session and keeps its Start snapshot fixed.

**SwiftUI constraints.** `NavigationStack` root with native refresh. Stable IDs preserve scroll/filter state. Loading does not replace durable content. Delivery retry is idempotent and cannot activate a partial revision.

## Surface IR-02 — Session Review

**Purpose.** Show every recorded Actual Set, distinguish it from Plan, resolve incomplete facts, and expose auditable corrections before Analysis or AI review.

**Entry / exit.** Enter from Today returned-session queue, History, or transfer notification. Field edits open scoped native editors. Completion returns to the same session and updates dependent History/Analysis only after an effective revision exists.

**Traceability.** `FR-002–007`, `FR-029`, `FR-033–041`, `FR-061–067`, `FR-089–091`; `UJ-1`, `UJ-2`, `Flows 2–3`.

**Hierarchy.** Complete/Incomplete state → session identity and local/receipt provenance → Actual summary → ordered Exercise/Actual Set ledger → unresolved or corrected facts → body areas → optional Apple Health write → non-blocking AI review invitation.

**Primary action.** `Resolve 1 incomplete item` when incomplete; otherwise there is no permanent primary CTA. Editing, Apple Health write, and `Ask AI to review` remain clearly separate actions.

**Components / tokens.** `actual-set-row`, `durable-state-label`, `recognition-state-chip`, `sync-state-indicator`, `proactive-review-invitation`; `actualText`, `confirmedText`, `pendingText`, `destructive`, `phoneMetric`.

| State | Contract |
|---|---|
| Complete | Show all effective Actual Sets and provenance; nothing disappears after Finish. |
| Incomplete / partial | Put exact missing/pending fields before summaries; keep usable facts visible. |
| Loading / offline cache | Render cached complete facts and literal freshness/receipt state. |
| Corrected | Field row shows effective value and correction marker; disclosure reveals prior value and provenance. |
| Conflict | Preserve both revisions and block dependent Analysis/AI proposal until explicit resolution. |
| Edit failure | Retain user input, focus error summary, and offer Retry without rewriting sibling fields. |
| Destructive | Delete/split/merge actions name exact set scope, require confirmation where destructive, and remain visually separate. |
| Apple Health unavailable/failed | Local session remains authoritative; write state is optional and retryable. |
| Proactive review | One nonmodal invitation with Review/Later/Disable; showing it sends nothing. |
| Accessibility | Headings navigate Exercise groups; each row announces order, Actual values, Plan differences, completeness, and provenance. |

**Ownership / handoff.** Watch-committed facts arrive idempotently. iPhone owns full correction, split/merge/insert/delete, conflict resolution, complete review, Apple Health write, and optional AI review entry.

**SwiftUI constraints.** Use stable, field-scoped editing routes. Apply revisions atomically. A row never visually commits until its local write succeeds. Body areas and summaries derive only from effective Actual Sets.

## Surface IR-03 — Training History

**Purpose.** Browse complete and incomplete planned/ad-hoc sessions while preserving correction, transfer, and conflict truth.

**Entry / exit.** Enter from Today or Session Review. Search/filter selections and scroll position survive native back. Selecting a session opens IR-02 at the exact effective or unresolved record.

**Traceability.** `FR-036–046`, `FR-061–068`; `UJ-1`, `UJ-2`, `Flows 2–4`.

**Hierarchy.** Period/search/filter → chronological ledger → literal session completeness → planned/ad-hoc origin → Exercise count and effective volume → transfer/correction/conflict state.

**Primary action.** None in the populated state; selecting a session is navigation. Empty state uses `Record first workout`.

**Components / tokens.** `history-ledger-row`, `durable-state-label`, `sync-state-indicator`; `textPrimary`, `textSecondary`, `actualText`, `confirmedText`, `pendingText`.

| State | Contract |
|---|---|
| Ready | Newest effective session first; group by calendar period without hiding exact dates. |
| Loading | Keep cached rows; inline progress does not replace history. |
| Empty | Explain that recorded workouts appear here; route to planned or ad-hoc recording. |
| Offline cache | Name last refresh and keep locally available review usable. |
| Incomplete | Amber structural mark plus exact unresolved count; session remains selectable. |
| Corrected | Mark “Corrected” without treating it as an error; Session Review exposes audit history. |
| Return pending/failed | Keep the Watch session identity distinct; Retry cannot duplicate it. |
| Conflict | Show “Needs comparison”; dependent Analysis remains stale/pending. |
| Tombstone/deletion pending | Do not resurrect an older copy; show deletion state only where recovery/retry is actionable. |
| Accessibility | Rows announce date, session name, complete/incomplete, planned/ad-hoc, Exercise/set count, and exceptional state. |

**Ownership / handoff.** iPhone owns browse/filter and durable effective-history presentation. Watch may remain authority for a not-yet-received active/completed session; History represents that boundary literally.

**SwiftUI constraints.** Use `List` with stable session/revision IDs, searchable/filterable native controls, and cached snapshots. Device time never decides correction conflicts. Row summaries use effective Actual Sets only.

## Shared Exceptional-State Contract

| Boundary | iPhone review behavior |
|---|---|
| Current plan vs pending revision | Always keep the effective revision visible; pending/failed proposal or delivery is separate. |
| Watch local save vs iPhone receipt | Never collapse into “Synced.” Show each boundary explicitly. |
| Plan vs Actual | Plan is terracotta reference; Actual is violet/ink fact; changed values show both. |
| Complete vs incomplete | Completeness is a literal record state, not a color or score. |
| Correction vs conflict | A resolved correction is effective and auditable; an unresolved conflict blocks dependent aggregates. |
| AI unavailable | Current plan, History, Session Review, and local workout remain usable. |

## Visual Self-Critique

The first pass risked becoming a familiar warm-cream SaaS card layout. The revised batch removes equal rounded cards and dashboard tiles. Today uses one dominant next-session object, Session Review uses a continuous Plan/Actual evidence table, and History uses a chronological ledger. The left spine is functional—it changes meaning across Exercise, set, and time order—and earns the visual boldness. Claude-like colors remain semantic rather than decorative.

## Core-Flow Acceptance Gate

On 2026-09-12, the Product Owner accepted IR-01 through IR-03 as the iPhone review flow, including effective-plan priority, Watch delivery truth, full Actual Set visibility, scoped correction, incomplete/conflict handling, and chronological History. The iPhone review batch is frozen and the ND-03 core-flow acceptance gate is closed. The next configured batch is iPhone planning and analysis.

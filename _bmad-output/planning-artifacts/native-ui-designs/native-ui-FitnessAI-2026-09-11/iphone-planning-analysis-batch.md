# FitnessAI iPhone Planning and Analysis Screen Batch

## Document State

- Stage: `ND-03 Screens`
- Batch: `iPhone planning and analysis`
- State: accepted and frozen by the Product Owner on 2026-09-12 through the instruction to enter the final batch
- Direction: `Training Ledger`
- Frozen tokens: `0.2.0-nd02-accepted`
- Surfaces: `PA-01 Training Plans`, `PA-02 Analysis`, `PA-03 Exercise Catalog`

## Batch Thesis

This batch turns planning, evidence, and the Exercise vocabulary into three different registers rather than one dashboard. Training Plans is a revision lineage, Analysis is an evidence reading, and Exercise Catalog is a canonical index. Each uses the shared ledger spine for an actual ordering relationship, while preserving distinct page jobs.

Claude-like cream, terracotta, violet, moss, and amber remain semantic. Plan uses terracotta; effective Actual evidence uses ink/violet; verified support uses moss; unresolved, excluded, and stale inputs use amber. No color implies effectiveness, support, or causality on its own.

## Shared Layout and Navigation

- All three surfaces are contextual routes from Plan Home/Today, Session Review/History, or search—not a final tab-bar decision.
- Native large titles identify the current object before derived metrics or actions.
- The ledger spine means revision order in PA-01, chronological evidence in PA-02, and canonical category/index order in PA-03.
- Native back restores selected revision, period, Primary Exercise, filters, search query, and scroll position.
- Loading keeps durable content. Errors retain prior facts and inputs. Empty states route to the first meaningful action without invented content.

## Surface PA-01 — Training Plans

**Purpose.** Inspect the effective Training Plan, its immutable revision lineage, future-session structure, non-effective drafts/proposals, and Watch delivery without confusing any of them.

**Entry / exit.** Enter from Today & Plans. Select an effective revision/session for detail; `Create or revise plan` enters AI Plan Chat. Proposal review and Approval/Commit/Delivery remain separate downstream surfaces. Export enters the bounded Plan Exchange flow.

**Traceability.** `FR-028–035`, `FR-054–060`, `FR-071–073`, `FR-078–087`; `UJ-4`, `Flows 3–5`.

**Hierarchy.** Effective plan identity → cycle progress and ordered sessions → Watch delivery → revision lineage → non-effective draft/proposal state → create/revise/export actions.

**Primary action.** `Open effective plan` when browsing; `Review proposal` only when a complete valid proposal exists. Create/revise is contextual and never styled as approval.

**Components / tokens.** `plan-revision-header`, `revision-lineage`, `plan-session-row`, `sync-state-indicator`, `proposal-approval-gate`; `planText`, `confirmedText`, `pendingText`, `destructive`, `phoneTitle`.

| State | Contract |
|---|---|
| Effective | Name revision, start date, cycle, schema/catalog version, and future-session scope. |
| Loading | Keep the effective revision visible; inline progress may refresh lineage or delivery. |
| Empty | “No effective plan.” Offer create and FitnessAI-file import as distinct paths. |
| Draft / generating | Mark non-effective. Cancel or failure cannot change the effective plan. |
| Proposal valid | Show proposal identity, base revision, digest, validation, and unresolved count before a separate complete review. |
| Invalid/unmapped/safety-blocked | Name blocking reasons and allowed correction/rejection paths; no approval. |
| Approval invalidated / stale base | Clear approval, show cause/new base, require complete review again; never silently rebase. |
| Commit pending/failed | Do not call the proposal effective. Failure keeps the prior revision wholly effective. |
| Watch pending/delivered/failed | Delivery is separate from local effectiveness. Last complete Watch revision remains named and usable. |
| Destructive | Deleting a plan/revision names future scope and synchronized deletion state; historical Actual Sets remain outside mutation. |
| Accessibility | Revision rows announce identity, effective/non-effective state, base, validation, delivery, and available action. |

**Ownership / handoff.** iPhone owns creation, review, approval, commit, lineage, delivery state, and Plan file exchange. Watch receives only a fully committed compatible revision for a future Start.

**SwiftUI constraints.** Stable `planId/revisionId/proposalId` identity; typed routes; approval bound to `proposalId + baseRevision + digest`; atomic/idempotent commit and delivery retry.

## Surface PA-02 — Analysis

**Purpose.** Explain what changed in training from effective Actual Sets, with visible period, Primary Exercise, exclusions, provenance, and text equivalents for every chart conclusion.

**Entry / exit.** Enter from History or Session Review. Period and Primary Exercise selections persist on native back. Selecting an excluded/incomplete fact opens the exact Session Review record.

**Traceability.** `FR-036–041`, `FR-046`, `FR-059–060`, `FR-091`; `UJ-2`, `Flow 3`; `NFR-RPE-002`, `NFR-UX-001`.

**Hierarchy.** Period → data freshness/exclusion state → literal summary → session/exercise/volume/intensity/load/duration facts → selected Primary Exercise evidence curve → RPE provenance → optional review invitation.

**Primary action.** None for ordinary viewing. When stale or partial, `Review excluded records`; optional `Ask AI to review` remains non-blocking and enters authorization before any data is sent.

**Components / tokens.** `analysis-summary`, `evidence-curve`, `provenance-key`, `durable-state-label`, `proactive-review-invitation`; `actualText`, `confirmedText`, `pendingText`, `phoneMetric`.

| State | Contract |
|---|---|
| Current | Every metric derives from effective Actual Sets and names the selected period. |
| Loading | Keep the last current result and show calculation progress inline. |
| Empty | State that no effective Actual Sets exist in the period; route to History or first workout. |
| Partial / stale | Name excluded incomplete/conflicted sessions and affected metrics; do not present a false complete aggregate. |
| Calculation failure | Preserve the last valid result with its period/version and offer Retry. |
| Offline | Locally derivable Analysis remains available; Apple Health/AI failure does not remove it. |
| RPE provenance | Distinguish user-confirmed, corrected, auto-used, predicted-only, and excluded values. |
| AI review unavailable | Preserve Analysis and feedback; no proposal or plan mutation is implied. |
| Accessibility | Chart has a concise trend sentence and navigable point table with date, Actual value, and provenance. |
| Appearance | Lines use solid strokes/markers and text keys; no gradient area fill or color-only series distinction. |

**Ownership / handoff.** iPhone owns aggregation and interpretation. Watch supplies committed Actual facts; planned values never substitute for missing Actual values.

**SwiftUI constraints.** Swift Charts is allowed with accessibility representations and a textual summary. Metric inputs are effective revisions only. Cache keys include period, Exercise, effective-record revision, schema, and model provenance versions.

## Surface PA-03 — Exercise Catalog

**Purpose.** Expose the canonical Exercise vocabulary, automatic-support boundary, target body areas, movement category, equipment, substitution rationale, and concise licensed teaching text on iPhone.

**Entry / exit.** Enter from Plan detail, substitution request, correction, Analysis Primary Exercise selection, or search. Selection returns the canonical Exercise identity to the originating flow; it never silently replaces an Exercise.

**Traceability.** `FR-008`, `FR-030–032`, `FR-049–053`, `FR-055`, `FR-073`; `UJ-1`, `UJ-4`, `Flow 2`.

**Hierarchy.** Search/filter → support matrix context → canonical Exercise name → supported/limited/manual-only state → primary target/movement/equipment → teaching text → substitution differences → explicit Select.

**Primary action.** `Select this exercise` only in a requesting flow. Browsing detail has no permanent primary CTA.

**Components / tokens.** `exercise-index-row`, `recognition-state-chip`, `support-boundary`, `canonical-mapping-row`, `substitution-diff`; `confirmedText`, `pendingText`, `textPrimary`, `textSecondary`.

| State | Contract |
|---|---|
| Supported | Name the exact Watch/device/OS/side/orientation matrix and supported recognition capabilities; do not imply universal support. |
| Limited | Name which capability is limited and keep manual recording available. |
| Manual-only / unsupported | Literal state plus manual path; never style as disabled Exercise selection. |
| Loading | Preserve cached canonical names and known support state; version refresh stays inline. |
| Empty search | “No matching canonical Exercise.” Offer query edit or manual mapping request where allowed; never invent mapping. |
| Mapping unresolved | Block proposal/import completion until mapped or explicitly omitted in the owning flow. |
| Permission/signal unavailable | Separate runtime availability from catalog support qualification. |
| Media unavailable | Keep first-party text and facts; do not show broken or unlicensed media placeholders. |
| Substitution | Show matching primary target/movement and exact secondary-target/range differences before Select. |
| Accessibility | Support state, target, movement, equipment, and substitution differences are text and accessibility values, not icons alone. |

**Ownership / handoff.** iPhone owns catalog inspection, teaching, mapping, and substitution review. Watch displays only the canonical name and a truthful supported/manual boundary required during recording.

**SwiftUI constraints.** Native searchable list with stable `exerciseId` and catalog/support-matrix versions. Assets are licensed/owned and remain off Watch when nonessential. Selection returns identity and rationale to the originating domain flow.

## Shared Exceptional-State Contract

| Boundary | Behavior |
|---|---|
| Effective plan vs proposal | Effective content remains ink/confirmed; proposals remain Plan-colored and explicitly non-effective. |
| Planned vs performed | Analysis consumes Actual only; Plan can appear solely as comparison. |
| Supported vs available | Catalog qualification and current sensor/permission availability are separate facts. |
| Corrected vs predicted RPE | Corrected/user-confirmed facts drive effective Analysis; prediction provenance remains visible. |
| Incomplete/conflicted records | Excluded from dependent aggregates with exact count and recovery link. |
| Remote AI unavailable | Plan, Analysis, Catalog, History, and local recording stay usable. |

## Visual Self-Critique

A planning page can easily become a card grid, Analysis a generic KPI dashboard, and Catalog an icon gallery. This design rejects all three defaults. Revision lineage is temporal and immutable; Analysis begins with a written finding backed by a thin evidence curve and point table; Catalog resembles a precise movement index. The ledger spine earns its presence through three different ordering semantics. Decorative gradients, progress rings, body heatmaps without textual truth, and generic AI sparkles were removed.

## Batch Acceptance Gate

On 2026-09-12, the Product Owner accepted PA-01 through PA-03 by instructing the workflow to enter the final batch. Revision/effectiveness separation, Actual-only Analysis, visible exclusions and provenance, and truthful Exercise support boundaries are frozen. The active ND-03 batch is System: Sync & Recovery, Account & Privacy, and required exceptional states.

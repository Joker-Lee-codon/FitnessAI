# FitnessAI System and Exceptional-State Screen Batch

## Document State

- Stage: `ND-03 Screens`
- Batch: `System`
- State: accepted and frozen by the Product Owner on 2026-09-12
- Direction: `Training Ledger`
- Frozen tokens: `0.2.0-nd02-accepted`
- Surfaces: `SY-01 Sync & Recovery`, `SY-02 Account & Privacy`, `SY-03 Remote AI Authorization`, `SY-04 Apple Health`, `SY-05 Plan Exchange`, `SY-06 Settings & Capabilities`

## Batch Thesis

System state is a boundary ledger, not a settings-card collection. Every row answers where a durable fact lives, who owns it, what a failure affects, and what the user can do next. The ledger spine maps local commit, Watch delivery, iPhone receipt, remote AI authorization, and optional Apple Health copies without collapsing them into “Synced.”

Cream is the document surface; ink is durable fact; terracotta is Plan boundary; violet is user/Actual action; moss is confirmed local state; amber is pending/incomplete; red is isolated to destructive or failed consequences. Symbols never replace literal status.

## Navigation and Shared Rules

```text
Today / contextual failure
  ├─ Sync & Recovery
  ├─ Account & Privacy ── Remote AI Authorization
  ├─ Apple Health
  ├─ Plan Exchange
  └─ Settings & Capabilities
```

- System pages are contextual routes under More/Settings; blocking errors may deep-link to the exact boundary.
- Native back restores the originating plan, session, proposal, filter, scroll position, and unsent/non-effective input.
- The failure summary receives focus before the recovery action. Ordinary pending/success changes never steal focus.
- Destructive actions are never swipe-only and never share creation/approval styling.

## SY-01 — Sync & Recovery

**Purpose.** Inspect and recover each persistence or delivery boundary without revoking locally durable truth.

**Traceability.** `FR-003`, `FR-043–047`, `FR-064–070`, `FR-080–085`; `Flows 2, 4`; `NFR-RECOV-001`, `NFR-COMPAT-002`.

**Hierarchy.** iPhone local store → Watch plan delivery → Watch workout save → iPhone receipt → restoration → conflicts/deletions → precise Retry.

| State | Contract |
|---|---|
| Current/pending | Name object/revision and last confirmed boundary; retain durable source while queued. |
| Failed/offline | Name the failed edge and what remains usable; Retry is idempotent. |
| Partial restore | Name restored/outstanding data classes; local capture stays usable. |
| Conflict/multiple Watches | Preserve every identity/revision; unsafe comparison moves to iPhone; device time cannot decide. |
| Deletion pending/failed | Tombstone prevents replay resurrection; show Retry or recovery window where applicable. |
| Accessibility | Row announces object, source, destination, state, consequence, and action. |

**SwiftUI constraints.** Stable event/object/revision IDs, typed deep links, visible offline queue, idempotent Retry, and no synthetic “sync health” score.

## SY-02 — Account & Privacy

**Purpose.** Explain local/account boundaries, sign-in continuity, privacy actions, and remote-AI authorization without implying local permission authorizes remote use.

**Traceability.** `FR-042–048`, `FR-067–070`, `FR-082`, `FR-086`; `Flows 3–4`; `NFR-PRIV-001–007`, `NFR-SEC-001–003`.

| State | Contract |
|---|---|
| Signed in/out | Name account and locally available facts; never silently merge accounts. |
| Restoration pending/failed | Report data classes/progress; already-started local capture remains usable. |
| Authorization none/active/expired/withdrawn | Show purpose, provider, categories/window, policy version, expiry, and one-time consumption. |
| Sign-out | Offer retain encrypted local data or remove it; name unsynchronized records first. |
| Export/delete | Show accepted/in progress/complete/failed; reauthenticate high-impact actions. |
| Accessibility | Rows announce data class, scope, destination, state, and consequence. |

## SY-03 — Remote AI Authorization

**Purpose.** Obtain one affirmative, default-off, request-bound authorization before any eligible content is sent remotely.

**Traceability.** `FR-054–060`, `FR-078–087`; `UJ-4`, `Flow 3`; `NFR-PRIV-007`, `NFR-SAFE-001`.

**Hierarchy.** Purpose/provider/route → retention/training policy/region → default-off categories → record window → digest/policy/expiry → `Authorize and send once`.

| State | Contract |
|---|---|
| Required/selected | No send occurs before action; show exact category/window and outbound digest. |
| Scope changed | Invalidate the prior preview/authorization and require a new review. |
| Compliance gate closed | Fail closed; local plan/workout remains available. |
| Withdrawn/expired/consumed | Prevent reuse; prior plans/history remain unchanged. |
| Network/AI failure | Preserve input and audit; Retry cannot broaden scope. |
| Accessibility | Controls announce category, off/on, purpose, window, and one-time consequence. |

**SwiftUI constraints.** Consent is request- and digest-bound. Scroll, focus, HealthKit permission, or general App consent cannot select data.

## SY-04 — Apple Health

**Purpose.** Manage observable least-privilege read/write capabilities while FitnessAI local records stay authoritative.

**Traceability.** `FR-088–090`; `Flow 6`; `NFR-HK-001–002`, `NFR-UX-001`.

| State | Contract |
|---|---|
| Not requested | Explain benefit and request action; never claim denied. |
| No accessible data/available/unavailable | Use only observable language. |
| Write pending/written/failed | Report per session; success follows HealthKit confirmation only. |
| `healthKitDetached` | Do not silently recreate the missing external copy; offer explicit write. |
| Offline/system unavailable | FitnessAI History and Analysis remain usable. |
| Accessibility | Capability row announces scope, observed state, consequence, and action. |

## SY-05 — Plan Exchange

**Purpose.** Export exactly one FitnessAI Plan or inspect an untrusted FitnessAI Plan file before creating a new draft.

**Traceability.** `FR-071–073`; `Flow 5`; `NFR-PORT-001`.

| State | Contract |
|---|---|
| Export ready/failed/cancelled | Include only selected Plan content; failure changes nothing. |
| Import loading/valid | Treat the file as untrusted until validation/mapping completes. |
| Unresolved/unsupported/newer | Map, explicitly omit, or cancel; never invent completion. |
| Duplicate | Name existing import identity; never silently replace/revise. |
| Commit failed | Create no draft; retain preview/mappings for Retry. |
| Accessibility | Mapping rows announce source, target, state, omission consequence, and error. |

**SwiftUI constraints.** Native file picker and Share Sheet; import atomically creates a new draft; export payload is immutable and bounded to one Plan.

## SY-06 — Settings & Capabilities

**Purpose.** Manage recognition, RPE, Finish reminder, proactive review, Apple Health, accessibility, and device support without exposing deferred features.

**Traceability.** `FR-008–027`, `FR-049–053`, `FR-088–091`; `UJ-1`, `Flows 2–6`.

| State | Contract |
|---|---|
| Enabled/disabled | Literal label plus native control; disabling never rewrites History. |
| Unsupported/unavailable | Name device/Exercise/signal boundary and keep manual recording. |
| RPE verification/drift | Show five-estimate window and consent; prediction never replaces confirmed RPE. |
| Finish reminder | Explain two-signal rule, no auto-finish, cooldown, and disabled state. |
| Proactive review | Review/Later/Disable; merely showing it sends nothing. |
| Deferred | Add no discoverable placeholders for voice, Alpha cloud restore, or unrestricted coaching. |

## Remaining IA Closure

| Surface | Frozen layout/state contract |
|---|---|
| AI Plan Chat | Text only; missing answers/assumptions visible; Send never approves; input survives failure. |
| Proposal Review | Linear complete plan/diff with mappings, assumptions, unresolved fields, future scope, `proposalId`, base, and digest. |
| Approval, Commit & Delivery | Separate approval after complete review; commit and Watch delivery states remain distinct. |
| Phone-only Active Workout | Reuse durable Watch identities and Plan/Actual grammar semantics with native iPhone controls; no simulated sensor automation. |
| Revision Proposal Review | Exact future field-level diff; historical Actual Sets and active/completed sessions remain outside mutation. |

## Exceptional-State Atlas

| State | Content | Recovery |
|---|---|---|
| Loading | Preserve durable/cached content; name object inline. | Cancel when safe. |
| Empty | Explain what appears and first valid action. | Create/start/import. |
| Offline | Name local availability and delayed edge. | Idempotent automatic/manual Retry. |
| Pending | Amber structure + literal state; never success. | Wait/cancel/resolve. |
| Failure | Specific summary, retained facts/input, affected edge. | Focus summary then exact Retry. |
| Incomplete | Exact missing/pending count and consequence. | Resolve or explicitly finish incomplete. |
| Conflict | Preserve revisions and affected derivatives. | Explicit compare/choose on iPhone. |
| Permission unavailable | Observable state only. | Manual/local fallback. |
| Destructive | Exact object/scope and synchronized consequence. | Explicit confirmation; optional timed recovery. |

## Visual Self-Critique

System pages easily become identical rounded rows with colored icons. This batch removes that icon grid and uses a boundary ledger: each diamond is a real durable or authorization edge, each row states ownership, and each recovery action names its target. Privacy has no shield illustration, Sync has no cloud-health score, and Apple Health cannot borrow authority from FitnessAI records.

## Final ND-03 Acceptance Gate

On 2026-09-12, the Product Owner accepted SY-01 through SY-06, Remaining IA Closure, and the Exceptional-State Atlas. The fourth MVP batch and ND-03 are complete. ND-04 native quality gates and Architecture handoff are ready.

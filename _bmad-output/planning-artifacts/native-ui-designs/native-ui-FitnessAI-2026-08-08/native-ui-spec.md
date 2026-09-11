---
title: FitnessAI Native UI Specification
status: nd-03-reviewer-gate
stage: ND-03
selected_direction: Titanium Measure
stack: SwiftUI
updated: 2026-09-09
---

# FitnessAI Native UI Specification

## 1. Checkpoint and Authority

The core-product private-Alpha iPhone visual and layout contract is complete and is stopped at the requested Reviewer Gate Checkpoint. No expensive reviewer has run. This specification resumes the 2026-08-08 native UI run after the 2026-09-08 PRD and UX reconciliation removed its earlier scope blocker.

Authority order is: the current bilingual PRD → `EXPERIENCE.md` behavior/state contract → `DESIGN.md` and `design-system/fitnessai/MASTER.md` visual system → this page/layout contract. The earlier Direction D boards and ND-03 discussion wireframes are historical only and do not constrain implementation.

The production review carrier is `previews/iphone-core-alpha-final-v1.html`. Its hierarchy, containment, navigation relationships, action placement, state grammar, and responsive behavior are normative. Representative names, dates, measurements, and system-owned Share Sheet chrome are fixtures.

## 2. Frozen Visual System

The selected system is **Titanium Measure** 1.1.0: a minimalist, clean, restrained native training instrument. It uses native San Francisco/PingFang, tabular training figures, semantic light/dark colors, 4 pt rhythm, 20 pt compact iPhone inset, 8/12/16 pt radii, SF Symbols, and no decorative shadows. `tokens.json` mirrors the current semantic system and adds only reference-frame and fixed-action layout values.

Visual priority is actual fact → source/authority → durability → next user action. Cyan means a current user-authoritative action, not AI approval. Green, amber, periwinkle, and red supplement literal confirmed, pending, corrected/revision, and destructive/error labels. No status relies on color alone.

## 3. iPhone Shell and Navigation

- Reference frame: 390 × 844 pt; support iPhone 11+/iOS 18+ without horizontal scrolling.
- Top level: Plan, History, Analysis, More. Plan is the private-Alpha root.
- AI Chat, Authorization, Proposal Review, Approval, Delivery, Session Review, Apple Health, and Plan Exchange are contextual `NavigationStack` routes.
- Native back restores the originating object, filters, scroll position, and unsent/non-effective input.
- Fixed bottom actions use a safe-area inset plus at least 88 pt matching scroll inset. Only one consequential primary action appears per state.
- At accessibility sizes, metric grids stack, comparison columns become sequential Current/Proposed groups, and metadata yields before facts, consequences, or actions.

## 4. AI Plan Lifecycle

Traceability: UJ-4; FR-054–060; FR-078–087; NFR-AI-001–006; NFR-PRIV-007; NFR-SAFE-001.

| ID | Surface | Final hierarchy and primary action | Complete state family |
|---|---|---|---|
| `AI-01` | Plan Home | Effective revision and Watch delivery truth → today’s ordered session → secondary “Adjust with AI.” Start remains a Watch action. | No plan; local plan ready; Watch pending/delivered/failed; offline last-delivered revision. |
| `AI-02` | AI Plan Chat | Missing answers/assumptions → linear text conversation → separate non-effective structured draft → native composer. Send never approves. | Empty; composing; generating/cancellable; retained-input failure; safety stop. |
| `AI-03` | Remote AI Authorization | Purpose/provider/retention/training policy → all categories default off → record time window → excluded sources. | Required; partial; authorized; withdrawn; disclosure incomplete; expanded scope blocked. |
| `AI-04` | Proposal Review | `proposalId`/base → complete new plan or every field diff → mappings/assumptions/unresolved fields → Safety Rule Pack → digest and non-mutation scope. | Valid; invalid; unmapped; contradictory; safety-blocked; base stale; approval invalidated. |
| `AI-05` | Approval | Separate screen repeats identity, base, digest, validation, future-session scope, and consequence. Primary: “Approve and Create Revision N.” | Ready; disabled with reason; invalidated; refreshed review required. |
| `AI-06` | Commit and Delivery | Local commit and Watch delivery are separate state panels. Local success makes the revision effective; Watch may retain its last full revision. | Commit pending/failed/succeeded; delivery pending/delivered/failed; idempotent Retry. |

Authorization categories are current conversation, profile/preferences, physical limitations, and confirmed/corrected FitnessAI records with an explicit time window. Apple Health, raw motion/heart rate, imported-plan contents, and unconfirmed predictions remain excluded. Missing provider, retention, model-training, or request-field mapping disclosure disables authorization.

## 5. Training History and Complete Analysis

Traceability: UJ-1, UJ-2; FR-035–041; FR-061–066; NFR-SESSION; NFR-REC; NFR-COMPAT.

### 5.1 Training History

Period/filter controls lead, followed by an exact summary and chronological session ledger. Every row keeps planned/ad-hoc, Complete/Incomplete, sets/duration, effective revision, and copy/sync state attached. Row selection opens Session Review; Reuse is a named secondary action and creates a new draft only.

Required states: ready, loading, empty filtered period, offline cached history, incomplete, corrected, revision conflict, return pending/failed, restoration pending/failed, and tombstoned copy. Returning preserves filters and scroll position.

### 5.2 Analysis

Each view leads with a literal conclusion, then exact metrics, one evidence chart, an adjacent textual equivalent, exclusions/provenance, and a data-table alternative. Weekly/monthly period and selected Primary Exercise are explicit controls. Metrics include session count, performed Exercises, volume, intensity, Actual Load, duration, effective RPE provenance, and selected Primary Exercise trends.

Only effective Actual Sets contribute. Incomplete/conflicted facts are excluded and named. Stale analysis preserves unaffected conclusions and routes to the exact record. Apple Health failure never removes locally derived analysis.

Required states: weekly, monthly, Primary Exercise trend, empty, loading, partial, stale/conflicted, calculation failure, and current. Charts use direct labels, solid confirmed series, outlined corrected points, no animated drawing under Reduce Motion, a 44 pt effective point target, and a complete VoiceOver summary/table.

## 6. Apple Health

Traceability: Flow 6; FR-088–090; NFR-HK-001–002.

Apple Health is a More/Settings route with one native capability row per purpose: workout-summary read, required health-signal read, and completed-workout write. Each row names scope and observable state. The screen permanently distinguishes authoritative FitnessAI local records, optional Apple Health copies, and the separate remote-AI boundary.

Required states are not requested, no accessible data, available, unavailable, write pending, written, failed/retry, and `healthKitDetached`. The UI never claims read denial because HealthKit does not expose it. A write begins only after durable FitnessAI Finish; retry is idempotent and never blocks or changes the local record. A detached copy requires a new explicit write action.

## 7. First-Party Plan Exchange and Share Sheet

Traceability: Flow 5; FR-071–073; NFR-PORT-001.

Export review names the selected single plan, file/schema/catalog/revision/provenance, and excluded Workout Sessions, Actual Sets, health data, and credentials. “Create File and Share” creates the bounded file, then presents the native iOS Share Sheet. Cancellation or share failure changes no plan.

Import begins from the system file picker/open route, treats the file as untrusted, enforces schema/size/executable-content limits, and presents source/version, full plan, mappings, omissions, duplicates, and unsupported fields. Unknown items must be mapped or explicitly omitted. “Create New Draft” remains disabled until resolution is complete and never merges into or replaces an existing plan.

Required states: export ready, export creation failed, Share Sheet cancelled/failed; import loading, valid, unresolved mapping, duplicate, unsupported version, malformed/invalid, cancelled, commit failed, and draft created.

## 8. Post-Session Proactive AI Review

Traceability: UJ-2, Flow 3; FR-059; FR-060; FR-091.

After a completed session becomes reviewable, one native nonmodal sheet may appear over Session Review. It explicitly says that nothing has been sent and no proposal exists. Review is primary; Later and Disable are secondary. Later creates no hidden authorization or approval; Disable prevents future invitations until the setting is changed.

Review routes to a record-scoped authorization screen, then generating, complete field-level diff, separate approval, commit, and delivery. Evidence names the exact confirmed/corrected records and time window. AI unavailable/timeout/invalid preserves the session, feedback, current plan, and ordinary History/Analysis use.

## 9. Apple Watch Boundary

The approved `.working/watch-final-review-v11.html` remains the Watch starting visual reference only where it agrees with the current PRD and spines. It covers Planned/Free Workout Entry, planned/free Active Session, Rest Timer, Rest Confirmation, iPhone handoff, Recovery, and Finish Review. Automatic Exercise/set/rep recognition, opt-in RPE verification/auto-use, conservative forgotten-Finish, manual fallback, local durability, and transfer states follow the current contracts even where the historical fixture did not render them.

Watch never shows a partial plan revision. Active sessions bind to their Start snapshot. Complex privacy, plan diff, conflict, Apple Health, Analysis, and Plan Exchange review remain on iPhone.

## 10. Reusable Exceptional-State Contract

| State | Layout behavior | Preserved truth and recovery |
|---|---|---|
| Loading | Inline/native progress at the affected boundary; usable cached facts remain visible. | Name what is loading; Cancel/Back preserves inputs. |
| Empty | `ContentUnavailableView`-style symbol, literal reason, one relevant route. | Never invent an insight or recommend from absent data. |
| Offline | Full-width neutral/attention row beside the affected action. | Current local plan, cached History, Watch recording, and manual paths remain usable. |
| Permission unavailable | Capability row and explanatory panel; no generic modal loop. | Name observable scope and system-settings route without claiming denial. |
| Pending | Amber rail/label plus exact object and boundary. | Separate draft, local commit, Watch delivery, Health write, and transfer. |
| Failure | Error summary first, retained fact next, Retry at the failed boundary. | No optimistic success; prior effective revision and durable records survive. |
| Conflict/stale | Preserve both revisions and mark dependent Analysis/proposal stale. | Device time never selects truth; route to explicit resolution. |
| Destructive/omission | Native confirmation states exact object, copies, Analysis effect, or omitted import field. | Cancel leaves every current fact unchanged. |

## 11. Accessibility and Appearance Acceptance

- VoiceOver order follows visual priority. Proposal headings are navigable; diff rows announce path, change type, before/after value, and future-session scope.
- Authorization announces category, state, purpose, and record window; focus and scrolling cannot select a category.
- Error focus lands on the error summary, Retry retains input, and success focus lands on the exact local/remote result panel.
- Dynamic Type supports at least 200% on iPhone; required Chinese strings, consequences, digests, values, and actions wrap instead of truncate.
- Light/Dark, Increase Contrast, Differentiate Without Color, Reduce Motion, Full Keyboard Access, minimum 44 × 44 pt targets, localization expansion, keyboard avoidance, native back, and safe-area clearance are mandatory.
- Physical-device validation remains required for P3/sRGB color, largest Chinese text, VoiceOver focus restoration, chart point selection, one-hand use, and Watch handoff.

## 12. Coverage and Reviewer Gate

| Requirement group | Visual/state coverage |
|---|---|
| FR-001–041, FR-061–066 | Watch v11 boundary, Session Return, Training History, complete Analysis, correction/incomplete/conflict/recovery. |
| FR-054–060, FR-078–087 | `AI-01`–`AI-06`: conversation, remote authorization, complete review, immutable approval, atomic commit, Watch delivery, and graceful failure. |
| FR-071–073 | Export review, native Share Sheet, safe import preview/mapping, new draft only. |
| FR-088–090 | Apple Health capability scope, read observability, idempotent write, failure, and detached copy. |
| FR-091 | One post-session invitation and the existing authorized diff/approval lifecycle. |

Reviewer Gate status: **ready, reviewers not run**. ND-03 is not marked accepted until the Product Owner accepts this contract. ND-04 and `architecture-handoff.md` intentionally remain unstarted.

Architecture blockers before implementation acceptance: freeze the recognition whitelist, RPE verification/auto-use operating point, forgotten-Finish operating point, plan-file parser/size limits, Apple Health capability-to-data mapping, and Alpha Plan Safety Rule Pack v1. Before real remote-AI traffic, name the provider/subprocessor, retention, model-training policy, and request-field-to-authorization-category mapping. Professional review remains required before release beyond Product Owner testing.

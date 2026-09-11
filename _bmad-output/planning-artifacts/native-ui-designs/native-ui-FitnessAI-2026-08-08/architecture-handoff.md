---
title: FitnessAI Native UI Architecture Handoff
status: complete
native_ui_gate: passed-with-owned-device-validation
selected_direction: Titanium Measure
updated: 2026-09-09
sources:
  - ../../prds/prd-FitnessAI-2026-07-19/prd.md
  - ../../ux-designs/ux-FitnessAI-2026-07-20/EXPERIENCE.md
  - ../../ux-designs/ux-FitnessAI-2026-07-20/DESIGN.md
  - native-ui-spec.md
---

# FitnessAI Native UI Architecture Handoff

## 1. Handoff Status and Authority

ND-01 through ND-04 are complete. The Product Owner accepted the core-flow Reviewer Gate on 2026-09-09. Mandatory native contract, traceability, accessibility, completeness, and delivery checks pass; physical-device-only checks remain explicitly owned and do not block lean Architecture creation.

Authority order is the current bilingual PRD → `EXPERIENCE.md` → `DESIGN.md` / `design-system/fitnessai/MASTER.md` → `native-ui-spec.md` → this handoff. Architecture may choose implementation internals but may not collapse the truth, approval, revision, device, privacy, or phase boundaries below.

## 2. Selected Direction and Immutable Tokens

The implementation direction is **Titanium Measure 1.1.0**, not historical Direction D. The immutable semantic source is `design-system/fitnessai/tokens.json`; the native-run mirror is `tokens.json` version `1.1.0-alpha-layout`.

Architecture must preserve semantic names for canvas/surface/subtle backgrounds; primary/secondary/tertiary text; standard border; primary user action; pending attention; confirmed, corrected, and destructive states; Always On; spacing; radii; stroke; icon; touch; motion; and platform layout. SwiftUI consumes named Color Assets, native Dynamic Type roles, `@ScaledMetric`, SF Symbols, and native interaction states. Components must not embed unexplained raw colors, fixed body sizes, decorative shadows, or web layout semantics.

## 3. Surface and Component Ownership

| Boundary | Owner | Architecture invariant |
|---|---|---|
| AI conversation, authorization, proposal review, approval, local plan commit | iPhone | Conversation/generation never approves; approval is separate and bound to immutable proposal identity. |
| Effective Training Plan and Plan Revision store | iPhone local domain | One atomic, idempotent revision commit; failure leaves the prior revision wholly effective. |
| Plan delivery | iPhone ↔ Watch transport | Eventually consistent, full-revision, digest-verified, idempotent; Watch never exposes a partial revision. |
| Active Workout Session and Actual Set durability | Watch local domain | Start snapshot is fixed; each saved claim follows durable local commit; phone/cloud receipt is independent. |
| Complete correction and conflict resolution | iPhone | Field-scoped auditable revision; preserve sibling facts and every user-authored branch until effective resolution. |
| Automatic Exercise/set/rep recognition | Watch inference + support matrix | Confidence/provenance retained; abstention/manual fallback is normal; correction does not erase captured facts. |
| RPE verification/auto-use | Watch inference and local calibration | Predicted, confirmed, auto-used, corrected, and effective values remain distinct and correctable. |
| History and Analysis | iPhone derived read model | Derive from effective Actual Sets only; exclusions/conflicts are visible and prevent false precision. |
| Apple Health | iPhone adapter | FitnessAI local record remains authoritative; reads expose observable data states; writes are idempotent optional copies. |
| Plan file exchange | iPhone document boundary | Versioned single-plan format is untrusted input; import creates a new draft only; export is data-minimized. |
| Proactive review invitation | iPhone presentation state | Once per completed session; showing/Later sends nothing and creates no authorization, proposal, or approval. |

Required reusable SwiftUI component families: `ai-conversation`, `remote-ai-authorization`, `plan-diff-review`, `proposal-approval-gate`, `safety-stop`, `session-control`, `actual-set-row`, `load-stepper`, `recognition-state-chip`, `rpe-verification-prompt`, `forgotten-finish-prompt`, `analysis-summary`, `healthkit-capability-row`, `plan-exchange-review`, `proactive-review-invitation`, `sync-state-indicator`, `recovery-choice-sheet`, and `support-boundary-notice`.

## 4. Navigation and Cross-Device Handoff

iPhone uses a native `TabView` with Plan, History, Analysis, and More. Plan is the root. AI Chat, Remote Authorization, Proposal Review, Approval, Delivery, Session Review, Apple Health, and Plan Exchange are typed `NavigationStack` destinations. Back restores object identity, filters, scroll, and unsent/non-effective drafts.

Watch uses shallow task-specific navigation. Approved Plan → manual Start → Active Workout → safe-rest correction/RPE when required → manual Finish → local save/return. Recovery may Resume, Finish Incomplete, or explicitly discard after confirmation. Digital Crown is optional acceleration and never the sole input or commit path.

Cross-device messages carry stable object/revision IDs, schema/catalog/model/support-matrix versions where applicable, content digest, idempotency identity, and causality/revision metadata. Device time cannot resolve plan or record conflicts. A newer iPhone plan never mutates an already-started Watch session. Failed delivery leaves the last complete compatible Watch revision available.

## 5. Required State Machines

### 5.1 AI proposal and approval

`conversation → authorizationRequired → authorized → generating → proposed → validating → reviewable → approvalReady → committing → effective`.

Branches: `cancelled`, `aiFailed`, `invalid`, `unmapped`, `contradictory`, `safetyBlocked`, `baseStale`, `approvalInvalidated`, `commitFailed`, and `rejected`. Any proposal content, mapping, base revision, digest, or validation result change creates a new identity and requires complete re-review. Only `effective` may begin Watch delivery.

### 5.2 Watch plan delivery

`notQueued → pending → delivered` with `failed` and retry/reconnect transitions. The Watch switches only after complete compatible content and digest verification. Duplicate, late, reordered, or repeated events cannot duplicate or roll back a revision.

### 5.3 Workout and Actual Set

Session: `notStarted → active → finishing → complete | incomplete`, with `interrupted → recoverable → active | incomplete | discarded`. Actual Set: `draft → committingLocal → savedLocal → transferPending → received`, with `localWriteFailed`, `transferFailed`, `pendingField`, `corrected`, and `conflict` branches. “Saved” is legal only after `savedLocal`.

### 5.4 Recognition, RPE, and finish assistance

Recognition: `supportedAttempt → accepted | uncertain | abstained | manualOnly | unsupported`; uncertainty is shown only at `restSafeForInteraction` and retains all sibling facts. RPE: `disabled | verifying → confirmed/corrected → verificationPassed → autoUseOptIn → autoUsed`, with `abstained`, `lowConfidence`, and `drifted → verifying`. Forgotten Finish: `suppressed | eligible → prompted → finish | continue`; it never auto-finishes.

### 5.5 Apple Health

Read capability: `notRequested → noAccessibleData | available | unavailable | failed`. Write copy: `notEnabled | pending → written | failed`; external disappearance produces `healthKitDetached`, and only a new explicit action may re-enter `pending`.

### 5.6 Plan exchange

Export: `review → creating → shareSheet → completed | cancelled | failed`. Import: `selected → parsing → invalid | unsupported | duplicate | unresolved | reviewable → committingDraft → draftCreated | commitFailed`. No import state mutates an existing effective plan.

### 5.7 Analysis and proactive review

Analysis: `loading → current | empty | partial | stale | failed`; dependent metrics remain stale while input conflicts are unresolved. Invitation: `available → review | later | disabled`; Review enters remote authorization, Later creates no hidden state, and Disabled persists until user re-enables it.

## 6. Accessibility and Native Semantics

- iPhone supports at least 200% Dynamic Type; Watch supports at least 140%. Metric grids and diffs linearize before clipping.
- VoiceOver reading order follows fact → source/authority → durability → consequence → action. Diff rows announce field path, change type, before/after, and future scope.
- Every state uses text plus symbol/structure; hue, animation, gesture, haptic, or Crown is never the sole cue.
- Frequent/consequential targets are at least 44 × 44 pt with 8 pt separation. Full Keyboard Access covers iPhone review/correction.
- Error focus moves to the error summary; Retry retains data; success focus moves to the exact local/remote result. Cross-device return restores the exact object and field.
- Reduce Motion removes displacement/chart drawing; Reduce Transparency and Increase Contrast use the frozen semantic variants.
- Fixed actions respect keyboard and safe areas and reserve matching scroll inset. Native sheets, alerts, destructive confirmation, file picker, Share Sheet, and Health authorization remain platform-owned.

## 7. Requirements-to-Journey-to-Surface Traceability

| Requirement group | Journey/flow | Surface/state ownership |
|---|---|---|
| FR-001–041; NFR-RPE; NFR-SESSION; NFR-REC; NFR-RECOV; NFR-COMPAT | UJ-1, UJ-2, Flow 2 | Watch Entry/Active/Rest/Recovery/Finish; Session Review; History; complete Analysis; manual and error fallbacks. |
| FR-043; FR-046–047; FR-049–050; FR-052–053 | UJ-1, Flow 2, Flow 4 | Local durability, idempotent transfer/conflict, privacy boundaries, support state, and continued local use. |
| FR-054–060; FR-078–087; NFR-AI-001–006; NFR-PRIV-007; NFR-SAFE-001 | UJ-4, Flow 3, Flow 4 | `AI-01`–`AI-06`: chat, authorization, safety stop, complete review, approval, atomic commit, delivery, stale/failure recovery. |
| FR-061–066 | UJ-1, Flow 2 | Field correction, split/merge/insert/delete, incomplete records, auditable revision, active-session recovery, idempotency. |
| FR-071–073; NFR-PORT-001 | Flow 5 | Export scope review, versioned file, native Share Sheet, bounded import, mapping/omission, new draft only. |
| FR-088–090; NFR-HK-001–002 | Flow 6 | Capability rows, observable read state, write pending/written/failed, local authority, `healthKitDetached`. |
| FR-091; NFR-UX-001 | UJ-2, Flow 3, all flows | One proactive invitation; complete final visual/layout, exceptional states, accessibility, and native reflow. |

Nonvisual requirements such as model accuracy, evaluation cohort thresholds, data residency, cryptographic transport, parser fuzzing, and professional policy review remain Architecture, test, security, or release evidence; their user-visible failure and provenance states are mapped above.

## 8. Native Quality Gate Result

| Gate | Result | Evidence / owner |
|---|---|---|
| Contract integrity and phase separation | Pass | PRD §6.1 applicability set; `EXPERIENCE.md`; no deferred route is discoverable. |
| User truth, local commit, offline, conflict, incomplete, privacy | Pass | State machines in Section 5 and `native-ui-spec.md` Sections 4–10. |
| Watch glanceability, silence, safe rest, recovery, Always On | Pass with device validation owned | Watch v11 plus current spine; Product Owner/QA device plan in Section 9. |
| iPhone navigation, sheets, safe areas, keyboard, focus | Pass | `AI-L01`–`RV-L01` and consolidated review carrier. |
| Light/Dark, Dynamic Type, VoiceOver, Reduce Motion, non-color cues | Pass with device validation owned | Frozen tokens/spec; Product Owner/QA device plan in Section 9. |
| Exceptional-state completeness | Pass | Reusable state contract and all seven required state machines. |
| Bilingual structural/ID parity and token validity | Pass | `validate_outputs.py`; paired spine structural audit; JSON parse. |
| Required layout-critical previews | Pass | iPhone 28-instance final board; Watch v11 reference. |

## 9. Physical-Device Validation Plan

| Validation | Owner | Pass criterion |
|---|---|---|
| Small/large Watch, both Crown orientations | Product Owner + implementation QA | No clipped Exercise/value/action; Crown and touch equivalents work; one/two deliberate interactions for primary actions. |
| Bright/dim gym and Always On | Product Owner | Essential Exercise/set/load/reps/durability readable within a two-second glance; action/status color remains nonessential. |
| Sweat/one-hand/accidental touch and haptics | Product Owner | 44 pt targets succeed reliably; no accidental destructive/Finish action; success/warning/error haptics are distinguishable with visual/spoken equivalents. |
| iPhone 11 and current larger device | Implementation QA | No horizontal scroll; bottom actions clear keyboard/home indicator; native back restores state. |
| Largest Simplified Chinese and VoiceOver | Accessibility QA + Product Owner | No required consequence/value/action truncation; stable reading/focus order through errors and Watch handoff. |
| P3/sRGB, Light/Dark, Increase Contrast | Implementation QA | Text/control/non-text contrast meets the DESIGN targets on load-bearing surfaces. |
| Analysis chart selection | Accessibility QA | 44 pt effective points, exact value/period/unit, complete text and table alternatives. |
| Offline, local-write failure, replay, reconnect | Integration QA | No lost/duplicated Actual Set or Plan Revision; no false saved/delivered/written claim. |

## 10. Open Decisions for Architecture

These decisions are required before implementation acceptance but do not block creation of the lean Architecture spine:

1. Freeze the private-Alpha automatic-recognition whitelist and versioned support-matrix representation.
2. Freeze RPE verification/auto-use confidence, drift, recalibration, and abstention operating points.
3. Freeze forgotten-Finish two-signal thresholds, `restSafeForInteraction`, cooldown, suppression, and device evidence plan.
4. Define the FitnessAI Plan File schema, extension/UTType, parser size/depth/count limits, canonical mapping strategy, and fuzz/error boundaries.
5. Define Apple Health capability-to-HealthKit-type mapping, read rationale, write metadata/deduplication key, and detached-copy detection limitations.
6. Freeze Alpha Plan Safety Rule Pack v1 data model, versioning, checks, pass/block outputs, and test-fixture ownership.
7. Before real remote AI traffic, name provider/subprocessor, region, retention, training policy, request-field-to-authorization-category mapping, revocation storage, and audit event.
8. Choose local persistence, iPhone–Watch transport, background retry, idempotency, causal revision, and derived-analysis invalidation mechanisms without weakening the state contracts.

## 11. Exact Next Action

Start `bmad-architecture` in create mode using the current bilingual PRD, `EXPERIENCE.md`, `DESIGN.md`, `native-ui-spec.md`, `tokens.json`, and this handoff. Architecture should produce a lean spine first and carry every Section 10 item as a named decision or validation owner rather than silently inventing a value.

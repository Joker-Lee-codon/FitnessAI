---
stepsCompleted:
  - step-01-validate-prerequisites
  - step-02-design-epics
  - step-03-create-stories
  - step-04-final-validation
inputDocuments:
  - ../specs/spec-FitnessAI/SPEC.md
  - ../specs/spec-FitnessAI/SPEC.zh-CN.md
  - ../specs/spec-FitnessAI/implementation-contract.md
  - ../specs/spec-FitnessAI/verification-matrix.md
  - ../specs/spec-FitnessAI/open-gates.md
  - prds/prd-FitnessAI-2026-07-19/prd.md
  - ux-designs/ux-FitnessAI-2026-07-20/EXPERIENCE.md
  - ux-designs/ux-FitnessAI-2026-07-20/DESIGN.md
  - architecture/architecture-FitnessAI-2026-09-09/ARCHITECTURE-SPINE.md
  - native-ui-designs/native-ui-FitnessAI-2026-08-08/native-ui-spec.md
  - native-ui-designs/native-ui-FitnessAI-2026-08-08/architecture-handoff.md
  - ../../design-system/fitnessai/MASTER.md
scope: private-alpha
authority: SPEC-FitnessAI and 2026-09-10 Architecture Spine
---

# FitnessAI - Epic Breakdown

## Overview

This document provides the complete epic and story breakdown for FitnessAI. Requirements are extracted from the preservation-validated SPEC contract and its companions. The private-Alpha implementation set is authoritative; explicitly deferred PRD requirements remain traceable but are not scheduled into S0-S7.

## Requirements Inventory

### Functional Requirements

#### Private-Alpha implementation set (78)

FR-001: Start a planned or ad-hoc Workout Session on iPhone or Apple Watch using shared identities, durable states, correction rules, and Analysis; the selected capture device owns the live session.
FR-002: Record every Actual Set as structured Exercise state, order, repetitions, Actual Load, optional RPE state, timing, provenance, and completeness data.
FR-003: Commit captured or entered workout facts locally before showing saved/corrected/finished/discarded success or attempting transfer.
FR-004: Provide authoritative manual Finish.
FR-005: Offer a completion question only after both sustained recovery and sustained absence of strength activity; never auto-finish.
FR-006: After completion, show Actual Sets and trained body areas.
FR-007: Keep missing or pending information visibly incomplete; never guess, hide, or falsely confirm it.
FR-008: Attempt Exercise recognition in ad-hoc Watch sessions without preselection only on qualified paths.
FR-009: Attempt working-set boundary and repetition recognition from supported Watch signals only on qualified paths.
FR-010: Preserve confidence and accepted, uncertain, corrected, unresolved, abstained, manual-only, or unsupported recognition states.
FR-011: Request confirmation only for uncertainty, correction, or an explicit trust gate and within the shared interruption budget.
FR-012: Permit Exercise-label correction after the first Actual Set.
FR-013: Exercise correction preserves set order, repetitions, load, RPE state, and timing.
FR-014: Subsequent sets use the corrected Exercise while the correction remains auditable.
FR-015: Report initial recognition success separately from recovered-record success.
FR-016: For planned training, prefill the first Actual Load from the Plan snapshot.
FR-017: For ad-hoc training, prefill the latest historical Actual Load when available; otherwise require user entry.
FR-018: Default each later set to the prior Actual Load until the user changes it.
FR-019: Let the user authoritatively edit Actual Load; never claim automatic external-load sensing.
FR-020: Keep all RPE estimation, display, verification, and calibration inactive until the user enables RPE tracking.
FR-021: Present the first five chronological eligible RPE predictions for confirmation or correction.
FR-022: After at least four of five predictions are within ±1, offer—not silently enable—routine-confirmation disablement.
FR-023: After at least two of five predictions are wrong, calibrate only from corrected labels and start a new five-estimate window.
FR-024: After a passed window and explicit consent, allow high-confidence RPE auto-use with provenance and correction.
FR-025: Low-confidence, unfamiliar, missing-signal, or drifting RPE remains pending or prompts within budget; never fabricate Actual RPE.
FR-026: Keep target, predicted, confirmed, auto-used, corrected, and effective RPE distinct.
FR-027: Suggest next-set load from Actual RPE and remaining Plan, but change the next Actual Set only after explicit accept/edit; allow reject.
FR-028: Select and start an existing Plan and view its exercises, sets, reps, loads, and optional target RPE.
FR-029: Keep planned content separate from Actual Sets whenever reality differs.
FR-030: Let the user request substitutes when planned equipment is unavailable.
FR-031: Match substitutes through versioned canonical primary body area, movement pattern, available equipment, and disclosed secondary/range differences.
FR-032: Require explicit user selection; never silently replace an Exercise in the current or future Plan.
FR-033: At completion, identify material Plan-versus-Actual differences and show the exact future-scope field diff.
FR-034: Rejecting guidance preserves Actual facts and leaves the future Plan unchanged.
FR-035: Reuse a historical session as a new draft without changing source history or implicitly approving a future Plan update.
FR-036: Browse complete and incomplete planned/ad-hoc sessions in Training History.
FR-037: View completed-session count and performed Exercises for a selected week.
FR-038: Calculate weekly/monthly volume, intensity, load, and duration from effective Actual Sets, not planned content.
FR-039: View trends for an explicitly selected Primary Exercise.
FR-040: Preserve corrected values and relevant RPE provenance in History and Analysis.
FR-041: Show the complete durable session record after completion without disappearing fields.
FR-043: Keep local recording usable offline; concurrent sessions remain distinct and recoverable until explicit safe resolution.
FR-046: Prevent duplicate or clock-based overwrite under interrupted, repeated, reordered, or concurrent transfer; preserve conflicting revisions and expose unsafe conflicts on iPhone.
FR-047: Keep complete high-frequency sensor streams local by default.
FR-049: Map recognized, planned, substituted, and corrected Exercise references to canonical records.
FR-050: Store canonical body-area and movement attributes needed for substitution and Analysis.
FR-052: Explain concepts such as RPE without requiring RPE tracking.
FR-053: Ship no unlicensed media and make no precise wrist-only full-body-form claim.
FR-054: Start bounded text AI Plan creation/revision from goals, experience, availability, session time, equipment, preferences, and mandatory limitations; keep gaps and assumptions visible.
FR-055: Accept equipment context before or after generation and propose substitutes only with canonical mapping and rationale.
FR-056: Produce a validated complete structured Training Plan Draft; prose-only output is incomplete.
FR-057: Show the complete plan or complete field diff, unresolved fields, and mappings before one explicit atomic approval.
FR-058: Apply non-diagnostic affected-scope stop behavior for injury/recovery/warning signs and require an allowed explicit continuation path.
FR-059: On explicit review request, use only permitted confirmed/corrected records and concise feedback, name evidence/assumptions, and apply FR-058.
FR-060: Bind every effective AI change to explicit approval of immutable `proposalId`, base revision, and digest; any relevant change invalidates approval.
FR-061: Correct repetitions and split, merge, insert, or delete Actual Sets during or after a session.
FR-062: Resolve pending fields before or after Finish; unresolved Finish produces editable Incomplete status.
FR-063: Make post-completion corrections append-only and auditable, preserve prior provenance, and invalidate/recompute only after effective resolution.
FR-064: Recover the latest durable session after termination, restart, battery/sensor interruption, or disconnect and offer Resume, Finish Incomplete, or confirmed discard.
FR-065: Preserve a partial/ambiguous write as one visible pending Actual Set without dropping or duplicating it.
FR-066: Make recovery and replay idempotent and unable to duplicate a set or revert a later correction.
FR-071: Export exactly one versioned FitnessAI Plan file and share it through native Share Sheet with data-minimized scope.
FR-072: Import a compatible Plan only after bounded validation and full preview, creating a new non-effective draft.
FR-073: Keep unknown Exercises, incompatible fields, duplicates, omissions, and unsupported versions explicit; never invent mappings or present partial import as complete.
FR-078: Give every AI draft/proposal immutable identity, digest, provenance, target, base, generation time, permitted scope, and assumptions.
FR-079: Show all additions/removals/changes and affected future sessions; exclude history and active sessions from mutation scope.
FR-080: Commit approval atomically and idempotently as one new Plan Revision; failure leaves the prior Plan wholly effective.
FR-081: Deliver only complete compatible revisions to Watch with truthful pending/delivered/failed states and no manual reconstruction.
FR-082: Restrict Alpha AI inputs to the allowed sources; default Apple Health summaries off and keep real Health-derived traffic disabled until GATE-3 closes.
FR-083: Allow continued conversation, regeneration, or rejection without changing the active Plan.
FR-084: Prevent duplicate, late, retried, or reordered events from duplicating or rolling back Plan Revisions.
FR-085: Preserve the last confirmed Plan and local workout capture through AI, validation, or delivery failure.
FR-086: Require affirmative, revocable, one-shot authorization for exact remote categories/window; general app or HealthKit consent never substitutes.
FR-087: Run a versioned deterministic Safety Rule Pack before approval and commit; missing, failed, or unsupported checks block commit.
FR-088: Manage least-privilege Apple Health reads for the frozen allowlist and show only observable states; excluded clinical categories remain inaccessible.
FR-089: After durable Finish, optionally write an idempotent workout copy with separate pending/written/failed states.
FR-090: Keep local FitnessAI truth independent; external Health changes produce `healthKitDetached` and never trigger silent recreation.
FR-091: Show at most one non-blocking post-session Review/Later/Disable invitation; display/dismiss sends nothing and creates no proposal or approval.

#### Deferred or excluded from S0-S7 (13; traceability retained)

FR-042: FitnessAI Account sign-in is public-beta scope.
FR-044: Application-cloud synchronization after local commit is public-beta scope.
FR-045: Account-scoped cross-device cloud restoration is public-beta scope.
FR-048: Account-scoped export and deletion request lifecycle is public-beta scope.
FR-051: Rich teaching images are deferred; concise owned/licensed text and support truth remain in Alpha under FR-052/053.
FR-067: Cloud deletion propagation and anti-resurrection tombstones are public-beta scope.
FR-068: Account-scoped cross-device restoration progress/failure is public-beta scope.
FR-069: Sign-out retain/remove and unsynchronized-record handling is public-beta scope.
FR-070: Cross-account non-merge and previewable transfer is public-beta scope.
FR-074: User-invoked voice draft capture is Post-MVP.
FR-075: Voice ambiguity/conflict handling and equivalent non-voice paths are Post-MVP.
FR-076: Named third-party Plan formats are Post-MVP/V2.
FR-077: Server-backed link/QR Plan sharing is Post-MVP/V2.

### NonFunctional Requirements

#### Private-Alpha implementation and release constraints (46)

NFR-SIZE-001: Thinned iPhone installed variant ≤500 MB; report download and installed size separately.
NFR-SIZE-002: Watch app remains <75 MB uncompressed with an internal installed target ≤25 MB.
NFR-SIZE-003: All Watch ML assets total ≤6 MB and the RPE component ≤2 MB unless the PRD changes with evidence.
NFR-SIZE-004: Keep rich teaching images and nonessential media out of the Watch bundle.
NFR-SIZE-005: Use Xcode/App Store Connect thinning evidence, not debug/archive size, for acceptance.
NFR-RPE-001: Do not claim heart rate alone reliably determines set-level Actual RPE.
NFR-RPE-002: Keep predicted, target, confirmed, corrected, auto-used, and effective RPE distinct across every boundary.
NFR-RPE-003: Abstain or ask concisely below the frozen confidence threshold or when required signals are unavailable.
NFR-RPE-004: Beat preregistered simple baselines on participant-held-out and later-session data with calibration and slice evidence.
NFR-RPE-005: Pass preregistered prompt/correction burden gates inside SM-INT-001.
NFR-RPE-006: Use only confirmed/corrected RPE as calibration or training labels; never recursively label from predictions.
NFR-RPE-007: Keep RPE estimation/calibration inactive until the user opts in.
NFR-RPE-008: Enforce the five-estimate verification window, ≥4 pass offer, and ≥2 wrong recalibration/restart.
NFR-RPE-009: Require explicit consent for auto-use and retain model provenance and correction capability.
NFR-RPE-010: Continue abstention and reverification after verification when confidence, familiarity, signals, or drift require it.
NFR-RPE-011: Use integer RPE 1–10; verification success is within ±1 and exact match is reported separately.
NFR-RPE-012: Freeze eligibility before revealing labels; use the first five chronological eligible predictions and keep all in the denominator.
NFR-RPE-013: Two corrections in any rolling five auto-used eligible estimates trigger immediate drift reverification.
NFR-RPE-014: Freeze participant/time partitions, model, eligibility, support, threshold, baseline, risk, burden, and evaluation before final holdout.
NFR-SESSION-001: Manual Finish is normal and authoritative.
NFR-SESSION-002: Reminder eligibility requires both sustained recovery and sustained absence of strength activity.
NFR-SESSION-003: Inferred inactivity never auto-finishes; the user chooses Finish or Continue.
NFR-SESSION-004: Validate and separately report false/missed reminders for long rests, equipment waits, and low-motion Exercises.
NFR-SESSION-005: Preregister personalization, windows, missing-signal behavior, cooldown, and false/missed thresholds before physical-device validation.
NFR-RES-001: Representative physical-device sessions have no resource termination, material unresponsiveness, or recorded-information loss.
NFR-RES-002: Every supported Watch/OS pair completes a 90-minute/20-set test with zero resource termination/data loss and p95 ≤1 s for Start/correction/Finish; report battery, thermal, memory, and >2 s interactions.
NFR-REC-001: Freeze recognition partitions, model, eligibility, support matrix, thresholds, denominators, and procedure before final holdout.
NFR-REC-002: Unsupported/uncertain Exercises, devices, signals, and results visibly degrade to manual/pending and never count as success.
NFR-RECOV-001: Fault testing covers termination, restart, battery/sensor interruption, disconnect, partial writes, repeated transfer, and delayed/reordered delivery with exactly-once effective facts.
NFR-COMPAT-001: Only physical-device tests for every named device/OS pair may establish support.
NFR-COMPAT-002: Retain app/schema/model/catalog/support versions and never silently reinterpret historical records.
NFR-PRIV-001: Classify data classes separately and minimize collection/use to disclosed purpose.
NFR-PRIV-003: Keep complete raw motion/heart-rate local by default and out of ordinary telemetry, logs, and remote use.
NFR-PRIV-007: Disclose exact remote-AI purpose, scope, provider/subprocessors, retention, and training policy; obtain FR-086 authorization and send only selected fields.
NFR-SEC-003: Protect sensitive local data, exclude stores/secrets from consumer backup and diagnostics, and use device-local non-synchronizing Keychain for secrets.
NFR-SAFE-001: Enforce non-diagnostic stops and deterministic safety checks in Alpha; require professional review before release beyond Product Owner testing.
NFR-AI-001: Validate every proposal against versioned schema and canonical Exercise mapping before commit.
NFR-AI-002: Automated tests observe zero effective Plan writes without required approval.
NFR-AI-003: Local revision commit and complete Watch delivery are atomic/idempotent with no partial revision, duplicate, rollback, or false delivery.
NFR-AI-004: AI unavailability, invalid output, or timeout cannot block current Plan access or durable local capture.
NFR-AI-005: Effective AI revisions retain proposal/digest/approval/base/schema/model/rule-pack/data-source audit provenance without chain-of-thought.
NFR-AI-006: Reject or clarify unmapped, contradictory, invalid, or safety-excluded output instead of inventing facts.
NFR-PORT-001: Treat Plan files as untrusted, enforce limits, reject executable/malformed data, preserve provenance, and never mutate an existing Plan on import.
NFR-HK-001: Apple Health access is optional and least privilege; missing/unavailable/failed Health cannot block Plan, correction, local Analysis, or Watch recording.
NFR-HK-002: Health writes/retries are idempotent and content-free in logs; do not claim completion early or silently recreate detached copies.
NFR-UX-001: Implement the complete bilingual DESIGN/EXPERIENCE contract with native light/dark, Dynamic Type, VoiceOver, error, empty, loading, offline, and recovery states—no placeholders.

#### Deferred or public-beta constraints (8; traceability retained)

NFR-PRIV-002: China-region application-cloud residency and cross-border controls are public-beta scope.
NFR-PRIV-004: Production retention and 30-day account deletion/de-identification are public-beta scope.
NFR-PRIV-005: Account-wide self-service data export/deletion is public-beta scope.
NFR-PRIV-006: Public-beta privacy/security release record is deferred.
NFR-SEC-001: Production synchronized-data encryption/access controls are public-beta scope.
NFR-SEC-002: Account authentication, revocation, rate limiting, and high-impact reauthentication are public-beta scope.
NFR-VOICE-001: Post-MVP voice-state and raw-audio privacy contract.
NFR-SHARE-001: Post-MVP/V2 server-backed sharing security and privacy contract.

### Additional Requirements

#### Success measures and counter-metrics

- SM-COMP-001: Every recorded/entered/corrected/confirmed item is durable; missing items make the session incomplete.
- SM-ACC-001: Recognition accuracy includes abstentions/misses and is not improved by later correction.
- SM-PRES-001: Corrections preserve all sibling facts and timing.
- SM-RET-001: Four-week default-recorder continuation needs preregistered cohort/denominator rules before holdout.
- SM-FEED-001: Critical/recurring core trust feedback requires preregistered severity, recurrence, cadence, and closure evidence.
- SM-INT-001: At most five proactive Exercise/rep/load/RPE prompts in a representative ~20-set session.
- SM-AI-001: Every approved proposal becomes exactly one complete structured revision.
- SM-AI-002: Effective Plan changes without required explicit approval must be zero.
- SM-E2E-001: Product Owner completes conversation → review → approval → commit → Watch execution → Actual Set return → AI change proposal without manual rebuilding.
- SM-ALPHA-CORE-001: Product Owner repeatedly uses the full private-Alpha core without returning to another primary recorder; experimental errors remain visible/correctable.

#### Architecture requirements

- AD-1/AD-12: Seed one Xcode workspace with separate iPhone/Watch targets and a local Swift Package; keep domain targets framework-free and map models at ports. This is the S0 starter seed and Epic 1 Story 1 concern.
- AD-2: Stable IDs precede persistence; every user/approved-AI mutation atomically commits append-only revision + outbox + invalidation; define one revision DAG/effective reducer and golden vectors.
- AD-3: iPhone owns long-lived truth and complete resolution; selected capture device owns the live session; Watch uses `HKWorkoutSession`; phone-only uses the same domain.
- AD-4: Use durable causal outbox transfer, pairing epochs, `(pairingEpoch, sourceDeviceId, messageId)` replay identity, chunk/whole-object digests, four acknowledgement states, compatibility handshake, and whole-object `applied` cleanup.
- AD-5: Use separate GRDB 7.11.1 stores, atomic critical writes, protected files, `completeUntilFirstUserAuthentication`, backup exclusion, non-synchronizing Keychain, unreadable-store preservation, and conservative cleanup/tombstones.
- AD-6: Keep recognition/RPE/Finish assistance independently evidence-gated, session-frozen, fail-closed, and manually replaceable; use only the exact candidate device/orientation/handedness/eight-Exercise row until qualified.
- AD-7: Treat AI as untrusted structured proposal input; validate after generation and before commit; bind accessible approval to identity/digest/base/policies; never mutate active sessions/history.
- AD-8: Separate built-in gateway and device-local BYOK DeepSeek routes, pseudonymous route/account isolation, one-shot digest-bound authorization, content-free audit, allowlists/ceilings, and kill switches.
- AD-9: Keep FitnessAI authoritative over optional HealthKit context/copies; implement the versioned allowlist, observable states, export generations, transition table, and detached-copy behavior.
- AD-10: Use plain uncompressed UTF-8 JSON; enforce 2 MB, depth 12, one Plan, 366 days, 30 Exercises/day, 20 Sets/Exercise, 10,000 Sets, and 2,000 chars/note plus canonical unknown-field/mapping/duplicate behavior.
- AD-11: Derive Analysis only from effective Actual Set revisions; invalidate/recompute by scope and label stale/pending/partial/conflicted/excluded truthfully.
- AD-13: Separate development/private-Alpha/future-production data and credentials; require compile/domain/schema/safety/persistence/sync/AI/secret checks, Alpha fault/accessibility/paired-device/physical-device evidence, privacy-safe logs, opt-in telemetry, and size reports.
- AD-14: Implement Titanium Measure semantic tokens, typed native navigation, thin MVVM/state machines, complete exceptional states, and equivalent non-color/non-motion/non-haptic/non-Crown access.

#### Gate requirements

- GATE-1 enabling/evidence requirement: Before the first AI Plan implementation Story, freeze Safety Rule Pack v1 numeric bounds and golden fixtures. Until complete deterministic results exist, proposal scaffolding may proceed but commit remains blocked. Professional review gates release beyond owner testing.
- GATE-2 enabling requirement: Before built-in Alpha traffic, freeze DeepSeek legal/runtime/region/subprocessor/retention/training/deletion/disclosure and gateway operational controls. Until then, built-in traffic is technically disabled; ports and BYOK may be locally tested.
- GATE-3 enabling requirement: Before any real Health-derived remote traffic, approve Apple-purpose, processor/contract, cross-border, disclosure, retention/training, deletion/revocation/user-rights, and request-field mapping evidence. Until then, preview may render but send fails closed.
- GATE-4 evidence requirement: Before automatic recognition is enabled, freeze and pass the registered physical-device evidence record. Until then, the AD-6 row is candidate-only and manual Complete Set is supported.
- GATE-5 evidence requirement: Before RPE auto-use, freeze and pass model, threshold, baseline, burden, drift, subgroup, missing-signal, resource, and holdout evidence. Until then, RPE is off by default and confirmation-only where approved.
- GATE-6 evidence requirement: Before forgotten-Finish is enabled, freeze thresholds/protocol and pass long-rest/equipment-wait/low-motion physical-device evidence. Until then, manual Finish only.
- GATE-7 prerequisite requirement: Before Plan import Stories may be accepted, freeze parser time/memory ceilings and failure reporting. Export may proceed while import acceptance remains blocked.

#### Gate Story Placement Contract

| Gate | Story placement | Work allowed while open | Path that remains fail closed |
|---|---|---|---|
| GATE-1 | Epic 2 prerequisite → implementation → evidence → commit enablement | Proposal/schema/review/digest scaffolding | Safety-dependent AI Plan behavior and every proposal commit |
| GATE-2 | Epic 2 adapter/control → evidence record → traffic enablement | Provider port, fake provider, BYOK, disabled gateway adapter, local contract tests | All real built-in DeepSeek traffic |
| GATE-3 | Epic 2 authorization/fail-closed preview → Epic 6 local summary → evidence record → send enablement | Local Health, AI without Health, default-off preview and local summaries | All real Health-derived remote sends |
| GATE-4 | Epic 7 candidate → preregistration → physical-device evidence → row-specific enablement | Candidate development, data capture, manual Complete Set | Every unqualified recognition function/device/orientation/Exercise row |
| GATE-5 | Epic 7 disabled model/state flow → preregistration → evidence → explicit-user enablement | Manual RPE and approved confirmation-only collection | RPE auto-use |
| GATE-6 | Epic 7 disabled candidate → preregistration → physical-device evidence → enablement | Manual Finish and disabled 15-minute dual-signal candidate | Forgotten-Finish reminder and every automatic Finish path |
| GATE-7 | Epic 5 export → parser-budget prerequisite → parser/preview/evidence | Bounded Plan export | Plan import Story acceptance |

Every evidence Story names the owned evidence artifact, frozen versions and inputs, thresholds, failure result, and default-disabled control. A Gate Story cannot be accepted by a status assertion alone.

### UX Design Requirements

UX-DR1: Implement iPhone top-level Plan, History, Analysis, and More with Plan as root; use typed contextual routes and restore object/filter/scroll/non-effective input on back.
UX-DR2: Implement `AI-L01`–`AI-L05`/`AI-01`–`AI-06` for Plan Home, text Chat, default-off Authorization, complete Proposal Review, separate Approval, and separate Commit/Delivery truth.
UX-DR3: Implement `PW-L01`–`PW-L02` phone-only active workout, set editing, correction, recovery, Finish Incomplete, and confirmed discard using the shared session model.
UX-DR4: Implement Watch Approved Plan, Active Workout, Edit Actual Set, Rest Resolution, Recovery, and Finish/Local Save surfaces with one primary task/action per state.
UX-DR5: Implement `HX-L01` History with ready/loading/empty/offline/incomplete/corrected/conflict/tombstone/return/restoration states and scroll/filter restoration.
UX-DR6: Implement `AN-L01` Analysis with exact metrics, literal conclusions, effective-Actual-Set provenance, exclusions, stale/partial/error states, and text/table alternatives for charts.
UX-DR7: Implement `HK-L01` capability-specific Apple Health rows, local-authority explanation, detached/retry states, and a separate gate-blocked remote-summary preview.
UX-DR8: Implement `PX-L01` export scope review, native Share Sheet, bounded import preview/mapping/omission/duplicate/error states, and one Create New Draft action.
UX-DR9: Implement `RV-L01` once-per-session nonmodal Review/Later/Disable invitation that routes through existing authorization/diff/approval without hidden state.
UX-DR10: Build reusable `ai-conversation`, `remote-ai-authorization`, `plan-diff-review`, `proposal-approval-gate`, `safety-stop`, `session-control`, `actual-set-row`, `load-stepper`, `recognition-state-chip`, `rpe-verification-prompt`, `forgotten-finish-prompt`, `analysis-summary`, `healthkit-capability-row`, `plan-exchange-review`, `proactive-review-invitation`, `sync-state-indicator`, `recovery-choice-sheet`, and `support-boundary-notice` families.
UX-DR11: Consume Titanium Measure semantic tokens through SwiftUI Color/Font roles, 4 pt rhythm, native geometry, no decorative shadow, SF Symbols, and no raw styling inside components.
UX-DR12: Preserve the fact → source/authority → durability → consequence/action hierarchy; local save, delivery, synchronization, Health write, and remote send are distinct statuses.
UX-DR13: Use a single consequential primary action per state, ≥44 × 44 pt controls with 8 pt separation, safe-area bottom actions, keyboard avoidance, and native sheets/alerts/file picker/Share Sheet/Health authorization.
UX-DR14: Support light/dark/Increase Contrast/Differentiate Without Color/Reduce Motion/Reduce Transparency, ≥200% iPhone and ≥140% Watch text scaling, VoiceOver, Full Keyboard Access, and no sole reliance on color, motion, haptic, gesture, or Crown.
UX-DR15: Error focus lands on a literal summary then recovery action; Retry preserves input; success focus lands on the exact durable result; status updates do not steal focus unless integrity is threatened.
UX-DR16: Defer proactive prompts to `restSafeForInteraction`; retain pending facts, coalesce announcements, and enforce the shared five-prompt active-session budget.
UX-DR17: Keep unsupported/manual-only boundaries explicit, preserve manual Complete Set/Finish/local capture, and add no discoverable deferred-feature placeholders.
UX-DR18: Reflow from iPhone 11 through larger phones without horizontal scrolling; linearize metrics/diffs at accessibility sizes and never truncate critical Chinese values, consequences, digests, or actions.
UX-DR19: Provide current, pending, stale, partial, conflicted, invalid, unsupported, failed, cancelled, incomplete, and recovery states as literal UI semantics, never optimistic or color-only success.
UX-DR20: Validate physical-device Watch glanceability, Always On, Crown/touch equivalents, sweat/one-hand use, haptics, gym lighting, iPhone geometry, largest Chinese text, P3/sRGB contrast, chart targeting, offline, failure, replay, and reconnect behavior.

### FR Coverage Map

FR-001: Epic 1 — shared planned/ad-hoc session start and capture ownership.
FR-002: Epic 1 — structured Actual Set truth.
FR-003: Epic 1 — durable local-save boundary.
FR-004: Epic 1 — authoritative manual Finish.
FR-005: Epic 7 — evidence-gated forgotten-Finish prompt.
FR-006: Epic 1 — completed-session facts and trained areas.
FR-007: Epic 1 — visible incomplete/pending facts.
FR-008: Epic 7 — qualified ad-hoc Exercise recognition.
FR-009: Epic 7 — qualified set-boundary and repetition recognition.
FR-010: Epic 7 — recognition confidence and provenance states.
FR-011: Epic 7 — trust-gated prompting under the shared budget.
FR-012: Epic 7 — first-set Exercise correction.
FR-013: Epic 7 — sibling-fact preservation during recognition correction.
FR-014: Epic 7 — corrected continuation and audit.
FR-015: Epic 7 — recognition/recovery metric separation.
FR-016: Epic 1 — planned first-load default.
FR-017: Epic 1 — historical ad-hoc first-load default.
FR-018: Epic 1 — previous-Actual-Load default.
FR-019: Epic 1 — authoritative load editing.
FR-020: Epic 7 — RPE opt-in boundary.
FR-021: Epic 7 — five-estimate verification.
FR-022: Epic 7 — ≥4/5 auto-use offer.
FR-023: Epic 7 — ≥2/5 recalibration and restart.
FR-024: Epic 7 — explicit-consent high-confidence auto-use.
FR-025: Epic 7 — abstention/pending/drift behavior.
FR-026: Epic 7 — distinct RPE states and provenance.
FR-027: Epic 3 — explicit accept/edit/reject next-set guidance.
FR-028: Epic 1 — select and execute an existing Plan snapshot.
FR-029: Epic 1 — planned/Actual separation.
FR-030: Epic 3 — request substitute Exercises.
FR-031: Epic 3 — canonical substitute matching and comparison.
FR-032: Epic 3 — user-authoritative substitute selection.
FR-033: Epic 4 — exact post-session Plan reconciliation diff.
FR-034: Epic 4 — rejection preserves Actual facts and future Plan.
FR-035: Epic 4 — historical session reuse as a new draft.
FR-036: Epic 4 — browsable complete/incomplete History.
FR-037: Epic 4 — weekly session and Exercise evidence.
FR-038: Epic 4 — Actual-Set-based weekly/monthly Analysis.
FR-039: Epic 4 — selected Primary Exercise trends.
FR-040: Epic 4 — corrected-value/RPE provenance in Analysis.
FR-041: Epic 4 — complete session detail.
FR-042: Deferred — public-beta FitnessAI Account sign-in.
FR-043: Epic 1 — offline local capture and distinct concurrent sessions.
FR-044: Deferred — public-beta application-cloud synchronization.
FR-045: Deferred — public-beta account-scoped restoration.
FR-046: Epic 1 — causal/idempotent cross-device transfer and visible conflicts.
FR-047: Epic 1 — raw high-frequency streams remain local.
FR-048: Deferred — public-beta account export/deletion lifecycle.
FR-049: Epic 1 — canonical Exercise identity.
FR-050: Epic 1 — body-area and movement attributes.
FR-051: Deferred — rich teaching media.
FR-052: Epic 1 — concise RPE and concept explanation.
FR-053: Epic 1 — licensed-content and support-claim boundary.
FR-054: Epic 2 — bounded text AI Plan intake.
FR-055: Epic 2 — equipment context and mapped substitutions.
FR-056: Epic 2 — complete structured Plan Draft.
FR-057: Epic 2 — complete review and one atomic approval.
FR-058: Epic 2 — non-diagnostic safety stop.
FR-059: Epic 2 — explicitly invoked evidence-bounded revision proposal.
FR-060: Epic 2 — digest/base/proposal-bound approval.
FR-061: Epic 1 — field/topology Actual Set correction.
FR-062: Epic 1 — pending-field resolution and Incomplete Finish.
FR-063: Epic 1 — append-only auditable corrections.
FR-064: Epic 1 — active-session recovery choices.
FR-065: Epic 1 — one visible pending fragment.
FR-066: Epic 1 — idempotent recovery and replay.
FR-067: Deferred — public-beta deletion propagation/tombstones.
FR-068: Deferred — public-beta cloud restoration status.
FR-069: Deferred — public-beta sign-out retain/remove.
FR-070: Deferred — public-beta cross-account non-merge.
FR-071: Epic 5 — one bounded Plan export and Share Sheet.
FR-072: Epic 5 — validated preview-to-new-draft import.
FR-073: Epic 5 — explicit mapping/omission/duplicate/version handling.
FR-074: Deferred — Post-MVP voice draft capture.
FR-075: Deferred — Post-MVP voice conflict and fallback.
FR-076: Deferred — Post-MVP/V2 third-party Plan formats.
FR-077: Deferred — Post-MVP/V2 link/QR sharing.
FR-078: Epic 2 — immutable proposal identity and scope.
FR-079: Epic 2 — complete future-scope diff.
FR-080: Epic 2 — atomic/idempotent revision commit.
FR-081: Epic 1 — complete compatible Plan delivery to Watch.
FR-082: Epic 2 — bounded AI source policy and Health-summary gate.
FR-083: Epic 2 — non-effective conversation/regeneration/rejection.
FR-084: Epic 2 — duplicate/retry/out-of-order Plan protection.
FR-085: Epic 2 — AI/delivery failure degradation.
FR-086: Epic 2 — one-shot remote-use authorization.
FR-087: Epic 2 — deterministic Safety Rule Pack gating.
FR-088: Epic 6 — least-privilege Apple Health reads.
FR-089: Epic 6 — optional idempotent Health workout copy.
FR-090: Epic 6 — local authority and detached-copy behavior.
FR-091: Epic 8 — one non-blocking post-session review invitation.

## Epic List

### Epic 1: Complete a Trustworthy Manual Workout Across iPhone and Watch

The trainee can first complete a planned or ad-hoc phone-only session, then use the same truth model to receive a complete compatible Plan on Watch, execute an immutable Start snapshot, save facts locally through disconnect/restart, and return them to iPhone exactly once. S0 repository/contracts, S1 phone-only capture, and S2 paired-Watch capture are ordered checkpoints inside one cohesive user-value Epic; no AI, Health, network, or automation dependency can block the manual core.

**FRs covered:** FR-001–004, FR-006–007, FR-016–019, FR-028–029, FR-043, FR-046–047, FR-049–050, FR-052–053, FR-061–066, FR-081.

**Implementation slices:** S0 → S1 → S2. **Primary bindings:** CAP-2–3, CAP-7, CAP-12–13; AD-1–5, AD-12–14.

### Epic 2: Turn an Authorized AI Conversation into an Approved Plan Revision

The trainee can authorize an exact remote data scope, create or revise a complete structured Plan, resolve safety/mapping issues, review every field, approve one digest-bound proposal, and atomically activate exactly one revision while every failure preserves the prior Plan and manual workout core. GATE-1 is a prerequisite/evidence Story; GATE-2 and GATE-3 keep built-in and Health-derived traffic technically disabled until closed, while safe scaffolding and eligible local/BYOK work may proceed.

**FRs covered:** FR-054–060, FR-078–080, FR-082–087.

**Implementation slice:** S3. **Primary bindings:** CAP-1, CAP-9, CAP-11; AD-2, AD-7–9, AD-13–14; GATE-1–3.

### Epic 3: Make User-Authoritative Decisions During a Workout

During a session, the trainee can request a canonical substitute when equipment is unavailable and accept, edit, or reject next-set load guidance without silently changing the current Actual Set or future Plan. This Epic consumes only stable Plan snapshots, effective Actual facts, RPE provenance, and Exercise Catalog ports; it does not depend on or call the post-session Analysis/read-model implementation.

**FRs covered:** FR-027, FR-030–032.

**Implementation slice:** S4A. **Primary bindings:** CAP-13–14; AD-2, AD-7, AD-14.

### Epic 4: Review History, Analysis, and Future-Plan Reconciliation

After or between sessions, the trainee can browse complete History, inspect revision-bound weekly/monthly and selected Primary Exercise Analysis, see stale/partial/conflicted exclusions truthfully, reuse a historical session as a new draft, and accept or reject an exact future-Plan reconciliation diff without altering completed work. This Epic owns Analysis/read-model and future-Plan reconciliation use cases and depends only on shared stable domain contracts, not the in-session guidance implementation.

**FRs covered:** FR-033–041.

**Implementation slice:** S4B. **Primary bindings:** CAP-7–8, CAP-14; AD-2, AD-7, AD-11, AD-14.

### Epic 5: Exchange a FitnessAI Plan as a Safe Independent Draft

The trainee can export exactly one bounded FitnessAI Plan through the native Share Sheet and import a file only after complete validation, mapping, omission, duplicate, and provenance review creates a new non-effective draft. Parser or sharing failure changes no existing Plan. GATE-7 is a prerequisite/evidence Story: export may proceed, but Plan import cannot be accepted until parser time/memory ceilings and failure reporting are frozen.

**FRs covered:** FR-071–073.

**Implementation slice:** S5A. **Primary bindings:** CAP-10; AD-10, AD-13–14; GATE-7.

### Epic 6: Use Apple Health Without Surrendering Local Truth

The trainee can grant optional least-privilege Apple Health capabilities, observe only truthful read states, and create or retry idempotent workout copies while FitnessAI remains authoritative and external changes become `healthKitDetached`. Health failure leaves local Plan, History, Analysis, and capture intact. The local capability works independently; GATE-3 keeps every real Health-derived remote send technically disabled while allowing a separate authorization preview and AI without Health data.

**FRs covered:** FR-088–090.

**Implementation slice:** S5B. **Primary bindings:** CAP-9; AD-8–9, AD-13–14; GATE-3.

### Epic 7: Gain Evidence-Gated Watch Assistance with Manual Fallback

On the exact qualified device/orientation/handedness/Exercise rows, the trainee can receive independently qualified recognition, set/rep, opt-in RPE, and conservative Finish assistance with confidence, abstention, correction, drift recovery, safe-rest prompting, and the shared interruption budget. GATE-4–6 are evidence Stories; each open or failed Gate keeps only its named automation path disabled while Epic 1 manual capture remains supported.

**FRs covered:** FR-005, FR-008–015, FR-020–026.

**Implementation slice:** S6. **Primary bindings:** CAP-4–6; AD-6, AD-13–14; GATE-4–6.

### Epic 8: Complete a Controlled Post-Session Review and Reuse the Private Alpha

After a completed session, the Product Owner can accept, defer, or disable one non-blocking review invitation and, when accepted, enter the existing authorized diff-and-approval path without hidden data use or mutation. The Product Owner can then repeatedly complete the full conversation-to-Plan-to-workout-to-Analysis loop across accessible native iPhone and Watch surfaces; S7 closes migration, fault, size, privacy, paired-device, and physical-device evidence without discoverable deferred placeholders or optimistic state claims.

**FRs covered:** FR-091.

**Implementation slice:** S7. **Primary bindings:** CAP-11–12 and all integrated CAPs; AD-13–14; SM-COMP-001–SM-ALPHA-CORE-001.

## Epic 1: Complete a Trustworthy Manual Workout Across iPhone and Watch

The trainee can first complete a planned or ad-hoc phone-only session, then use the same truth model to receive a complete compatible Plan on Watch, execute an immutable Start snapshot, save facts locally through disconnect/restart, and return them to iPhone exactly once. S0 repository/contracts, S1 phone-only capture, and S2 paired-Watch capture are ordered checkpoints inside one cohesive user-value Epic; no AI, Health, network, or automation dependency can block the manual core.

### Story 1.1: Launch the Runnable iPhone, Watch, and Shared-Contract Workspace

As a Product Owner,
I want a launchable iPhone and Apple Watch private-Alpha shell with enforced shared-package boundaries,
So that every later workout capability is built on one runnable native product without creating incompatible truth models.

**Acceptance Criteria:**

**Given** a clean checkout on the specified Apple Silicon development environment
**When** the developer opens and builds the FitnessAI workspace with Xcode 26.6 and Swift 6.3.3
**Then** the iPhone and Watch app targets both compile and launch
**And** the workspace uses one local Swift Package with explicit `Contracts`, domain, application-use-case, persistence-port, synchronization-contract, safety-rule, and analysis targets
**And** GRDB is pinned exactly to 7.11.1 with the resolved dependency committed.

**Given** the shared-package dependency graph
**When** dependency-direction tests inspect every domain target
**Then** no domain target imports SwiftUI, GRDB, HealthKit, WatchConnectivity, Core Motion, an AI-provider framework, or an application target
**And** adapters depend inward through named ports only
**And** no generic `Utils` target is introduced.

**Given** the iPhone app launches without an existing Plan or Workout Session
**When** the Product Owner reaches the root experience
**Then** Plan is selected within native Plan, History, Analysis, and More navigation
**And** unfinished capabilities use truthful native empty states rather than developer placeholders or discoverable deferred-feature controls
**And** contextual navigation uses typed destinations suitable for later object, filter, scroll-position, and non-effective-input restoration.

**Given** the Watch app has no compatible delivered Plan
**When** it launches
**Then** it shows a truthful no-delivered-Plan state
**And** it exposes no partial Plan, simulated recognition, or nonfunctional future capability.

**Given** Light Mode, Dark Mode, increased text size, VoiceOver, Reduce Motion, or Differentiate Without Color is enabled
**When** the launch and empty states are inspected
**Then** semantic Titanium Measure tokens and native SwiftUI behavior are used
**And** required state and navigation meaning remains available without relying only on color, motion, haptics, gestures, or Digital Crown.

**Given** this Story is only the repository and contract seed
**When** its persistence content is inspected
**Then** it creates no speculative tables or entities for future Stories
**And** it stores no secrets, Health data, sensor data, AI content, or workout facts.

**Traceability:** AD-1, AD-12, AD-13, AD-14; UX-DR1, UX-DR11–15, UX-DR17–19; NFR-UX-001.

### Story 1.2: Unify Cross-Device Fact Identity, Units, and Digest Contracts

As a trainee,
I want every Plan, Workout Session, Actual Set, and revision to retain the same identity and meaning across iPhone, Watch, retries, and transfer,
So that workout facts are never duplicated, mistranslated, or interpreted as different content.

**Acceptance Criteria:**

**Given** the app is creating a Plan, Plan Revision, Workout Session, Actual Set, revision event, device message, approval, or proposal identity
**When** the object first exists in the domain
**Then** it receives a stable ID before persistence, transfer, or UI success
**And** local retry, restart, Watch transfer, and replay retain that ID
**And** device time or arrival order never regenerates or selects fact identity.

**Given** iPhone and Watch exchange or compare workout facts
**When** shared `Contracts` encode or decode them
**Then** the contracts define platform-neutral IDs, units, revision metadata, error codes, and version fields
**And** they expose no SwiftUI, GRDB-row, HealthKit, WatchConnectivity, or provider-specific model
**And** a future Kotlin implementation can implement the schema and golden fixtures without sharing Swift code.

**Given** the user enters a load
**When** it enters a domain contract
**Then** the original entered value and kg/lb unit are preserved
**And** canonical conversion is a separate derived value
**And** external, bodyweight, assisted, unloaded, timed, and non-comparable load kinds are distinct
**And** total and per-side basis are distinct when applicable
**And** semantically incomparable loads are never forced into one value class.

**Given** a fact will be interpreted outside its originating component
**When** it enters persistence, Watch transfer, an AI proposal, a Plan file, or Analysis
**Then** it carries every applicable app, schema, Exercise-catalog, model, support-matrix, Safety-Rule-Pack, or algorithm version
**And** a missing or incompatible required version produces an explicit pending, unsupported, or rejected error
**And** historical facts are never silently reinterpreted under a current version.

**Given** the same structured content participates in display, approval, sync, import, or commit
**When** canonical serialization and digest are generated
**Then** one normative profile specifies UTF-8 encoding, Unicode normalization, decimal and unit representation, UTC/time-zone meaning, unknown-field behavior, covered fields/bytes, and a versioned hash algorithm
**And** equivalent iPhone and Watch input produces identical canonical bytes and digest
**And** changing any covered field changes the digest.

**Given** the contract repository contains golden vectors
**When** iPhone-target, Watch-target, and shared-package tests run
**Then** every target agrees on valid-fixture bytes, digest, IDs, units, and version interpretation
**And** malformed, unknown-required-field, unsupported-version, decimal-boundary, Unicode, and time-zone fixtures return the specified typed error
**And** no fixture produces partial success or an automatically substituted fact.

**Given** Story 1.2 is limited to stable contracts
**When** its implementation scope is inspected
**Then** it creates only the schemas, value types, canonicalization implementation, and fixtures required here
**And** it creates no Workout, Plan, AI, Health, or sync database table
**And** it sends no network request or exposes a later user capability.

**Traceability:** AD-2, AD-4, AD-12; Architecture Consistency Conventions; S0 cross-target golden-fixture exit condition; NFR-COMPAT-002.

### Story 1.3: Preserve and Resolve Workout Truth with One Revision DAG

As a trainee,
I want every change to preserve the original fact and use the same rule to determine the effective revision,
So that iPhone, Watch, correction, and retry conflicts never silently overwrite or lose my record.

**Acceptance Criteria:**

**Given** a user or approved AI changes a Plan, Workout Session, or Actual Set
**When** the domain creates a revision
**Then** it includes a stable revision/event ID, object ID, canonical field path or operation kind, parent/head set, author device, resolution references, and applicable versions
**And** the original object and prior revisions remain immutable
**And** the reducer computes the effective value through one shared contract instead of overwriting an old value.

**Given** two revisions modify different canonical fields of one object
**When** the reducer receives both revisions and every required parent exists
**Then** safely mergeable different-field edits produce a deterministic effective result independent of arrival order
**And** iPhone and Watch produce the same result for the same DAG.

**Given** two revisions write incomparable values to the same canonical field
**When** the reducer processes them
**Then** the result remains `conflicted`
**And** both user-authored values and their provenance remain visible
**And** device time, arrival order, greatest ID, or last-write-wins never silently selects a winner.

**Given** concurrent revisions perform split/merge, insert/delete, reorder, completion-state, or Plan-topology operations
**When** the operations overlap or cannot be safely composed
**Then** the reducer does not flatten or guess a combined result
**And** the affected object remains `conflicted` or `pendingResolution`
**And** unaffected sibling facts remain effective.

**Given** a revision references a parent that has not arrived
**When** the reducer computes state
**Then** that revision remains `pendingMissingParent`
**And** it does not become effective early
**And** receiving the parent later permits recomputation without creating a duplicate revision.

**Given** the user explicitly resolves a conflict on iPhone
**When** a resolution revision is created
**Then** it references every resolved head
**And** the selected result is stored as a new append-only revision
**And** unselected revisions remain in audit history
**And** resubmitting the same resolution idempotency key returns the original result.

**Given** the same revision set reaches the reducer in different orders, batches, or duplicate counts
**When** golden-vector and property tests run
**Then** they produce the same effective, pending, or conflicted state
**And** they do not duplicate an Actual Set, lose a correction, or roll back a later user revision
**And** iPhone, Watch, and platform-neutral fixture results agree.

**Given** Story 1.3 is limited to revision policy
**When** its implementation scope is inspected
**Then** it implements only revision value types, DAG validation, the effective-value reducer, typed conflict states, and fixtures
**And** it creates no database table, Watch transfer, UI conflict-resolution screen, or Analysis recomputation
**And** later adapters must call this reducer instead of implementing another conflict rule.

**Traceability:** AD-2, AD-3, AD-4, AD-11; shared-domain prerequisite for FR-046, FR-063, FR-066; SM-PRES-001; S0 golden-vector exit condition.

### Story 1.4: Establish an Atomic, Protected, and Recoverable iPhone Persistence Boundary

As a trainee,
I want workout and Plan data to be saved safely and completely on my iPhone,
So that interruption or storage failure can never produce a reported success for partially saved or lost truth.

**Acceptance Criteria:**

**Given** the app creates or opens its local database for the first time
**When** the persistence component finishes initialization
**Then** the system uses GRDB 7.11.1 and system SQLite behind one persistence port
**And** this Story creates only the minimum schema metadata, revision-event, outbox-event, invalidation, and idempotency records required as storage foundations
**And** it does not pre-create business tables that have not been explicitly defined by later Stories.

**Given** a later capability must save a business fact, revision record, outbox event, and related invalidation together
**When** it submits those values through the shared transaction boundary
**Then** every value commits successfully in one database transaction
**And** failure at any write step rolls back the entire transaction without leaving partial data
**And** the calling layer may report success only after the transaction has committed.

**Given** an operation is retried with the same idempotency identifier after it has already succeeded
**When** the persistence layer recognizes the completed operation
**Then** it returns the prior result
**And** it does not create duplicate revisions, events, or outbox records.

**Given** a test injects power loss, disk-write failure, or process termination at different transaction write points
**When** the database is opened again
**Then** its state is either fully committed or completely uncommitted
**And** it never contains a saved business fact whose required revision or outbox event is missing.

**Given** a local save fails
**When** the user remains in the current workflow
**Then** the system preserves the user's uncommitted input
**And** it returns a typed error that distinguishes the failure cause
**And** it neither reports success nor discards the input.

**Given** the database and its auxiliary files are created
**When** their protection and backup attributes are inspected
**Then** the database, WAL, SHM, and later local-transfer files governed by the same policy use `completeUntilFirstUserAuthentication`
**And** they are excluded from iCloud and ordinary device backup
**And** keys, tokens, and other sensitive credentials are never stored in the database.

**Given** the database is corrupt, unreadable, or cannot complete migration
**When** the app attempts to start the persistence layer
**Then** the system enters an explicit recovery state and stops writes that depend on that database
**And** it does not silently replace the existing data with an empty database
**And** it preserves the original file for diagnosis or recovery.

**Given** the persistence layer emits diagnostics
**When** it writes a log or error report
**Then** it records only metadata such as object identifiers, state, error type, version, and timing
**And** it does not record workout content, Health data, user free text, or other sensitive payloads.

**Given** Story 1.4 is complete
**When** its delivery scope is inspected
**Then** it contains only the iPhone persistence adapter, transaction capability, protection policy, and automated tests
**And** it does not contain concrete workout business tables, Watch persistence, cross-device sync, History Analysis, or AI functionality.

**Traceability:** AD-2, AD-5, AD-13; NFR-SEC-003; atomic-commit foundation for later fact writes.

### Story 1.5: Browse the Canonical Exercise Catalog and Understand Support Boundaries

As a trainee,
I want to find and understand the standard exercises recognized by the system on iPhone,
So that I can choose exercises with unambiguous meaning and know which capabilities are available or require manual action.

**Acceptance Criteria:**

**Given** the user opens the Exercise Catalog without a network connection
**When** the app loads the versioned exercise data bundled locally
**Then** the user can browse and search exercises
**And** every exercise has a stable canonical Exercise ID and catalog version
**And** search results come from local data without depending on AI, an account, or a remote service.

**Given** the user opens a canonical exercise
**When** the app displays its details
**Then** the page shows its name, primary target body parts, secondary target body parts, movement pattern, and required equipment
**And** it shows structured range-of-motion or other attributes required by later substitution and Analysis when applicable
**And** those attributes come from versioned fields rather than guesses based on names or free text.

**Given** an exercise supports only some capabilities or requires manual recording
**When** the user views or selects it
**Then** the app explicitly shows its `supported`, `limited`, `manual-only`, or `unsupported` state
**And** it explains the currently available manual path
**And** it does not present any automatic recognition capability as available before its evidence Gate has passed.

**Given** external content, older data, or a later import references an exercise that cannot be mapped
**When** the catalog attempts to resolve that reference
**Then** the system preserves it as an unresolved mapping
**And** it does not invent a canonical mapping from a similar name
**And** it does not represent the unresolved exercise as fully supported.

**Given** the user wants to understand a training concept such as RPE
**When** the user opens the related explanation
**Then** the app provides concise local text
**And** reading the explanation does not mean that RPE recording or estimation has been enabled
**And** the related optional capability retains its prior disabled state.

**Given** an exercise detail includes instructional media
**When** the app displays an image or other content
**Then** it uses only properly licensed or project-owned media
**And** missing media leaves the complete text and an explicit unavailable state visible
**And** it never describes single-point Apple Watch observations as a precise judgment of whole-body movement quality.

**Given** the user uses VoiceOver, larger text, or non-haptic cues
**When** the user browses, searches, or selects an exercise
**Then** canonical identity, attributes, and support state have readable labels
**And** their meaning does not rely only on color, imagery, motion, or haptics.

**Given** the Exercise Catalog changes in a later app version
**When** historical facts or Plans still reference an older catalog version
**Then** their original Exercise IDs and version provenance remain preserved
**And** the new catalog does not silently reinterpret historical exercise meaning.

**Given** Story 1.5 is complete
**When** its implementation scope is inspected
**Then** it contains only the versioned Exercise Catalog, search and detail UI, support boundaries, concept explanations, and corresponding tests
**And** it does not contain automatic Exercise recognition, substitution recommendations, AI Plan generation, workout Analysis, or remote media downloading.

**Traceability:** FR-049, FR-050, FR-052, FR-053; AD-6, AD-12; UX-DR17; NFR-REC-002.

### Story 1.6: Create a Local Plan and Start an iPhone Workout from an Immutable Snapshot

As a trainee,
I want to create, select, and start a Plan without AI or a network, or start an ad-hoc workout directly,
So that I can still use the core iPhone workout flow when advanced capabilities are unavailable.

**Acceptance Criteria:**

**Given** the user has no usable training Plan
**When** the user chooses to create a local Plan
**Then** the user can define its name, ordered training days, canonical exercises, planned set counts, repetitions or repetition ranges, planned loads, and optional target RPE
**And** every exercise references the canonical Exercise ID and catalog version from Story 1.5
**And** Plan creation does not depend on AI, an account, Apple Health, or a network.

**Given** the user edits an existing Plan
**When** the user saves the changes
**Then** the system creates a new Plan revision rather than overwriting an old revision
**And** the save completes through the atomic transaction from Story 1.4
**And** a failed save leaves the previously effective Plan unchanged and preserves the user's input for editing or retry.

**Given** a Plan lacks a required field, contains an invalid unit, or references an unresolved exercise
**When** the user attempts to save it or start a workout from it
**Then** the system shows an explicit error adjacent to the affected field
**And** it neither guesses the missing content nor represents the invalid Plan as startable
**And** the user can return to the Exercise Catalog to resolve the mapping or retain the Plan as an incomplete draft.

**Given** the user selects a valid Plan from the Plan list
**When** the user views its pre-start details
**Then** the app shows the exercise order, set counts, repetitions, planned loads, and optional target RPE
**And** it explicitly shows the currently effective revision and state
**And** viewing the Plan does not create a Workout Session; the user must intentionally start it.

**Given** the user starts a planned workout
**When** the start operation commits locally
**Then** the system creates a stable Workout Session ID
**And** it stores an immutable Start snapshot containing the selected Plan revision, Exercise-catalog version, exercise order, set counts, repetitions, planned loads, and optional target RPE
**And** the UI enters the active-workout state only after that commit succeeds.

**Given** the user starts an ad-hoc workout
**When** the start operation commits locally
**Then** the system creates a stable ad-hoc Workout Session ID
**And** it explicitly records that the session has no Plan snapshot
**And** the user can subsequently choose an exercise from the canonical Exercise Catalog
**And** starting an ad-hoc workout never requires the user to create a Plan first.

**Given** the same start operation is resubmitted because of a repeated tap, app retry, or recovery
**When** the system receives the same idempotency identifier
**Then** it returns the existing Workout Session
**And** it does not create a duplicate session or a second Start snapshot.

**Given** the current recording device already has an unfinished Workout Session
**When** the user attempts to start another session
**Then** the app first shows the existing session and its state
**And** lets the user return to handle that session
**And** does not silently finish, replace, or merge it.

**Given** the user edits the source Plan after the workout has started
**When** the active session displays planned content again
**Then** that session continues to use its immutable Start snapshot
**And** later Plan changes affect only future sessions that have not started
**And** the system does not present a later Plan edit as the original content of the active session.

**Given** a planned workout has started but no set has been completed
**When** the system compares planned content with actual workout facts
**Then** the Start snapshot represents only planned content and does not automatically create an Actual Set
**And** later actual exercise, repetition, load, and RPE facts remain stored separately from planned fields.

**Given** Story 1.6 is complete
**When** its implementation scope is inspected
**Then** it contains only local Plan drafts and revisions, Plan selection, the ad-hoc workout entry, Workout Session identity, and the immutable Start snapshot
**And** it does not contain Actual Set entry, workout completion, Watch delivery, AI Plan generation, exercise substitution, or workout Analysis.

**Traceability:** FR-001, FR-028, FR-029; AD-2, AD-3, AD-4; independently usable phone-only S1 workout entry.

### Story 1.7: Reliably Record Every Actual Set on iPhone

As a trainee,
I want to record the exercise, repetitions, and load that I actually completed,
So that my workout record reflects what I did rather than merely copying the Plan.

**Acceptance Criteria:**

**Given** the user is in a planned workout
**When** the user prepares to record the first set of an exercise
**Then** the system pre-fills the planned load from the immutable Start snapshot
**And** clearly identifies it as a Plan-provided default rather than a confirmed Actual Load
**And** lets the user change it before saving.

**Given** the user is in an ad-hoc workout and the exercise has a historical Actual Set
**When** the user prepares to record its first set
**Then** the system may pre-fill the most recent effective Actual Load for that exercise
**And** shows that the value came from workout history
**And** does not present a planned load, AI suggestion, or value with unknown provenance as a historical Actual Load.

**Given** the user is in an ad-hoc workout and the exercise has no usable historical Actual Load
**When** the user prepares to record its first set
**Then** the system requires the user to enter the Actual Load or choose an applicable unloaded kind
**And** it does not guess an external load.

**Given** the user has saved the preceding set for the same exercise
**When** the user begins the next set
**Then** the system defaults to the preceding set's saved Actual Load
**And** the user can still change the current set
**And** changing the current set does not retroactively change any previously saved set.

**Given** the user records an actual workout set
**When** the system prepares to create the Actual Set
**Then** it stores a stable Actual Set ID, Workout Session ID, canonical Exercise ID and catalog version, set order, actual repetitions, Actual Load, time, provenance, and completeness state
**And** Actual Load preserves the user's original value and kg/lb unit
**And** it distinguishes total, per-side, bodyweight, assisted, unloaded, timed, or other semantically incomparable load kinds when applicable.

**Given** the current capability permits a user-entered RPE
**When** the user manually enters RPE for the set
**Then** the system stores it as a user-provided Actual RPE with provenance
**And** does not represent it as a model estimate
**And** preserves an explicit state rather than inventing a value when RPE is disabled or omitted.

**Given** actual exercise, repetitions, load, or RPE differs from planned content
**When** the Actual Set is saved
**Then** the system stores planned and actual fields separately
**And** does not alter the Start snapshot to hide the difference
**And** the user-confirmed, successfully committed value is authoritative for the actual workout fact.

**Given** the user selects Complete Set
**When** the Actual Set, corresponding revision, outbox event, and invalidation have not all committed
**Then** the UI does not show the set as saved
**And** a failed commit preserves the user's input and shows a retryable error
**And** the set appears complete only after the Story 1.4 atomic transaction succeeds.

**Given** the user taps Complete Set repeatedly or the app retries the same save request
**When** the request carries the same idempotency identifier
**Then** the system returns the original Actual Set
**And** it creates no duplicate set, revision, or outbox event.

**Given** the user uses VoiceOver, larger text, or Reduce Motion
**When** the user enters or confirms repetitions, load, and unit
**Then** every field, default-value source, error, and save state has a readable label
**And** critical actions do not require color, a swipe gesture, animation, or haptics to complete.

**Given** Story 1.7 is complete
**When** its implementation scope is inspected
**Then** it contains only complete Actual Set manual entry, load-default rules, structured saving, and corresponding tests
**And** it does not contain correction of saved facts, missing-field recovery, workout completion, Watch entry, automatic Exercise or repetition recognition, or an AI next-set suggestion.

**Traceability:** FR-002, FR-003, FR-016, FR-017, FR-018, FR-019, FR-029; AD-2, AD-4; SM-PRES-001.

### Story 1.8: Correct an Active Workout Record and Preserve Incomplete Information

As a trainee,
I want to fix incorrect, missed, or extra sets during a workout while preserving information I cannot yet confirm,
So that recording problems can be repaired without overwriting original facts or pretending the record is complete.

**Acceptance Criteria:**

**Given** the user discovers that a saved set has incorrect repetitions, load, or manually entered RPE
**When** the user submits a correction
**Then** the system creates a new revision rather than overwriting the original value
**And** the new revision changes only the fields the user explicitly edited
**And** the original value, provenance, and correction history remain preserved.

**Given** the user discovers that an Actual Set references the wrong canonical exercise
**When** the user selects the correct exercise and confirms the change
**Then** the system changes the exercise reference through a new revision
**And** preserves the existing set order, repetitions, load, RPE state, and time
**And** records the before-and-after canonical Exercise IDs, catalog versions, and user-correction provenance.

**Given** the user missed an actual workout set
**When** the user inserts it at the correct position
**Then** the system creates a new Actual Set with a stable ID
**And** explicitly stores its session order and user-added provenance
**And** does not modify the original facts of adjacent sets.

**Given** the user recorded a set that did not occur
**When** the user confirms deletion
**Then** the system creates an auditable deletion revision
**And** does not physically erase the original set from the database
**And** the deleted set no longer contributes to effective workout facts.

**Given** two Actual Sets should be merged into one
**When** the user confirms the merge and supplies the final fields
**Then** the system creates a new revision relationship that explicitly references both source sets
**And** both source sets and their provenance remain in audit history
**And** the effective result counts as exactly one Actual Set.

**Given** one Actual Set should be split into two
**When** the user confirms the split and completes the fields for each result
**Then** the system creates two result sets with stable IDs that reference the source set
**And** the source set no longer counts again as an effective set
**And** retrying the same split does not create additional sets.

**Given** a set lacks its exercise, repetitions, load kind, or another required field
**When** the user cannot yet confirm the complete information
**Then** the system saves the recoverable content as a visible `pending` Actual Set
**And** explicitly identifies every missing field
**And** does not guess the missing value, hide the set, or display it as complete.

**Given** the user is ready to complete a `pending` Actual Set
**When** the user fills every required field and commits successfully
**Then** the system creates a new resolution revision and makes the set complete
**And** preserves the prior incomplete state and provenance
**And** does not create a duplicate Actual Set.

**Given** two user-authored revisions of the same field cannot be safely merged
**When** the system computes the effective workout fact
**Then** the field remains `conflicted` or `pendingResolution`
**And** iPhone shows both values and their provenance for an explicit user choice
**And** device time, arrival order, or last-write-wins does not silently select a result.

**Given** the user resolves a revision conflict
**When** the user confirms the content that should be effective
**Then** the system creates a new resolution revision that references every conflicting head
**And** unselected revisions remain in audit history
**And** duplicate submission of the same resolution returns the original result.

**Given** a correction affects later Analysis or a Plan suggestion
**When** the correction commits successfully
**Then** the system also creates the corresponding invalidation record
**And** a derived result that has not been recomputed remains visibly `pending` or `stale`
**And** the system does not continue to present the old derived result as current.

**Given** any correction, insertion, deletion, split, merge, or conflict resolution fails to commit
**When** the atomic transaction rolls back
**Then** the previously effective workout facts remain unchanged
**And** the user's current input remains visible and retryable
**And** the UI does not report a successful correction.

**Given** Story 1.8 is complete
**When** its implementation scope is inspected
**Then** it handles only correction, insertion, deletion, split, merge, pending fields, and conflict resolution for an active iPhone workout
**And** it does not contain workout completion, a post-completion correction UI, Watch recovery, automatic recognition, or Analysis computation.

**Traceability:** FR-007, FR-046, FR-061, FR-062; AD-2, AD-3, AD-11; SM-PRES-001.

### Story 1.9: Manually Finish an iPhone Workout and Review the Actual Result

As a trainee,
I want to decide when my workout ends and immediately review and correct what was actually recorded,
So that the system neither ends the workout on my behalf nor treats incomplete or incorrect data as final.

**Acceptance Criteria:**

**Given** the user has an active workout
**When** the user intentionally selects Finish Workout
**Then** the system shows a completion confirmation
**And** the session can end only after the user explicitly confirms
**And** idle time, backgrounding, or another inference never automatically ends it.

**Given** the current workout has no unresolved required fields
**When** the user confirms Finish and the local transaction commits successfully
**Then** the Workout Session becomes `completed`
**And** its completion revision, outbox event, and related invalidations commit in the same transaction
**And** the UI reports completion only after that commit succeeds.

**Given** the current workout still contains a `pending` or `conflicted` Actual Set or another missing required field
**When** the user selects Finish Workout
**Then** the app lists every unresolved item
**And** lets the user return to edit, cancel Finish, or explicitly choose Finish Incomplete
**And** does not hide, guess, or automatically confirm any unresolved field.

**Given** the user explicitly chooses Finish Incomplete
**When** the completion transaction commits successfully
**Then** the Workout Session is stored with an explicit `completedIncomplete` state
**And** every recoverable fact, missing field, and conflict remains visible
**And** the session is not counted as a complete workout.

**Given** the completion transaction fails
**When** the user remains on the workout screen
**Then** the Workout Session remains active
**And** saved Actual Sets and the user's uncommitted input are not lost
**And** the app shows a retryable error rather than successful completion.

**Given** the user confirms Finish repeatedly or the app retries the same completion request
**When** the request contains the same idempotency identifier
**Then** the system returns the original completion result
**And** it creates no second completion revision, duplicate session, or duplicate outbox event.

**Given** the workout has finished successfully
**When** the app displays the result of that workout
**Then** it lists every currently effective Actual Set, including exercise, order, repetitions, Actual Load, available RPE state, and time
**And** it displays trained body parts from the versioned catalog attributes of the exercises actually completed
**And** it does not substitute uncompleted planned sets for Actual Sets.

**Given** the completed session contains an unknown Exercise mapping or incomplete Actual Set
**When** the app generates its result summary
**Then** unknown or incomplete content remains explicit
**And** the trained-body-part summary includes only effective Actual Sets that can be mapped reliably
**And** it does not guess an exercise or field to produce a complete-looking summary.

**Given** the user discovers an incorrect repetition, load, exercise, RPE, or set boundary after completion
**When** the user enters correction from the result of this workout
**Then** the system reuses the revision, insertion, deletion, split, merge, and conflict-resolution rules from Story 1.8
**And** every correction creates an auditable new revision rather than overwriting the original fact
**And** correction does not return the completed session to an active state.

**Given** a post-completion correction commits successfully
**When** the system regenerates this workout result
**Then** the summary uses the latest deterministically effective revisions
**And** recomputes only the affected body-part and summary content
**And** downstream Analysis or Plan proposals that depend on the old value remain `pending` or `stale` until a later capability recomputes them.

**Given** the user uses VoiceOver, larger text, or Reduce Motion
**When** the user views completion confirmation, unresolved items, or workout results
**Then** completion state, Actual Sets, missing fields, and correction entry have readable labels and a focusable order
**And** critical meaning does not rely only on color, motion, or haptics.

**Given** Story 1.9 is complete
**When** its implementation scope is inspected
**Then** it contains only authoritative manual Finish on iPhone, complete or incomplete completion state, the current session result, and post-completion correction
**And** it does not contain History browsing, weekly or monthly Analysis, Watch workouts, an automatic Finish prompt, Apple Health writing, or AI suggestions.

**Traceability:** FR-003, FR-004, FR-006, FR-007, FR-029, FR-061, FR-062, FR-063; AD-2, AD-3, AD-11; SM-COMP-001, SM-PRES-001.

### Story 1.10: Recover Trustworthy iPhone Workout State Offline and After Interruption

As a trainee,
I want to continue my workout without a network and after the app closes or the device restarts,
So that reliably saved workout facts are never lost, duplicated, or replaced by older state.

**Acceptance Criteria:**

**Given** iPhone is in Airplane Mode, has no network, or cannot reach the backend
**When** the user creates a Plan, starts a workout, records a set, corrects a fact, or manually finishes
**Then** every phone-only core capability continues to work from local data
**And** a waiting outbox state does not block local saving
**And** the app does not describe a locally committed fact as unsaved merely because it cannot connect.

**Given** the user successfully starts a workout, saves a set, corrects a fact, or changes session state
**When** that operation commits locally
**Then** its latest reliable state can be restored after the app relaunches
**And** restoration uses committed revisions and effective facts
**And** it does not depend on UI memory, device time, or a remote copy to choose the restored result.

**Given** the app is terminated or closed during an active workout
**When** the user opens the app again
**Then** the system detects the most recently reliably saved active Workout Session
**And** shows its session identity, saved Actual Sets, `pending` items, and last reliable state
**And** lets the user continue, finish incomplete, or explicitly discard it.

**Given** the user chooses to continue a restored workout
**When** recovery completes
**Then** the system continues with the original Workout Session ID and Start snapshot
**And** the next set order and load default use only deterministically effective Actual Sets
**And** it does not create a new session, copy existing sets, or reinterpret the original Plan.

**Given** the user explicitly chooses to discard the restored workout
**When** the discard transaction commits successfully
**Then** the system creates an auditable session-state revision
**And** removes the session from the active entry only after that commit
**And** does not delete database content to pretend the session never existed.

**Given** an app interruption leaves only part of a set operation recoverable
**When** recovery can identify that content as belonging to the same recording attempt
**Then** the system preserves exactly one visible `pending` Actual Set
**And** identifies the missing or boundary-ambiguous fields
**And** neither silently drops the fragment nor creates multiple sets from the same event.

**Given** a write is interrupted before its atomic transaction commits
**When** the app opens the database again
**Then** the incomplete transaction is fully rolled back
**And** no part of it is displayed as saved
**And** the previously reliable state remains unchanged.

**Given** the same persisted event, recovery operation, or outbox event is replayed repeatedly
**When** the system recognizes the same stable ID or idempotency identifier
**Then** the event takes effect at most once
**And** it creates no duplicate Actual Set, revision, or Workout Session
**And** it does not roll back a user correction made after that event.

**Given** events reappear late or out of order
**When** the revision reducer recomputes effective state
**Then** the result matches the result from the same events arriving in normal order
**And** an event whose parent is missing remains `pendingMissingParent`
**And** facts that cannot be safely merged remain visibly conflicted for user resolution.

**Given** the database is corrupt or unreadable
**When** recovery cannot establish trustworthy state
**Then** the app uses the explicit recovery state from Story 1.4
**And** it does not create an empty session, guess workout content, or silently replace the original database
**And** it clearly explains that recovery cannot currently continue.

**Given** a workout includes high-frequency sensor data or future local raw signals
**When** the app performs ordinary workout-state recovery
**Then** core recovery depends only on structured workout facts and revisions
**And** it does not require the complete high-frequency sensor stream
**And** raw signals remain local by default.

**Given** Story 1.10 is complete
**When** its implementation scope is inspected
**Then** it completes phone-only S1 offline use, interruption recovery, partial-write handling, and idempotent replay tests
**And** it does not contain Watch–iPhone transfer, multi-Watch concurrency, cloud account recovery, automatic recognition, or remote sync.

**Traceability:** FR-003, FR-043, FR-046, FR-047, phone-only foundation for FR-064–FR-066; AD-2–AD-5; NFR-RECOV-001, SM-COMP-001, SM-PRES-001; UX-DR3.

### Story 1.11: Reliably Deliver a Complete Compatible Plan to Apple Watch

As a trainee,
I want my confirmed Plan to arrive completely on my paired Apple Watch with a clear delivery result,
So that I do not have to recreate exercises and sets on Watch or use a corrupt, stale, or incompatible Plan.

**Acceptance Criteria:**

**Given** iPhone and Apple Watch establish the currently valid pairing relationship
**When** the devices negotiate capabilities
**Then** they exchange and persist `pairingEpoch`, device ID, app version, schema version, Exercise-catalog version, and applicable capability versions
**And** automatic capabilities that have not been enabled report themselves as disabled
**And** the absence of an automatic model required by no manual capability does not block transfer of a compatible manual Plan.

**Given** iPhone has an effective Plan revision suitable for Watch
**When** the system prepares to deliver that Plan
**Then** the pending content first enters the durable iPhone outbox
**And** the transfer includes the complete Plan, revision identity, Exercise-catalog dependencies, provenance, versions, and whole-object digest
**And** it does not send isolated fields that require Watch to guess their context.

**Given** a Plan requires chunked transfer
**When** iPhone creates the transfer manifest
**Then** the manifest includes a stable message ID, chunk IDs, count, sizes, per-chunk digests, whole-object digest, causality, and dependency versions
**And** every chunk can be resent without being applied twice
**And** missing chunks can be identified explicitly and retried.

**Given** Plan delivery is not yet complete
**When** the user views that Plan's Watch status on iPhone
**Then** the app shows pending, transferring, received, durably committed, applied, or a failure reason
**And** it does not report Delivered when Watch has only partial content
**And** the local iPhone Plan and phone-only workout remain usable.

**Given** Watch receives the complete Plan and every dependency
**When** Watch validates schema, Exercise Catalog, size, each chunk digest, and the whole-object digest
**Then** it saves the Plan and dependencies in one local transaction only after every validation passes
**And** the compatible Plan atomically replaces the previously active Plan revision on Watch
**And** Watch returns `received`, `durablyCommitted`, and `applied` acknowledgement states.

**Given** the Plan has a missing chunk, mismatched digest, incompatible version, or unsupported required field
**When** Watch cannot apply it safely
**Then** Watch returns an explicit `rejected(reason)` or continues waiting for identified missing content
**And** preserves the previously usable complete Plan
**And** does not apply a partial Plan, automatically omit a field, or invent an Exercise mapping.

**Given** the same transfer arrives repeatedly after disconnection, timeout, or retry
**When** Watch receives the same `(pairingEpoch, sourceDeviceId, messageId)`
**Then** it returns the prior processing result
**And** does not create a duplicate Plan revision, replace the active Plan again, or duplicate dependencies.

**Given** an old device or a revoked pairing relationship sends a Plan
**When** Watch or iPhone detects an invalid `pairingEpoch`
**Then** the content enters quarantine
**And** does not automatically become an available Plan
**And** only an explicit recovery or re-pairing flow can handle it.

**Given** Watch has acknowledged whole-object `applied`
**When** iPhone cleans up transfer data
**Then** cleanup retains the replay tombstone and prior processing result
**And** does not remove the only transfer copy early at `received` or `durablyCommitted`
**And** retrying an old message still cannot apply it twice.

**Given** Watch has no complete compatible Plan
**When** the user opens the Watch app
**Then** it shows a truthful No Available Plan state or incompatibility reason
**And** does not display a partial Plan or pretend synchronization succeeded
**And** lets the user leave without starting a corrupt workout.

**Given** the user uses VoiceOver, larger text, or non-haptic cues
**When** the user views Plan delivery and error states
**Then** every state, failure reason, and retry action has a readable label
**And** delivery meaning does not rely only on color, motion, or haptics.

**Given** Story 1.11 is complete
**When** its implementation scope is inspected
**Then** it contains only pairing capability negotiation, Plan and dependency transfer, Watch atomic application, acknowledgement state, and failure recovery
**And** it does not contain starting a workout on Watch, recording an Actual Set, sensor capture, automatic recognition, or workout-result return.

**Traceability:** FR-081; AD-4, AD-5, AD-12–AD-14; NFR-COMPAT-002.

### Story 1.12: Start a Workout and Manually Record Actual Sets on Apple Watch

As a trainee,
I want to start a planned or ad-hoc workout directly on Apple Watch and manually confirm each set's actual data,
So that I can record a workout reliably without automatic recognition or a currently reachable iPhone.

**Acceptance Criteria:**

**Given** Watch has stored a complete compatible Plan delivered by Story 1.11
**When** the user views a Plan that can be started
**Then** Watch shows its exercises, set counts, repetitions, planned loads, and optional target RPE
**And** explicitly identifies the Plan revision and synchronization state in use
**And** does not display a Plan that has not been fully applied or has been rejected.

**Given** the user starts a planned workout on Watch
**When** the start operation commits to the Watch database
**Then** the system creates or accepts a globally unique Workout Session ID
**And** saves the immutable Start snapshot, recording-device identity, and `Watch` capture owner
**And** reports that the workout has started only after the local commit succeeds.

**Given** iPhone is reachable when the workout starts
**When** the devices coordinate Workout Session identity
**Then** Watch and iPhone use the same stable Workout Session ID
**And** a duplicate start message does not create a second session
**And** after Watch becomes capture owner, iPhone does not create another live Actual Set stream for the same session.

**Given** iPhone is unreachable but Watch has a complete compatible Plan
**When** the user starts the workout on Watch
**Then** Watch can create a globally unique Workout Session ID locally
**And** continues from the cached Plan's immutable Start snapshot
**And** iPhone later accepts that identity unchanged rather than creating or merging a session by time.

**Given** the user starts an ad-hoc workout on Watch
**When** the start operation commits successfully
**Then** Watch creates a stable ad-hoc Workout Session ID and explicitly records the absence of a Plan snapshot
**And** the user can select the current exercise manually from the local canonical Exercise Catalog
**And** an ad-hoc workout does not require a preselected complete exercise list or an iPhone connection.

**Given** Watch starts the workout runtime
**When** the Workout Session enters its active state
**Then** it uses an active `HKWorkoutSession` and corresponding workout processing
**And** maps runtime start, pause, failure, and end into durable session states
**And** does not use `WKExtendedRuntimeSession` as a substitute for the workout runtime.

**Given** the user prepares to record the first set of a planned exercise
**When** Watch shows the set-entry UI
**Then** it pre-fills the planned load from the Start snapshot
**And** clearly labels the value as a default
**And** lets the user change repetitions, Actual Load, and applicable manual RPE.

**Given** the user records the first set of an ad-hoc workout and Watch has no reliable historical Actual Load
**When** the user prepares to complete the set
**Then** Watch requires a load or an applicable unloaded kind
**And** does not guess or claim to sense an external load.

**Given** the user has saved the preceding set for the same exercise
**When** Watch creates the next set input
**Then** it defaults to the preceding deterministically effective Actual Load
**And** lets the user change the current set
**And** does not change a previously saved set when the current set changes.

**Given** the user selects Complete Set
**When** Watch creates the Actual Set
**Then** it uses the stable identity, unit, load-kind, provenance, and completeness contracts from Story 1.7
**And** commits the Actual Set, revision, and Watch outbox event in one local transaction
**And** reports the set as saved only after that commit succeeds.

**Given** actual repetitions, load, exercise, or RPE differs from the Plan
**When** Watch saves the Actual Set
**Then** it preserves planned and actual fields separately
**And** the user's confirmed actual input is authoritative
**And** it does not change the Start snapshot to hide the difference.

**Given** saving fails or the user repeatedly selects Complete Set
**When** Watch handles the same idempotent request
**Then** failure preserves the input and offers retry
**And** a repeated successful request returns the original Actual Set
**And** it creates no duplicate set, revision, or outbox event.

**Given** automatic Exercise recognition, repetition recognition, or RPE estimation has not passed its evidence Gate
**When** the user performs a Watch workout
**Then** the complete manual path for choosing an exercise, entering repetitions, changing load, and completing a set remains available
**And** Watch does not show fabricated automatic results
**And** the absence of automatic capabilities does not block the workout.

**Given** the user uses VoiceOver, larger text, or disabled haptics
**When** the user starts a workout or enters an Actual Set
**Then** current exercise, set order, repetitions, load, unit, default source, and save state have readable labels
**And** no critical operation is available only through Digital Crown, swiping, color, motion, or haptics.

**Given** Story 1.12 is complete
**When** its implementation scope is inspected
**Then** it contains only planned and ad-hoc Watch start, capture ownership, workout runtime, and manual Actual Set entry
**And** it does not contain interruption recovery, workout completion, result return, automatic Exercise or repetition recognition, or automatic RPE.

**Traceability:** FR-001–FR-003, FR-016, FR-018, FR-019, FR-028, FR-029, FR-043; AD-3–AD-5; SM-COMP-001.

### Story 1.13: Recover, Correct, and Manually Finish a Watch Workout After Interruption

As a trainee,
I want Apple Watch to recover my workout after app termination, restart, disconnection, or runtime failure and let me choose whether to continue, correct, or finish,
So that device problems never lose, duplicate, or silently complete my workout facts.

**Acceptance Criteria:**

**Given** the Watch app is terminated, the device restarts, a recoverable power or sensor interruption occurs, or iPhone disconnects
**When** the user opens the Watch app again
**Then** Watch restores the most recently reliably saved active Workout Session from its local database
**And** uses the original Workout Session ID, capture owner, and immutable Start snapshot
**And** does not require iPhone to be reachable for recovery.

**Given** Watch restores an active session
**When** the recovery view presents workout state
**Then** it shows saved Actual Sets, `pending` items, the current exercise, and the last reliable state
**And** lets the user continue, finish incomplete, or explicitly discard
**And** does not select any outcome automatically.

**Given** the active `HKWorkoutSession` stops or fails because of the system
**When** FitnessAI handles the runtime state change
**Then** it durably maps the failure, pause, or recovery state to the Workout Session
**And** runtime failure does not mark the workout normally completed
**And** saved structured workout facts remain usable.

**Given** an interrupted set operation leaves identifiable partial content
**When** Watch can determine that the content belongs to one recording event
**Then** it restores exactly one visible `pending` Actual Set
**And** identifies each missing or uncertain field
**And** neither drops the fragment nor creates duplicate sets.

**Given** the user finds an incorrect repetition, load, exercise, or manual RPE in a recently saved set on Watch
**When** the user confirms the edit
**Then** Watch creates a new auditable revision rather than overwriting the original value
**And** preserves every unedited field, original provenance, and original time
**And** atomically commits the revision and outbox event.

**Given** Watch encounters a complex split, merge, or concurrent conflict that cannot be represented safely on the small screen
**When** Watch cannot show every revision required for resolution
**Then** it leaves the fact `pendingResolution`
**And** explains that it must be handled on iPhone
**And** does not select a result by arrival order or device time.

**Given** the user intentionally selects Finish Workout on Watch
**When** the system presents completion confirmation
**Then** explicit user confirmation is required to finish
**And** disconnection, runtime stop, a long rest, or inactivity does not automatically finish the session
**And** the user can cancel and continue.

**Given** the session has unresolved required fields
**When** the user confirms Finish
**Then** Watch identifies the unresolved information
**And** lets the user return to edit or explicitly finish with `completedIncomplete`
**And** does not represent the incomplete session as complete.

**Given** the user confirms normal completion or Finish Incomplete
**When** the Watch local completion transaction commits successfully
**Then** it saves completion state, revision, outbox event, and related invalidation together
**And** Watch can report successful local completion while iPhone remains offline
**And** it ends the workout runtime only after local commit succeeds.

**Given** the user repeats Finish or Watch replays the same completion event after recovery
**When** the system recognizes the same idempotency identifier
**Then** it returns the original completion result
**And** creates no second completion revision or duplicate Workout Session
**And** does not roll back a later user correction.

**Given** the workout has completed locally on Watch
**When** the user views its result
**Then** Watch shows the currently effective Actual Sets and trained body parts from reliable Exercise mappings
**And** incomplete or unresolved content remains explicit
**And** it does not use planned sets or automatic guesses to fill the summary.

**Given** Watch is low on storage
**When** the system must protect core workout records
**Then** it first stops or removes optional raw-signal and automation data
**And** does not preferentially delete Workout Sessions, Actual Sets, revisions, or unconfirmed facts
**And** if reliable saving cannot continue, it blocks and explains the problem before the user's next commit.

**Given** fault tests cover app termination, device restart, power or sensor interruption, disconnection, partial writes, and duplicate replay
**When** effective facts before and after recovery are compared
**Then** every reliably persisted event takes effect exactly once
**And** no user correction is lost, Actual Set duplicated, or incomplete fact presented as complete
**And** manual Continue and manual Finish always remain available.

**Given** Story 1.13 is complete
**When** its implementation scope is inspected
**Then** it contains only Watch local recovery, recent-set correction, complex-conflict handoff, authoritative manual Finish, and local result display
**And** it does not contain applying the complete result on iPhone, cloud recovery, automatic recognition, automatic RPE, or a forgotten-Finish prompt.

**Traceability:** FR-003, FR-004, FR-006, FR-007, FR-043, FR-046, FR-061–FR-066; AD-2–AD-5; NFR-SESSION-001, NFR-SESSION-003, NFR-RECOV-001; UX-DR4.

### Story 1.14: Apply Watch Workout Facts Exactly Once on iPhone

As a trainee,
I want workout records saved on Watch to return completely to iPhone after reconnection,
So that disconnection, retry, out-of-order delivery, or concurrent use of multiple Watches never duplicates, loses, or incorrectly merges my sets.

**Acceptance Criteria:**

**Given** Watch successfully saves a start, Actual Set, correction, pending state, or completion event
**When** its local transaction commits
**Then** the corresponding structured event enters the durable Watch outbox in the same transaction
**And** carries `pairingEpoch`, source device ID, stable message ID, Workout Session ID, revision causality, versions, and digest
**And** Watch does not wait for an iPhone acknowledgement before allowing the local workout to continue.

**Given** Watch and iPhone can communicate interactively
**When** Watch attempts to return workout events
**Then** live messaging may accelerate delivery
**And** durable user-info or file transfer remains responsible for eventual recoverable delivery
**And** loss of a live message does not lose a locally saved workout fact.

**Given** iPhone receives a Watch workout object or event
**When** iPhone validates identity, pairing epoch, schema, Exercise Catalog, dependency versions, and digest
**Then** it writes the fact, revision, outbox state, and invalidation atomically to the iPhone database only after all required validation passes
**And** calls the shared revision reducer to compute effective state
**And** the transfer adapter does not overwrite an existing fact on its own.

**Given** iPhone is processing a transferred object
**When** its processing stage changes
**Then** it returns `received`, `durablyCommitted`, `applied`, or `rejected(reason)` to Watch
**And** both devices persist their latest acknowledgement state
**And** Received is not treated as Safely Applied.

**Given** the same Watch event arrives repeatedly because of disconnection, timeout, or retry
**When** iPhone receives the same `(pairingEpoch, sourceDeviceId, messageId)`
**Then** it returns the prior processing result
**And** that event affects effective facts at most once
**And** it creates no duplicate Workout Session, Actual Set, revision, or completion record.

**Given** Watch events arrive late or out of order
**When** iPhone recomputes the Workout Session
**Then** revision-DAG causality determines the result
**And** an event with a missing parent remains `pendingMissingParent` until its dependency arrives
**And** a late older event does not roll back a later correction made on iPhone or Watch.

**Given** iPhone and Watch produce changes to the same canonical field that cannot be merged safely
**When** both revisions reach iPhone
**Then** both user-authored revisions and their provenance remain preserved
**And** the field remains `conflicted` or `pendingResolution`
**And** iPhone provides the explicit conflict resolution from Story 1.8 instead of choosing by device time.

**Given** two supported Watches independently start or recover workouts while disconnected
**When** both sessions later return to the same iPhone
**Then** each retains its own Workout Session ID, source device ID, and Start snapshot
**And** the system does not silently merge them because their times overlap, exercises match, or they use the same Plan
**And** if the product requires concurrent-session handling, it presents the sessions separately for an explicit user decision.

**Given** a revoked pairing epoch or old device resends workout facts
**When** iPhone detects that the source is invalid
**Then** it quarantines the content with its provenance
**And** does not automatically write it into a currently valid session
**And** only an explicit recovery flow can accept it again.

**Given** iPhone has not returned whole-object `applied`
**When** Watch performs storage cleanup
**Then** it does not remove the only structured event, manifest, chunk, or raw file copy
**And** can continue retrying missing content with bounded backoff
**And** manual workout and local correction remain available while disconnected.

**Given** iPhone has returned whole-object `applied`
**When** Watch enters transfer-copy cleanup
**Then** it retains redundant structured copies for at least the seven-day safety window
**And** cleans raw chunks only after `applied`
**And** cleans file, index, and manifest atomically and retryably while retaining a replay tombstone.

**Given** iPhone safely applies a Watch session
**When** the user views that session's result
**Then** it uses the Actual workout result and correction UI from Story 1.9
**And** shows whether transfer is complete, waiting, failed, or conflicted
**And** does not hide or count an unresolved fact as confirmed.

**Given** transfer encounters a missing chunk, digest error, incompatible version, or database failure
**When** iPhone cannot apply the content safely
**Then** it returns an explicit failure reason and preserves the previously effective facts
**And** Watch retains a retryable copy
**And** the manual workout core on both iPhone and Watch remains unblocked.

**Given** integration tests simulate disconnection, reconnection, duplication, delay, out-of-order delivery, missing chunks, process termination, and concurrent Watches
**When** final effective facts on both devices are compared
**Then** every committed user event takes effect exactly once
**And** no correction is lost, Actual Set duplicated, or session incorrectly merged
**And** both devices produce consistent effective, pending, or conflicted state for the same revision DAG.

**Given** Story 1.14 is complete
**When** its implementation scope is inspected
**Then** it contains only Watch workout-fact return, idempotent iPhone application, acknowledgements, retention cleanup, multi-Watch isolation, and fault tests
**And** it does not contain account cloud sync, AI, Apple Health, automatic recognition, or an automatic Finish prompt.

**Traceability:** FR-043, FR-046, FR-047, FR-064–FR-066; AD-2–AD-5; NFR-RECOV-001, SM-COMP-001, SM-PRES-001.

## Epic 2: Turn an Authorized AI Conversation into an Approved Plan Revision

The trainee can authorize an exact remote data scope, create or revise a complete structured Plan, resolve safety/mapping issues, review every field, approve one digest-bound proposal, and atomically activate exactly one revision while every failure preserves the prior Plan and manual workout core. GATE-1 is a prerequisite/evidence Story; GATE-2 and GATE-3 keep built-in and Health-derived traffic technically disabled until closed, while safe scaffolding and eligible local/BYOK work may proceed.

### Story 2.1: Freeze the Safety Rule Pack v1 Numeric Contract and Golden Fixtures

As the Product Owner,
I want to freeze the numeric bounds, decision rules, and golden fixtures for Safety Rule Pack v1 before any AI Plan capability is implemented,
So that implementers never invent safety policy and subsequent safety checks and Plan commits can be verified against one deterministic, auditable contract.

**Acceptance Criteria:**

**Given** GATE-1 has not closed
**When** the Product Owner has not supplied a complete Safety Rule Pack v1 decision set
**Then** this Story remains incomplete
**And** implementers must not fill gaps, infer values, or adopt implicit defaults
**And** subsequent safety-dependent AI Plan implementation and every proposal commit remain disabled.

**Given** the Product Owner supplies the Safety Rule Pack v1 decisions
**When** the frozen rule inventory is created
**Then** it covers at least unit and numeric validity, schedule contradiction, canonical Exercise support, volume, intensity, load progression, injury or recovery warning signs, and allowed explicit continuation paths
**And** every rule has a stable rule ID, rule version, and concise non-diagnostic explanation
**And** it contains no `TBD`, undefined placeholder, or ambiguous condition that depends on implementer interpretation.

**Given** a rule contains a numeric or temporal boundary
**When** the rule is recorded in the frozen inventory
**Then** it specifies the input fields, canonical units, lower and upper bounds, boundary inclusivity, applicable scope, and compound conditions
**And** it defines behavior for missing values, unsupported units, anomalous values, and mutually contradictory inputs
**And** its outcome does not depend on UI formatting, locale, incidental floating-point rounding, or provider free text.

**Given** a rule is triggered
**When** the inventory defines its expected result
**Then** the result is explicitly `pass`, `clarificationOrCorrectionRequired`, or `affectedScopeStop`
**And** it identifies the affected Plan scope, trigger reason, and permitted next action
**And** a local issue does not expand into a broader block without an explicit rule basis.

**Given** a safety issue permits the user to continue
**When** the rule defines an allowed continuation
**Then** it specifies the required user action, information that must be supplied or corrected, and scope that remains prohibited after continuation
**And** ordinary confirmation, a general disclaimer, or continued app use cannot substitute for the prescribed explicit continuation
**And** the product does not describe the flow as diagnosis or medical advice.

**Given** a rule depends on the Exercise Catalog, Plan schema, unit contract, or another policy input
**When** Safety Rule Pack v1 is frozen
**Then** every dependency version or digest is recorded
**And** the rule pack has its own canonical version, generation time, owner, and full-content digest
**And** any relevant dependency change creates a new rule-pack version rather than silently changing v1.

**Given** the Golden Fixture Corpus is created
**When** its coverage is inspected
**Then** every rule category includes at least a normal pass, an exact-boundary case, adjacent values inside and outside the boundary, a missing or unsupported input, and a case requiring correction or stop
**And** rules involving relationships among fields include contradictory combinations
**And** every fixture declares its inputs, frozen dependency versions, expected rule ID, expected result, affected scope, and permitted next action.

**Given** the same fixture is evaluated by different implementations or on repeated runs
**When** expected results are compared
**Then** identical canonical inputs produce exactly the same result
**And** input-field order, device locale, and irrelevant fields do not change the decision
**And** fixtures can be consumed directly by automated tests for a later pure-domain Safety evaluator.

**Given** any Safety Rule Pack v1 inventory or fixture content changes
**When** the change is saved
**Then** it receives a new version and digest
**And** the prior version remains auditable and is not overwritten
**And** later test evidence, proposal review, or approval produced against the prior version cannot be represented as valid for the new version.

**Given** all GATE-1 prerequisite inputs are frozen
**When** Story 2.1 is accepted
**Then** three controlled artifacts are produced and registered by name: `Safety Rule Pack v1 Manifest`, `Safety Rule Pack v1 Golden Fixture Corpus`, and `GATE-1 Decision Record`
**And** the Decision Record identifies the Product Owner, versions, digests, coverage, outstanding evaluator/evidence work, and current Gate state
**And** completing this Story means only that GATE-1 inputs are frozen; it does not claim that the evaluator is implemented, evidence has passed, or proposal commit is enabled.

**Given** the product is limited to Product Owner testing
**When** later deterministic implementation and evidence satisfy GATE-1
**Then** qualified professional review remains a separate open condition for release beyond Product Owner testing
**And** this Story's completion does not imply that review occurred
**And** the absence of professional review cannot be presented as a safety release conclusion for a broader audience.

**Given** GATE-1 remains open, fails, or has incomplete material
**When** the user uses existing local product capabilities
**Then** manual Plan creation or selection, manual workouts, correction, and local recording remain available
**And** unfinished AI safety rules do not block the Epic 1 manual core
**And** the UI does not present a false state in which an AI proposal can be committed.

**Given** the implementation scope of Story 2.1 is inspected
**When** its single-agent size is assessed
**Then** it contains only the formalization of Product Owner-approved rule decisions into a versioned Manifest, Golden Fixtures, Decision Record, and default-closed Gate registration
**And** it does not contain Safety evaluator implementation, AI conversation, provider integration, remote sending, proposal review, approval, or Plan Revision commit
**And** the implementing agent cannot make numeric safety decisions on behalf of the Product Owner.

**Traceability:** FR-087; GATE-1 prerequisite; AD-7, AD-13; NFR-SAFE-001, NFR-AI-006; UX-DR10, UX-DR17, UX-DR19.

### Story 2.2: Implement the Deterministic Fail-Closed Safety Evaluator

As a trainee,
I want every structured Plan to receive the same deterministic safety evaluation after generation and before commit,
So that incomplete, contradictory, or safety-bounded content cannot silently become effective while safety failures never block manual local training.

**Acceptance Criteria:**

**Given** Story 2.1 has frozen Safety Rule Pack v1
**When** the pure-domain evaluator initializes
**Then** it verifies the Manifest, fixture corpus, versions, dependency digests, and supported rule types
**And** missing, mismatched, or unknown material fails closed instead of being skipped.

**Given** a canonical immutable Plan safety snapshot
**When** evaluation runs at `postGeneration` or `preCommit`
**Then** it evaluates every applicable rule and records the stage, input digest, rule-pack version/digest, dependency versions, and stable ordered per-rule results
**And** provider prose, chain-of-thought, locale, current time, and UI strings cannot determine the result.

**Given** rules pass, require correction, or stop an affected scope
**When** results are aggregated
**Then** the outcome is exactly `pass`, `clarificationOrCorrectionRequired`, or `affectedScopeStop`
**And** it names rule IDs, reasons, canonical fields, affected scope, and any version-bound allowed continuation
**And** it never mutates the Plan or broadens a stop without a frozen rule basis.

**Given** required input is missing, unsupported, contradictory, or evaluator execution fails
**When** a complete result cannot be produced
**Then** status is explicitly incomplete or failed and commit eligibility is false
**And** no fallback, retry, exception handling, or generic confirmation can manufacture `pass`.

**Given** identical canonical input and frozen versions are evaluated repeatedly
**When** results and digests are compared
**Then** they are byte-for-byte stable regardless of field order, locale, process restart, or device
**And** any input or dependency version change invalidates reuse of the prior result.

**Given** the Story 2.1 golden corpus runs in automated tests
**When** actual output is compared with every expected boundary, contradiction, missing-input, and stop case
**Then** every rule ID, outcome, scope, and continuation matches
**And** any mismatch fails this Story while GATE-1 and all proposal commits remain disabled.

**Given** evaluator implementation is complete
**When** GATE-1 state is inspected
**Then** it records only `deterministicEvaluatorImplemented` and remains default closed pending an independently accepted evidence record
**And** existing Plans, manual workouts, correction, and local recording remain available on every evaluator failure.

**Given** Story 2.2 scope is inspected
**When** single-agent size is assessed
**Then** it contains only safety input mapping, pure rule execution, structured results, fail-closed eligibility, and golden tests
**And** excludes AI UI, providers, remote authorization, proposal review, approval, commit, and Gate enablement.

**Traceability:** FR-058, FR-087; GATE-1 implementation; AD-7, AD-13; NFR-SAFE-001, NFR-AI-001, NFR-AI-006; UX-DR10, UX-DR17, UX-DR19.

### Story 2.3: Record GATE-1 Evidence and Enable Safety-Eligible Proposal Work

As the Product Owner,
I want a version-bound GATE-1 evidence record that independently proves the evaluator matches the frozen rules,
So that safety-eligible proposal work can proceed without treating an implementation status assertion as evidence.

**Acceptance Criteria:**

**Given** Stories 2.1 and 2.2 are complete
**When** the owned `GATE-1 Safety Rule Pack Evidence Record` is assembled
**Then** it names the Manifest, fixture corpus, evaluator build, schema/catalog/unit versions, digests, owners, execution environment, and timestamp
**And** embeds or links immutable machine-readable test output rather than only stating that tests passed.

**Given** evidence tests execute
**When** thresholds are assessed
**Then** 100% of frozen golden fixtures and required rule categories must match exactly with zero skipped, quarantined, or manually overridden cases
**And** deterministic repeat and fail-closed fault tests must pass.

**Given** evidence is incomplete, mismatched, stale, or failed
**When** Gate state is computed
**Then** GATE-1 remains disabled with a literal reason
**And** proposal commit remains impossible while proposal/schema/review scaffolding and manual local training remain available.

**Given** all owner-testing evidence passes
**When** the Product Owner explicitly accepts the exact evidence digest
**Then** GATE-1 becomes enabled only for the frozen versions and Product Owner testing scope
**And** any version change automatically closes it again and invalidates dependent safety results and approvals.

**Given** release beyond Product Owner testing is considered
**When** qualified exercise/health professional review is absent or rejected
**Then** the evidence record shows that release condition as open
**And** no owner-testing evidence is represented as professional safety approval.

**Given** Story 2.3 scope is inspected
**When** its implementation is reviewed
**Then** it contains only evidence capture, exact thresholds, Gate transition, invalidation, and default-disabled enforcement
**And** excludes AI conversation, provider traffic, proposal approval, and Plan commit implementation.

**Traceability:** FR-087; GATE-1 evidence and enabling; AD-7, AD-13; NFR-SAFE-001, NFR-AI-002, NFR-AI-006.

### Story 2.4: Preserve Immutable Non-Effective AI Proposals

As a trainee,
I want AI drafts and revisions to remain identifiable, reviewable proposals until I explicitly approve them,
So that conversation, regeneration, rejection, or delayed events never change my active Plan.

**Acceptance Criteria:**

**Given** an AI create or revise operation begins
**When** a proposal identity is allocated
**Then** it receives an immutable `proposalId`, target, base revision, creation time, provenance, permitted scope, assumptions, schema/model/rule-pack versions, and canonical digest
**And** the identity exists before persistence or transport.

**Given** proposal content changes through clarification or regeneration
**When** new structured content is produced
**Then** a new immutable proposal identity and digest are created
**And** the prior proposal remains auditable and cannot inherit approval.

**Given** a proposal is draft, rejected, expired, invalid, or under review
**When** effective Plan state is reduced
**Then** the proposal has no effect on the active Plan, history, or active Workout Sessions
**And** rejection requires no compensating Plan write.

**Given** duplicate, late, retried, or reordered proposal events arrive
**When** the lifecycle reducer processes them
**Then** stable event identity and causality make processing idempotent
**And** an older state cannot roll back a later rejection, replacement, approval consumption, or commit result.

**Given** proposal content cannot be represented as a complete typed structure
**When** it is stored
**Then** status is explicitly incomplete or invalid with preserved raw-provider provenance where permitted
**And** prose-only content is never represented as a complete Plan Draft.

**Given** Story 2.4 scope is inspected
**When** single-agent size is assessed
**Then** it contains proposal identity, schema-neutral lifecycle states, digests, persistence mapping, and reducer tests
**And** excludes provider calls, authorization UI, safety UI, approval, and effective Plan commit.

**Traceability:** FR-078, FR-083, FR-084; AD-2, AD-7; NFR-AI-002, NFR-AI-005.

### Story 2.5: Establish Isolated AI Provider Routes with Built-In Traffic Disabled

As a trainee,
I want AI provider routes to be isolated and controllable before any real built-in traffic is allowed,
So that I can test proposal behavior without leaking content or coupling the product to an unapproved route.

**Acceptance Criteria:**

**Given** the AI domain requests generation
**When** it calls a provider
**Then** it uses a provider port with typed request/result/error contracts
**And** domain code has no DeepSeek SDK, HTTP, credential, or vendor-response dependency.

**Given** local development or contract tests run
**When** the fake provider is selected
**Then** deterministic complete, invalid, timeout, duplicate, and reordered responses can be reproduced without network access or secrets
**And** no production route is contacted.

**Given** a user supplies a device-local BYOK credential
**When** the BYOK adapter is configured
**Then** the secret remains in non-synchronizing Keychain, never enters logs or proposal content, and uses a route-specific pseudonymous identity
**And** switching route or account starts a new identity and never reuses conversation history.

**Given** the built-in gateway adapter exists while GATE-2 is open
**When** any code attempts real built-in traffic
**Then** an independent technical kill switch rejects the send before content leaves the device
**And** the UI reports the route as unavailable rather than silently falling back to BYOK or another provider.

**Given** request controls are configured
**When** a route is exercised
**Then** endpoint allowlists and request, time, rate, and cost ceilings are enforced outside provider prose
**And** audit output is content-free and contains only route, pseudonymous IDs, versions, status, size class, and timing.

**Given** Story 2.5 scope is inspected
**When** it is reviewed
**Then** it contains provider ports, fake/BYOK adapters, disabled built-in adapter, identity isolation, ceilings, secret handling, and contract tests
**And** excludes GATE-2 closure, conversation UI, Health data, proposal approval, and Plan commit.

**Traceability:** FR-082, FR-085; GATE-2 enabling; AD-8, AD-13; NFR-PRIV-003, NFR-PRIV-007, NFR-SEC-003, NFR-AI-004.

### Story 2.6: Close GATE-2 with an Auditable Built-In Route Evidence Record

As the Product Owner,
I want the built-in DeepSeek route enabled only from an approved legal, privacy, security, and operational evidence record,
So that real built-in traffic cannot begin from an undocumented configuration or status assertion.

**Acceptance Criteria:**

**Given** GATE-2 is assessed
**When** the owned `GATE-2 Built-In DeepSeek Route Evidence Record` is created
**Then** it names the legal entity, runtime provider, processing region, subprocessors, retention/cache, training use, deletion/revocation, disclosure, endpoint, credential owner, and effective dates
**And** records approved request fields and prohibited categories.

**Given** operational controls are recorded
**When** evidence is reviewed
**Then** it includes immutable configuration digests for allowlists, request/time/rate/cost ceilings, key rotation, redacted audit, rollback owner, and kill switch
**And** contains executable negative tests proving prohibited endpoints, oversized requests, missing authorization, and kill-switch activation send zero content.

**Given** any required decision, test, owner approval, or current-version match is missing or failed
**When** Gate state is computed
**Then** GATE-2 remains disabled with an exact reason
**And** fake-provider, eligible BYOK, proposal scaffolding, and manual workouts remain available.

**Given** every required record and test passes
**When** the Product Owner approves the exact evidence digest
**Then** built-in traffic is enabled only for the recorded endpoint, fields, ceilings, versions, region, and validity window
**And** any material evidence/configuration change automatically disables the route until reapproved.

**Given** a runtime incident or rollback decision occurs
**When** the kill switch is activated
**Then** new sends stop before content egress, in-flight status remains truthful, and the last confirmed Plan remains usable
**And** disabling the route does not disable BYOK or local manual capture.

**Given** Story 2.6 scope is inspected
**When** it is reviewed
**Then** it contains the evidence artifact, exact thresholds, negative tests, version-bound enablement, expiration, and rollback
**And** excludes Health-derived remote approval and ordinary conversation behavior.

**Traceability:** FR-082, FR-085; GATE-2 prerequisite evidence and traffic enablement; AD-8, AD-13; NFR-PRIV-007, NFR-SEC-003, NFR-AI-004.

### Story 2.7: Authorize One Exact Remote AI Send

As a trainee,
I want to authorize the exact categories and time window for one remote AI request,
So that general app consent, Health permission, or a previous conversation can never authorize new remote use.

**Acceptance Criteria:**

**Given** a remote AI request is prepared
**When** authorization is presented
**Then** it names purpose, provider/route, selected data categories, source window, transformations, retention/training policy, destination, request digest, and expiry
**And** unselected fields and complete raw motion/heart-rate never appear in the payload.

**Given** authorization is off by default
**When** the user views, dismisses, or edits the preview
**Then** no content is sent and no authorization is consumed
**And** the exact choices remain accessible with VoiceOver, Dynamic Type, keyboard, and non-color semantics.

**Given** the user affirmatively authorizes the exact preview
**When** the send transaction begins
**Then** one authorization token bound to route, categories, window, request digest, and expiry is atomically matched and consumed
**And** retry cannot widen scope or create a second authorized logical request.

**Given** payload, provider route, policy version, source data, selected category, or digest changes
**When** send eligibility is checked
**Then** prior authorization is invalid and a new preview is required
**And** no generic confirmation or HealthKit permission substitutes.

**Given** the user revokes before consumption or the token expires
**When** a send is attempted
**Then** it fails before egress with a literal reason
**And** a content-free audit records IDs, versions, categories, digest, status, and timing but no content, secret, or chain-of-thought.

**Given** Story 2.7 scope is inspected
**When** it is reviewed
**Then** it contains preview, affirmative one-shot authorization, atomic consumption, invalidation, revocation, and redacted audit
**And** excludes Health summary creation, AI conversation content, proposal approval, and Plan commit.

**Traceability:** FR-086; AD-8, AD-14; NFR-PRIV-007, NFR-SEC-003; UX-DR2, UX-DR10, UX-DR12–UX-DR15, UX-DR18.

### Story 2.8: Preview Health-Derived AI Scope While GATE-3 Fails Closed

As a trainee,
I want Health-derived AI data to remain separately visible and disabled until its evidence gate closes,
So that I can understand a possible request without accidentally sending health information.

**Acceptance Criteria:**

**Given** GATE-3 is open
**When** the AI authorization surface is shown
**Then** Health-derived categories are off by default and visually separated from goals, Plan, confirmed workout facts, and concise feedback
**And** the preview states that local Health capability and remote Health use are different permissions.

**Given** no eligible local Health summary exists
**When** the user opens the preview
**Then** the UI shows unavailable or not selected without inferring values from raw data
**And** AI without Health and manual Plan use remain available.

**Given** a synthetic or later eligible local summary is selected while GATE-3 is open
**When** the user reviews the exact field mapping
**Then** the preview can render category, source window, transformation, and request field
**And** every real send is rejected before egress even if the user confirms.

**Given** code attempts to bypass the preview or reuse non-Health authorization
**When** the remote boundary classifies payload fields
**Then** any Health-derived field requires both a matching one-shot token and an enabled GATE-3 evidence digest
**And** missing classification fails closed.

**Given** Story 2.8 scope is inspected
**When** it is reviewed
**Then** it contains default-off Health rows, exact mapping preview, field classification, and zero-egress Gate enforcement
**And** excludes HealthKit reads, local summary computation, GATE-3 evidence closure, and real Health-derived sending.

**Traceability:** FR-082, FR-086; GATE-3 authorization/fail-closed preview; AD-8, AD-9, AD-14; NFR-HK-001, NFR-PRIV-007; UX-DR2, UX-DR7, UX-DR12.

### Story 2.9: Conduct a Bounded Text Conversation for Plan Intent

As a trainee,
I want to describe my training goals and constraints in a bounded text conversation,
So that AI can prepare a Plan without hiding missing information, assumptions, or remote-use scope.

**Acceptance Criteria:**

**Given** the user starts Plan creation or revision
**When** the text intake opens
**Then** it captures goals, experience, availability, session duration, equipment, preferences, and mandatory limitations
**And** distinguishes confirmed user input, prior allowed facts, assumptions, and unanswered required fields.

**Given** required information is missing or contradictory
**When** the conversation continues
**Then** the system asks bounded clarification and keeps gaps visible
**And** it does not fabricate constraints or produce a complete-draft status.

**Given** the user regenerates, continues, cancels, or rejects
**When** conversation state changes
**Then** input is preserved according to the selected action while the active Plan remains unchanged
**And** no proposal, approval, or remote authorization is implied by conversation text.

**Given** a remote turn is requested
**When** payload is prepared
**Then** only FR-082 allowed sources and the Story 2.7 exact authorized fields are included
**And** raw sensor streams, unselected Health categories, unrelated history, secrets, and chain-of-thought are excluded.

**Given** remote AI is unavailable, times out, or returns invalid content
**When** the user returns to the conversation
**Then** entered text and the last confirmed Plan remain available with retry, edit, or cancel
**And** local workout capture is not blocked.

**Given** accessibility and layout settings vary
**When** the conversation is used
**Then** it supports light/dark, large Chinese text, VoiceOver, keyboard avoidance, error focus, and input-preserving Retry without horizontal scrolling.

**Traceability:** FR-054, FR-082, FR-083, FR-085; AD-7, AD-8, AD-14; NFR-AI-004; UX-DR2, UX-DR10, UX-DR13–UX-DR15, UX-DR18–UX-DR19.

### Story 2.10: Request an Evidence-Bounded Plan Revision

As a trainee,
I want to explicitly request Plan review using only permitted reliable evidence and concise feedback,
So that AI suggestions disclose what they used and never reinterpret uncertain or excluded records as truth.

**Acceptance Criteria:**

**Given** the user explicitly requests review
**When** evidence selection is prepared
**Then** only confirmed or corrected effective workout records, the active Plan/base revision, and user-supplied concise feedback are eligible
**And** pending, conflicted, incomplete, excluded, or raw high-frequency data is omitted or explicitly identified as unavailable.

**Given** evidence is selected
**When** the exact remote preview is shown
**Then** it names record categories, time window, base revision, exclusions, transformations, assumptions, and request digest
**And** Story 2.7 authorization is required for the single send.

**Given** evidence contains warning signs or safety-sensitive feedback
**When** the revision request is evaluated
**Then** Story 2.2 safety behavior applies and any required clarification or affected-scope stop remains explicit
**And** the system makes no diagnosis.

**Given** the user dismisses, rejects, or continues editing feedback
**When** no proposal is approved
**Then** the active Plan and completed workout facts remain unchanged
**And** no proactive invitation or prior authorization silently initiates another request.

**Given** Story 2.10 scope is inspected
**When** it is reviewed
**Then** it contains explicit review invocation, evidence selection/exclusion, preview, and safety handoff
**And** excludes Analysis computation, proactive invitation, proposal approval, and commit.

**Traceability:** FR-059, FR-082, FR-083, FR-086; AD-7–AD-9; NFR-AI-005; UX-DR2, UX-DR9, UX-DR12.

### Story 2.11: Validate a Complete Structured Plan Draft and Exercise Mappings

As a trainee,
I want AI output converted into a complete validated Plan Draft with explicit mappings and assumptions,
So that prose, unknown Exercises, or partial fields can never masquerade as an executable Plan.

**Acceptance Criteria:**

**Given** provider output arrives
**When** it enters the untrusted-input boundary
**Then** bounded decoding validates schema/version, types, counts, units, dates, required fields, and canonical structure
**And** prose-only, malformed, oversized, contradictory, or unknown content remains invalid or requires clarification.

**Given** a complete candidate Plan is decoded
**When** Exercise references and equipment are resolved
**Then** every Exercise maps to a versioned canonical record or remains explicitly unmapped
**And** substitutions disclose primary body area, movement pattern, available equipment, and secondary/range differences with rationale.

**Given** equipment context is added before or after generation
**When** the draft is regenerated or revised
**Then** a new immutable proposal and digest are created
**And** no Exercise is silently replaced in the active or draft Plan.

**Given** all structural and mapping checks pass
**When** completeness is computed
**Then** the draft includes every day, session, Exercise, set, repetition, load/unit, optional target RPE state, assumptions, unresolved fields, and versions
**And** complete status is false when any required field or mapping remains unresolved.

**Given** a complete draft is produced
**When** safety evaluation runs
**Then** Story 2.2 executes at `postGeneration` and its full result becomes immutable proposal provenance
**And** validation or safety failure changes no effective Plan.

**Given** Story 2.11 scope is inspected
**When** it is reviewed
**Then** it contains untrusted decoding, complete structured Draft, equipment context, canonical mapping, validation, and post-generation safety
**And** excludes approval and effective commit.

**Traceability:** FR-055, FR-056, FR-058, FR-078; AD-7; NFR-AI-001, NFR-AI-005–NFR-AI-006; UX-DR2, UX-DR10, UX-DR17, UX-DR19.

### Story 2.12: Resolve Safety Clarifications and Affected-Scope Stops

As a trainee,
I want safety and mapping problems shown with precise correction or continuation choices,
So that I can resolve an allowed issue without accepting diagnostic claims or hidden Plan changes.

**Acceptance Criteria:**

**Given** a proposal has `clarificationOrCorrectionRequired`
**When** the safety-stop surface opens
**Then** it shows literal rule reasons, affected fields, missing or invalid values, assumptions, and allowed corrections
**And** the primary action corrects or supplies information rather than approving the proposal.

**Given** a proposal has `affectedScopeStop`
**When** it is displayed
**Then** stopped and unaffected scope are separately identified with non-diagnostic language
**And** only the frozen allowed continuation, edit, or cancel actions are offered.

**Given** the user edits information or takes an allowed continuation
**When** a new candidate is formed
**Then** a new proposal identity/digest is created and both structural validation and post-generation safety rerun
**And** the prior result and user action remain auditable but confer no approval.

**Given** the user cancels or cannot resolve the issue
**When** the flow ends
**Then** no Plan field changes and the previous effective Plan remains available
**And** manual workout capture remains usable.

**Given** the UI is used with VoiceOver, high contrast, Reduce Motion, or large text
**When** errors and actions appear
**Then** focus reaches the literal summary then recovery action, critical Chinese text is not truncated, and meaning never relies on color, motion, or haptics.

**Traceability:** FR-058, FR-083, FR-087; AD-7, AD-14; NFR-SAFE-001, NFR-AI-006, NFR-UX-001; UX-DR2, UX-DR10, UX-DR13–UX-DR15, UX-DR18–UX-DR19.

### Story 2.13: Review and Explicitly Approve One Complete Proposal

As a trainee,
I want to review every Plan field or future-scope difference before one explicit approval,
So that I know exactly what will change and stale or partial content cannot inherit my consent.

**Acceptance Criteria:**

**Given** a complete create proposal is ready
**When** review opens
**Then** every structured Plan field, unit, mapping, assumption, warning, unresolved state, source, versions, Safety result, base, `proposalId`, and digest is accessible
**And** no collapsed section hides material content from approval.

**Given** a revision proposal is ready
**When** the diff is shown
**Then** every addition, removal, and changed value/unit plus affected future session is included
**And** completed history and active Workout Sessions are explicitly outside mutation scope.

**Given** unresolved, invalid, incomplete, stopped, stale-base, or failed-safety content exists
**When** approval eligibility is computed
**Then** approval is disabled with a literal recovery reason
**And** review never presents optimistic success.

**Given** the user selects the separate approval action
**When** the confirmation surface appears
**Then** it binds consent to the exact unconsumed `proposalId`, displayed digest, base revision, schema/model/rule-pack/policy versions, and permitted scope
**And** any relevant change invalidates consent before commit.

**Given** the user rejects, closes, regenerates, or continues conversation
**When** the review ends
**Then** the proposal remains non-effective or is explicitly rejected
**And** the active Plan is unchanged.

**Given** review uses accessibility modes
**When** fields and diffs reflow
**Then** they linearize without horizontal scrolling, preserve critical Chinese values/digests/actions, and expose equivalent non-color and keyboard/VoiceOver operation.

**Traceability:** FR-057, FR-060, FR-078, FR-079, FR-083; AD-7, AD-14; NFR-AI-002, NFR-AI-005; UX-DR2, UX-DR10–UX-DR15, UX-DR18–UX-DR19.

### Story 2.14: Atomically Commit Exactly One Approved Plan Revision

As a trainee,
I want an approved proposal to become exactly one complete Plan Revision or make no change,
So that failure, retry, duplication, or reordered delivery never leaves a partial or rolled-back Plan.

**Acceptance Criteria:**

**Given** commit is requested
**When** eligibility is checked
**Then** the system verifies an unconsumed proposal, exact approval/digest, unchanged Plan head, permitted scope, complete structural validation, enabled GATE-1 evidence, and a fresh `preCommit` safety result under unchanged versions
**And** any mismatch blocks commit without consuming the prior Plan.

**Given** all checks pass
**When** the local transaction commits
**Then** one append-only Plan Revision, proposal-consumption record, approval provenance, outbox event, and invalidation are persisted atomically using `proposalId` as the idempotency key
**And** the new revision becomes effective only after the transaction succeeds.

**Given** the same commit is retried or events arrive late, duplicated, or reordered
**When** the repository recognizes the proposal identity and causality
**Then** it returns the original result without another revision
**And** an older proposal cannot roll back a newer Plan head.

**Given** validation, safety, database, AI, or delivery fails
**When** the operation terminates
**Then** the prior confirmed Plan remains wholly effective, the proposal/approval status is truthful, and no partial revision appears
**And** local Plan access and workout capture remain available.

**Given** commit succeeds but Watch delivery is pending or failed
**When** status is displayed
**Then** local commit and Watch delivery remain distinct literal states
**And** delivery failure never rolls back or falsely reports the local revision as undelivered locally.

**Given** automated invariant and fault tests run
**When** they simulate zero approval, stale digest/base, changed policy, failed safety, partial writes, duplicate/retry/out-of-order events, and delivery failure
**Then** effective writes without required approval are zero and every approved proposal produces at most one complete revision
**And** no test blocks the Epic 1 manual core.

**Given** Story 2.14 scope is inspected
**When** it is reviewed
**Then** it contains pre-commit validation/safety, atomic idempotent commit, causality, failure degradation, and distinct delivery truth
**And** excludes Watch transfer implementation already owned by Epic 1 and Health-derived Gate closure owned by Epic 6.

**Traceability:** FR-057, FR-060, FR-080, FR-084, FR-085, FR-087; AD-2, AD-7, AD-13; NFR-AI-002–NFR-AI-005; SM-AI-001, SM-AI-002; UX-DR2, UX-DR12, UX-DR15, UX-DR19.

## Epic 3: Make User-Authoritative Decisions During a Workout

During a session, the trainee can request a canonical substitute when equipment is unavailable and accept, edit, or reject next-set load guidance without silently changing the current Actual Set or future Plan. This Epic consumes only stable Plan snapshots, effective Actual facts, RPE provenance, and Exercise Catalog ports; it does not depend on or call the post-session Analysis/read-model implementation.

### Story 3.1: Request Canonical Exercise Substitutes for Available Equipment

As a trainee,
I want to request substitutes when planned equipment is unavailable,
So that I can keep training while understanding how each alternative differs from the planned Exercise.

**Acceptance Criteria:**

**Given** an active session uses an immutable Plan snapshot
**When** the user requests a substitute for the current Exercise
**Then** the request uses the canonical Exercise ID, primary body area, movement pattern, required equipment, and the equipment the user marks available
**And** no substitute is selected automatically.

**Given** candidate mappings exist
**When** results are shown
**Then** each candidate has a canonical ID and explains primary-area match, movement-pattern match, equipment fit, and disclosed secondary-area or range differences
**And** unsupported or uncertain mappings remain explicit.

**Given** no safe canonical candidate exists
**When** matching completes
**Then** the system shows No Supported Substitute and retains the planned Exercise
**And** the user can return, manually choose another supported Exercise, or leave the item incomplete.

**Given** catalog or support versions differ from the Start snapshot
**When** substitution is requested
**Then** the session-frozen compatible catalog is used or the operation fails with a literal version reason
**And** historical and planned identities are not silently reinterpreted.

**Given** the substitute surface reflows or uses VoiceOver
**When** candidates are compared
**Then** mappings and differences are readable without color-only ranking, horizontal scrolling, or hidden critical values.

**Traceability:** FR-030, FR-031; CAP-13, CAP-14; AD-7, AD-14; UX-DR10, UX-DR14, UX-DR17–UX-DR19.

### Story 3.2: Explicitly Select a Session Substitute Without Mutating the Plan

As a trainee,
I want to explicitly choose a substitute for the current workout scope,
So that my actual training follows my decision without silently rewriting the future Plan.

**Acceptance Criteria:**

**Given** Story 3.1 shows candidates
**When** the user selects one candidate
**Then** the exact original Exercise, substitute, rationale, scope, and affected remaining planned items are previewed
**And** selection alone changes no Actual Set or Plan.

**Given** the user confirms the session-scoped substitution
**When** the local transaction succeeds
**Then** an append-only auditable session decision is saved with provenance, versions, and Start-snapshot reference
**And** subsequent applicable set-entry defaults use the selected Exercise while prior Actual Sets remain unchanged.

**Given** the user cancels or rejects
**When** the preview closes
**Then** the original session snapshot remains in force and no compensating write is created.

**Given** the user asks to apply the change to future training
**When** the session decision completes
**Then** the system creates only a non-effective future-Plan proposal for the ordinary Epic 2 review path
**And** it never edits the active Plan or current Start snapshot directly.

**Given** the same confirmation is retried
**When** its stable action ID is recognized
**Then** the original decision is returned without duplicate revisions or repeated substitutions.

**Traceability:** FR-032; AD-2, AD-7, AD-14; SM-PRES-001; UX-DR10, UX-DR12–UX-DR15, UX-DR19.

### Story 3.3: Accept, Edit, or Reject Next-Set Load Guidance

As a trainee,
I want a next-set load suggestion that I can accept, edit, or reject,
So that guidance helps me without ever claiming authority over my next Actual Set.

**Acceptance Criteria:**

**Given** an effective Actual RPE and remaining Plan scope are available
**When** the user requests or becomes eligible for guidance
**Then** a deterministic suggestion names the source Actual Set/RPE provenance, current load/unit, proposed next load, rationale, and applicable next-set scope
**And** missing, pending, incomparable, or untrusted RPE produces no fabricated suggestion.

**Given** a suggestion is displayed
**When** the user takes no action
**Then** no Actual Set, Start snapshot, or future Plan changes
**And** the ordinary previous-Actual-Load default remains authoritative.

**Given** the user accepts or edits the suggestion
**When** the next set-entry draft opens
**Then** the chosen value becomes only an editable default for that next Actual Set
**And** the Actual Set becomes fact only after the ordinary explicit Complete Set commit.

**Given** the user rejects the suggestion
**When** rejection is saved
**Then** no load value changes and the rejection remains auditable without affecting completed facts.

**Given** units, equipment, Exercise, session state, or source RPE changes
**When** an old suggestion is acted upon
**Then** it is invalidated and recomputed or rejected with an exact reason
**And** stale guidance cannot overwrite a newer user edit.

**Given** proactive guidance is shown during a workout
**When** interruption eligibility is checked
**Then** it waits for `restSafeForInteraction`, uses the shared prompt budget where applicable, and never removes manual load entry.

**Traceability:** FR-027; CAP-14; AD-2, AD-7, AD-14; NFR-RPE-002–NFR-RPE-003; SM-INT-001; UX-DR10, UX-DR16–UX-DR17, UX-DR19.

## Epic 4: Review History, Analysis, and Future-Plan Reconciliation

After or between sessions, the trainee can browse complete History, inspect revision-bound weekly/monthly and selected Primary Exercise Analysis, see stale/partial/conflicted exclusions truthfully, reuse a historical session as a new draft, and accept or reject an exact future-Plan reconciliation diff without altering completed work. This Epic owns Analysis/read-model and future-Plan reconciliation use cases and depends only on shared stable domain contracts, not the in-session guidance implementation.

### Story 4.1: Browse Complete and Incomplete Training History

As a trainee,
I want to browse all durable planned and ad-hoc sessions,
So that completed, incomplete, corrected, conflicted, and recovery records do not disappear from my history.

**Acceptance Criteria:**

**Given** durable Workout Sessions exist
**When** History loads
**Then** it lists planned and ad-hoc sessions using effective revisions with date, completion state, performed Exercises, and literal incomplete/corrected/conflicted indicators
**And** planned content never substitutes for missing Actual facts.

**Given** History is loading, empty, offline, failed, or contains tombstoned/conflicted records
**When** the state is displayed
**Then** each condition has distinct literal semantics and an applicable recovery action
**And** no optimistic empty or success state hides durable records.

**Given** the user filters or scrolls History and opens a session
**When** the user navigates back
**Then** filter, object context, scroll position, and non-effective input are restored.

**Given** a correction or recovered transfer changes effective session state
**When** History refreshes
**Then** only affected rows are invalidated and recomputed
**And** the row identifies pending or stale state until recomputation completes.

**Given** large text, VoiceOver, keyboard, or non-color settings are used
**When** History is browsed
**Then** state, date, Exercise, and recovery actions remain readable and operable without truncated critical Chinese content.

**Traceability:** FR-036; AD-11, AD-14; NFR-UX-001; UX-DR1, UX-DR5, UX-DR12–UX-DR15, UX-DR18–UX-DR19.

### Story 4.2: Inspect the Complete Effective Session Record

As a trainee,
I want to inspect every durable Actual Set and its relevant correction provenance,
So that completion never makes fields disappear or hides which values are effective.

**Acceptance Criteria:**

**Given** a History session is selected
**When** detail opens
**Then** it shows every effective Actual Set with Exercise, order, repetitions, load/unit/kind, RPE state, timing, completeness, source, and trained body areas
**And** missing fields remain visibly missing.

**Given** values were corrected, split, merged, inserted, deleted, recovered, or conflicted
**When** their rows are viewed
**Then** effective values are distinguished from prior revisions and relevant provenance is inspectable
**And** sibling facts and original timing remain preserved.

**Given** a fact is pending, incomplete, conflicted, excluded, or awaiting a missing parent
**When** detail is rendered
**Then** it is not counted as confirmed and the exact resolution or waiting state is shown.

**Given** the user performs an allowed post-completion correction
**When** the revision commits
**Then** the detail uses Epic 1 append-only correction behavior and marks dependent Analysis stale
**And** no history row is overwritten in place.

**Given** detail is reopened offline or after restart
**When** local data is readable
**Then** the complete last durable record remains available without cloud or AI dependency.

**Traceability:** FR-040, FR-041; AD-2, AD-5, AD-11; SM-COMP-001, SM-PRES-001; UX-DR5, UX-DR12, UX-DR19.

### Story 4.3: Calculate Weekly and Monthly Analysis from Effective Actual Sets

As a trainee,
I want weekly and monthly training summaries calculated only from effective Actual Sets,
So that planned, missing, or conflicted work never inflates my results.

**Acceptance Criteria:**

**Given** the user selects a week
**When** Analysis computes
**Then** it shows completed-session count and performed Exercises from effective Actual facts
**And** incomplete sessions and exclusions are separately disclosed.

**Given** weekly or monthly metrics are requested
**When** volume, intensity, load, and duration are derived
**Then** formulas, units, time zone/calendar boundary, source revision watermark, and denominator are versioned and reproducible
**And** planned sets and semantically incomparable load kinds are not silently aggregated.

**Given** corrected effective facts exist
**When** Analysis runs
**Then** corrected values and applicable RPE provenance are used
**And** superseded revisions do not contribute twice.

**Given** data is insufficient for a metric
**When** the result is displayed
**Then** it states insufficient, partial, excluded, or incomparable rather than returning zero or a fabricated conclusion.

**Given** charts are displayed
**When** accessibility alternatives are requested
**Then** the same exact values, units, exclusions, and conclusions are available as text and table without color-only meaning.

**Traceability:** FR-037, FR-038, FR-040; AD-11, AD-14; NFR-RPE-002, NFR-UX-001; UX-DR6, UX-DR11–UX-DR15, UX-DR18–UX-DR20.

### Story 4.4: View Trends for One Explicitly Selected Primary Exercise

As a trainee,
I want to select one Primary Exercise and inspect its comparable trend,
So that substitutions or similarly named movements are not silently mixed into my progress.

**Acceptance Criteria:**

**Given** the user opens Exercise trends
**When** no canonical Primary Exercise is selected
**Then** no trend is calculated and the UI asks for an explicit selection.

**Given** a Primary Exercise is selected
**When** trend points are computed
**Then** only effective Actual Sets mapped to that canonical identity and semantically comparable load/unit kinds are included
**And** substitutions remain separate unless an explicit supported comparison rule exists.

**Given** corrected or incomplete records occur in the period
**When** the trend is shown
**Then** corrected effective values are used and excluded/pending/conflicted points and reasons are disclosed.

**Given** the user changes Exercise, period, unit, or filter
**When** Analysis refreshes
**Then** the selection and source watermark change explicitly and old results are not shown as current.

**Given** a chart cannot be perceived or targeted
**When** the user uses text, table, VoiceOver, or keyboard alternatives
**Then** every point, date, value, unit, and literal conclusion remains available.

**Traceability:** FR-039, FR-040, FR-049; AD-11, AD-14; UX-DR6, UX-DR14, UX-DR18, UX-DR20.

### Story 4.5: Keep Analysis Truthful Through Invalidation and Recovery

As a trainee,
I want Analysis to identify when its source facts changed or remain unresolved,
So that cached metrics never look current while corrections, transfer, or conflicts are still being reconciled.

**Acceptance Criteria:**

**Given** an effective fact, mapping, resolution, or relevant version changes
**When** the atomic mutation commits
**Then** the affected Analysis scope receives an invalidation in the same transaction
**And** unaffected periods and Exercises remain usable.

**Given** cached output precedes its source watermark
**When** Analysis opens
**Then** it is labeled stale and recomputation begins or an explicit retry is offered
**And** stale output is never presented as current.

**Given** sources are pending, partial, conflicted, incomplete, excluded, or unreadable
**When** recomputation runs
**Then** results carry the corresponding literal state, exclusions, and source counts
**And** unsafe values are not silently selected by arrival time.

**Given** recomputation fails or the app restarts
**When** Analysis recovers
**Then** durable source facts remain authoritative, prior cache remains labeled stale, and retry is idempotent
**And** History and workout capture remain available.

**Given** tests mutate one revision at a time
**When** affected read models are compared
**Then** only correct scopes change and deterministic recomputation produces the same output from the same effective facts.

**Traceability:** FR-038–FR-041; AD-2, AD-11; NFR-RECOV-001; UX-DR6, UX-DR12, UX-DR15, UX-DR19.

### Story 4.6: Reconcile Plan Versus Actual with an Exact Future-Scope Diff

As a trainee,
I want material Plan-versus-Actual differences translated into a complete future-Plan proposal,
So that I can approve or reject future changes without altering completed work.

**Acceptance Criteria:**

**Given** a session completes with material Plan-versus-Actual differences
**When** reconciliation is requested
**Then** it compares the immutable Start snapshot with effective Actual Sets and identifies exact additions, removals, and changed fields/values/units
**And** it names affected future sessions and excludes completed history and active sessions.

**Given** facts are incomplete, pending, conflicted, or incomparable
**When** the diff is formed
**Then** those items remain explicit and cannot be converted into guessed future changes.

**Given** a valid reconciliation candidate exists
**When** review opens
**Then** it becomes a non-effective immutable proposal through the Epic 2 identity, safety, complete-diff, and approval path
**And** no special reconciliation shortcut bypasses digest-bound approval.

**Given** the user rejects or dismisses guidance
**When** the action is saved
**Then** Actual facts remain preserved and the future Plan remains unchanged.

**Given** the user approves and commit succeeds
**When** the result is shown
**Then** exactly one future Plan Revision becomes effective through Story 2.14
**And** completed and active Workout Sessions remain unchanged.

**Traceability:** FR-033, FR-034; CAP-14; AD-2, AD-7, AD-11, AD-14; UX-DR2, UX-DR6, UX-DR10, UX-DR12.

### Story 4.7: Reuse a Historical Session as a New Draft

As a trainee,
I want to reuse a historical session as a new editable draft,
So that I can build future training from what I actually did without changing the source history or implicitly approving a Plan.

**Acceptance Criteria:**

**Given** a complete or incomplete historical session is open
**When** the user selects Reuse as Draft
**Then** a preview identifies included effective Actual facts, omitted pending/conflicted fields, mappings, units, source session/revision, and assumptions
**And** the source session remains immutable.

**Given** the user confirms draft creation
**When** the local transaction succeeds
**Then** a new stable draft identity with provenance and digest is created as non-effective
**And** it does not change the active Plan or create an approval.

**Given** unknown mappings, unsupported units, or required omissions exist
**When** creation is attempted
**Then** the draft remains incomplete with explicit correction actions
**And** the system does not invent replacements.

**Given** the same action is retried
**When** its idempotency key is recognized
**Then** the original draft is returned without duplication.

**Given** the user wants to activate the draft
**When** they continue
**Then** it enters the ordinary Epic 2 validation, safety, complete review, approval, and atomic commit path.

**Traceability:** FR-035; AD-2, AD-7, AD-11; NFR-AI-001–NFR-AI-002; UX-DR5, UX-DR10, UX-DR12, UX-DR19.

## Epic 5: Exchange a FitnessAI Plan as a Safe Independent Draft

The trainee can export exactly one bounded FitnessAI Plan through the native Share Sheet and import a file only after complete validation, mapping, omission, duplicate, and provenance review creates a new non-effective draft. Parser or sharing failure changes no existing Plan. GATE-7 is a prerequisite/evidence Story: export may proceed, but Plan import cannot be accepted until parser time/memory ceilings and failure reporting are frozen.

### Story 5.1: Export One Bounded FitnessAI Plan Through the Share Sheet

As a trainee,
I want to review and export exactly one Plan as a bounded FitnessAI file,
So that I can share only the intended Plan without hidden history, health, account, or sensor data.

**Acceptance Criteria:**

**Given** the user selects an effective Plan or non-effective draft
**When** export review opens
**Then** it identifies exactly one Plan, revision/draft identity, included fields, provenance, schema/catalog versions, and excluded data classes
**And** History, Actual Sets, Health data, AI conversation, secrets, and raw signals are excluded.

**Given** export is confirmed
**When** the file is encoded
**Then** it is plain uncompressed UTF-8 JSON with one versioned FitnessAI Plan, canonical units/IDs, provenance, and whole-file digest
**And** AD-10 structural limits are enforced before a file is exposed.

**Given** validation or encoding fails
**When** the operation ends
**Then** no partial file is shared, the exact failure is shown, and every existing Plan remains unchanged.

**Given** a valid file exists
**When** the user selects Share
**Then** the native Share Sheet receives only that file after explicit action
**And** cancelling the Share Sheet changes no Plan or export status beyond cancellation.

**Given** the export surface uses accessibility modes
**When** scope and actions are reviewed
**Then** all included/excluded categories, file identity, errors, and the single consequential action are readable without color-only meaning or truncated Chinese text.

**Traceability:** FR-071; AD-10, AD-13, AD-14; NFR-PORT-001, NFR-UX-001; UX-DR8, UX-DR10–UX-DR15, UX-DR18–UX-DR19.

### Story 5.2: Freeze GATE-7 Parser Resource Budgets and Failure Reporting

As the Product Owner,
I want Plan-import time and memory ceilings frozen before parser acceptance,
So that untrusted files cannot gain an undefined resource budget or ambiguous failure behavior.

**Acceptance Criteria:**

**Given** GATE-7 is open
**When** the owned `GATE-7 Plan Parser Budget Decision Record` is created
**Then** it records numeric wall/CPU time and peak-memory ceilings, measurement environment, abort behavior, user-visible failure categories, owner, version, and digest
**And** contains no `TBD` or implementer-invented value.

**Given** AD-10 structural limits apply
**When** the budget record is frozen
**Then** it explicitly layers resource ceilings over 2 MB, depth 12, one Plan, 366 days, 30 Exercises/day, 20 Sets/Exercise, 10,000 Sets, and 2,000 characters/note
**And** states which checks occur before allocation or deep parsing.

**Given** parsing exceeds any frozen ceiling
**When** abort behavior is specified
**Then** termination is bounded, no partial object is accepted, temporary state is discarded safely, and a literal non-sensitive reason is returned
**And** no existing Plan is mutated.

**Given** the record is incomplete or changes
**When** Gate state is evaluated
**Then** GATE-7 remains or returns disabled and import acceptance is blocked
**And** bounded export from Story 5.1 remains available.

**Given** Story 5.2 scope is inspected
**When** it is reviewed
**Then** it contains only frozen parser budgets, measurement protocol, failure taxonomy, change control, and default-disabled Gate registration
**And** excludes parser implementation, preview, and draft creation.

**Traceability:** GATE-7 prerequisite; AD-10, AD-13; NFR-PORT-001.

### Story 5.3: Parse and Validate an Untrusted Plan File with Import Disabled

As a trainee,
I want a selected Plan file parsed within strict limits before any import action is enabled,
So that malformed or hostile content cannot change my Plans or exhaust the app.

**Acceptance Criteria:**

**Given** the user selects a file through the native picker
**When** bounded parsing begins
**Then** size, encoding, compression, depth, counts, note length, time, and memory are enforced using AD-10 and Story 5.2
**And** executable, malformed, multi-Plan, unsupported-root, or limit-exceeding content is rejected before draft creation.

**Given** JSON is structurally valid
**When** schema and compatibility validation runs
**Then** supported/unsupported versions, required/unknown fields, units, dates, canonical Exercise references, duplicates, omissions, and digests receive explicit results
**And** unknown data is never silently invented, executed, or merged.

**Given** parsing aborts, crashes, times out, or exceeds memory
**When** failure is handled
**Then** a bounded literal error and recovery action are shown, temporary content cannot become effective, and logs contain no imported Plan content.

**Given** the same file is parsed repeatedly
**When** canonical results are compared
**Then** they are deterministic and carry the same file digest, mappings, omissions, duplicate findings, and compatibility state.

**Given** parser implementation passes unit and fault tests while GATE-7 evidence is absent
**When** import eligibility is checked
**Then** parser output may be previewed but Create New Draft remains technically disabled
**And** no status assertion closes GATE-7.

**Traceability:** FR-072, FR-073; GATE-7 implementation; AD-10, AD-13; NFR-PORT-001; UX-DR8, UX-DR19.

### Story 5.4: Review Import Findings with Draft Creation Disabled

As a trainee,
I want a complete import preview while draft creation remains disabled,
So that I can resolve mappings, omissions, duplicates, and incompatibilities without any existing Plan being touched.

**Acceptance Criteria:**

**Given** bounded parsing succeeds
**When** preview opens
**Then** it shows file identity/digest, source provenance, schema/catalog versions, every Plan field, mapping, unknown field, omission, duplicate, warning, and incompatibility
**And** partial content is never labeled complete.

**Given** required unknown Exercises or incompatible fields remain
**When** the user reviews actions
**Then** explicit mapping, omission, cancel, or unsupported outcomes are offered according to the frozen contract
**And** no mapping is invented or silently dropped.

**Given** GATE-7 has not yet passed its evidence Story
**When** the preview becomes structurally complete
**Then** Create New Draft remains technically disabled with the literal Gate reason
**And** preview, correction, cancellation, export, and existing Plan use remain available.

**Given** the user adjusts an allowed mapping or omission decision
**When** the preview recomputes
**Then** the original file digest, decision digest, resulting completeness, and every changed interpretation are visible
**And** no draft, approval, or effective mutation is persisted.

**Given** preview reflows for accessibility
**When** long Chinese values and errors are shown
**Then** critical fields, mappings, digests, and actions remain untruncated and operable without horizontal scrolling.

**Given** Story 5.4 scope is inspected
**When** it is reviewed
**Then** it contains only complete preview and non-effective mapping/omission decisions under a default-disabled create action
**And** excludes Gate evidence and draft persistence.

**Traceability:** FR-072, FR-073; GATE-7 preview enabling; AD-10, AD-14; NFR-PORT-001; UX-DR8, UX-DR10, UX-DR13–UX-DR15, UX-DR18–UX-DR19.

### Story 5.5: Prove Parser Budgets and Enable GATE-7 Import Acceptance

As the Product Owner,
I want reproducible parser evidence bound to the frozen budgets and build,
So that Plan import becomes acceptable only after malicious and boundary files are proven to fail safely.

**Acceptance Criteria:**

**Given** Stories 5.2–5.4 are complete
**When** the owned `GATE-7 Plan Parser Evidence Record` is generated
**Then** it names the budget record, parser build, schema/catalog versions, fixture corpus, device/environment, digests, and owner
**And** embeds machine-readable measurements and results rather than a pass statement.

**Given** the corpus runs
**When** thresholds are evaluated
**Then** every exact-boundary, over-boundary, malformed, deep, duplicate, unknown, incompatible, compressed, executable-content, timeout, and allocation-pressure case meets frozen time/memory and failure-reporting expectations
**And** zero failed cases create or mutate a Plan.

**Given** any test is skipped, nondeterministic, above budget, stale, or failed
**When** Gate state is computed
**Then** GATE-7 remains disabled and Create New Draft stays unavailable
**And** export and existing Plan use remain available.

**Given** all evidence passes
**When** the Product Owner accepts the exact evidence digest
**Then** GATE-7 enables import only for the recorded parser/schema/build/budgets
**And** any relevant version or budget change closes the Gate and invalidates prior enablement.

**Traceability:** FR-072, FR-073; GATE-7 evidence and enablement; AD-10, AD-13; NFR-PORT-001.

### Story 5.6: Create One Independent Non-Effective Imported Draft

As a trainee,
I want a fully reviewed compatible file to create one separate non-effective draft after GATE-7 passes,
So that importing never merges, overwrites, approves, or activates an existing Plan.

**Acceptance Criteria:**

**Given** GATE-7 is enabled for the exact parser/schema/build/budgets
**When** the user returns to a complete import preview
**Then** the file, mapping decisions, compatibility, Gate evidence, and digests are revalidated against current versions
**And** any stale or changed input disables creation and requires a refreshed preview.

**Given** every required field and mapping is resolved
**When** the user selects Create New Draft
**Then** exactly one new non-effective draft with a stable ID, import provenance, source file digest, decision digest, mappings, omissions, and versions is atomically saved
**And** no active or existing draft Plan is merged, overwritten, approved, or activated.

**Given** save fails or the action retries
**When** the stable action identity is processed
**Then** failure creates no partial draft and retry returns the one prior successful draft without duplication.

**Given** GATE-7 closes between preview and commit
**When** the transaction checks eligibility
**Then** creation fails before any write with the exact Gate reason
**And** existing Plans and the reviewed preview remain unchanged.

**Given** the user later wants activation
**When** they continue from the imported draft
**Then** it enters Epic 2 validation, safety, complete review, explicit approval, and atomic commit
**And** import itself confers no approval.

**Traceability:** FR-072, FR-073; GATE-7 enabled import acceptance; AD-2, AD-10; NFR-PORT-001; UX-DR8, UX-DR12, UX-DR15, UX-DR19.

## Epic 6: Use Apple Health Without Surrendering Local Truth

The trainee can grant optional least-privilege Apple Health capabilities, observe only truthful read states, and create or retry idempotent workout copies while FitnessAI remains authoritative and external changes become `healthKitDetached`. Health failure leaves local Plan, History, Analysis, and capture intact. The local capability works independently; GATE-3 keeps every real Health-derived remote send technically disabled while allowing a separate authorization preview and AI without Health data.

### Story 6.1: Manage Least-Privilege Apple Health Capabilities

As a trainee,
I want each Apple Health capability requested and shown separately,
So that I can grant only the frozen allowlisted access and understand what is unavailable, denied, or unsupported.

**Acceptance Criteria:**

**Given** the user opens Apple Health settings
**When** capability rows load
**Then** each frozen read or write type has a separate purpose, requested state, observable result, last attempt, and recovery action
**And** excluded clinical categories are absent from entitlements, queries, and UI.

**Given** authorization has not been requested
**When** the user takes no action
**Then** no Health prompt appears and Plan, History, Analysis, AI without Health, and workout capture remain usable.

**Given** the user requests one capability
**When** HealthKit returns an observable state
**Then** the app reports only what the API can truthfully determine and never claims read authorization it cannot observe
**And** denial or restriction does not imply another capability failed.

**Given** HealthKit is unavailable, restricted, denied, or errors
**When** the row updates
**Then** the literal state and safe retry/settings action are shown without optimistic success
**And** local FitnessAI truth remains authoritative.

**Given** accessibility modes are active
**When** capability rows and explanations are used
**Then** status and actions do not rely on color, icons, or gestures alone and large Chinese text remains complete.

**Traceability:** FR-088; AD-9, AD-14; NFR-HK-001, NFR-UX-001; UX-DR7, UX-DR10–UX-DR15, UX-DR18–UX-DR19.

### Story 6.2: Build Data-Minimized Local Health Summaries

As a trainee,
I want permitted Health data transformed locally into explicit bounded summaries,
So that raw Health records remain local and remote AI can never receive more than a separately reviewed summary.

**Acceptance Criteria:**

**Given** an allowed Health read is available
**When** local summary computation runs
**Then** it uses only frozen allowlisted types, an explicit time window, documented aggregation, canonical units, source-query generation, and a versioned summary schema
**And** complete raw samples remain local.

**Given** data is missing, partial, stale, denied, or incomparable
**When** a summary is formed
**Then** the condition, coverage window, exclusions, and completeness are explicit
**And** no value is guessed or backfilled from FitnessAI planned content.

**Given** Health data later changes
**When** a prior summary is viewed
**Then** it remains bound to its source generation/digest and is marked stale rather than silently recomputed inside an authorized request.

**Given** a summary is selected for AI preview
**When** Story 2.8 maps its fields
**Then** only summary categories and transformations are exposed
**And** GATE-3 and a matching Story 2.7 one-shot authorization are still required for real sending.

**Given** Health summary computation fails
**When** the user returns to local features
**Then** Plan, History, Analysis from FitnessAI facts, and workout capture remain available.

**Traceability:** FR-082, FR-088; GATE-3 enabling input; AD-8, AD-9; NFR-HK-001, NFR-PRIV-003, NFR-PRIV-007; UX-DR7, UX-DR12, UX-DR19.

### Story 6.3: Close GATE-3 with Health-Derived Remote-Use Evidence

As the Product Owner,
I want real Health-derived AI traffic enabled only by a complete compliance, privacy, security, and field-mapping evidence record,
So that a local Health permission or preview can never be mistaken for remote-use approval.

**Acceptance Criteria:**

**Given** GATE-3 is assessed
**When** the owned `GATE-3 Health-Derived Remote-Use Evidence Record` is assembled
**Then** it names the health/fitness purpose, Apple compliance basis, processor/contract review, region/cross-border path, disclosure, retention/training, deletion/revocation/user rights, owners, effective dates, versions, and digest
**And** no open item is represented as approved.

**Given** request mapping is reviewed
**When** evidence is recorded
**Then** every allowed request field maps to one Story 6.2 summary category, source type/window, transformation, unit, purpose, and retention treatment
**And** raw samples, excluded clinical types, and unmapped fields are prohibited.

**Given** negative tests run
**When** GATE-3 is disabled, authorization is missing/stale, a field is unmapped, or payload contains raw/extra data
**Then** egress is zero and content-free audit records the exact rejection
**And** AI without Health remains available.

**Given** evidence is incomplete, stale, rejected, or tests fail
**When** Gate state is evaluated
**Then** GATE-3 remains disabled and Story 2.8 preview cannot send
**And** local Health and the manual core remain available.

**Given** every required approval and test passes
**When** the Product Owner accepts the evidence digest
**Then** GATE-3 enables only recorded summary fields, route, purpose, region, versions, and validity window
**And** any relevant change automatically closes the Gate pending new evidence.

**Traceability:** FR-082, FR-086, FR-088; GATE-3 prerequisite evidence and enablement; AD-8, AD-9, AD-13; NFR-HK-001, NFR-PRIV-007.

### Story 6.4: Send One Authorized Health Summary After GATE-3

As a trainee,
I want an eligible local Health summary sent only after I approve its exact one-shot preview,
So that Gate closure never becomes standing consent for my health information.

**Acceptance Criteria:**

**Given** GATE-3 is enabled for matching versions
**When** a Health-derived remote preview opens
**Then** Health categories remain off by default and show exact summary fields, source window, transformations, purpose, provider, route, evidence version, and request digest.

**Given** the user affirmatively selects categories and authorizes the request
**When** the payload reaches the remote boundary
**Then** it must match both GATE-3 allowlisting and a fresh Story 2.7 one-shot token exactly
**And** the token is atomically consumed for one logical request.

**Given** summary generation, source data, Gate evidence, route, policy, selection, or request digest changes
**When** send is attempted
**Then** the authorization is invalidated and a new preview is required.

**Given** delivery fails or times out
**When** status is displayed
**Then** sent, not sent, failed, and retry-needs-authorization remain distinct
**And** no automatic retry reuses health authorization or broadens the payload.

**Given** the send completes
**When** audit is stored
**Then** it records IDs, versions, selected categories, digest, status, and timing without content, raw Health data, secrets, or chain-of-thought.

**Traceability:** FR-082, FR-086; GATE-3 send enablement; AD-8, AD-9; NFR-PRIV-007; UX-DR2, UX-DR7, UX-DR12, UX-DR19.

### Story 6.5: Write an Idempotent Workout Copy to Apple Health

As a trainee,
I want an optional completed-workout copy written to Apple Health after FitnessAI saves Finish,
So that external interoperability never controls whether my local workout is complete.

**Acceptance Criteria:**

**Given** a Workout Session has durably finished in FitnessAI
**When** the user has enabled the separate Health write capability
**Then** an export generation with stable idempotency metadata is queued after local Finish
**And** local completion never waits for or depends on HealthKit.

**Given** the write is pending, written, failed, denied, or retryable
**When** status is shown
**Then** each state remains distinct from local save and session completion
**And** failure includes a safe explicit retry where applicable.

**Given** the same export generation retries
**When** HealthKit or the app repeats work
**Then** it cannot create a second FitnessAI-owned workout copy
**And** logs and errors contain no workout content.

**Given** effective workout facts change after a correction
**When** export eligibility is reevaluated
**Then** a new explicit export generation is required according to the transition contract
**And** an external copy is never silently rewritten as if no correction occurred.

**Given** Health write fails permanently
**When** the user views the session
**Then** the complete FitnessAI workout remains authoritative and usable in History and Analysis.

**Traceability:** FR-089; AD-2, AD-9; NFR-HK-001, NFR-HK-002; UX-DR7, UX-DR12, UX-DR15, UX-DR19.

### Story 6.6: Preserve Local Truth When a Health Copy Detaches

As a trainee,
I want external deletion or change of a Health workout copy shown as detached,
So that FitnessAI never silently recreates external data or changes my local workout truth.

**Acceptance Criteria:**

**Given** FitnessAI previously wrote a Health workout copy
**When** later reconciliation cannot find or safely match the external object
**Then** the export generation becomes `healthKitDetached` with last-known identity, generation, and observable reason
**And** the local Workout Session and Actual Sets remain unchanged.

**Given** an external Health object changes
**When** it differs from FitnessAI truth
**Then** FitnessAI does not import the change into local facts, select it by timestamp, or rewrite history
**And** the detached or differing state is visible.

**Given** a copy is detached
**When** background reconciliation or app restart occurs
**Then** the system does not silently recreate the copy
**And** only an explicit user action may create a new export generation.

**Given** duplicate, delayed, or reordered Health callbacks occur
**When** the state machine handles them
**Then** generation identity and transition rules prevent rollback from detached to falsely written.

**Given** HealthKit is unavailable
**When** the user continues using FitnessAI
**Then** Plan, workout, History, Analysis, and AI without Health remain available and local truth stays authoritative.

**Traceability:** FR-090; AD-9; NFR-HK-001, NFR-HK-002; UX-DR7, UX-DR12, UX-DR19.

## Epic 7: Gain Evidence-Gated Watch Assistance with Manual Fallback

On the exact qualified device/orientation/handedness/Exercise rows, the trainee can receive independently qualified recognition, set/rep, opt-in RPE, and conservative Finish assistance with confidence, abstention, correction, drift recovery, safe-rest prompting, and the shared interruption budget. GATE-4–6 are evidence Stories; each open or failed Gate keeps only its named automation path disabled while Epic 1 manual capture remains supported.

### Story 7.1: Capture Candidate Watch Signals with Every Automation Disabled

As a trainee,
I want candidate sensing to leave manual Watch recording fully usable,
So that experimental recognition never fabricates or controls my workout facts.

**Acceptance Criteria:**

**Given** the candidate AD-6 device/orientation/handedness/eight-Exercise row is installed
**When** a Watch workout starts
**Then** automatic Exercise, set-boundary, repetition, RPE, and forgotten-Finish outputs are independently disabled by default
**And** manual Exercise selection, repetitions, load, Complete Set, correction, and Finish remain available.

**Given** approved experimental capture is enabled for Product Owner testing
**When** supported signals are observed
**Then** high-frequency streams remain local, versioned, session-frozen, and separated from durable Actual Set truth
**And** unsupported devices, orientations, handedness, Exercises, missing signals, or resource pressure stop candidate capture without blocking the workout.

**Given** a candidate produces an internal result while its Gate is closed
**When** the result reaches the domain boundary
**Then** it cannot create, complete, label, or change an Actual Set
**And** it cannot appear as a supported automatic result in user-facing UI.

**Given** resource or storage pressure occurs
**When** the Watch protects core records
**Then** optional candidate/raw data is stopped or cleaned before structured workout facts
**And** inability to save core facts is explained before the next manual commit.

**Given** Story 7.1 scope is inspected
**When** it is reviewed
**Then** it contains only candidate signal adapters, local experimental storage, independent default-off switches, support checks, and manual fallback tests
**And** excludes model qualification or automation enablement.

**Traceability:** FR-007–FR-011, FR-020, FR-047; GATE-4–6 disabled candidate enabling; AD-6, AD-13; NFR-REC-002, NFR-RPE-007, NFR-RES-001; UX-DR17, UX-DR19.

### Story 7.2: Freeze the GATE-4 Recognition Preregistration

As the Product Owner,
I want recognition evaluation frozen before final holdout results are viewed,
So that support claims and thresholds cannot move after performance is known.

**Acceptance Criteria:**

**Given** GATE-4 is open
**When** the owned `GATE-4 Recognition Preregistration Record` is frozen
**Then** it names participants/time partitions, untouched holdout, candidate model/build, device/OS, orientation, handedness, eight-Exercise rows, signal eligibility, and versions/digests
**And** Exercise classification, set boundary, and repetitions have independent qualification decisions.

**Given** metrics are defined
**When** the record is reviewed
**Then** it freezes denominators including abstentions/misses, thresholds, confidence intervals, silent misses, false sets, repetition error, correction/recovered-record separation, slices, and resource protocol
**And** no unsupported result can count as success.

**Given** interaction is evaluated
**When** prompts are specified
**Then** safe-rest eligibility and the shared five-prompt representative-session budget are frozen with prompt/correction counter-metrics.

**Given** required values are missing or changed after holdout access
**When** Gate state is assessed
**Then** GATE-4 remains disabled or requires a new untouched holdout and version
**And** manual Complete Set remains the supported path.

**Traceability:** FR-008–FR-015; GATE-4 prerequisite; AD-6, AD-13; NFR-REC-001, NFR-REC-002, NFR-COMPAT-001, SM-ACC-001, SM-INT-001.

### Story 7.3: Prove GATE-4 on Physical Devices and Enable Only Passing Rows

As the Product Owner,
I want row-specific physical-device recognition evidence,
So that only independently passing functions on exact tested configurations are enabled.

**Acceptance Criteria:**

**Given** Story 7.2 is frozen
**When** the owned `GATE-4 Recognition Physical-Device Evidence Record` is generated
**Then** it binds preregistration, model/support/catalog builds, physical devices/OS, participants/sessions, immutable predictions, labels, raw result files, and digests
**And** embeds machine-readable results rather than a support assertion.

**Given** the untouched holdout is evaluated
**When** thresholds and slices are compared
**Then** classification, set boundary, and repetitions each pass or fail independently with preregistered denominators, uncertainty, silent misses, correction burden, and resource evidence
**And** recovery after correction does not improve initial-recognition success.

**Given** a function/configuration row fails, is missing, or lacks physical-device evidence
**When** support state is published
**Then** that exact row remains `manualOnly` or candidate-disabled with a literal reason
**And** passing neighboring rows do not enable it.

**Given** a row passes and the Product Owner accepts the evidence digest
**When** enablement is applied
**Then** only that function/device/OS/orientation/handedness/Exercise row is enabled for the frozen versions
**And** any relevant change automatically disables it pending new evidence.

**Traceability:** FR-008–FR-015; GATE-4 evidence and row-specific enablement; AD-6, AD-13; NFR-REC-001–NFR-REC-002, NFR-COMPAT-001, NFR-RES-001–NFR-RES-002; SM-ACC-001.

### Story 7.4: Recognize and Correct a Qualified Exercise

As a trainee,
I want qualified ad-hoc Exercise recognition with an explicit correction path,
So that a supported suggestion reduces entry while my correction remains authoritative and auditable.

**Acceptance Criteria:**

**Given** an ad-hoc Watch session has no preselected Exercise and its exact GATE-4 classification row is enabled
**When** eligible signals produce a result
**Then** the UI shows canonical Exercise, confidence, model/support versions, and accepted, uncertain, abstained, unsupported, or manual-only state
**And** unsupported or below-threshold output never becomes an Exercise fact.

**Given** confidence requires confirmation
**When** interaction becomes `restSafeForInteraction`
**Then** one concise prompt may use the shared budget and offers confirm, correct, or manual selection
**And** workout recording continues without blocking.

**Given** the user confirms or manually selects an Exercise
**When** the first Actual Set commits
**Then** the user-confirmed canonical identity and recognition provenance are saved atomically with the set
**And** recognition alone never commits the fact.

**Given** the user corrects the Exercise after the first Actual Set
**When** correction commits
**Then** an append-only revision changes only Exercise identity, preserves order/repetitions/load/RPE/timing, and makes later sets use the corrected Exercise
**And** the original prediction and correction remain auditable.

**Given** recognition is disabled or fails
**When** the user trains
**Then** manual Exercise selection and Complete Set remain fully available.

**Traceability:** FR-008, FR-010–FR-014, FR-049; AD-2, AD-6, AD-14; NFR-REC-002; SM-ACC-001, SM-PRES-001, SM-INT-001; UX-DR10, UX-DR16–UX-DR17, UX-DR19.

### Story 7.5: Recognize Qualified Set Boundaries and Repetitions

As a trainee,
I want qualified set and repetition assistance that abstains when uncertain,
So that I can reduce interaction without losing manual control or accepting invented sets.

**Acceptance Criteria:**

**Given** exact GATE-4 set-boundary and repetition rows are independently enabled
**When** eligible supported signals are processed
**Then** candidate boundary, repetition count, confidence, timing, model/support versions, and provenance remain distinct from a committed Actual Set
**And** one function may operate only if its own row passed.

**Given** the result is high-confidence under the frozen policy
**When** the Watch proposes completion
**Then** the user retains a visible manual Complete Set path and can edit repetitions/load/Exercise/RPE before commit
**And** local commit remains the only saved-fact boundary.

**Given** confidence is low, signals are missing, activity is unsupported, or the model abstains
**When** assistance resolves
**Then** no set or repetition is fabricated and state is uncertain, abstained, unsupported, or manual-only
**And** any prompt waits for safe rest and respects the shared budget.

**Given** the user corrects a recognized result
**When** correction commits
**Then** append-only provenance preserves the initial prediction and user correction without altering sibling facts
**And** initial-recognition and recovered-record success remain separate metrics.

**Given** candidate events repeat or arrive late
**When** the session reducer processes them
**Then** stable identity prevents duplicate sets and cannot roll back a later manual correction.

**Traceability:** FR-009–FR-011, FR-013, FR-015; AD-2, AD-6, AD-14; NFR-REC-001–NFR-REC-002; SM-ACC-001, SM-PRES-001, SM-INT-001.

### Story 7.6: Keep RPE Opt-In and Every RPE State Distinct

As a trainee,
I want RPE tracking off until I enable it and every RPE meaning kept separate,
So that a target or prediction is never misrepresented as my Actual RPE.

**Acceptance Criteria:**

**Given** the user has not enabled RPE tracking
**When** a workout runs
**Then** RPE estimation, verification, calibration, display, and auto-use are inactive
**And** concise RPE education may be viewed without enabling tracking.

**Given** the user explicitly opts in
**When** RPE fields become available
**Then** target, predicted, confirmed, auto-used, corrected, and effective RPE remain distinct with source/model/version provenance
**And** integer values are limited to 1–10.

**Given** the model or GATE-5 is disabled
**When** the user records a set
**Then** manual RPE entry remains available and authoritative
**And** no prediction is shown or used as Actual RPE.

**Given** RPE state crosses iPhone/Watch, History, Analysis, or recovery boundaries
**When** it is encoded or displayed
**Then** the same semantic distinction and provenance are preserved without collapsing states.

**Given** the user disables RPE tracking
**When** the setting commits
**Then** future estimation stops while previously confirmed/corrected facts remain auditable
**And** other workout capture remains unchanged.

**Traceability:** FR-020, FR-026, FR-052; GATE-5 disabled state flow; AD-6, AD-14; NFR-RPE-001–NFR-RPE-002, NFR-RPE-007, NFR-RPE-011.

### Story 7.7: Freeze the GATE-5 RPE Preregistration

As the Product Owner,
I want the RPE model, labels, thresholds, burden gates, drift rules, and holdout frozen before final evaluation,
So that auto-use cannot be justified by moving criteria after results are known.

**Acceptance Criteria:**

**Given** GATE-5 is open
**When** the owned `GATE-5 RPE Preregistration Record` is frozen
**Then** it identifies participants/time splits, untouched holdout, model/build, eligibility before label reveal, support rows, signals, integer output, confidence threshold, versions, and digests
**And** only confirmed/corrected RPE is eligible as a label.

**Given** evaluation criteria are recorded
**When** the record is reviewed
**Then** it freezes simple baselines, participant-held-out and later-session metrics, calibration/risk-coverage, exact and within-±1 accuracy, all-eligible denominators, subgroup/missing-signal/resource slices, and confidence intervals.

**Given** interaction and drift criteria are recorded
**When** the record is reviewed
**Then** it freezes first-five chronological eligibility, ≥4 within ±1 offer threshold, ≥2 wrong recalibration/restart, rolling-five two-correction drift trigger, and prompt/correction burden gates inside SM-INT-001.

**Given** any criterion is missing or changed after holdout access
**When** Gate state is assessed
**Then** GATE-5 remains disabled or requires a new untouched holdout/version
**And** RPE remains off by default and manual or approved confirmation-only use remains available.

**Traceability:** FR-020–FR-026; GATE-5 prerequisite; AD-6, AD-13; NFR-RPE-003–NFR-RPE-014; SM-INT-001.

### Story 7.8: Prove GATE-5 and Enable Only Evidence-Bound RPE Use

As the Product Owner,
I want reproducible held-out RPE evidence bound to exact model and support versions,
So that confirmation and auto-use eligibility exist only where accuracy, calibration, burden, drift, and resource gates pass.

**Acceptance Criteria:**

**Given** Story 7.7 is frozen
**When** the owned `GATE-5 RPE Physical-Device Evidence Record` is produced
**Then** it binds preregistration, immutable predictions/labels, model/support versions, devices/OS, raw result files, environment, and digests
**And** contains machine-readable outputs rather than a pass assertion.

**Given** final holdout is evaluated
**When** all thresholds are checked
**Then** baseline improvement, within-±1 and exact accuracy, calibration/risk-coverage, subgroup/missing-signal/resource slices, and prompt/correction burden must all pass as frozen
**And** abstentions and misses remain in their preregistered denominators.

**Given** any required slice, burden, resource, or holdout gate fails or is missing
**When** eligibility is computed
**Then** RPE auto-use remains disabled for that row and the exact failure is published
**And** passing neighboring rows do not enable it.

**Given** evidence passes and the Product Owner accepts its digest
**When** enablement is stored
**Then** only matching rows become eligible for verification and later explicit-user auto-use consent
**And** Gate passage alone never turns tracking or auto-use on.

**Given** model, threshold, eligibility, device/OS, support, or protocol changes
**When** a prediction is requested
**Then** previous evidence is invalid and the row returns to disabled pending new evidence.

**Traceability:** FR-020–FR-026; GATE-5 evidence and eligibility enablement; AD-6, AD-13; NFR-RPE-003–NFR-RPE-014, NFR-COMPAT-001, NFR-RES-001–NFR-RES-002.

### Story 7.9: Complete the Five-Estimate RPE Verification Window

As a trainee,
I want the first five eligible RPE estimates confirmed or corrected,
So that the system proves it understands my effort before offering reduced confirmation.

**Acceptance Criteria:**

**Given** RPE tracking is enabled and the exact GATE-5 row is eligible
**When** an estimate qualifies before its label is revealed
**Then** it enters the first five chronological eligible predictions with model/confidence/provenance frozen
**And** abstention or later correction cannot remove it from the denominator.

**Given** an eligible estimate is ready
**When** `restSafeForInteraction` is reached
**Then** the user can confirm or correct integer RPE 1–10 in a concise prompt within the shared interruption budget
**And** only confirmed/corrected values become Actual RPE labels.

**Given** five eligible predictions are resolved
**When** at least four are within ±1
**Then** the system may offer—but never silently enable—routine-confirmation disablement
**And** exact-match and within-±1 results are reported separately.

**Given** at least two of five predictions are wrong
**When** the threshold is reached
**Then** calibration uses only corrected labels and a new five-estimate window begins
**And** auto-use remains disabled.

**Given** the window is interrupted, recovered, or replayed
**When** state resumes
**Then** prediction order, denominator, labels, and outcome remain idempotent without duplicate prompts or estimates.

**Traceability:** FR-021–FR-023, FR-025–FR-026; AD-2, AD-6, AD-14; NFR-RPE-005–NFR-RPE-008, NFR-RPE-011–NFR-RPE-012; SM-INT-001.

### Story 7.10: Explicitly Enable RPE Auto-Use with Abstention and Drift Recovery

As a trainee,
I want to explicitly enable high-confidence RPE auto-use after verification and return to verification when trust drifts,
So that automation remains correctable and never fabricates effort when confidence or signals are insufficient.

**Acceptance Criteria:**

**Given** Story 7.9 passes and matching GATE-5 evidence remains valid
**When** the user receives the offer
**Then** auto-use remains off until separate explicit consent identifies eligible rows, model/rule versions, correction path, and revocation
**And** declining preserves confirmation/manual behavior.

**Given** auto-use is enabled and an eligible high-confidence estimate is produced
**When** the Actual Set commits
**Then** predicted, auto-used, and effective RPE plus model/confidence/provenance are saved distinctly
**And** the user can correct the value afterward.

**Given** confidence is low, signals are missing, the Exercise/configuration is unfamiliar, support/evidence is stale, or drift is suspected
**When** an estimate resolves
**Then** the system abstains or requests confirmation at safe rest within budget
**And** it never fabricates Actual RPE.

**Given** two corrections occur in any rolling five auto-used eligible estimates
**When** the second correction commits
**Then** auto-use disables immediately and a new five-estimate verification window begins
**And** prior confirmed/corrected labels remain auditable.

**Given** the user revokes tracking or auto-use
**When** revocation commits
**Then** future estimation/use stops for the selected scope without changing existing Actual facts or other workout capture.

**Traceability:** FR-024–FR-026; AD-2, AD-6, AD-14; NFR-RPE-003, NFR-RPE-006, NFR-RPE-009–NFR-RPE-014; SM-INT-001.

### Story 7.11: Keep the Forgotten-Finish Candidate Disabled

As a trainee,
I want forgotten-Finish logic unable to finish or prompt while unqualified,
So that long rests, equipment waits, and low-motion work never end my session.

**Acceptance Criteria:**

**Given** GATE-6 is open
**When** a session is active
**Then** manual Finish is normal and authoritative and no automatic Finish path exists
**And** the candidate reminder switch is independently disabled.

**Given** experimental Product Owner testing is approved
**When** the candidate evaluates sustained recovery and sustained absence of strength activity
**Then** both signals must remain true for the frozen candidate 15-minute window, missing signals suppress eligibility, and output remains internal
**And** it cannot display a prompt or change session state.

**Given** a long rest, equipment wait, low-motion Exercise, disconnect, runtime stop, or inactivity occurs
**When** the candidate observes it
**Then** the session remains active or in its truthful recovery state
**And** no event is mapped to completion.

**Given** candidate processing fails or consumes resources
**When** degradation occurs
**Then** it stops before manual recording or durable session facts are affected.

**Traceability:** FR-004, FR-005; GATE-6 disabled candidate; AD-6; NFR-SESSION-001–NFR-SESSION-003, NFR-RES-001; UX-DR17.

### Story 7.12: Freeze the GATE-6 Reminder Preregistration

As the Product Owner,
I want the forgotten-Finish protocol and false/missed thresholds frozen before physical-device results,
So that reminder enablement cannot ignore realistic long-rest and low-motion failures.

**Acceptance Criteria:**

**Given** GATE-6 is open
**When** the owned `GATE-6 Forgotten-Finish Preregistration Record` is frozen
**Then** it names participants/sessions, devices/OS, personalization, signal eligibility, missing-signal behavior, 15-minute dual-signal candidate, 15-minute Continue cooldown, versions, and digests.

**Given** outcome criteria are defined
**When** the record is reviewed
**Then** false-reminder and missed-reminder thresholds, confidence intervals, denominators, and separate long-rest, equipment-wait, low-motion, disconnect, and ordinary-finish slices are numeric and complete
**And** no automatic-Finish success metric exists.

**Given** interaction is specified
**When** reminder UX is frozen
**Then** only Finish and Continue are allowed, the prompt waits for safe interaction, and it participates in the shared interruption budget
**And** missing signals suppress rather than accelerate the prompt.

**Given** required decisions are missing or changed after evidence access
**When** Gate state is assessed
**Then** GATE-6 remains disabled or requires a new untouched evaluation
**And** manual Finish remains available.

**Traceability:** FR-005; GATE-6 prerequisite; AD-6, AD-13; NFR-SESSION-002–NFR-SESSION-005; SM-INT-001.

### Story 7.13: Prove GATE-6 and Enable a Conservative Finish-or-Continue Prompt

As a trainee,
I want a forgotten-Finish question only after physical-device evidence passes and both frozen conditions remain true,
So that I can choose Finish or Continue without the app ending my workout automatically.

**Acceptance Criteria:**

**Given** Story 7.12 is frozen
**When** the owned `GATE-6 Forgotten-Finish Physical-Device Evidence Record` is produced
**Then** it binds preregistration, build, devices/OS, immutable session outcomes, raw result files, resource measurements, versions, owners, and digests
**And** includes machine-readable long-rest, equipment-wait, low-motion, missing-signal, disconnect, false, and missed results.

**Given** any frozen threshold, slice, resource criterion, or physical-device requirement fails or is missing
**When** evidence is assessed
**Then** GATE-6 remains disabled and no reminder is user-visible
**And** manual Finish remains the only supported finish path.

**Given** all evidence passes and the Product Owner accepts its digest
**When** the exact device/OS configuration is enabled
**Then** a reminder becomes eligible only after both sustained recovery and sustained no-strength activity remain true for 15 minutes with required signals present
**And** any version/configuration change disables it pending new evidence.

**Given** eligibility occurs during unsafe interaction or after the shared prompt budget is exhausted
**When** the UI considers presentation
**Then** the reminder is deferred or suppressed and never blocks set recording or manual Finish.

**Given** the prompt is presented
**When** the user chooses Continue or Finish
**Then** Continue keeps the session active and starts the 15-minute cooldown, while Finish enters the ordinary explicit manual-Finish confirmation
**And** dismiss, timeout, app termination, or no response never finishes the workout.

**Given** VoiceOver, large text, reduced motion, or disabled haptics is used
**When** the reminder appears
**Then** reason, current session state, Finish, and Continue remain readable and operable without color, motion, haptic, gesture, or Crown-only access.

**Traceability:** FR-005, FR-011; GATE-6 evidence and enablement; AD-6, AD-13–AD-14; NFR-SESSION-001–NFR-SESSION-005, NFR-COMPAT-001, NFR-RES-001–NFR-RES-002; SM-INT-001; UX-DR10, UX-DR14, UX-DR16–UX-DR20.

## Epic 8: Complete a Controlled Post-Session Review and Reuse the Private Alpha

After a completed session, the Product Owner can accept, defer, or disable one non-blocking review invitation and, when accepted, enter the existing authorized diff-and-approval path without hidden data use or mutation. The Product Owner can then repeatedly complete the full conversation-to-Plan-to-workout-to-Analysis loop across accessible native iPhone and Watch surfaces; S7 closes migration, fault, size, privacy, paired-device, and physical-device evidence without discoverable deferred placeholders or optimistic state claims.

### Story 8.1: Offer Review, Later, or Disable Once per Completed Session

As a trainee,
I want at most one non-blocking post-session review invitation,
So that I can choose Review, Later, or Disable without any hidden send, proposal, approval, or Plan change.

**Acceptance Criteria:**

**Given** a session has durably finished and its local result is available
**When** invitation eligibility is evaluated
**Then** at most one invitation is associated with that canonical Workout Session and completion revision
**And** duplicate Finish, transfer replay, correction, restart, or device reconnection cannot create another invitation for the same eligibility event.

**Given** the invitation is displayed or dismissed
**When** no action is selected
**Then** no remote data is prepared or sent and no authorization, proposal, approval, or Plan mutation is created
**And** completed workout facts remain unchanged.

**Given** the user selects Later
**When** the decision commits
**Then** a bounded non-blocking deferral state is stored idempotently without creating AI work
**And** any later reappearance follows the frozen cadence rather than active-session prompting.

**Given** the user selects Disable
**When** the preference commits
**Then** future invitations stop until the user explicitly re-enables them in settings
**And** ordinary user-invoked review remains available.

**Given** the invitation appears under accessibility settings
**When** Review, Later, or Disable is used
**Then** it is nonmodal, focus-safe, readable at large Chinese text, and operable without color, motion, haptics, gesture, or timeout dependence.

**Traceability:** FR-091; AD-2, AD-14; UX-DR9, UX-DR10, UX-DR13–UX-DR16, UX-DR18–UX-DR19.

### Story 8.2: Route Accepted Review Through Existing Authorization and Approval

As a trainee,
I want accepting the invitation to enter the ordinary evidence, authorization, proposal, diff, and approval flow,
So that proactive entry never creates a privileged shortcut or hidden state.

**Acceptance Criteria:**

**Given** the user selects Review in Story 8.1
**When** the review route opens
**Then** it begins Story 2.10 with the source session visible and no preselected remote categories
**And** displaying the route itself sends nothing.

**Given** source facts are selected
**When** evidence eligibility is calculated
**Then** only confirmed/corrected effective records and concise user feedback are eligible
**And** incomplete, pending, conflicted, excluded, or raw data remains omitted and disclosed.

**Given** a remote request is desired
**When** the user continues
**Then** exact Story 2.7 one-shot authorization and any applicable GATE-3 Health authorization are required
**And** prior invitation, HealthKit permission, or previous consent cannot substitute.

**Given** a proposal is produced
**When** the user reviews it
**Then** the ordinary Story 2.11–2.14 validation, safety, complete diff, explicit approval, and atomic commit apply without bypass
**And** cancel, rejection, failure, or timeout preserves the active Plan and workout facts.

**Given** the route is restored after interruption
**When** the app resumes
**Then** non-effective input and source context can be restored while any stale authorization or proposal is invalidated according to its digest/base/version rules.

**Traceability:** FR-059, FR-082, FR-086, FR-091; AD-7–AD-9, AD-14; NFR-AI-002, NFR-AI-004–NFR-AI-005; UX-DR2, UX-DR9, UX-DR12, UX-DR15, UX-DR19.

### Story 8.3: Prove the Full Private-Alpha User Loop Without Manual Rebuilding

As the Product Owner,
I want to repeatedly complete the full private-Alpha loop on supported iPhone and Watch hardware,
So that the product proves its core value without manual database repair, payload reconstruction, or another primary recorder.

**Acceptance Criteria:**

**Given** a clean private-Alpha installation and supported paired devices
**When** the owned `S7 Private-Alpha End-to-End Evidence Record` is executed
**Then** it covers bounded conversation, exact authorization, complete proposal review, explicit approval, atomic Plan commit, compatible Watch delivery, Watch or phone execution, durable Actual Set return, correction, History, Analysis, and explicit evidence-bounded revision
**And** no step requires manual payload, database, Plan, or transfer reconstruction.

**Given** optional AI, Health, recognition, RPE, reminder, or network capability is disabled or fails
**When** the loop continues
**Then** the last durable Plan and Epic 1 manual local capture remain usable
**And** each unavailable capability reports its literal independent state.

**Given** the same loop is repeated across the declared Alpha migration path
**When** local stores, schema, catalog, support, model, and policy versions change through supported migrations
**Then** durable facts, identities, provenance, pending/conflicted state, approvals, and replay tombstones remain interpretable
**And** historical records are never silently reinterpreted.

**Given** the Product Owner runs the Alpha as the default recorder over the preregistered observation period
**When** continuation is measured
**Then** cohort, denominator, exclusions, competing-recorder definition, and observation window follow the frozen SM-RET-001 protocol
**And** results are recorded without converting a single-user observation into a broader claim.

**Given** the end-to-end record is reviewed
**When** any step is manual-only, pending, stale, partial, conflicted, failed, or unsupported
**Then** that state remains visible and cannot be reported as completed automation or success.

**Traceability:** SM-E2E-001, SM-RET-001, SM-ALPHA-CORE-001; AD-13; NFR-RECOV-001, NFR-COMPAT-002, NFR-AI-003–NFR-AI-004, NFR-HK-001; UX-DR12, UX-DR17, UX-DR19–UX-DR20.

### Story 8.4: Close Fault, Compatibility, and Paired-Device Evidence

As the Product Owner,
I want reproducible fault and physical-device evidence for every supported configuration,
So that support is based on durable behavior under interruption rather than simulator or happy-path results.

**Acceptance Criteria:**

**Given** the Alpha support matrix names a device/OS pair
**When** the owned `S7 Fault and Compatibility Evidence Record` is assembled
**Then** that exact physical iPhone/Watch pair executes start, set save, correction, Finish, Plan delivery, Actual Set return, recovery, and replay scenarios
**And** simulator evidence cannot establish support.

**Given** fault injection runs
**When** termination, restart, battery/sensor interruption, disconnect, partial write, duplicate, delay, reordering, missing chunk, revoked pairing epoch, and concurrent sessions are simulated
**Then** every reliably committed fact takes effect exactly once, no later correction rolls back, and unsafe conflicts remain visible for explicit resolution.

**Given** each supported Watch/OS pair runs the frozen 90-minute/20-set protocol
**When** resource results are measured
**Then** resource termination and recorded-information loss are zero, p95 Start/correction/Finish interaction is at most one second, and battery, thermal, memory, and interactions over two seconds are reported
**And** optional automation is disabled before core recording is compromised.

**Given** a configuration or requirement fails
**When** support state is published
**Then** it becomes unsupported or manual-only with the exact failed function and evidence version
**And** passing configurations do not lend support to it.

**Given** tests are rerun
**When** build, device/OS, schema, catalog, model, or protocol changes
**Then** prior evidence is invalidated for affected rows and default-disabled/manual fallback applies until new evidence passes.

**Traceability:** AD-4–AD-6, AD-13; NFR-RES-001–NFR-RES-002, NFR-RECOV-001, NFR-COMPAT-001–NFR-COMPAT-002; SM-COMP-001, SM-PRES-001.

### Story 8.5: Publish Size, Privacy, Security, and Release-Control Evidence

As the Product Owner,
I want one version-bound release-control record for bundle size, data handling, secrets, logging, and Gate state,
So that a private-Alpha build cannot ship with hidden media, credentials, remote use, or unsupported release claims.

**Acceptance Criteria:**

**Given** a candidate Alpha build is archived and thinned
**When** the owned `S7 Size Privacy and Security Evidence Record` is generated
**Then** it reports iPhone download and installed sizes separately with thinned installed variant at most 500 MB
**And** reports Watch uncompressed size below 75 MB, internal installed target at most 25 MB, all Watch ML assets at most 6 MB, and RPE component at most 2 MB using Xcode/App Store Connect thinning evidence rather than debug/archive size.

**Given** bundle contents are inspected
**When** size and licensing checks run
**Then** Watch contains no rich teaching images or nonessential media, no unlicensed media ships, and no unsupported wrist-only full-body-form claim appears
**And** every bundled model/catalog/support asset has a version and purpose.

**Given** privacy and storage checks run
**When** local stores, files, telemetry, diagnostics, backups, and remote payloads are inspected
**Then** data classes are purpose-separated and minimized, raw motion/heart-rate remains local by default, sensitive stores/secrets are backup/diagnostic excluded, and secrets remain in device-local non-synchronizing Keychain
**And** telemetry is opt-in and content-free.

**Given** compile, domain, schema, safety, persistence, sync, AI, and secret checks execute
**When** any required check or Gate is failed/open
**Then** only its named path remains disabled, the release record states the exact result, and no optimistic release conclusion is produced
**And** manual local capture remains available.

**Given** development, private-Alpha, and future-production environments are inspected
**When** credentials and data are compared
**Then** they are isolated with no production credential in an Alpha build and no account/cloud feature implied by deferred placeholders.

**Traceability:** AD-13; NFR-SIZE-001–NFR-SIZE-005, NFR-PRIV-001, NFR-PRIV-003, NFR-PRIV-007, NFR-SEC-003, NFR-SAFE-001; FR-047, FR-053; UX-DR17.

### Story 8.6: Validate the Complete Accessible Native Experience and Alpha Feedback Loop

As the Product Owner,
I want the complete native iPhone and Watch experience validated with accessible states and disciplined feedback evidence,
So that the Alpha is reusable in real gyms without placeholders, hidden failures, or inaccessible critical actions.

**Acceptance Criteria:**

**Given** all private-Alpha surfaces are built
**When** the owned `S7 Accessibility UX and Feedback Evidence Record` is executed
**Then** it covers Plan, AI conversation/authorization/review/commit, phone and Watch workout, History, Analysis, Health, Plan exchange, proactive review, sync, recovery, and support-boundary components
**And** every ready/loading/empty/offline/pending/stale/partial/conflicted/invalid/unsupported/failed/cancelled/incomplete/recovery state has literal semantics and recovery where applicable.

**Given** iPhone 11 through larger phones and supported Watches are tested
**When** light/dark, Increase Contrast, Differentiate Without Color, Reduce Motion, Reduce Transparency, at least 200% iPhone text, at least 140% Watch text, largest Chinese content, VoiceOver, Full Keyboard Access, and disabled haptics are used
**Then** critical values, consequences, digests, and actions do not truncate or require horizontal scrolling
**And** no critical function relies only on color, motion, haptic, gesture, or Crown.

**Given** physical gym use is evaluated
**When** glanceability, Always On, sweat/one-hand input, Crown/touch equivalence, lighting, P3/sRGB contrast, chart targeting, offline, replay, and reconnect scenarios run
**Then** each supported path meets its frozen acceptance result or is explicitly unsupported/manual-only
**And** one primary consequential action and at least 44 by 44 point controls with 8 point separation remain where required.

**Given** critical or recurring core-trust feedback is collected
**When** the feedback record is updated
**Then** severity, recurrence, cohort/denominator, cadence, owner, decision, closure evidence, and affected requirement are recorded under a preregistered SM-FEED-001 protocol
**And** anecdotes are not silently converted into resolved metrics.

**Given** deferred public-beta, Post-MVP, or V2 features are inspected
**When** Alpha navigation and components are reviewed
**Then** no discoverable placeholder, disabled teaser, account/cloud promise, voice entry, named third-party format, or link/QR sharing surface ships
**And** concise support boundaries identify what is actually available.

**Given** the complete record passes
**When** Alpha readiness is reported
**Then** conclusions are limited to tested Product Owner scope, devices, versions, Gates, and evidence
**And** any failed item remains open without being hidden by overall success language.

**Traceability:** AD-14; NFR-UX-001; SM-FEED-001, SM-ALPHA-CORE-001; UX-DR1–UX-DR20.

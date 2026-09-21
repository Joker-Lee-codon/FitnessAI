# FitnessAI Native UI Architecture Handoff

## Document State

- Stage: `ND-04 Handoff`
- State: accepted and frozen by the Product Owner on 2026-09-12
- Date: 2026-09-12
- Selected direction: `Training Ledger`
- Frozen design tokens: `0.2.0-nd02-accepted`
- Scope: iPhone and Apple Watch private-Alpha native UI, plus explicit public-beta boundaries already required by the PRD

## Handoff Verdict

The Product Owner accepted this native UI package on 2026-09-12. It passes the specification-level quality gates and is ready for Architecture. No unresolved visual decision blocks architecture work. Physical-device, model, reminder, security, and backend gates remain owned release evidence rather than assumed UI proof.

The implementation invariant is simple: a screen may describe only an acknowledged durable fact. A tap, sensor inference, AI output, transfer attempt, or external write is never styled as complete before its authoritative boundary confirms it.

## Authority and Data Boundaries

```text
Plan proposal ──user approval──> local Plan Revision ──complete delivery──> Watch snapshot
                                                                  │
Watch interaction/inference ──local commit──> Actual Set/Session ──idempotent return──> iPhone
                                                                  │
                                      optional, separately confirmed copies
                                      ├─ Apple Health
                                      └─ China-region application backend
```

1. User-confirmed and user-corrected values outrank AI, sensor, voice, import, synchronization, and recovery drafts.
2. Plan, proposal, revision, delivery, Start snapshot, Actual Set, Workout Session, return, HealthKit write, and cloud restore are distinct typed states.
3. Watch local commit is authoritative for an active workout. iPhone receipt, HealthKit write, and cloud synchronization cannot revoke it.
4. A proposal never mutates an effective Plan until complete review, explicit approval, atomic local commit, and separately observable Watch delivery.
5. Historical Actual Sets and completed or active sessions are immutable under later Plan revisions.
6. Every durable or derived record retains the producing schema, app, catalog, support-matrix, and model versions when applicable.

## Surface and Navigation Contract

| Domain | Surfaces | Architecture contract |
|---|---|---|
| Watch workout | `WC-01`–`WC-06` | Typed shallow routes; one primary action; rest-safe prompts; local-first idempotent commit and recovery. |
| iPhone review | `IR-01`–`IR-03` | Today/Plans, Session Review, and History preserve Plan/Actual provenance, incomplete facts, filters, and source versions. |
| iPhone planning | `PA-01`–`PA-03` | Plan revisions, evidence-bounded Analysis, and bounded Exercise catalog remain separate domains. |
| System | `SY-01`–`SY-06` | Persistence, delivery, account, authorization, HealthKit, import/export, and capability states name the exact boundary. |
| Remaining private-Alpha IA | AI Plan Chat, Proposal Review, Approval/Commit/Delivery, phone-only Active Workout, Revision Proposal Review | Implement from the frozen closure contract; do not invent new visual grammar or merge approval with generation. |

Architecture may choose the root iPhone container, but it must preserve native Back behavior, deep links to exact failures, restoration of scroll/filter/draft context, and the conceptual separation above. A permanent tab bar is not a design requirement.

## Functional Traceability

| Requirement group | Native UI disposition |
|---|---|
| `FR-001–007` | Workout start, durable set/session commit, Finish, incomplete completion, and review: `WC-01`, `WC-02`, `WC-05`, `IR-02`. |
| `FR-008–015` | Recognition capability, abstention, correction, and prompt timing: `WC-02`, `WC-04`, `PA-03`, `SY-06`. |
| `FR-016–027` | Actual values, RPE provenance/verification, manual fallback, and corrections: `WC-02`–`WC-04`, `PA-02`, `SY-06`. |
| `FR-028–035` | Plan receipt, snapshot, workout summary, and planning continuity: `WC-01`, `IR-01`, `PA-01`, `PA-03`. |
| `FR-036–041` | History, Analysis, source labels, body-area derivation, and Session Review: `IR-02`, `IR-03`, `PA-02`. |
| `FR-042–048` | Account and cross-device restoration boundaries: `IR-01`, `IR-03`, `SY-01`, `SY-02`; private Alpha retains local use without account dependency. |
| `FR-049–053` | Exercise catalog and support/capability disclosure: `PA-03`, `SY-06`. |
| `FR-054–060` | AI plan conversation, safety stop, proposal review, approval, and revision: `PA-01`, `SY-03`, Remaining private-Alpha IA. |
| `FR-061–066` | Correction authority, interruption, recovery, and exactly-once continuity: `WC-03`, `WC-05`, `WC-06`, `IR-02`, `SY-01`. |
| `FR-067–070` | Sign-out, deletion, tombstone, and account continuity: `IR-03`, `SY-01`, `SY-02`. |
| `FR-071–073` | Bounded Plan export/import and mapping: `PA-01`, `SY-05`. |
| `FR-074–077` | Post-MVP voice and sharing remain deferred with no discoverable route or placeholder. |
| `FR-078–087` | Remote-AI request scope, one-shot authorization, proposal integrity, and audit: `PA-01`, `SY-02`, `SY-03`, Remaining private-Alpha IA. |
| `FR-088–090` | Optional, least-privilege Apple Health read/write with local fallback: `IR-02`, `SY-04`. |
| `FR-091` | Non-blocking post-session review invitation: `IR-02`, `PA-02`, `SY-06`. |

## Nonfunctional Traceability

| Requirement group | Implementation and evidence boundary |
|---|---|
| `NFR-SIZE-001–005` | Use native components and symbols, lazy-load bounded media, and measure thinned iPhone/Watch/model artifacts in CI and release candidates. |
| `NFR-RPE-001–014` | `WC-04`, `PA-02`, and `SY-06` expose provenance, consent, verification, correction, abstention, and drift; model owner supplies version-frozen holdout evidence. |
| `NFR-SESSION-001–005` | `WC-05` preserves manual Finish and two-signal reminder choice; Product/UX owners pre-register operating thresholds before physical validation. |
| `NFR-RES-001–002` | Active workout views avoid decorative animation and chatty updates; QA supplies 90-minute physical-device resource evidence. |
| `NFR-REC-001–002` | Unsupported or low-confidence recognition visibly degrades to manual/pending; model owner supplies whitelist evidence. |
| `NFR-RECOV-001`, `NFR-COMPAT-001–002` | Stable event identities, idempotent replay, version retention, and the physical support matrix are architecture and QA obligations. |
| `NFR-PRIV-001–007`, `NFR-SEC-001–003` | `SY-02` and `SY-03` expose scope and consequences; Architecture must enforce data classification, China-region boundaries, secure storage/authentication, audit, and exclusion from consumer cloud backup. |
| `NFR-SAFE-001`, `NFR-AI-001–006` | Complete diff, explicit approval, schema/safety validation, atomic idempotent commit, immutable audit data, and local fallback are mandatory. Professional review remains a release gate. |
| `NFR-PORT-001` | `SY-05` treats files as untrusted, bounded input and atomically creates a new draft only after validation. |
| `NFR-VOICE-001`, `NFR-SHARE-001` | Post-MVP only; no first-build routes. Preserve requirements for later re-entry. |
| `NFR-HK-001–002` | `SY-04` makes each HealthKit capability and write result observable; local FitnessAI records remain complete without HealthKit. |
| `NFR-UX-001` | All private-Alpha surfaces inherit Light/Dark, Dynamic Type, VoiceOver, Reduce Motion, non-color state, loading, empty, offline, failure, incomplete, conflict, and recovery contracts. |

## SwiftUI and Design-System Contract

- Generate `Color`, typography, spacing, radius, motion, haptic, and platform aliases from `tokens.json`; do not copy raw hex values into feature views.
- Preserve semantic components: `training-rail`, `durable-state-label`, `actual-set-primary-action`, `metric-stepper`, `rest-resolution-banner`, and `recovery-action-group`.
- Prefer `NavigationStack`, typed routes, native sheets, native file picker, Share Sheet, standard controls, and semantic accessibility actions.
- Use stable domain identity as list identity. Never key durable objects by display order, timestamp alone, or localized copy.
- Domain acknowledgements drive state transitions. Views never infer commit, receipt, authorization, HealthKit completion, or conflict resolution from elapsed time.
- Crown input is optional acceleration only; visible controls and accessibility adjustable actions provide equivalent operation.
- Animation is causal, interruptible, and nonessential. Reduce Motion replaces spatial movement with immediate state change or a short opacity transition.

## Reusable State Machine

Every durable action should be representable as:

```text
idle → editing → submitting → locallyCommitted
                  └─ failed(inputRetained, exactBoundary, retryToken)

locallyCommitted → deliveryPending → delivered
                         └─ deliveryFailed(localTruthRetained, retryToken)
```

Conflict, incomplete, permission-unavailable, unsupported, detached external copy, and recovery are typed states, not message strings. Retrying is idempotent and scoped to the failed boundary. Destructive operations name exact objects and synchronized consequences, require explicit confirmation, and never reuse approval styling.

## Accessibility and Localization Acceptance

- Dynamic Type must reflow without truncating Exercise names, Actual values, units, unresolved counts, or destructive consequences.
- VoiceOver reading order is context → durable state → current value/uncertainty → consequence → action. Ordinary sensor or pending updates do not steal focus.
- Every state uses literal text plus shape/symbol; color and haptics are redundant signals.
- Minimum iPhone touch targets are 44×44 pt. Watch actions occupy practical full-width targets and remain reachable in every supported orientation.
- English and Simplified Chinese must tolerate realistic expansion; measurements and dates use locale-aware formatting while stored canonical values remain unchanged.
- Reduce Motion, Increase Contrast, Differentiate Without Color, Bold Text, and Voice Control behavior must be included in preview and physical-device passes.

## Physical-Device and Release Gates

| Gate | Owner | Pass criterion |
|---|---|---|
| Watch layout matrix | iOS UI owner + QA | Every supported Watch size, wrist/Crown orientation, appearance, accessibility setting, and supported OS has no clipped fact/consequence and all primary/escape actions are reachable. |
| Workout endurance | Architecture owner + QA | On every supported Watch/OS pair, a 90-minute/20-working-set session has zero resource termination, zero committed-data loss, and p95 ≤1 s for Start, correction, and Finish; required telemetry is reported. |
| Recovery fault matrix | Architecture owner + QA | Termination, restart, battery interruption, sensor loss, disconnection, partial write, repeated transfer, and delayed/reordered delivery restore every committed item exactly once with the latest user correction effective. |
| Recognition whitelist | Model owner + Product Owner | Version-frozen device/Exercise/support rows independently pass registered classification, boundary, and repetition thresholds; all other cases visibly degrade to manual/pending. |
| RPE qualification | Model owner + Product Owner | Registered holdout, abstention, correction, prompt-burden, drift, and auto-use gates pass before verified automatic use is enabled. |
| Finish reminder | Product Owner + UX owner + QA | Registered two-signal thresholds pass long-rest, equipment-wait, low-motion, missing-signal, cooldown, false-reminder, and missed-reminder tests; no path auto-finishes. |
| Accessibility | iOS UI owner + QA | Critical flows complete with VoiceOver, largest supported Dynamic Type, Reduce Motion, Increase Contrast, Differentiate Without Color, and no Crown-only action. |
| Size/resource budget | Architecture owner | Thinned artifacts and embedded models meet the PRD budgets; bounded assets and runtime measurements are attached to the release record. |
| Privacy/security | Product Owner + security/privacy owners | Required data-purpose, consent, residency, retention, deletion/export, remote-AI, authentication, encryption, and incident-response records are approved for the target release. |
| AI plan safety | Product Owner + qualified reviewer | Versioned screening, warning, plan-safety, continuation, and escalation bundle is professionally reviewed and acceptance-tested before use beyond Product Owner testing. |

## Architecture Decisions Still Open

Architecture owns these decisions without changing the UI contract:

1. App/module boundaries, dependency injection, observation strategy, and domain state-machine implementation.
2. Local persistence technology, event/revision schema, migrations, idempotency keys, tombstones, and transactional boundaries.
3. Watch Connectivity transport, queueing, replay, deduplication, delivery receipts, and conflict storage.
4. China-region account/backend architecture for public beta; private Alpha must remain locally usable without it.
5. HealthKit query/write adapters, authorization-state observation, idempotent retry, and detached-copy audit.
6. Remote-AI gateway, request/digest binding, timeout/fallback, safety/schema validation, audit storage, and provider policy enforcement.
7. Model packaging, update strategy, on-device execution budgets, support-matrix versioning, and feature flags.
8. Root iPhone navigation container and deep-link registry; the frozen conceptual routes and restoration behavior cannot be collapsed.
9. Exact supported OS/device matrix and CI/physical-lab coverage beyond the frozen first evidence row.

## Explicitly Deferred Product Decisions

- `DV-001`–`DV-003`: pilot continuation, competitive positioning, and later review cadence.
- `DV-004`–`DV-006`: reminder, RPE, and expanded remote-AI operating points.
- `DV-007`: bounded Plan-file parser limits must be frozen before Story acceptance.
- `DV-008`–`DV-009`: later AI conversation form and explanation density; complete review and approval remain invariant.
- `DV-010`–`DV-012`: recognition whitelist, RPE automation mode, and later AI performance thresholds.

## Implementation Start Order

1. Establish domain identities, authority rules, state machines, and token generation.
2. Implement the Watch durable workout spine (`WC-01`–`WC-06`) with local persistence and recovery before sensors or AI.
3. Implement iPhone receipt, Session Review, History, and Sync & Recovery against real boundary states.
4. Add planning, proposal approval, delivery, Analysis, catalog, and bounded Plan exchange.
5. Add optional HealthKit, account/backend, and remote-AI adapters behind capability and authorization gates.
6. Run accessibility, localization, fault, resource, and physical-device matrices before enabling automatic recognition, RPE auto-use, or reminder candidates.

## Handoff Acceptance Gate

On 2026-09-12, the Product Owner accepted and froze this handoff as the native UI contract for Architecture. `ND-04` and the `bmad-native-ui-design` workflow are complete. This acceptance does not waive any owned physical-device, model, privacy/security, safety, or release gate listed above. The next workflow is `bmad-architecture`.

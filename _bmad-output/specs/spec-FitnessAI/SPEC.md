---
id: SPEC-FitnessAI
companions:
  - implementation-contract.md
  - verification-matrix.md
  - open-gates.md
  - ../../planning-artifacts/prds/prd-FitnessAI-2026-07-19/prd.md
  - ../../planning-artifacts/ux-designs/ux-FitnessAI-2026-07-20/EXPERIENCE.md
  - ../../planning-artifacts/ux-designs/ux-FitnessAI-2026-07-20/DESIGN.md
  - ../../planning-artifacts/architecture/architecture-FitnessAI-2026-09-09/ARCHITECTURE-SPINE.md
  - ../../planning-artifacts/native-ui-designs/native-ui-FitnessAI-2026-08-08/native-ui-spec.md
  - ../../planning-artifacts/native-ui-designs/native-ui-FitnessAI-2026-08-08/architecture-handoff.md
  - ../../../design-system/fitnessai/MASTER.md
sources: []
---

> **Canonical contract.** This SPEC and the files in `companions:` are the complete, preservation-validated contract for what to build, test, and validate. Source documents listed in frontmatter are for traceability only — consult them only if you need narrative rationale or prose color this contract intentionally omits.

# FitnessAI Private-Alpha Implementation SPEC

## Why

FitnessAI realizes a vision for mainland-China strength trainees: a native iPhone and Apple Watch product that converts bounded AI conversation into an executable Plan while preserving a complete, truthful workout record with minimal interruption. Trusted recording is the foundation; user-authoritative, reviewable AI Plan orchestration is the differentiator. This contract makes the confirmed Product, UX, and Architecture decisions directly implementable and independently verifiable.

## Capabilities

- **CAP-1 — AI Plan lifecycle**
  - **intent:** A trainee can create or revise a complete structured Training Plan through text AI, review every field or diff, and activate exactly one immutable Plan Revision only after digest-bound explicit approval.
  - **success:** Every valid approval produces one complete committed revision; no silent, stale, duplicate, or partial activation occurs.
- **CAP-2 — Paired-Watch workout**
  - **intent:** A trainee can execute a delivered Plan snapshot or ad-hoc workout on Apple Watch while facts save locally and remain usable offline.
  - **success:** The complete or visibly incomplete session survives disconnect, termination, restart, recovery, and replay with every committed fact present exactly once.
- **CAP-3 — Phone-only workout**
  - **intent:** A trainee without a Watch can run planned or ad-hoc sessions on iPhone using the same identities, states, corrections, and Analysis as paired capture.
  - **success:** Phone-only capture has parity of truth and recovery semantics without simulated Watch automation or a second domain model.
- **CAP-4 — Evidence-gated recognition**
  - **intent:** Qualified Watch configurations can assist Exercise classification, set boundaries, and rep counts with confidence, abstention, rapid correction, and manual fallback.
  - **success:** Each function independently passes its frozen PRD evidence gate; unsupported or uncertain paths never claim automatic success.
- **CAP-5 — Opt-in RPE assistance**
  - **intent:** A user can verify, correct, and later explicitly enable high-confidence RPE auto-use with provenance and drift recovery.
  - **success:** Predicted, confirmed, corrected, auto-used, and effective values remain distinct; only confirmed or corrected labels calibrate the model.
- **CAP-6 — Conservative Finish assistance**
  - **intent:** Watch can offer a forgotten-Finish prompt only after the qualified dual-signal window while manual Finish remains authoritative.
  - **success:** Missing signals suppress the prompt, Continue applies cooldown, and no inferred state ends a session automatically.
- **CAP-7 — Correction, recovery, and synchronization**
  - **intent:** Users can correct, split, merge, insert, delete, recover, transfer, and resolve conflicting workout facts without silent overwrite or duplication.
  - **success:** Append-only causal revisions preserve every user fact until a deterministic safe result or explicit iPhone resolution selects the effective revision.
- **CAP-8 — History and Analysis**
  - **intent:** Users can inspect complete History and weekly, monthly, and selected-Exercise Analysis derived from effective Actual Sets.
  - **success:** Output is current or explicitly stale, pending, partial, conflicted, or excluded; planned and semantically incomparable work never produce false aggregates.
- **CAP-9 — Apple Health interoperability**
  - **intent:** Users can grant least-privilege HealthKit capabilities, retain FitnessAI local authority, and separately preview selected local summaries for one-shot remote authorization.
  - **success:** Read, write, retry, and detachment states are observable, and real remote Health-summary traffic remains zero until its fail-closed gate passes.
- **CAP-10 — Bounded Plan exchange**
  - **intent:** Users can export one FitnessAI JSON Plan and import it only as a fully previewed independent draft.
  - **success:** No hidden data, parser abuse, silent omission, merge, overwrite, partial import, or activation occurs.
- **CAP-11 — Proactive post-session review**
  - **intent:** A completed session can offer one Review, Later, or Disable invitation that enters the existing authorization and proposal flow.
  - **success:** Displaying or dismissing the invitation sends no data and creates no authorization, proposal, approval, or mutation.
- **CAP-12 — Native usable experience**
  - **intent:** Every Alpha surface implements the accepted native navigation, Titanium Measure semantics, recovery states, and accessibility contract.
  - **success:** All required light/dark, Dynamic Type, VoiceOver, error, empty, loading, offline, and recovery states work without placeholder screens.
- **CAP-13 — Exercise catalog and support truth**
  - **intent:** Users can inspect canonical Exercise mappings, body-area and movement attributes, support boundaries, and concise owned or licensed teaching content.
  - **success:** Supported, limited, and manual-only status is explicit; no unlicensed media or wrist-only full-body claim ships.
- **CAP-14 — In-session Plan guidance and reconciliation**
  - **intent:** During and after a session, users can accept, edit, or reject next-set load suggestions and canonical substitute Exercises while planned and Actual facts remain separate.
  - **success:** No suggestion changes an Actual Set or future Plan without the required user action; rejected guidance preserves completed facts, and accepted future changes enter the ordinary complete-diff approval lifecycle.

## Constraints

- Build one local-first hexagonal modular monolith with separate iPhone and Watch targets and a local Swift Package; domain targets depend on no UI, database, device, Health, sensor, or AI-provider framework.
- Use Xcode 26.6, Swift 6.3.3, native SwiftUI with thin MVVM and explicit state machines, and system SQLite through exactly pinned GRDB 7.11.1.
- Stable IDs exist before persistence. Every user or approved-AI mutation is an append-only revision atomically committed with durable outbox and invalidations; UI success follows commit, and device time never decides truth.
- iPhone owns Plans, long-term records, complete conflict resolution, Analysis, AI, Health, and exchange. The chosen capture device owns the live session; its Plan snapshot is immutable after Start.
- Important iPhone–Watch content uses acknowledged causal transfer. Only compatible whole-object `applied` permits activation or cleanup; retries are idempotent.
- Manual local capture survives AI, HealthKit, Watch delivery, network, or optional automation failure. Unsupported or uncertain paths fail closed to manual or pending states.
- Alpha Watch automation starts only from the AD-6 Series 11 46 mm, orientation, handedness, and eight-Exercise evidence row; expansion requires independent physical-device evidence.
- Exercise, rep, load, and RPE confirmations share at most five proactive prompts in a representative approximately 20-set session and appear only at safe rest.
- Forgotten Finish requires 15 sustained minutes of both recovery and no strength activity, suppresses on missing signals, never auto-finishes, and cools down 15 minutes after Continue.
- Built-in Alpha AI is DeepSeek through a gated FitnessAI gateway. BYOK supports DeepSeek only with a device-local non-synchronizing Keychain secret and direct calls; arbitrary provider URLs are excluded.
- Each remote request consumes a one-shot authorization bound to route, provider, account, purpose, categories/window, outbound digest, policy version, and expiry. HealthKit permission and proposal approval cannot substitute.
- FitnessAI remains authoritative over HealthKit. Remote Health input is limited to user-selected local summaries, and real transmission remains disabled until the provider/legal/privacy/region/retention/training-use/deletion/revocation/user-rights gate passes.
- Plan exchange obeys every AD-10 JSON size, depth, count, note, mapping, metadata, and draft-only limit; executable content, external references, attachments, partial import, merge, overwrite, and activation are forbidden.
- Stores, sidecars, outbox, and chunks use `completeUntilFirstUserAuthentication` and are excluded from iCloud and ordinary backup; secrets use device-local non-synchronizing Keychain; an unreadable store is never replaced with an empty one.
- Titanium Measure semantic tokens and native platform behavior are presentation authority. iPhone top level is Plan, History, Analysis, and More with Plan as root; Watch stays shallow and task-specific.
- Release evidence covers compile, domain, schema, safety, persistence, synchronization, AI contract, secrets, migration, fault injection, accessibility, paired-device, and required physical-device tests; private-Alpha telemetry is off unless explicitly opted in.
- Size gates are: iPhone thinned installed variant ≤500 MB; Watch uncompressed <75 MB and installed target ≤25 MB; all Watch ML assets ≤6 MB; RPE assets ≤2 MB.

## Non-goals

- Public-beta application-cloud accounts, restoration, and China-region synchronization infrastructure in the private Alpha.
- Diagnosis, injury-severity assignment, rehabilitation prescription, unrestricted coaching, or full-body form claims from a single wrist.
- Automatic external-load sensing, automatic Start/Finish, or any AI mutation of active sessions or historical Actual Sets.
- Voice, continuous listening, arbitrary/self-hosted AI endpoints, arbitrary third-party Plan formats, server-backed links/QR sharing, Android, or discoverable placeholders for deferred features.
- Raw sensor or unrestricted HealthKit transfer to remote AI; clinical, medication, laboratory, reproductive, raw ECG, glucose, blood-pressure, and disease-specific HealthKit categories.
- Public-launch brand polish, broad device automation claims, or release conclusions based only on simulator evidence.

## Success signal

The Product Owner repeatedly completes conversation → complete review → explicit approval → atomic iPhone Plan Revision → paired-Watch or phone-only execution → durable Actual Sets → correction/History/Analysis → optional evidence-bounded revision without rebuilding items, losing facts, accepting silent mutation, or returning to another primary recorder. Every optional failure leaves the last durable truth and manual local capture usable.

## Assumptions

- `project-context.md` is absent; this SPEC assumes it contains no additional binding decision because repository `AGENTS.md` and all specified planning artifacts were available and fully read.

## Open Questions

- What numeric Alpha Plan Safety Rule Pack v1 bounds and golden fixtures will the Product Owner freeze before the first AI Plan Story?
- What current DeepSeek legal entity, runtime provider, processing region, subprocessors, retention/cache, training use, deletion/revocation, disclosure, endpoint, ceilings, rollback owner, and kill-switch record will be approved before built-in traffic?
- What written Apple health/fitness-purpose, processor/contract, privacy, cross-border, retention, deletion, revocation, and user-rights review will close the real Health-summary traffic gate?
- What frozen datasets, denominators, slices, confidence thresholds, RPE baseline/burden gates, and false/missed reminder thresholds will be preregistered before automation holdouts are viewed?
- What parser time and memory budgets will supplement the already frozen AD-10 structural limits before Plan import acceptance?

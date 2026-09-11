# FitnessAI Implementation Contract

## 1. Authority and Consumption

Read `SPEC.md` first, then every file in its `companions:` array. When wording conflicts, the 2026-09-10 Architecture Spine and its recorded Product Owner overrides win; otherwise use PRD → EXPERIENCE → DESIGN/Titanium Measure → native UI specification → architecture handoff. Preserve stable `CAP-*`, `FR-*`, `NFR-*`, `SM-*`, and `AD-*` identifiers in code, tests, fixtures, and review evidence.

## 2. Delivery Slices

| Slice | Demonstrable outcome | Exit condition |
|---|---|---|
| S0 — Contracts and repository seed | One Xcode workspace, iPhone/Watch targets, local package boundaries, platform-neutral schemas, IDs, units, errors, canonical serialization/digest profile, and golden vectors | Both apps compile; cross-target golden fixtures agree; dependency tests prove AD-1 |
| S1 — Durable manual iPhone loop | Planned/ad-hoc phone-only Start → Actual Sets → correction → Finish/Incomplete → History | Fault tests show local success only after commit, recovery without loss/duplicates, and no optional dependency blocks capture |
| S2 — Paired Watch manual loop | Full compatible Plan delivery → immutable Start snapshot → durable Watch sets → idempotent iPhone return | Disconnect/restart/replay/chunk fault tests preserve each fact exactly once; partial Plan never activates |
| S3 — AI Plan lifecycle | Text intake → one-shot authorization → structured draft/diff → Safety result → complete review → digest approval → atomic revision | Invalid/stale/changed proposals cannot commit; retries return the original result; last Plan stays usable on every failure |
| S4 — Correction, History, and Analysis | Field and topology corrections invalidate/recompute revision-bound read models | Conflicts remain visible; current/stale/pending states are truthful; formulas match PRD definitions |
| S5 — Health and Plan exchange adapters | Optional HealthKit context/copy and bounded JSON draft exchange behind ports | Local truth survives every adapter failure; remote Health is gate-disabled; import never mutates an existing Plan |
| S6 — Evidence-gated assistance | Qualified recognition, RPE verification, and forgotten-Finish behavior | Each function passes its own preregistered physical-device gate and can be independently disabled without blocking manual capture |
| S7 — Alpha closure | Complete native surfaces, accessibility, migration/fault evidence, size reports, and repeated owner workouts | `SM-COMP-001`–`SM-INT-001`, `SM-AI-001/002`, `SM-E2E-001`, and `SM-ALPHA-CORE-001` pass with counter-metrics reported |

Each slice is vertical and shippable to the Product Owner test environment. Do not scaffold discoverable deferred screens.

## 3. Domain and Persistence Contract

- Define separate domain, application-use-case, persistence-port, synchronization-contract, safety-rule, analysis, and adapter targets. UI models, database rows, wire payloads, AI payloads, and HealthKit models map at ports.
- Use a single normative revision DAG and effective-value reducer. A revision carries revision/event ID, object ID, canonical field path or operation kind, parent/head set, author device, resolution references, and applicable versions.
- Different-field edits may merge. Incomparable same-field writes and overlapping split/merge, insert/delete, reorder, completion, or Plan-topology operations conflict and stay visible. Resolution cites every resolved head. Missing parents remain pending.
- Critical transactions write fact, revision, outbox, and scoped invalidation together. A stable idempotency key returns the prior result on replay.
- iPhone and Watch use separate GRDB stores. Raw streams are protected files indexed by their owning store. Unacknowledged facts are never automatically deleted; optional raw or automation data degrades before user facts.
- Phone-only and paired sessions use the same contracts. A session keeps its originating global ID and immutable Plan snapshot; sessions are never merged by time.

## 4. Watch Runtime and Transfer Contract

- Continuous Watch capture uses `HKWorkoutSession` with workout processing, not `WKExtendedRuntimeSession` as a substitute. Runtime start, pause, failure, recovery, and end map to durable session states.
- Persist important outbound content to an outbox first. Use live messages only to accelerate, queued user-info for durable structured events, application context for replaceable latest state, and files for chunks.
- Replay identity is `(pairingEpoch, sourceDeviceId, messageId)`. Revoked-epoch input is quarantined for explicit recovery.
- Transfer manifests carry chunk IDs/counts/sizes/digests, whole-object digest, causality, and dependency/support versions. Acknowledgements are `received`, `durablyCommitted`, `applied`, or `rejected(reason)`.
- Watch activates a Plan only after the entire compatible revision and dependencies commit together. The active automation eligibility set freezes at Start except an emergency fail-closed disable.

## 5. AI, Authorization, and Safety Contract

- Treat provider output as untrusted typed input. A proposal includes immutable `proposalId`, base revision, provenance, permitted scope, assumptions, schema/model/rule-pack versions, canonical digest, and every structured Plan field or field-level change.
- Run the deterministic balanced Safety Rule Pack after generation and again before commit. Outcomes are pass, clarification/correction required, or affected-scope stop; unresolved results block Plan commit but never truthful workout capture.
- Approval UI exposes all added, removed, and changed fields, values and units, assumptions, warnings, scope, Safety result, base revision, and digest. Commit verifies an unconsumed proposal, exact displayed digest, unchanged Plan head, and unchanged policy versions; `proposalId` is the commit key.
- Built-in and BYOK DeepSeek routes have separate adapters and isolation identities. A route/account switch starts a new pseudonymous identity and never reuses conversation history.
- A remote send atomically matches and consumes its one-shot authorization. Audit records IDs, versions, categories, digest, status, and timing only—never content, secrets, or chain-of-thought.

## 6. Evidence-Gated Assistance Contract

| Function | Frozen Alpha behavior | Release evidence |
|---|---|---|
| Recognition | AD-6 device/orientation/handedness/eight-candidate row; classification, set boundary, and reps qualify independently; uncertainty waits for safe rest; manual fallback always exists | PRD §3.2 and NFR-REC frozen holdout, slices, denominators, confidence intervals, silent misses, false sets, and physical-device support matrix |
| RPE | Opt-in; integer 1–10; first five eligible estimates confirmed/corrected; ≥4 within ±1 can offer auto-use; ≥2 wrong recalibrates and restarts; two corrections in rolling five auto-used estimates triggers drift | Participant-held-out and chronological data, baseline improvement, risk–coverage, missing-signal, subgroup, prompt/correction burden, resource, and frozen holdout evidence |
| Forgotten Finish | Both recovery and no-strength-activity sustained 15 minutes; missing signals suppress; Finish/Continue only; Continue cooldown 15 minutes | Frozen personalization and false/missed thresholds tested against long rest, equipment waits, low-motion work, and physical devices |
| Shared prompting | Exercise, rep, load, and RPE proactive prompts share one session counter; representative approximately 20-set budget is five | Prompt source/count/correction counter-metrics reported with completeness and accuracy |

## 7. Apple Health Contract

- Implement the AD-9 versioned allowlist and exclusions exactly; authorization is capability-specific and optional. Expose only observable read states.
- FitnessAI session ID plus a locally allocated monotonically increasing export generation identifies intentional create/update copies. A versioned transition table governs create, update, delete, detach, relink, and self-authored retry.
- External absence or change becomes `healthKitDetached`; never recreate automatically. HealthKit failure cannot alter or block FitnessAI records or Analysis.
- Remote AI receives only the selected locally computed summary after a separate AD-8 preview/authorization. Keep the send path technically disabled until GATE-3 closes.

## 8. Plan Exchange Contract

- Export exactly one plain, uncompressed UTF-8 `.json` Plan with FitnessAI marker, format/catalog/source versions, source identity, full ledger, original load value/unit, and digest. Exclude sessions, health, account, secrets, authorizations, and sensors.
- Reject input over 2 MB, nesting over 12, more than one Plan, 366 days, 30 Exercises/day, 20 Sets/Exercise, 10,000 Sets total, or 2,000 characters/note.
- Validate syntax, schema, version, digest, duplicate identity/fingerprint, mapping, and Safety Rules before complete preview. Unknown required fields fail; known aliases map deterministically; optional unknown fields round-trip inertly or require itemized omission confirmation.
- Confirmation creates a non-effective draft with new local IDs. Activation still uses the ordinary proposal review and approval lifecycle.

## 9. Presentation Contract

- iPhone top level is Plan, History, Analysis, and More; all other destinations are typed contextual routes. Native back restores object identity, filters, scroll position, and unsent/non-effective input.
- Use Titanium Measure semantic tokens, one consequential primary action per state, and the fact → source/authority → durability → consequence/action display order. Local save never implies delivery or synchronization.
- Implement `AI-L01`–`AI-L05`, `PW-L01`–`PW-L02`, `HX-L01`, `AN-L01`, `HK-L01`, `PX-L01`, and `RV-L01` plus the Watch surfaces in the bilingual UX contract.
- Preserve input on failure; focus the error summary then recovery action. Provide non-color, non-motion, non-haptic, and non-Crown equivalents; charts have adjacent text and table alternatives; frequent or consequential controls are at least 44 × 44 pt.

## 10. Definition of Done

A capability is done only when its domain contract, persistence behavior, state transitions, error/recovery path, UI/accessibility states, automated tests, and required physical-device evidence all pass. Optional-adapter failure must leave the last durable truth and manual capture usable. Deferred gates block only their named risky path, never the local manual core.

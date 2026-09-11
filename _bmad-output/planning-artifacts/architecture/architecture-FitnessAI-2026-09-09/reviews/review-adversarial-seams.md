# Adversarial Seam Review — FitnessAI Architecture Spine

**Reviewer lens:** Assume two independent implementation units obey every stated AD, then look for remaining legal choices that can diverge at integration boundaries.

**Verdict:** **NEEDS FIXES**

The spine has strong ownership, local-first, durability, and approval principles, but several protocol-level invariants are still underspecified. The first six findings can produce silent data divergence, privacy bypass, or duplicate/stale AI commits even when both implementations honestly follow the current text.

## Findings

### 1. Critical — AD-2 / AD-4 / AD-11: no canonical revision ancestry, conflict predicate, or effective-value reducer

- **Severity:** Critical
- **Location:** AD-2 lines 37–41; AD-4 lines 49–53; AD-11 lines 91–95
- **Finding:** The spine requires field-scoped append-only revisions, different-field merge, same-field conflict, causality, and “effective” values, but does not bind the causal representation or the deterministic reducer. It also does not specify how create/update/delete/reorder operations on child entities interact, how a conflict-resolution revision cites all resolved heads, or what happens when a child arrives before its parent.
- **Divergent implementations:** Unit A uses a single `baseRevisionId` and treats edits with the same base as concurrent; Unit B uses per-field heads or a version vector. A delete-versus-edit or insert-versus-reorder can therefore be merged by one unit and surfaced as conflict by the other. Their Analysis views can include different “effective” sets while both avoid device time and arrival-order tie-breaking.
- **Actionable fix:** Bind one platform-neutral revision DAG/reducer in Contracts: immutable revision/event ID, object ID, field path or operation kind, parent/head set, author device, and resolution references. Define conflict as incomparable writes to the same canonical field/entity operation; define deterministic handling of missing parents, delete/edit and reorder semantics; require a resolution revision to cite every resolved head. Make the effective reducer and conflict fixtures normative across iPhone, Watch, import, and future Kotlin.

### 2. Critical — AD-7: approval is not transactionally bound to the current base and is not an idempotent command

- **Severity:** Critical
- **Location:** AD-7 lines 67–71
- **Finding:** The proposal carries `proposalId`, base revision, and digest, and approval creates a Plan Revision atomically, but the rule does not require a compare-and-swap against the current base inside that transaction, nor uniqueness/consumption of `proposalId`. “Content change invalidates approval” is insufficient for a concurrent manual edit or a retried/double-tapped approval.
- **Divergent implementations:** Unit A checks the base when displaying review and later commits after the Plan changed; Unit B checks at commit. Unit A can silently overwrite/branch from stale context. Separately, one unit deduplicates approval by `proposalId`, while another generates a fresh mutation ID for every tap and commits the same proposal twice.
- **Actionable fix:** Require the approval transaction to verify proposal status is unconsumed, displayed digest equals the canonical proposal digest, and current Plan head equals the approved base (or explicitly enter a visible conflict/rebase flow). Enforce a unique commit key on `proposalId`; retries return the original result. Any base, content, rule-pack, schema, model, or permitted-scope change invalidates approval.

### 3. Critical — AD-8: remote-send permission has no durable, one-shot authorization artifact

- **Severity:** Critical
- **Location:** AD-8 lines 73–77
- **Finding:** Every remote request must preview purpose/categories/window/provider/summary, but no invariant says the user’s allow/narrow decision is represented as a one-shot artifact cryptographically or transactionally bound to the exact outbound body and destination. It also does not forbid reusing a prior allowance after data, account, provider route, or summary changes.
- **Divergent implementations:** Unit A treats “Allow” as session-wide permission and sends later summaries without another preview; Unit B treats it as one request only. A provider adapter could regenerate the summary after approval or switch built-in/BYOK routing while still claiming the categories are unchanged.
- **Actionable fix:** Define a one-shot `RemoteUseAuthorization` with stable ID, exact provider/account/route, purpose, category/window selection, canonical outbound-body digest, policy version, creation/expiry, and consumed status. The send transaction must compare the exact body/destination to it and atomically consume it; any change requires a fresh preview and authorization. Explicitly state that OS/HealthKit permission and proposal approval cannot satisfy this artifact.

### 4. Critical — AD-4 / Consistency Conventions: digest and wire equivalence are not canonical

- **Severity:** Critical
- **Location:** AD-4 lines 49–53; conventions lines 115–123; Stack lines 126–137
- **Finding:** Envelopes and exchanged/AI objects carry a digest, but canonical serialization, hash algorithm/version, date/time/unit/number normalization, unknown-field treatment, and byte-versus-semantic digest scope are not bound. “Versioned schemas and golden fixtures” does not itself decide these rules.
- **Divergent implementations:** Unit A hashes pretty-printed JSON with decimal weights and ISO-8601 offsets; Unit B hashes canonical CBOR/JSON, binary floating point, and UTC. They reject each other’s valid payloads—or worse, validate different semantic content under locally computed digests. Approval display and commit may also digest different normalized forms.
- **Actionable fix:** Add a normative canonical-envelope contract: exact encoding profile, field ordering or canonicalization algorithm, integer/decimal representation, Unicode normalization, UTC/time-zone semantics, unit representation, unknown-field policy, digest algorithm plus version, and precisely which bytes/semantic fields are covered. Require golden vectors for encode/decode/digest across iPhone and Watch; the same canonical digest must bind display, approval, send, import, and commit where applicable.

### 5. High — AD-4: acknowledgement, chunk assembly, and Plan activation state machines are incomplete

- **Severity:** High
- **Location:** AD-4 lines 49–53
- **Finding:** Receipt requires validation, durable commit, and application acknowledgement, but ack identity/status, replay behavior, negative acknowledgement, retry termination, chunk manifest/completeness, and atomic Plan activation are unspecified. “Last complete compatible Plan” does not define completeness or how compatibility is negotiated.
- **Divergent implementations:** Watch Unit A acknowledges each chunk after file write and activates when all numbered chunks appear; iPhone Unit B interprets the first ack as whole-message receipt and deletes its outbox. Another Watch implementation may activate a Plan before dependent catalog entries arrive, while still considering the Plan itself complete.
- **Actionable fix:** Bind a transfer state machine with manifest ID, ordered chunk IDs/count/size/digests, whole-payload digest, dependency/support versions, and ack states (`received`, `durablyCommitted`, `applied`, `rejected` with stable reason). Only an idempotent whole-object `applied` ack permits sender cleanup/activation. Specify replay responses, missing-chunk recovery, timeout/backoff, and that a Plan plus all required dependencies commits and swaps active revision in one transaction.

### 6. High — AD-3 / AD-4: device replacement and pairing generation do not fence stale Watch writes

- **Severity:** High
- **Location:** AD-3 lines 43–47; AD-4 lines 49–53
- **Finding:** Device replacement is listed in `Binds`, and envelopes identify a source device, but no rule defines pairing identity/epoch, trust establishment, or whether an old Watch’s delayed outbox remains acceptable after replacement/unpairing. A digest detects corruption, not an authorized current counterpart or replay from an obsolete pairing.
- **Divergent implementations:** Unit A accepts every valid event for the session ID from any previously seen device; Unit B accepts only the current Watch. After replacement, delayed edits from the old Watch can resurrect or conflict with already resolved data on Unit A but be rejected on Unit B.
- **Actionable fix:** Introduce a persisted pairing generation/trust epoch in session and sync envelopes. Define which outstanding facts survive unpair/re-pair, how they are explicitly recovered, when an epoch is revoked, and how stale-device events are quarantined rather than silently applied. Bind replay protection to `(pairingEpoch, sourceDeviceId, messageId)` while preserving an auditable recovery path for genuinely unsent facts.

### 7. High — AD-3: offline session identity and recovery authority are ambiguous

- **Severity:** High
- **Location:** AD-3 lines 43–47; Capability Map lines 163–167
- **Finding:** The iPhone creates the shared session identity in paired use, while Watch owns offline facts and active-session recovery. The rule does not state whether Watch may start/recover when the phone is unavailable, how a provisional identity maps to the iPhone identity, or which terminal state wins after independent recovery.
- **Divergent implementations:** Unit A forbids Watch start without a delivered session; Unit B creates a Watch-local session and later imports it. If iPhone also starts a replacement session, one implementation merges the workouts and another creates two records. Finish/continue actions can likewise produce two terminal branches.
- **Actionable fix:** Bind the session lifecycle contract: allowed start paths, globally unique versus provisional IDs, a one-time alias/mapping operation, immutable Plan snapshot identity, state transitions, and conflict rules for start/finish/continue/recovery. Require every fact to retain its originating session ID and prohibit heuristic merge by timestamps.

### 8. High — AD-10: unknown-content and duplicate handling explicitly permits incompatible outcomes

- **Severity:** High
- **Location:** AD-10 lines 85–89
- **Finding:** “Unknown content is explicitly mapped, omitted, or rejected” leaves the exact choice to each importer, and “validates duplicates” does not say reject, warn, or import as a new draft. This conflicts with the stated prevention of silent omission and cannot be made interoperable by file format version alone.
- **Divergent implementations:** Importer A drops an unknown optional exercise attribute and presents a warning; Importer B rejects the same file. Importer A allows a duplicate as a fresh draft; Importer B blocks it based on source identity. Both comply, but users see different plans or lose metadata depending on implementation version/platform.
- **Actionable fix:** Make a versioned import decision table normative: unsupported required fields reject; supported aliases map deterministically; optional unknown fields are preserved as inert round-trip metadata or require an explicit per-item omission confirmation in the full preview; never omit silently. Define duplicate identity/fingerprint behavior and whether confirmation may create another draft. Add golden fixtures for every branch.

### 9. High — AD-9: HealthKit copy correction/version/detachment transitions are underspecified

- **Severity:** High
- **Location:** AD-9 lines 79–83
- **Finding:** Session ID/revision are used as HealthKit sync identity/version, but the document does not bind how non-numeric or branched revisions map to HealthKit’s monotonically increasing sync version, which local corrections update the copy, or how to distinguish an expected external change from deletion/corruption. `healthKitDetached` is named but its transition table is absent.
- **Divergent implementations:** Unit A writes every effective correction as a higher HealthKit sync version; Unit B detaches on any mismatch and stops updates. A branch resolution could map to a lower/different version on one unit, causing an ignored save or duplicate workout while another succeeds.
- **Actionable fix:** Define a local monotonically increasing HealthKit export generation per FitnessAI session, allocated atomically only for an intentional export/update. Specify create/update/delete/detach/relink transitions, what fields are compared, how self-authored versions are recognized, and that external absence/change never triggers automatic recreation. Add fixtures for correction, conflict resolution, manual Health deletion, and retry.

### 10. High — AD-13 / AD-6: capability kill switches and evidence eligibility are not synchronized at session boundaries

- **Severity:** High
- **Location:** AD-6 lines 61–65; AD-13 lines 103–107
- **Finding:** Each high-risk capability may fail closed, and automation requires an evidence row, but no invariant defines who evaluates the row, how iPhone/Watch exchange support/evidence/control versions, or whether eligibility is frozen or mutable during an active workout.
- **Divergent implementations:** iPhone Unit A shows recognition enabled from its cached matrix while Watch Unit B has a newer kill switch and records manual-only data. Another implementation disables a model mid-set and discards its pending prediction, while a peer preserves it for confirmation. User-facing state and resulting labels diverge.
- **Actionable fix:** Define a capability handshake carrying app/schema/model/evidence/control versions and an explicit negotiated state. Freeze the permitted automation set in the active-session snapshot except for an emergency transition to disabled; define treatment of pending predictions on disable. The Watch is authoritative for its sensor/model executability, and the iPhone must present the negotiated state rather than local expectation.

### 11. Medium — AD-5: cleanup acknowledgement and retention scope are not tied to immutable facts

- **Severity:** Medium
- **Location:** AD-5 lines 55–59
- **Finding:** “Acknowledged facts retain an initial seven-day window” does not specify which acknowledgement level starts the timer, whether later corrections reset it, whether raw chunk manifests and files are deleted together, or whether cleanup uses wall-clock time despite the ban on device time deciding truth.
- **Divergent implementations:** Watch Unit A starts seven days at transport receipt and deletes a chunk before iPhone application; Unit B starts at whole-object applied ack. Clock correction can also cause early deletion in one implementation. Database rows can survive without files, or files without manifests.
- **Actionable fix:** Tie cleanup eligibility to the immutable whole-object `applied` acknowledgement from Finding 5 plus monotonic local elapsed time; define retention per artifact class and whether superseding facts affect it. Delete file/index/manifest in a recoverable, idempotent cleanup transaction and retain tombstone/audit metadata sufficient to answer replays.

### 12. Medium — AD-14 / AD-7: “displayed digest” lacks a presentation-completeness invariant

- **Severity:** Medium
- **Location:** AD-7 lines 67–71; AD-14 lines 109–113
- **Finding:** Approval is bound to the complete displayed digest, but the presentation contract does not require every safety-relevant changed field, omission, assumption, unit conversion, or warning to be visible before approval. A digest itself is not meaningful to the user.
- **Divergent implementations:** UI Unit A summarizes “5 exercises changed” and hides expanded set/load changes; UI Unit B requires a full diff. Both approve the same digest, but Unit A effectively permits hidden mutations that AD-7 intends to prevent.
- **Actionable fix:** Bind an approval-view completeness contract: enumerate all changed fields and deletions, original and proposed values/units, assumptions, Safety Rule results, unresolved warnings, scope, and base revision; no collapsed section containing unreviewed safety-relevant changes may be approvable. Accessibility representation must expose the same information. Store the rendered canonical proposal version/digest, not screenshots or prose.

### 13. Medium — AD-8 / AD-13: Alpha gateway security is deferred later than gateway use

- **Severity:** Medium
- **Location:** AD-8 lines 73–77; AD-13 lines 103–107; Deferred line 180
- **Finding:** Built-in DeepSeek already requires a FitnessAI gateway, but authentication, request authorization, abuse limits, build/environment binding, and log redaction validation are deferred under the public-beta threat review. Owner-only Alpha does not prevent extraction or automated abuse of a callable gateway endpoint.
- **Divergent implementations:** Gateway Unit A trusts a static app header; client Unit B assumes device attestation or authenticated short-lived tokens. A modified client can consume the product key’s quota or submit arbitrary data while every stated secret-storage rule remains satisfied.
- **Actionable fix:** Move a minimum gateway contract before first Alpha traffic: environment-isolated endpoint, short-lived authenticated client/session credential, server-side provider allowlist and payload/schema limits, rate/cost ceilings, no client-selected provider URL/model outside policy, structured redacted logging, and secret-leak tests. Keep the broader regional/account threat model deferred for public beta.

## Recommended gate disposition

1. Fix Findings 1–6 before marking the spine final; they define the data, approval, authorization, wire, and device-trust invariants that lower-level units cannot safely invent.
2. Fix Findings 7–10 in the spine or explicitly defer them with a hard revisit condition before the first paired workout/import/HealthKit/automation implementation story, respectively.
3. Findings 11–13 can be concise additions to the relevant ADs or normative contract seeds, but should not remain implicit.

## Re-review — 2026-09-10

**Verdict:** **NEEDS FIXES — one remaining blocker**

| Original finding | Status | Re-review conclusion |
|---|---|---|
| 1. Revision DAG/reducer | Resolved | AD-2 now binds a normative DAG, causal fields, conflict predicate, missing-parent state, topology-operation handling, resolution references, reducer, and cross-platform golden fixtures. |
| 2. AI approval concurrency/idempotency | Resolved | AD-7 now verifies unconsumed proposal, displayed digest, current Plan head and policy versions in the transaction, with `proposalId` as the unique retry key. |
| 3. One-shot remote authorization | Resolved | AD-8 now binds exact destination/body/purpose/scope to an expiring authorization that is atomically consumed once. |
| 4. Canonical digest/wire equivalence | Resolved | Consistency Conventions now require one canonical encoding, normalization, semantic coverage, hash-version profile, and cross-device golden vectors. |
| 5. Transfer/ack/activation state machine | Resolved except cleanup conflict below | AD-4 now binds manifest/chunk metadata, explicit ack states, replay response, missing-chunk retry, dependency negotiation, and atomic Plan activation. |
| 6. Pairing generation/stale-device fencing | Resolved | AD-4 now binds persisted pairing epoch, replay identity, revocation quarantine, and explicit recovery. |
| 7. Offline session identity/recovery | Resolved | AD-3 now permits a cached-Plan Watch to mint a globally unique session ID that iPhone adopts unchanged and forbids time-based merge; AD-2 covers competing completion/topology branches. |
| 8. Unknown/duplicate import behavior | Resolved | AD-10 now binds a versioned decision table, deterministic alias mapping, no silent omission, inert metadata or itemized confirmation, and duplicate-draft behavior. |
| 9. HealthKit version/detachment transitions | Resolved | AD-9 now requires an atomic monotonic export generation and versioned create/update/delete/detach/relink transition table with self-authored retry behavior. |
| 10. Capability negotiation/session freeze | Resolved | AD-4 and AD-6 now bind capability handshake, Watch execution authority, session-frozen eligibility, emergency disable, and pending-prediction fallback. |
| 11. Cleanup acknowledgement/retention | **Blocking inconsistency remains** | AD-4 says only whole-object `applied` permits cleanup, while AD-5 says raw Watch chunks delete after durable iPhone commit, which corresponds to the earlier `durablyCommitted` state. Two implementations can therefore legally delete at different stages. |
| 12. Approval-view completeness | Resolved | AD-7 now enumerates all changes/deletions, values/units, assumptions, warnings, Safety result, scope, base revision, and accessible presentation before approval. |
| 13. Alpha gateway minimum security | Resolved | AD-8 now moves endpoint isolation, short-lived authentication, allowlists, limits, rotation, redaction, rollback ownership, and kill switch before Alpha traffic. |

### Remaining actionable fix

- Choose one rule and state it identically in AD-4 and AD-5: either raw Watch chunks are sender cleanup and therefore remain until whole-object `applied`, or raw chunks are an explicit exception eligible after verified whole-object `durablyCommitted` because iPhone durably owns the complete bytes and can retry application locally. Also state that file, index, and manifest share that same atomic cleanup eligibility. No other original adversarial finding remains blocking after this correction.

## Final re-review — 2026-09-10

**Verdict:** **PASS**

AD-4 and AD-5 now consistently require whole-object `applied` before any Watch raw-chunk cleanup. AD-5 also binds file, index, and manifest deletion into one idempotent atomic operation and retains replay tombstones. The sole remaining blocker from the prior re-review is resolved; all 13 original adversarial seam findings are now closed.

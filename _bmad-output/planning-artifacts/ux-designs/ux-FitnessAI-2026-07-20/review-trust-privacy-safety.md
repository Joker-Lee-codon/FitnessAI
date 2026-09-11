---
review: trust-privacy-safety
artifact: FitnessAI UX spines
date: 2026-07-20
verdict: changes-required
critical: 0
high: 5
medium: 3
low: 1
---

# Trust, Privacy & Safety Review

## Verdict

**Changes required before the spines are finalized.** The UX contract is unusually strong on local durable commit, provenance, scoped correction, idempotent recovery, unsupported/manual fallback, load honesty, RPE abstention, non-medical language, and separation of ordinary recording from research consent. No critical flaw was found. Five high-severity gaps remain where the current contract could either promise an unobservable platform state or leave destructive lifecycle scope ambiguous.

Severity count: **0 critical · 5 high · 3 medium · 1 low**.

Highest risk: the generic permission model promises `granted/denied/revoked` states for HealthKit even though an app cannot determine whether read access was denied; separately, deletion “completed” has no copy-by-copy definition covering Watch/iPhone raw data, synchronized data, compact personalization state, backups/legal exceptions, and offline devices.

## Scope and Evidence

Reviewed:

- `DESIGN.md`, `DESIGN.zh-CN.md`, `EXPERIENCE.md`, `EXPERIENCE.zh-CN.md`, and `.memlog.md`.
- All five frontmatter sources: Product Brief, PRD, market research, multi-vendor IMU research, and Apple Watch RPE research.
- Apple’s current HealthKit authorization documentation for the platform-observability check.

Finding references use line numbers from the English spines and source documents; the Chinese spines have matching structure and line alignment for the reviewed sections.

## Findings

| ID | Severity | Contract gap | Implementable repair |
|---|---|---|---|
| TPS-01 | High | HealthKit read permission is modeled as an observable `granted/denied/revoked` state. | Split permission state models by capability; never claim to know HealthKit read denial. |
| TPS-02 | High | “Deletion completed” has no explicit copy-by-copy scope, especially for local raw HR/IMU and the PRD’s 30-day account-deletion boundary. | Define deletion scope, per-copy progress, retained/legal exceptions, and exact completion semantics. |
| TPS-03 | High | Retained local data after sign-out is not contractually sealed from another account or prevented from syncing under new credentials. | Define account-bound encryption, visibility, queue suspension, and explicit transfer eligibility. |
| TPS-04 | High | Deletion tombstones promise no resurrection but do not expose local commit, cloud acceptance, known-device propagation, and offline-device pending as distinct states. | Give deletion the same multi-boundary truth model as workout save/sync. |
| TPS-05 | High | Forgotten-Finish is present in flows without the source-required two-signal and release-gate invariant. | State the invariant, missing-signal behavior, cooldown, and “feature unavailable until gate passes.” |
| TPS-06 | Medium | Research-consent withdrawal does not say what stops, what local data remains, or how prior research/model artifacts are handled. | Add a separate research lifecycle with prospective stop, local retention choice, deletion request, and lineage-aware limitation copy. |
| TPS-07 | Medium | Export is trackable but its required machine-readable contents and exclusion disclosure are absent. | Name the export inventory, format, provenance, and excluded local raw/research data. |
| TPS-08 | Medium | Permission revocation during an active session lacks an ordered degradation contract. | Preserve committed facts, stop only the affected stream, abstain where necessary, keep manual recording, and report the consequence at a safe pause. |
| TPS-09 | Low | The copy matrix lacks canonical wording for auto-used RPE, abstention, HealthKit-unobservable read state, and partial deletion. | Add literal Chinese-first examples for these highest-risk trust states. |

## Detailed Findings

### TPS-01 — HealthKit read authorization cannot support the promised generic status model

**Severity: High**

`EXPERIENCE.md:118` gives Account & Privacy the states “permission not determined/granted/denied/revoked,” and `EXPERIENCE.md:164` applies contextual permission behavior to HealthKit alongside other permissions. For HealthKit read access, Apple deliberately does not reveal whether access was granted or denied; denied reads appear as no matching data. `HKAuthorizationStatus` describes save/share authorization, not an observable read-grant state. See [Apple: HKAuthorizationStatus](https://developer.apple.com/documentation/healthkit/hkauthorizationstatus) and [Apple: Authorizing access to health data](https://developer.apple.com/documentation/HealthKit/authorizing-access-to-health-data).

This is a trust defect because copy such as “HealthKit access denied” can assert a fact the product does not know and may falsely diagnose “no data.”

**Repair:** define separate state families:

- HealthKit share/write: `not determined / authorized / denied / restricted/error` where the API supports them.
- HealthKit read: `not requested / request presented / data available / no accessible data / limited-window access / query error`; do not distinguish “denied” from “no matching data.”
- Motion, notification, account, and research consent retain their own observable states rather than inheriting one generic enum.

### TPS-02 — Account deletion does not define whether local raw sensor data is erased

**Severity: High**

`EXPERIENCE.md:165` says complete high-frequency HR/IMU stays local by default, while `EXPERIENCE.md:167` and Flow 9 (`297-305`) say account deletion shows completion/failure. The contract never states whether deleting the account also deletes raw chunks on Watch/iPhone, retained encrypted local account data, compact personalization state, or locally queued structured records. It also omits the PRD requirement that account-linked production data and synchronized compact personal-model state be removed or irreversibly de-identified within 30 days, subject to disclosed legal exceptions (`prd.md:327-335`).

The current “completed” label can therefore over-promise erasure while sensitive local data remains.

**Repair:** before confirmation, enumerate at least: this Watch, this iPhone, China-region synchronized records, compact personalization state, research uploads, backups/legal exceptions, and other offline devices. Define separate choices/status for local raw sensor deletion. “Completed” must name the completed scope and any retained exception; do not use account deletion as shorthand for device erasure.

### TPS-03 — Sign-out retention is not safely isolated from account switching

**Severity: High**

`EXPERIENCE.md:168` and Flow 9 (`300-302`) allow encrypted local account data to be retained and prevent silent history merge, but they do not say that retained data becomes inaccessible after sign-out, that its upload queue is suspended, or that a new account’s credentials can never authorize old-account operations. The phrase “eligible explicit transfer/merge” also lacks eligibility constraints.

**Repair:** specify that retained data remains cryptographically and logically bound to the prior account, hidden while another account is active, and unable to sync until that same account reauthenticates. Before account switch, show old-account unsynchronized counts and the effect of retain/remove. Cross-account transfer should appear only if a separately authorized product/legal contract defines eligible data, destination, provenance, and reversibility; otherwise do not offer it.

### TPS-04 — Deletion needs the same boundary truthfulness as save and sync

**Severity: High**

The recording contract correctly separates local save, phone receipt, and cloud acknowledgement (`EXPERIENCE.md:85, 100, 146, 155`). Deletion instead has only generic `accepted / in progress / completed / failed` (`101, 160, 167, 297-305`) while claiming that an offline device or old queue cannot resurrect data. An unreachable device cannot truthfully be described as having applied deletion, and “cloud completed” is not “all devices completed.”

**Repair:** define deletion boundary states such as `committed on this device`, `cloud tombstone accepted`, `other device pending`, `applied on known device`, `retention/legal exception`, and `failed/retry`. Older queued mutations and restored snapshots must be rejected by tombstone/revision ordering before they can become visible. If an offline device reconnects after the request, deletion must apply before its older outbox can publish. The user-facing status must distinguish “protected from resurrection” from “physically erased on every device.”

### TPS-05 — Forgotten-Finish lacks the mandatory two-signal safety gate

**Severity: High**

The spine correctly bans automatic ending (`EXPERIENCE.md:78, 202`) and records reminder thresholds as open (`340`). However, it reduces eligibility to “if eligible” and does not carry forward the source invariant: sustained recovery toward the user’s non-training state **and** sustained absence of strength-training activity must both be present; either signal alone is insufficient (`prd.md:304-310`). Missing signals, low-motion exercises, long rests, equipment waits, supersets/circuits, cooldown, and false/missed thresholds are not behaviorally resolved.

**Repair:** add the two-signal rule to the component/state contract now, even before numeric thresholds exist. Missing or unreliable signal means no reminder. The reminder must occur only at a safe pause, offer Finish/Continue, respect cooldown, and remain disabled in release until the pre-registered physical-device gate passes. Keep the numeric windows as an open gated decision.

### TPS-06 — Research-consent withdrawal stops collection but has no downstream lifecycle

**Severity: Medium**

The separation of ordinary recording from research consent is correct (`EXPERIENCE.md:164-165`). What is missing is the withdrawal journey: whether capture/upload stops immediately, whether unsent raw chunks remain local or are deleted, whether already uploaded material is deleted, and how data already included in derived datasets or model releases is handled. The multi-vendor research requires lineage-aware retention/deletion, and the RPE research treats future raw upload as a separately governed opt-in.

**Repair:** add a research-consent lifecycle distinct from account/HealthKit permission: consented, upload pending, withdrawn locally, server withdrawal accepted, deletion in progress/completed/limited by disclosed lawful or irreversible-derived constraints. Withdrawal must not disable ordinary local recording. The product must explain prospectively what can be stopped or deleted without implying that a released model can always be “untrained.”

### TPS-07 — Export status exists, but export meaning is underspecified

**Severity: Medium**

Flow 9 tracks export requests but does not name the source-required contents or format. The PRD requires a documented machine-readable export containing Training Plans, Workout Sessions, Actual Sets, corrections, effective RPE with provenance, and account metadata (`prd.md:327-332`). Raw local sensor chunks, research uploads, and HealthKit records have different ownership and may be excluded; silence creates a false completeness promise.

**Repair:** show the export inventory and format before request, include revision/provenance semantics, and explicitly list excluded data and separate export routes. “Export completed” must link to the actual artifact and its scope, not merely indicate job success.

### TPS-08 — Active-session permission revocation has no ordered degradation contract

**Severity: Medium**

The spine includes permission-revoked and sensor-gap states (`EXPERIENCE.md:108, 118, 141, 164`) and bans blocking prompts during a started session (`130`), but it does not state what happens when HealthKit or motion access disappears mid-session.

**Repair:** preserve all committed Actual Set facts, stop only the affected signal, mark its first affected boundary, force dependent RPE/recognition to abstain or pending, retain manual set/reps/load recording, and surface the consequence during rest or another safe pause. Never convert already confirmed facts back to inferred values. Permission repair can be routed after the session; it must not seize the active set UI.

### TPS-09 — The microcopy matrix is missing the highest-risk compound states

**Severity: Low**

The existing examples are good (`EXPERIENCE.md:55-70`) but do not cover: an auto-used model RPE versus a user-confirmed RPE, model abstention, HealthKit “no accessible data” without claiming denial, cloud deletion completed while another device is pending, research withdrawal, or account deletion with local raw data retained.

**Repair:** add canonical Chinese-first examples that name value source, affected copy, surviving facts, and next action. Avoid “已全部删除,” “权限被拒绝,” or “RPE 已测得” unless the exact underlying state supports those words.

## Controls That Passed

- **Save versus sync:** local durable commit is consistently the saved boundary; phone/cloud replication is orthogonal and cannot revoke recording success (`EXPERIENCE.md:57, 85, 100, 146, 155`).
- **Provenance and correction:** plan, detected, predicted, historical, user-entered, confirmed, auto-used, and corrected values remain distinguishable; corrections are scoped and auditable (`79-84, 96-101, 147-151`).
- **Recovery and idempotence:** app/device interruption, partial writes, duplicate/delayed/reordered replay, revision conflicts, and concurrent sessions have explicit preservation paths (`153-160, 259-281`).
- **Unsupported and low confidence:** unsupported device/signal/Exercise and low-confidence results degrade to manual or pending recording; captured sibling facts survive (`87, 141, 283-293`).
- **RPE boundary:** RPE is opt-in, uncertainty-aware, provenance-bearing, correctable, and non-diagnostic; the user-confirmed value remains authoritative (`60, 68-69, 83, 99, 140, 147`).
- **Load honesty:** load is planned/historical/previous-set/user-entered, never claimed as wrist-sensed (`59, 82, 147, 199-201`).
- **Training safety:** active-set silence, safe-pause prompting, explicit destructive confirmation, no automatic plan mutation, and no injury diagnosis/rehabilitation claim are present (`68-69, 78, 124-130, 234-246`).
- **Bilingual parity:** the reviewed English and Chinese spines preserve the same section order, tables, requirement mappings, state conclusions, and line-aligned flow structure.

## Required Disposition Before Finalization

Resolve TPS-01 through TPS-05 in the spines or explicitly mark the affected feature unavailable until its contract is resolved. TPS-06 through TPS-08 may remain gated only if the spines name the gate, owner/decision point, and safe interim behavior. TPS-09 is polish but should be completed before key-screen mocks or implementation handoff.

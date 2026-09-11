# FitnessAI PRD Open-Item Reconciliation

## 1. Scope and Gate Verdict

This read-only reconciliation compared `prd.md`, `prd.zh-CN.md`, `addendum.md`, `addendum.zh-CN.md`, and `.memlog.md`. It looked for explicit open markers, unresolved memlog assumptions, MVP handoff blockers, identifier and cross-reference defects, and bilingual drift.

**Gate verdict:** the document pair is structurally synchronized and the requirement identifiers are intact, but the PRD is not yet safe to finalize or hand off unchanged. Fourteen distinct open items remain; seven are phase-blockers for UX, architecture, or epic acceptance.

## 2. Explicit Marker and Memlog Audit

| Audit target | Result | Conclusion |
|---|---:|---|
| `Open Questions` sections | 0 | No explicit section exists; unresolved work is embedded in requirements and the memlog. |
| `[ASSUMPTION]` tags in either PRD | 0 | No inline tags remain. |
| `[NOTE FOR PM]` callouts | 0 | No callouts remain. |
| `TBD`, `TODO`, or placeholder tokens | 0 | No literal placeholders remain. |
| Memlog assumptions still requiring a product decision | 2 | Pilot retention threshold and Post-MVP beginner-plan review cadence remain open. |
| Superseded or resolved memlog assumptions | 5 | Ad-hoc recognition, exercise-media licensing, injury handling, auto-used RPE provenance, and the reminder AND gate were closed by later change, override, or decision entries. |

## 3. Remaining Open Items

| ID | Severity | Phase-blocker | Evidence | Open item and required closure |
|---|---|---:|---|---|
| OI-01 | Critical | Yes | `prd.md:33`, `prd.md:158-165` | **Automatic-recognition release contract is incomplete.** Define the MVP supported-exercise and supported-device/signal matrix, exercise-classification acceptance threshold, rep-count error target, working-set-boundary target, uncertainty/abstention target, and required evaluation slices. `SM-ACC-001` currently defines accounting but no pass/fail gate. |
| OI-02 | Critical | Yes | `prd.md:32-34`, `prd.md:154`, `prd.md:162-164`, `prd.md:200` | **The user-authoritative correction loop does not cover all captured truth.** Add capability and acceptance rules for correcting rep counts and set boundaries, inserting/deleting a mistaken set, resolving missing or pending fields, and correcting after completion. Clarify whether an incomplete session may be finished and how it later becomes complete. |
| OI-03 | Critical | Yes | `prd.md:14`, `prd.md:150`, `prd.md:205`, `prd.md:208` | **Active-session recovery is absent.** Specify the user-visible outcome after Watch app termination, device restart or battery loss, sensor interruption, Watch–iPhone disconnect/reconnect, and a partial local write. A durable local commit and later cloud synchronization do not by themselves guarantee that an in-progress Workout Session can be resumed without data loss or duplication. |
| OI-04 | High | Yes | `prd.md:11`, `prd.md:114-119`, `prd.md:148`, `prd.md:204-207`; `addendum.md:9-11` | **Supported platform and device topology is undefined.** Set minimum iPhone, Apple Watch, iOS, and watchOS support; state whether workout recording is Watch-standalone; identify where account sign-in occurs; and state when iPhone proximity is or is not required. “Supported device” is currently circular. |
| OI-05 | Critical | Yes | `prd.md:134-138`, `prd.md:204-210`; `addendum.md:27-33` | **Privacy, security, and China-region data-governance requirements are missing.** Define data classes and consent, account authentication, encryption expectations, access control, residency/transfer boundary, retention, telemetry restrictions, high-frequency sensor handling, personal-model handling, and export/deletion completion semantics. The PRD requires a China-region application backend but supplies no NFR contract for sensitive fitness/account data. |
| OI-06 | High | Yes | `prd.md:116-120`, `prd.md:204-210` | **Cross-device synchronization and account lifecycle are not acceptance-testable.** Define the authoritative conflict behavior for concurrent corrections and deletions, tombstone/duplicate behavior, restore completeness and timeliness, sign-out/local-data behavior, and what happens when account identity changes or two local histories meet. FR-046 states a prohibition but not the product-visible resolution rule. |
| OI-07 | Critical | Yes | `prd.md:174-179`, `prd.md:244-251`; `addendum.md:35-45` | **RPE release and trust-gate thresholds are incomplete.** Define an eligible estimate, the RPE scale and correctness tolerance, validated confidence/risk threshold, minimum improvement over each baseline, acceptable correction/prompt burden, drift trigger, and re-verification trigger. “Stable improvement,” “validated acceptance threshold,” and “unacceptable” are not executable gates. |
| OI-08 | High | No | `prd.md:35`; `.memlog.md:67` | **The four-week default-recorder continuation threshold remains explicitly unset.** Assign an owner and fix the cohort threshold, denominator, minimum completed-session count, and handling of unobservable/self-reported sessions before pilot holdout evaluation. |
| OI-09 | Medium | No | `prd.md:36` | **Core-function feedback is not operationalized.** Define “critical,” “recurring,” minimum sample/interview cadence, issue-closing evidence, and who decides that a theme is resolved. |
| OI-10 | High | No | `prd.md:152`, `prd.md:255-258`; `addendum.md:47-49` | **Forgotten-finish reminder validation remains open.** The AND gate is decided, but personalization, sustained-duration windows, missing-signal behavior, cooldown, and acceptable false-reminder/missed-reminder rates still need an owner and pre-release validation gate. |
| OI-11 | Low | No | `prd.md:103-106`, `prd.md:227-228`; `.memlog.md:41` | **Post-MVP beginner-plan review cadence and precedence remain open.** Decide how post-session, approximately weekly, and cycle-end recommendations interact, including conflict precedence. This is deferred and does not block the MVP. |
| OI-12 | Medium | No | `prd.md:69-73`, `prd.md:195-199` | **Analysis terms lack product definitions.** Define training volume, intensity, load, duration, primary-exercise selection, trend baseline, and the treatment of incomplete or corrected sets so UX and epic acceptance use the same meaning. |
| OI-13 | High | No | `prd.md:188-191` | **Plan reconciliation semantics are ambiguous.** Define “material difference,” which future plan instances can be updated, what fields are proposed, how reuse differs from update, and whether the user can review the exact diff before approval. |
| OI-14 | Low | No | `prd.md:10-144`, `prd.zh-CN.md:10-144` | **Top-level section numbering skips 3 and 4 in both languages.** Renumber the shared structure or restore the intentionally omitted sections before final polish; the bilingual pair must be changed together. |

## 4. Identifier and Cross-Reference Audit

| Identifier family | English | Chinese | Result |
|---|---:|---:|---|
| Success metrics | 6 | 6 | Exact ordered match: `SM-COMP-001`, `SM-ACC-001`, `SM-PRES-001`, `SM-RET-001`, `SM-FEED-001`, `SM-INT-001`. |
| User journeys | 5 | 5 | Exact ordered match: `UJ-1` through `UJ-5`; `UJ-4` is consistently Post-MVP. |
| Functional requirements | 60 | 60 | Exact ordered match with no gap or duplicate: `FR-001` through `FR-060`; `FR-054` through `FR-060` are consistently Post-MVP. |
| Non-functional requirements | 20 | 20 | Exact ordered match within all four namespaces: `SIZE` 001–005, `RPE` 001–010, `SESSION` 001–004, and `RES` 001. |

No broken explicit ID reference was found. The only structural reference defect is the shared top-level numbering jump from section 2 to section 5. The PRD intentionally omits a traceability matrix, consistent with the selected PRD skill, so lack of a matrix is not a defect.

## 5. Bilingual Consistency Audit

The English and Chinese PRDs have the same 262-line structure, matching frontmatter, headings at the same levels, ordered lists, requirement identifiers, numeric thresholds, links, scope labels, and conclusions. The two addenda likewise have the same 49-line structure and aligned headings, sources, technical identifiers, and decisions. No material bilingual semantic contradiction was found.

Full-width Chinese punctuation around Post-MVP labels is typographic localization, not an identifier mismatch. Any resolution of OI-01 through OI-14 must be applied to both language versions in the same change.

## 6. Minimum Capability-Level Closure Proposals for Phase-Blockers

The IDs below are proposed new stable IDs. Existing IDs should not be renumbered. Place each new requirement in the named capability group even though its global ID is higher than nearby requirements.

### OI-01 — Automatic-Recognition Release Contract

- **Suggested insertion:** Add `FR-061` after FR-015 in section 7.2; add a new PRD subsection `8.5 Recognition Quality and Release Acceptance` containing `NFR-REC-001` and `NFR-REC-002`.
- **FR-061:** “For each release, FitnessAI declares the exercises, Apple Watch families, OS ranges, and signal conditions for which exercise recognition, repetition counting, and working-set detection are supported. Outside that declared profile, FitnessAI abstains and preserves a manual recording path.”
- **NFR-REC-001:** “Before holdout results are inspected, a versioned release-acceptance profile freezes separate thresholds for initial exercise recognition, repetition-count error, working-set-boundary error, abstention/risk coverage, and required exercise, device, and cold-start evaluation slices.”
- **NFR-REC-002:** “Automatic recognition can ship only when every frozen threshold passes and the shared proactive-interruption budget remains satisfied; successful correction and data recovery are reported separately and cannot improve initial-recognition results.”
- **Why this unblocks handoff:** UX receives an explicit abstention/manual fallback, architecture receives a bounded support envelope, and epics receive a versioned, holdout-safe release gate without forcing a model implementation into the PRD.

### OI-02 — Complete User-Authoritative Correction Loop

- **Suggested insertion:** Add `FR-062` and `FR-063` after FR-014 in section 7.2, with a cross-reference from FR-041.
- **FR-062:** “During an active Workout Session and from completed Workout History, the user can correct the exercise, repetitions, Actual Load, RPE state, set order or boundary; add a missing Actual Set; and remove an erroneous Actual Set. Each correction preserves every unaffected field and an auditable correction history.”
- **FR-063:** “FitnessAI identifies unresolved or missing fields before Finish. The user may explicitly leave them unresolved and finish, in which case the Workout Session remains visibly incomplete and can be reopened for correction; it becomes complete only after every required recorded item is resolved.”
- **Why this unblocks handoff:** UX can design every truth-recovery state, architecture can define durable editable entities and audit history, and epics can test completeness across all captured fields instead of only exercise-label correction.

### OI-03 — Active-Session Failure Recovery

- **Suggested insertion:** Add `FR-064` after FR-007 in section 7.1; add `NFR-RECOV-001` after NFR-SESSION-004 in section 8.3.
- **FR-064:** “After an app-process, device, sensor, or connectivity interruption, FitnessAI offers to resume the same in-progress Workout Session from its latest durable state. Information from an interval that cannot be recovered remains visibly pending and is never inferred as confirmed.”
- **NFR-RECOV-001:** “Restart, reconnect, synchronization retry, and session resume cannot duplicate, drop, or reorder a durably acknowledged Actual Set or overwrite a later user correction. Physical-device recovery tests cover Watch process termination, device restart, Watch–iPhone disconnection, backend unavailability, and missing sensor signals.”
- **Why this unblocks handoff:** UX gets a defined resume and pending-data experience, architecture gets the required recovery invariant, and epics get explicit failure scenarios for the product's primary trust promise.

### OI-04 — Supported Surfaces and Device Topology

- **Suggested insertion:** Add a new scope subsection `6.3 Supported Product Surfaces` containing `FR-065` and `FR-066`; add `NFR-COMPAT-001` in a new subsection `8.6 Compatibility`.
- **FR-065:** “Once a planned or ad-hoc Workout Session is available on Apple Watch, the user can start, record, correct, and finish it without live iPhone or backend reachability. Features that require iPhone are identified before the user enters the Watch flow.”
- **FR-066:** “The user establishes the FitnessAI Account on a supported iPhone and associates a supported Apple Watch with that account. After association, the Watch can continue local workout recording while offline under the last authenticated account state.”
- **NFR-COMPAT-001:** “Each release declares its minimum supported iPhone, Apple Watch, iOS, and watchOS versions and supported pairings. UJ-1, UJ-3, and UJ-5 must pass on every declared pairing.”
- **Why this unblocks handoff:** UX knows which surface owns authentication and which flows must survive phone absence, architecture can establish device responsibilities and connectivity boundaries, and epics can target a finite compatibility matrix.

### OI-05 — Privacy, Security, and China-Region Data Governance

- **Suggested insertion:** Add a new PRD subsection `8.7 Privacy, Security, and Data Governance` containing the following stable IDs.
- **NFR-PRIV-001:** “Account profile, Workout History, Actual Sets, RPE provenance, analytics inputs, and personal-model summaries synchronize only under explicit informed user consent. Complete high-frequency sensor streams remain local by default and require a separate explicit purpose and consent before any upload.”
- **NFR-SEC-001:** “Account-scoped data is protected in transit and at rest and is accessible only to the authenticated user, authorized devices, and explicitly authorized service roles. Security failures cannot expose one account's data to another account.”
- **NFR-PRIV-002:** “Before release, FitnessAI maintains a user-facing and reviewable data map naming each synchronized data category, purpose, storage and processing region, retention rule, and recipient. Undeclared transfer or secondary use is prohibited.”
- **NFR-PRIV-003:** “Data export and account deletion cover every account-scoped synchronized category and its ordinary replicas. FitnessAI shows request status and completion, and discloses any legally required retention exception and its duration.”
- **Why this unblocks handoff:** UX gets the consent, disclosure, export, and deletion states; architecture gets authoritative data-boundary and access invariants; and epics can build auditable privacy/security acceptance without prescribing a specific backend technology.

### OI-06 — Synchronization and Account-Lifecycle Semantics

- **Suggested insertion:** Add `FR-067`, `FR-068`, and `FR-069` after FR-048 in section 7.6.
- **FR-067:** “When the same account-scoped field is changed on multiple devices, FitnessAI preserves the latest determinable user correction. If the correction order cannot be determined safely, FitnessAI preserves both candidates and asks the user to choose; it never silently discards either candidate.”
- **FR-068:** “Cross-device restoration reproduces each synchronized Training Plan, Workout Session, Actual Set, correction, and RPE provenance with the same stable identity and reports restoration progress and any unresolved failure to the user.”
- **FR-069:** “Before sign-out or account switching, FitnessAI identifies unsynchronized local information and requires the user to synchronize, export, or explicitly discard it. Sign-out does not imply account deletion; account deletion follows FR-048 and the declared retention rules.”
- **Why this unblocks handoff:** UX can design conflict, progress, failure, and sign-out states; architecture gets deterministic preservation rules and stable-identity invariants; and epics receive testable concurrent-edit, restore, and account-switch outcomes.

### OI-07 — Executable RPE Release and Trust Gates

- **Suggested insertion:** Add `NFR-RPE-011` and `NFR-RPE-012` after NFR-RPE-010 in section 8.2.
- **NFR-RPE-011:** “Before holdout results are inspected, a versioned RPE acceptance profile freezes the RPE scale and correctness tolerance, eligible-estimate definition, minimum participant-held-out and later-session improvement over each declared baseline, calibration and risk–coverage targets, missing-signal and required slice criteria, and maximum prompt and correction burden within SM-INT-001.”
- **NFR-RPE-012:** “RPE auto-use remains unavailable unless the complete acceptance profile passes. The profile defines drift and re-verification triggers, and release testing verifies that every low-confidence, unfamiliar, missing-signal, or drift case follows the pending-or-bounded-confirmation fallback.”
- **Why this unblocks handoff:** UX receives deterministic provisional, auto-use, correction, and re-verification states; architecture receives the evaluation and fallback contract; and epics can gate rollout on frozen evidence rather than subjective terms such as “stable” or “unacceptable.”

## 7. Recommended Closure Order

1. Resolve OI-01 through OI-07 before UX, architecture, or epic handoff.
2. Assign owners and revisit conditions for OI-08 through OI-13; OI-11 may remain explicitly deferred to Post-MVP.
3. Fix OI-14 during structural polish, then rerun identifier and bilingual parity checks.
4. Only after these closures, run the formal PRD reviewer gate and set both PRDs to `status: final` together.

## 8. Conclusion

The bilingual PRD pair is synchronized and free of literal placeholders or broken requirement identifiers. It still has **14 open items**, including **7 phase-blockers**. The main blockers are the missing recognition acceptance contract, incomplete correction and failure-recovery flows, undefined supported-device topology, absent privacy/security/data-governance NFRs, under-specified synchronization semantics, and non-executable RPE release gates.

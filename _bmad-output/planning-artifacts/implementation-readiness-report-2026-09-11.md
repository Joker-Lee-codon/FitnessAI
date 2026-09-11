---
stepsCompleted:
  - step-01-document-discovery
  - step-02-prd-analysis
  - step-03-epic-coverage-validation
  - step-04-ux-alignment
  - step-05-epic-quality-review
  - step-06-final-assessment
includedFiles:
  prd:
    - prds/prd-FitnessAI-2026-07-19/prd.md
    - prds/prd-FitnessAI-2026-07-19/addendum.md
  ux:
    - ux-designs/ux-FitnessAI-2026-07-20/EXPERIENCE.md
    - ux-designs/ux-FitnessAI-2026-07-20/DESIGN.md
  nativeUi:
    - native-ui-designs/native-ui-FitnessAI-2026-08-08/native-ui-spec.md
    - native-ui-designs/native-ui-FitnessAI-2026-08-08/design-direction.md
    - native-ui-designs/native-ui-FitnessAI-2026-08-08/architecture-handoff.md
  architecture:
    - architecture/architecture-FitnessAI-2026-09-09/ARCHITECTURE-SPINE.md
  epics:
    - epics.md
languageCopies:
  suffix: .zh-CN.md
---

# Implementation Readiness Assessment Report

**Date:** 2026-09-11
**Project:** FitnessAI

## Document Inventory

### PRD Files Found

**Primary documents:**

- `prds/prd-FitnessAI-2026-07-19/prd.md` (77,419 bytes; modified 2026-09-10 15:21:12)
- `prds/prd-FitnessAI-2026-07-19/addendum.md` (14,213 bytes; modified 2026-09-08 11:09:29)

The folder also contains review, reconciliation, validation, and editorial records. These are supporting evidence rather than competing authoritative PRD versions.

### UX Design Files Found

**Primary documents:**

- `ux-designs/ux-FitnessAI-2026-07-20/EXPERIENCE.md` (35,847 bytes; modified 2026-09-10 15:22:52)
- `ux-designs/ux-FitnessAI-2026-07-20/DESIGN.md` (31,544 bytes; modified 2026-09-10 15:23:59)

The folder also contains reconciliation, accessibility, trust/privacy/safety, rubric, and validation records as supporting evidence.

### Native UI Files Found

**Primary documents:**

- `native-ui-designs/native-ui-FitnessAI-2026-08-08/native-ui-spec.md` (13,668 bytes; modified 2026-09-09 00:48:41)
- `native-ui-designs/native-ui-FitnessAI-2026-08-08/design-direction.md` (13,320 bytes; modified 2026-09-09 00:51:28)
- `native-ui-designs/native-ui-FitnessAI-2026-08-08/architecture-handoff.md` (15,188 bytes; modified 2026-09-09 14:42:31)

### Architecture Files Found

**Primary document:**

- `architecture/architecture-FitnessAI-2026-09-09/ARCHITECTURE-SPINE.md` (24,569 bytes; modified 2026-09-10 15:24:14)

### Epics and Stories Files Found

**Primary document:**

- `epics.md` (216,104 bytes; modified 2026-09-11 09:21:35)

### Discovery Issues

- No whole-versus-sharded duplication was found; no `index.md`-based sharded version exists for the required document types.
- Every selected English source has a paired `.zh-CN.md` language copy. These pairs are intentional and are not treated as duplicate document conflicts.
- No `project-context.md` was found. This is non-blocking; the configured planning artifacts and project knowledge remain available.

## PRD Analysis

### Functional Requirements

- **FR-001:** The user can start a planned or ad-hoc Workout Session on iPhone or Apple Watch. Phone-only and paired-Watch sessions use the same identities, durable state model, correction rules, and Analysis; when Watch is the selected capture device, Watch remains authoritative for that active session.
- **FR-002:** FitnessAI records each Actual Set as a structured record containing the exercise state, set order, repetitions, Actual Load, RPE state when enabled, and timing required by history and analysis.
- **FR-003:** FitnessAI durably commits captured and user-entered workout information locally before treating it as saved or attempting cloud synchronization. It must not represent a user action as saved, corrected, finished, or discarded until that local commit succeeds.
- **FR-004:** The user can manually finish a Workout Session, and manual Finish is authoritative.
- **FR-005:** FitnessAI may ask whether a Workout Session is complete only when sustained recovery and sustained absence of strength-training activity are both present; it cannot end the session automatically.
- **FR-006:** After completion, FitnessAI shows the session's Actual Sets and body areas trained.
- **FR-007:** Missing or pending information remains visible as incomplete rather than being silently removed, guessed, or represented as confirmed.
- **FR-008:** FitnessAI can attempt to recognize exercises during an ad-hoc Workout Session without requiring exercise preselection.
- **FR-009:** FitnessAI can attempt to detect working-set boundaries and count repetitions from supported Apple Watch signals.
- **FR-010:** FitnessAI assigns a confidence state to automatic exercise and repetition results and distinguishes accepted, uncertain, corrected, and unresolved states.
- **FR-011:** FitnessAI requests confirmation only when required by uncertainty, correction, or another explicitly defined trust gate, subject to the proactive-interruption budget.
- **FR-012:** If the exercise label is wrong, FitnessAI allows correction after the first Actual Set rather than waiting until session completion.
- **FR-013:** Exercise-label correction preserves the already captured set order, repetitions, load, RPE state, and timing.
- **FR-014:** After correction, subsequent Actual Sets continue under the corrected exercise while the correction history remains auditable.
- **FR-015:** FitnessAI reports initial recognition success separately from successful data recovery after correction.
- **FR-016:** For planned training, FitnessAI prefills the first planned Actual Load from the Training Plan.
- **FR-017:** For ad-hoc training, FitnessAI prefills the exercise's most recent Actual Load when history exists; otherwise the user enters the first load.
- **FR-018:** Each subsequent set defaults to the previous Actual Load until the user changes it.
- **FR-019:** The user can change Actual Load on Apple Watch, and the user-entered value is authoritative; FitnessAI does not claim automatic external-load detection.
- **FR-020:** RPE estimation, display, verification, and personal calibration run only when the user enables RPE tracking.
- **FR-021:** After RPE tracking is enabled, FitnessAI presents the first five eligible model estimates for user confirmation or correction.
- **FR-022:** If at least four of five estimates are correct, FitnessAI offers the user the option to disable routine RPE confirmation.
- **FR-023:** If at least two of five estimates are wrong, FitnessAI updates lightweight local personal calibration using corrected labels and starts a new five-estimate verification window.
- **FR-024:** After successful verification and explicit consent, FitnessAI may automatically use subsequent high-confidence RPE predictions while preserving model-derived provenance and correction capability.
- **FR-025:** Low-confidence, unfamiliar, missing-signal, or drifting RPE cases remain pending or trigger a confirmation prompt within the interruption budget rather than fabricating an Actual RPE.
- **FR-026:** FitnessAI keeps target, predicted, individually confirmed, auto-used, corrected, and effective Actual RPE states distinguishable.
- **FR-027:** Based on the Actual RPE and remaining Training Plan, FitnessAI may suggest a next-set load. The suggestion may change the next Actual Set only after the user explicitly accepts or edits it; the user can also explicitly reject it.
- **FR-028:** The user can select and start an existing Training Plan and view planned exercises, sets, repetitions, loads, and optional target RPE.
- **FR-029:** FitnessAI keeps planned content separate from Actual Sets when the completed exercise, set count, repetitions, load, or RPE differs.
- **FR-030:** When planned equipment is unavailable, the user can request substitute exercises.
- **FR-031:** Substitute recommendations must match the canonical primary target body area and movement-pattern category, must be usable with the equipment the user says is available, and must show any difference in secondary target areas or movement range before selection. Acceptance tests use the versioned canonical Exercise attributes rather than free-text similarity.
- **FR-032:** The user chooses whether to use a substitute; FitnessAI cannot silently replace the exercise in the current or future Training Plan.
- **FR-033:** At session completion, FitnessAI identifies material differences between the Training Plan and Actual Sets—including substituted, added, or skipped Exercises or sets and changed repetitions, Actual Load, or RPE—and presents the exact proposed field-level diff for user review. The proposal names the future plan instance or revision it would affect.
- **FR-034:** Declining a suggestion or plan update preserves the Actual Set and leaves the future Training Plan unchanged.
- **FR-035:** The user can reuse a completed historical Workout Session as the starting point for a new draft session or Training Plan without modifying the source history; reuse is distinct from approving an update to an existing future Training Plan.
- **FR-036:** The user can browse completed planned and ad-hoc Workout Sessions in Training History.
- **FR-037:** The user can view how many Workout Sessions were completed in a selected week and which exercises were performed.
- **FR-038:** FitnessAI calculates weekly and monthly training volume, intensity, load, and duration from Actual Sets rather than planned content.
- **FR-039:** The user can view performance trends for selected primary exercises over time.
- **FR-040:** History and analysis preserve corrected values and distinguish user-confirmed or auto-used RPE provenance where relevant.
- **FR-041:** The user can review the full information recorded for a completed Workout Session without fields disappearing after completion.
- **FR-042:** The user can sign in to a FitnessAI Account on a supported device.
- **FR-043:** Workout recording remains usable offline and does not depend on immediate iPhone or backend reachability. When more than one supported Watch starts or restores a Workout Session for the same FitnessAI Account, concurrent sessions remain distinct and recoverable until the user explicitly resolves them; FitnessAI cannot silently merge, discard, or reassign either session's records.
- **FR-044:** After local commit, FitnessAI synchronizes account-scoped Training Plans, structured Training History, Actual Sets, confirmed or provenance-bearing RPE, analytics inputs, and compatible compact personal-model summaries to the application backend.
- **FR-045:** Signing in on another supported device restores synchronized account-scoped data required to review history and continue training.
- **FR-046:** Interrupted, duplicated, delayed, reordered, or concurrent synchronization cannot silently overwrite a newer user correction or create duplicate Actual Sets. FitnessAI preserves every user-authored revision involved in conflicts over field corrections, split or merged sets, deletion, completion state, or Training Plan revisions until an effective revision is determined. FitnessAI cannot resolve these conflicts solely by device time; when deterministic resolution is unsafe, it shows the revisions on iPhone and requires the user to choose. Dependent Analysis and plan proposals remain visibly pending or stale while the effective revision is unresolved.
- **FR-047:** Complete high-frequency sensor streams remain local by default and are not required for ordinary cross-device restoration.
- **FR-048:** The user can request account-scoped data export and account deletion through the product's applicable privacy workflow and can see when each request is accepted, in progress, completed, or failed.
- **FR-049:** FitnessAI maps recognized, planned, substituted, and corrected exercise references to canonical Exercise records.
- **FR-050:** An Exercise record can identify target body areas and the movement information required for substitution and analysis.
- **FR-051:** The user can view explanatory exercise text and properly licensed or owned images on iPhone.
- **FR-052:** FitnessAI can explain concepts such as RPE without requiring the user to enable RPE tracking.
- **FR-053:** FitnessAI does not ship unlicensed exercise media or present wrist-only observations as precise full-body form judgments.
- **FR-054:** A trainee can start a text AI conversation to create or revise a Training Plan using goals, experience, availability, session time, equipment, preferences, and mandatory known injury or physical-limitation information. Missing answers and AI assumptions remain visible.
- **FR-055:** The user can describe equipment before generation or after reviewing a proposal. FitnessAI may propose a substitute only when its canonical Exercise mapping and relevant movement/body-area rationale are available.
- **FR-056:** FitnessAI can produce a validated structured Training Plan Draft containing cycle duration, weekly frequency, session order, canonical Exercises, sets, repetitions or ranges, suggested load, and optional target RPE. A prose-only response is not a complete plan.
- **FR-057:** Before native creation or revision, FitnessAI shows the complete plan or complete field-level diff, its unresolved fields, and Exercise mappings. One explicit approval triggers an atomic local commit of a complete Plan Revision without item-by-item manual import.
- **FR-058:** Whenever a new or worsening injury, recovery state, or warning sign is disclosed during plan generation, session feedback, or later plan adaptation, FitnessAI stops recommendations for the affected scope until the user explicitly chooses an allowed continuation path. The user can exclude the affected training area or pause generation and seek qualified guidance. Warning signs stop generation and direct the user to offline medical care without naming a diagnosis; uncertainty or a declined answer never permits FitnessAI to infer severity. FitnessAI does not diagnose, assign injury severity, or prescribe rehabilitation.
- **FR-059:** At user request or after the user accepts the private-Alpha post-session review invitation, FitnessAI can use explicitly permitted user-confirmed or corrected FitnessAI structured records and concise subjective feedback to explain and propose a next-session or future-plan change. It applies FR-058 before showing a recommendation and identifies the records and assumptions used.
- **FR-060:** No AI-generated plan or progression change takes effect without explicit approval bound to the displayed immutable `proposalId`, base revision, and content digest. The complete field-level diff includes every added, removed, and changed field that will enter the new revision. Regeneration, editing, a base-revision change, or any content-digest change invalidates prior approval and requires the new proposal to be reviewed and approved; generation, conversation, or viewing alone never authorizes a change.
- **FR-061:** During and after a Workout Session, the user can correct repetitions, split or merge a detected set boundary, insert a missed Actual Set, and delete a false Actual Set.
- **FR-062:** The user can resolve every missing or pending required field before or after Finish. Finishing with unresolved fields creates an Incomplete Workout Session rather than discarding data or representing the session as complete.
- **FR-063:** A post-completion correction creates an auditable revision, updates derived Analysis only after an effective revision is determined, and preserves the prior value and provenance without rewriting unrelated fields. Split/merge, deletion, and completion-state revisions follow the same rule.
- **FR-064:** After Watch app termination, device restart, recoverable battery interruption, sensor interruption, or Watch–iPhone disconnect/reconnect, FitnessAI restores the latest durably committed active Workout Session and lets the user Resume, Finish as incomplete, or discard only with explicit confirmation.
- **FR-065:** If recovery finds a partial write or ambiguous set boundary, FitnessAI preserves the recoverable facts as one visible pending Actual Set; it does not silently drop the fragment or create multiple sets from the same event.
- **FR-066:** Recovery and replay are idempotent: the same committed event, transfer, or retry cannot create a duplicate Actual Set or revert a later user correction.
- **FR-067:** Deleting an Actual Set, Workout Session, or Training Plan creates a synchronized deletion state that prevents an offline device, replay, older revision, or pending synchronization queue from silently restoring the deleted item. Confirmed deletion propagates to every reachable product-managed copy with visible completion, failure, and retry state; recoverability, if offered, is explicit and time-bounded.
- **FR-068:** Cross-device restoration reports whether restoration of the required account-scoped records is complete, still in progress, or has failed. The user can continue local recording while restoration is incomplete.
- **FR-069:** On sign-out, FitnessAI asks whether to retain encrypted local account data for later sign-in or remove it from that device, and explains which unsynchronized records would be affected before removal.
- **FR-070:** Signing in with a different FitnessAI Account never silently merges the prior local history. Any eligible transfer or merge requires an explicit, previewable user action.
- **FR-071:** The user can export one Training Plan to a documented, FitnessAI-owned, versioned, machine-readable file and invoke the native iOS Share Sheet for that file. The artifact includes the plan content and the schema, Exercise-catalog mapping, revision, and provenance information required for compatible re-import, and excludes Workout Sessions, Actual Sets, health information, and account credentials.
- **FR-072:** The user can import a compatible FitnessAI Training Plan file on iPhone. Before saving, FitnessAI validates the format and version, previews the complete plan and source, reports unsupported or unresolved fields, and creates a new draft; import never silently replaces or revises an existing Training Plan.
- **FR-073:** Unknown Exercises, incompatible fields, duplicate imports, and newer or unsupported file versions remain visible and recoverable through mapping, explicit omission, cancellation, or a reported failure. FitnessAI cannot invent a mapping or represent a partial import as complete without the user's review.
- **FR-074:** A future voice-entry capability may accept user-invoked spoken input for structured workout facts on a supported surface. Every parsed value first becomes a correctable draft with voice-derived provenance and remains distinguishable from sensed, planned, historical, and user-confirmed values. It becomes an effective workout fact only after the user explicitly confirms or corrects it and the local commit succeeds; it cannot silently overwrite a confirmed fact.
- **FR-075:** When voice input is unavailable, interrupted, ambiguous, or conflicts with a touch-entered value, sensor-derived value, or synchronized revision, FitnessAI preserves committed facts, exposes the draft or conflict for correction, and keeps an equivalent non-voice recording path available.
- **FR-076:** Any future third-party plan import requires a named supported format and version, field and Exercise mapping, unit handling, a complete pre-save preview, partial-failure reporting, and creation of a new draft rather than silent mutation of an existing plan.
- **FR-077:** Any future QR- or link-based Training Plan share lets the recipient preview the shared plan and its source before creating a new draft. Sharing cannot include Workout Sessions, Actual Sets, health information, account credentials, or other data outside the explicitly shared Training Plan.
- **FR-078:** Every AI Training Plan Draft and Plan Change Proposal carries an immutable `proposalId`, content digest, provenance, target Training Plan ID when applicable, base revision, generation time, permitted data scope, and unresolved assumptions.
- **FR-079:** A Plan Change Proposal shows field-level additions, removals, and modifications plus affected future sessions. Historical Actual Sets and an already-started Workout Session are never part of the mutation scope.
- **FR-080:** User approval creates one new Plan Revision through an atomic, idempotent local commit. Any validation or commit failure leaves the prior active revision wholly effective and creates no partially active plan.
- **FR-081:** An effective compatible Plan Revision is delivered directly to the paired Apple Watch with visible pending, delivered, and failed states. The user never has to recreate its Exercises or sets on Watch or iPhone.
- **FR-082:** In the first usable build, AI reads only the current conversation, user-provided profile and physical constraints, explicitly permitted FitnessAI structured records that the user confirmed or corrected, and user-selected local summaries from the versioned Apple Health allowlist. Every Apple Health summary category defaults off and requires the one-shot per-request authorization in FR-086; real transmission remains technically disabled until the current provider, legal, privacy, region, retention/cache, model-training-use, deletion/revocation, disclosure, and user-rights gate is documented and approved. Raw sensor streams, imported plans, cloud-restored copies, clinical categories, and unrestricted HealthKit access remain excluded.
- **FR-083:** The user can modify a draft through continued conversation, regenerate it, or reject it. None of these actions changes the active Training Plan before the approval and commit in FR-057 and FR-080.
- **FR-084:** Duplicate approval events, retries, Watch reconnection, or out-of-order delivery cannot duplicate or roll back a Plan Revision. Watch ultimately offers only the latest user-approved compatible revision for a future Workout Session.
- **FR-085:** If AI is unavailable, returns invalid output, or plan delivery fails, the user can still view the last confirmed plan, record a Workout Session locally, and retry or discard the non-effective proposal.
- **FR-086:** Before any remote AI request uses profile, physical-limitation, conversation, or FitnessAI record data, the user must affirmatively approve the included data categories and record time window. Every category is excluded by default; general App consent or permission for local processing does not authorize remote processing. The user can inspect and withdraw the authorization. Withdrawal stops future remote AI use but does not rewrite an already approved Plan Revision or historical Actual Sets.
- **FR-087:** Before approval, FitnessAI validates the proposal against a versioned Alpha Plan Safety Rule Pack covering units, missing or contradictory schedule constraints, canonical Exercise support, and bounded plan volume, intensity, and load progression. The Product Owner owns the pack and must freeze its first version before the first AI-plan implementation Story begins; every change creates a new version. Each check returns a testable pass or blocking reason. A failed, missing, or unsupported check blocks commit and requires clarification, correction, or rejection rather than invented completion.
- **FR-088:** The user can grant and manage contextual, least-privilege Apple Health read access for the versioned private-Alpha allowlist: workouts; heart rate, resting heart rate, one-minute recovery, and HRV; sleep; active/resting energy, steps, and exercise time; body mass, height, body-fat, and lean-mass; VO2 max, respiratory rate, oxygen saturation, and sleeping wrist temperature where available; and explicitly allowed age/biological-sex characteristics. Clinical, medication, laboratory, reproductive, raw ECG, glucose, blood-pressure, and disease-specific types are excluded. FitnessAI distinguishes not requested, no accessible data, available, unavailable, and failed states; it never claims to know that read access was denied when HealthKit does not disclose that fact.
- **FR-089:** After a Workout Session is durably completed, the user can enable FitnessAI to write the completed workout summary to Apple Health. Each write exposes pending, written, and failed/retry states and is idempotent; it never blocks or changes the FitnessAI local record.
- **FR-090:** Deleting or changing the Apple Health copy does not silently delete or rewrite the FitnessAI copy. If the Apple Health copy disappears, FitnessAI marks its record `healthKitDetached` and does not recreate it without a new explicit write action. Remote AI use remains separately governed by FR-082 and FR-086.
- **FR-091:** After a completed Workout Session becomes reviewable on iPhone, FitnessAI can show one non-blocking invitation to review future-plan adjustments. The user can Review, Later, or disable the invitation. Merely showing the invitation sends no remote data and creates no proposal; accepting it enters FR-059 and every effective change still requires FR-060 approval.

**Total FRs: 91**

### Non-Functional Requirements

- **NFR-SIZE-001:** The user-acceptable ceiling for the thinned iPhone application variant is 500 MB installed. Download size and installed size must be measured and reported separately.
- **NFR-SIZE-002:** The watchOS application must remain below Apple's 75 MB maximum uncompressed size. FitnessAI adopts an internal target of no more than 25 MB installed on Apple Watch to preserve headroom for code, resources, and future compatibility.
- **NFR-SIZE-003:** For MVP, all machine-learning assets deployed to Apple Watch must total no more than 6 MB, and the per-set RPE component must total no more than 2 MB. Exceeding either budget requires a product-level PRD change supported by physical-device accuracy, energy, and size evidence; an architecture review alone cannot waive the limit.
- **NFR-SIZE-004:** Large exercise-teaching images and nonessential media must not be bundled into the Watch app. They remain on iPhone or are delivered through an appropriately licensed application content service.
- **NFR-SIZE-005:** Release size is verified using Xcode App Thinning size reports and App Store Connect/TestFlight device variants; debug `.app`, `.ipa`, and `.xcarchive` sizes are not acceptance measurements.
- **NFR-RPE-001:** FitnessAI must not claim or assume that heart rate alone can reliably determine set-level Actual RPE. Heart rate may be evaluated as one feature alongside motion, exercise context, load, repetitions, rest, and confirmed personal history.
- **NFR-RPE-002:** A predicted RPE must remain distinct from target RPE and user-confirmed Actual RPE throughout recording, synchronization, history, analysis, and model training. A prediction must never silently overwrite a confirmed value.
- **NFR-RPE-003:** The RPE estimator must support abstention. When confidence is below the pre-registered acceptance threshold or required signals are unavailable, FitnessAI must leave Actual RPE pending or ask a concise question rather than fabricate a value.
- **NFR-RPE-004:** Before user-facing release, the estimator must demonstrate improvement over simple baselines such as target RPE, previous-set RPE, and personal Exercise history on participant-held-out data and in later sessions. Evaluation must include uncertainty calibration, missing-signal behavior, Exercise/device slices, and cold-start versus personalized performance. The minimum improvement and risk–coverage thresholds must be pre-registered before holdout results are viewed and cannot be relaxed after unblinding.
- **NFR-RPE-005:** Model release acceptance must consider user burden as well as predictive error. Before holdout evaluation, the Product Owner and model owner must pre-register maximum RPE prompt and correction rates that fit inside SM-INT-001's shared interruption budget; the feature cannot advance unless every registered burden gate passes.
- **NFR-RPE-006:** Only user-confirmed RPE may serve as a training label for personal calibration or future model development; model predictions must not recursively become their own labels.
- **NFR-RPE-007:** RPE estimation, verification, prompts, and personal calibration must remain inactive when the user has not enabled RPE display or tracking.
- **NFR-RPE-008:** After RPE is enabled, FitnessAI must run a five-estimate personal verification window. At least four correct estimates permit an offer to disable routine confirmation; at least two incorrect estimates trigger local personal recalibration from corrected labels followed by a new five-estimate verification window.
- **NFR-RPE-009:** Automatically using subsequent RPE predictions requires explicit user consent after a successful verification window. Each auto-used value must retain model-derived provenance and remain distinguishable from individually confirmed RPE in storage and audit history.
- **NFR-RPE-010:** Passing personal verification does not disable uncertainty handling. Low-confidence estimates, unfamiliar exercises, missing signals, or detected performance drift must still abstain or request concise confirmation, and any later correction may trigger reverification.
- **NFR-RPE-011:** FitnessAI uses an integer RPE scale from 1 through 10. For the five-estimate personal verification window, an estimate is correct when it is within ±1 of the user's confirmed value; exact-match accuracy is also reported separately.
- **NFR-RPE-012:** An estimate is eligible for personal verification only when RPE tracking is enabled, the Exercise is supported, the Actual Set has a resolved boundary and repetition count, required signals are present, and no correction for that set remains pending. Eligibility and prediction must be fixed before the user's confirmed or corrected value is revealed; the first five chronological eligible predictions form the window, and every eligible outcome remains in the registered denominator.
- **NFR-RPE-013:** Two user corrections within any rolling five auto-used eligible estimates constitute a drift trigger. Routine confirmation resumes immediately and a new five-estimate verification window is required before auto-use can be offered again.
- **NFR-RPE-014:** Before final holdout results are viewed, the participant and chronological partitions, candidate model, eligibility rules, support matrix, confidence threshold, minimum baseline improvement, maximum accepted-error risk, maximum prompt/correction burden, and evaluation procedure must be version-frozen in a release-gate record. A viewed final holdout cannot be reused for candidate tuning. Missing any item or changing it after results are viewed blocks release of automatic RPE use.
- **NFR-SESSION-001:** Manual Finish is the normal and authoritative way to complete a Workout Session.
- **NFR-SESSION-002:** A forgotten-finish reminder may appear only when both sustained physiological recovery toward the user's non-training state and sustained absence of detected strength-training activity are present. Either signal alone is insufficient.
- **NFR-SESSION-003:** FitnessAI must not automatically end a Workout Session from inferred inactivity. The reminder asks whether training is complete, and the user chooses Finish or Continue.
- **NFR-SESSION-004:** The reminder trigger and duration must be validated against long inter-set rests, equipment waits, and low-motion exercises. False reminders and missed reminders must be reported separately before release.
- **NFR-SESSION-005:** Before physical-device validation begins, the Product Owner and UX owner must pre-register the personalization rule, sustained-duration windows, missing-signal behavior, cooldown, and maximum false-reminder and missed-reminder rates. The reminder cannot ship if any registered threshold fails, and thresholds cannot be relaxed after the blinded sessions are reviewed.
- **NFR-RES-001:** MVP has no product-specific per-session battery-percentage acceptance target. Physical-device testing must still confirm that FitnessAI can complete representative Workout Sessions without resource-related session termination, material Watch unresponsiveness, or loss of recorded information.
- **NFR-RES-002:** In a representative 90-minute, twenty-working-set physical-device session on every supported Watch/OS pair, there must be zero memory, thermal, or resource-related process termination; zero loss of committed information; and p95 response within one second for Start, correction, and Finish actions. Battery change, thermal state, memory peak, and any interaction exceeding two seconds must be reported even though no battery-percentage release threshold is set.
- **NFR-REC-001:** Before final holdout results are viewed, automatic-recognition evaluation must version-freeze participant and chronological partitions, the candidate model, eligibility rules, support matrix, §3.2 thresholds, denominators, and evaluation procedure. A viewed final holdout cannot be reused for tuning. Evaluation reports every registered slice and cannot adjust a rule after results are known.
- **NFR-REC-002:** Unsupported Exercises, devices, signals, and low-confidence results must visibly degrade to manual or pending recording. They cannot be counted as recognition success or represented as supported.
- **NFR-RECOV-001:** Recovery testing must cover app termination, Watch restart, recoverable battery interruption, sensor loss, Watch–iPhone disconnection, a partial local write, repeated transfer, and delayed/reordered cloud delivery. Every committed user item must appear exactly once after recovery, with the latest user correction effective.
- **NFR-COMPAT-001:** Each release must test every named MVP device/OS pair in the support matrix on physical devices. Simulator-only evidence cannot add a device, OS, signal, or Exercise family to supported status.
- **NFR-COMPAT-002:** Each Workout Session and model-derived record must retain the app/schema version and, when applicable, the model, Exercise catalog, and support-matrix versions that produced or interpreted it. Restoration, correction, and Analysis must not silently reinterpret historical values under a newer version.
- **NFR-PRIV-001:** FitnessAI must classify account identity, structured workout facts, RPE and health-related fields, compact personal-model state, high-frequency sensor streams, support records, and operational metadata separately. Collection and use must be limited to a disclosed purpose and the minimum fields required for that purpose.
- **NFR-PRIV-002:** Personal health information and account-scoped FitnessAI workout data must not be stored in Apple iCloud or CloudKit. Cross-device continuity uses a separately governed China-region application backend; any cross-border transfer requires a separately documented legal basis, disclosure, and consent where applicable.
- **NFR-PRIV-003:** Complete high-frequency motion and heart-rate streams remain local by default. Upload for research or model development requires separate explicit consent, a named retention period, and a revocation/deletion path; ordinary product telemetry must not contain raw signals, Exercise/load/RPE content, free-text notes, authentication secrets, or request bodies.
- **NFR-PRIV-004:** The Product Owner must publish retention periods for each synchronized data class before public beta. Account deletion removes or irreversibly de-identifies account-linked production data and synchronized compact personal-model state within 30 days, except records that must be retained under a documented legal obligation; the user can see completion or failure.
- **NFR-PRIV-005:** Export includes the user's Training Plans, Workout Sessions, Actual Sets, corrections, effective RPE with provenance, and account metadata in a documented, machine-readable format. Export and deletion requests remain usable without contacting support.
- **NFR-PRIV-006:** Before public beta, an approved privacy and security release record must cover data purposes, consent and withdrawal, residency and cross-border paths, retention, subprocessors, age eligibility, user-rights handling, and incident response. A missing or unapproved item blocks public beta.
- **NFR-PRIV-007:** Before content is sent to any remote AI service, FitnessAI discloses the purpose, included data classes and time window, provider/subprocessor relationship, retention, and model-training policy; obtains the affirmative, revocable authorization in FR-086; sends only required fields; and never includes an unselected category or raw motion or heart-rate streams by default.
- **NFR-SEC-001:** Account and synchronized fitness data must be encrypted in transit and at rest, protected by least-privilege service and support access, and separated from authentication secrets. Privileged access and destructive account actions require auditable security events that contain no health-content payload.
- **NFR-SEC-002:** A FitnessAI Account uses platform-appropriate secure authentication, rate limiting, session revocation, and reauthentication for export, deletion, or other high-impact privacy actions. Authentication failure cannot block local capture of an already-started Workout Session.
- **NFR-SEC-003:** Sensitive local data must use platform data-protection controls against unauthorized access and must be excluded from consumer cloud backup and diagnostic payloads unless separately approved, disclosed, and consented to where required.
- **NFR-SAFE-001:** The non-diagnostic stop behavior in FR-058 and the units, contradiction, support, volume, intensity, and load-progression checks in FR-087 are required even in the private Alpha. Before UJ-4 and FR-054 through FR-060 and FR-078 through FR-087 enter any release beyond Product Owner testing, the screening questions, warning-sign rules, plan-safety bounds, allowed continuation paths, and escalation copy require documented review by a qualified exercise or healthcare professional. The reviewed bundle is versioned and acceptance-tested across plan generation, feedback, and adaptation; material change requires reapproval. The review cannot authorize diagnosis, injury-severity assignment, or rehabilitation prescription within ordinary fitness scope.
- **NFR-AI-001:** Every AI plan proposal must pass a versioned Training Plan schema and canonical Exercise-mapping validation before it can be committed.
- **NFR-AI-002:** Automated acceptance tests must observe zero effective Training Plan writes without the approval required by FR-057 and FR-060.
- **NFR-AI-003:** Local Plan Revision commit is atomic and idempotent. Paired-Watch delivery is eventually consistent and idempotent: Watch continues to expose the last delivered compatible revision until the complete new revision arrives, never a partial revision. Under fault injection there is no duplicate effective revision, silent rollback, or false “delivered” state.
- **NFR-AI-004:** AI unavailability, invalid output, or timeout cannot prevent access to the current plan, paired-Watch training, or durable local workout recording.
- **NFR-AI-005:** Every effective AI-origin Plan Revision retains the immutable `proposalId`, content digest, approval event, base revision, schema/model and Alpha Plan Safety Rule Pack versions, and data-source summary needed for audit. The committed digest must equal the approved digest; FitnessAI does not store or expose model chain-of-thought.
- **NFR-AI-006:** An unmapped, contradictory, structurally invalid, or safety-excluded output is rejected or returned for clarification rather than completed with invented facts.
- **NFR-PORT-001:** Training Plan files are treated as untrusted input. Import must enforce schema and size limits, reject executable content and malformed structures, preserve the source and format version, and fail safely without changing an existing plan. Share Sheet export is data-minimized to the selected Training Plan.
- **NFR-VOICE-001:** Voice input requires observable states for permission, listening, transcription, draft review, confirmation, commit, cancellation, interruption, and unavailability. Raw audio is a separate data class and is not retained, uploaded, or used for model development unless a later product decision defines the purpose and the user gives separate explicit consent.
- **NFR-SHARE-001:** A shared plan payload is data-minimized to the intended Training Plan. If a server-backed link is used, access, expiry, revocation, forwarding risk, and China-region data placement must be defined and disclosed before release; a QR code alone is not treated as an authenticity, access-control, or privacy mechanism.
- **NFR-HK-001:** Apple Health access follows capability-specific least privilege and remains optional. Missing authorization, unavailable data, or HealthKit failure cannot block the current Training Plan, manual correction, complete FitnessAI History/Analysis from local Actual Sets, or durable Watch recording.
- **NFR-HK-002:** HealthKit writes and retries are idempotent and auditable without storing health-content payloads in operational logs. FitnessAI never reports a write as complete before HealthKit confirms it and never silently recreates a detached Apple Health copy.
- **NFR-UX-001:** Every private-Alpha IA surface must implement the approved bilingual `DESIGN.md` and `EXPERIENCE.md` visual/layout contract with complete light/dark, Dynamic Type, VoiceOver, error, empty, loading, offline, and recovery states. A placeholder or developer-only screen does not satisfy the personally usable Alpha.

**Total NFRs: 54**

### Additional Requirements

- The private-Alpha normative acceptance set explicitly selects the applicable success metrics, FRs, and NFR families; account-cloud continuity, rich exercise media, voice, arbitrary third-party import, and server-backed link/QR sharing remain later scope unless an architecture dependency is documented.
- Watch is authoritative for a Watch-captured active session; iPhone owns AI planning, full review/approval, complete correction, history, analysis, Apple Health controls, plan portability, and recovery coordination.
- Local commit precedes any saved/synchronized representation. AI, HealthKit, Watch delivery, import/export, or network failure must not block access to the confirmed plan or durable local recording.
- Recognition release evidence must use frozen participant/chronological partitions and support-matrix slices; recovery must preserve every committed user item exactly once; physical-device evidence is required for supported device/OS claims.
- AI plan changes require schema validation, canonical Exercise mapping, complete-plan or field-level-diff review, digest-bound approval, and atomic/idempotent revision commit.
- Remote AI data categories default off and require per-request authorization. Raw motion/heart-rate streams, imported plans, cloud-restored copies, and excluded HealthKit categories are outside the first-build remote-AI boundary.
- The product remains non-diagnostic; warning signs stop affected-scope recommendations, and professional safety review is required before release beyond Product Owner testing.
- The PRD defines 12 deferred validation gates (`DV-001`–`DV-012`) with owners and trigger points. They do not block implementation unless their named feature or release phase is entered.
- The addendum is explicitly non-authoritative when wording conflicts with `prd.md`. Its older slicing statements about recognition, RPE, Analysis, and Apple Health must therefore not override the current private-Alpha acceptance set and FR-082.

### PRD Completeness Assessment

The PRD is unusually complete and implementation-oriented: it defines stable requirement IDs, authority boundaries, failure behavior, provenance, release gates, quantitative acceptance thresholds, scope tiers, and deferred decisions with owners. All 91 FRs and 54 NFRs are explicit and testable at a useful level. The principal document-control concern is that frontmatter still says `status: draft`, while the document is being used as the authoritative implementation baseline. The addendum also retains stale first-slice descriptions that conflict with the current PRD, although its precedence statement resolves the normative outcome. These are clarity and governance issues rather than missing product requirements; downstream implementation must treat the main PRD dated 2026-09-10 as authoritative.

## Epic Coverage Validation

### Coverage Matrix

| FR Number | PRD Requirement | Epic Coverage | Status |
|---|---|---|---|
| FR-001 | The user can start a planned or ad-hoc Workout Session on iPhone or Apple Watch. Phone-only and paired-Watch sessions use the same identities, durable state model, correction rules, and Analysis; when Watch is the selected capture device, Watch remains authoritative for that active session. | Epic 1 — shared planned/ad-hoc session start and capture ownership. | ✓ Scheduled |
| FR-002 | FitnessAI records each Actual Set as a structured record containing the exercise state, set order, repetitions, Actual Load, RPE state when enabled, and timing required by history and analysis. | Epic 1 — structured Actual Set truth. | ✓ Scheduled |
| FR-003 | FitnessAI durably commits captured and user-entered workout information locally before treating it as saved or attempting cloud synchronization. It must not represent a user action as saved, corrected, finished, or discarded until that local commit succeeds. | Epic 1 — durable local-save boundary. | ✓ Scheduled |
| FR-004 | The user can manually finish a Workout Session, and manual Finish is authoritative. | Epic 1 — authoritative manual Finish. | ✓ Scheduled |
| FR-005 | FitnessAI may ask whether a Workout Session is complete only when sustained recovery and sustained absence of strength-training activity are both present; it cannot end the session automatically. | Epic 7 — evidence-gated forgotten-Finish prompt. | ✓ Scheduled |
| FR-006 | After completion, FitnessAI shows the session's Actual Sets and body areas trained. | Epic 1 — completed-session facts and trained areas. | ✓ Scheduled |
| FR-007 | Missing or pending information remains visible as incomplete rather than being silently removed, guessed, or represented as confirmed. | Epic 1 — visible incomplete/pending facts. | ✓ Scheduled |
| FR-008 | FitnessAI can attempt to recognize exercises during an ad-hoc Workout Session without requiring exercise preselection. | Epic 7 — qualified ad-hoc Exercise recognition. | ✓ Scheduled |
| FR-009 | FitnessAI can attempt to detect working-set boundaries and count repetitions from supported Apple Watch signals. | Epic 7 — qualified set-boundary and repetition recognition. | ✓ Scheduled |
| FR-010 | FitnessAI assigns a confidence state to automatic exercise and repetition results and distinguishes accepted, uncertain, corrected, and unresolved states. | Epic 7 — recognition confidence and provenance states. | ✓ Scheduled |
| FR-011 | FitnessAI requests confirmation only when required by uncertainty, correction, or another explicitly defined trust gate, subject to the proactive-interruption budget. | Epic 7 — trust-gated prompting under the shared budget. | ✓ Scheduled |
| FR-012 | If the exercise label is wrong, FitnessAI allows correction after the first Actual Set rather than waiting until session completion. | Epic 7 — first-set Exercise correction. | ✓ Scheduled |
| FR-013 | Exercise-label correction preserves the already captured set order, repetitions, load, RPE state, and timing. | Epic 7 — sibling-fact preservation during recognition correction. | ✓ Scheduled |
| FR-014 | After correction, subsequent Actual Sets continue under the corrected exercise while the correction history remains auditable. | Epic 7 — corrected continuation and audit. | ✓ Scheduled |
| FR-015 | FitnessAI reports initial recognition success separately from successful data recovery after correction. | Epic 7 — recognition/recovery metric separation. | ✓ Scheduled |
| FR-016 | For planned training, FitnessAI prefills the first planned Actual Load from the Training Plan. | Epic 1 — planned first-load default. | ✓ Scheduled |
| FR-017 | For ad-hoc training, FitnessAI prefills the exercise's most recent Actual Load when history exists; otherwise the user enters the first load. | Epic 1 — historical ad-hoc first-load default. | ✓ Scheduled |
| FR-018 | Each subsequent set defaults to the previous Actual Load until the user changes it. | Epic 1 — previous-Actual-Load default. | ✓ Scheduled |
| FR-019 | The user can change Actual Load on Apple Watch, and the user-entered value is authoritative; FitnessAI does not claim automatic external-load detection. | Epic 1 — authoritative load editing. | ✓ Scheduled |
| FR-020 | RPE estimation, display, verification, and personal calibration run only when the user enables RPE tracking. | Epic 7 — RPE opt-in boundary. | ✓ Scheduled |
| FR-021 | After RPE tracking is enabled, FitnessAI presents the first five eligible model estimates for user confirmation or correction. | Epic 7 — five-estimate verification. | ✓ Scheduled |
| FR-022 | If at least four of five estimates are correct, FitnessAI offers the user the option to disable routine RPE confirmation. | Epic 7 — ≥4/5 auto-use offer. | ✓ Scheduled |
| FR-023 | If at least two of five estimates are wrong, FitnessAI updates lightweight local personal calibration using corrected labels and starts a new five-estimate verification window. | Epic 7 — ≥2/5 recalibration and restart. | ✓ Scheduled |
| FR-024 | After successful verification and explicit consent, FitnessAI may automatically use subsequent high-confidence RPE predictions while preserving model-derived provenance and correction capability. | Epic 7 — explicit-consent high-confidence auto-use. | ✓ Scheduled |
| FR-025 | Low-confidence, unfamiliar, missing-signal, or drifting RPE cases remain pending or trigger a confirmation prompt within the interruption budget rather than fabricating an Actual RPE. | Epic 7 — abstention/pending/drift behavior. | ✓ Scheduled |
| FR-026 | FitnessAI keeps target, predicted, individually confirmed, auto-used, corrected, and effective Actual RPE states distinguishable. | Epic 7 — distinct RPE states and provenance. | ✓ Scheduled |
| FR-027 | Based on the Actual RPE and remaining Training Plan, FitnessAI may suggest a next-set load. The suggestion may change the next Actual Set only after the user explicitly accepts or edits it; the user can also explicitly reject it. | Epic 3 — explicit accept/edit/reject next-set guidance. | ✓ Scheduled |
| FR-028 | The user can select and start an existing Training Plan and view planned exercises, sets, repetitions, loads, and optional target RPE. | Epic 1 — select and execute an existing Plan snapshot. | ✓ Scheduled |
| FR-029 | FitnessAI keeps planned content separate from Actual Sets when the completed exercise, set count, repetitions, load, or RPE differs. | Epic 1 — planned/Actual separation. | ✓ Scheduled |
| FR-030 | When planned equipment is unavailable, the user can request substitute exercises. | Epic 3 — request substitute Exercises. | ✓ Scheduled |
| FR-031 | Substitute recommendations must match the canonical primary target body area and movement-pattern category, must be usable with the equipment the user says is available, and must show any difference in secondary target areas or movement range before selection. Acceptance tests use the versioned canonical Exercise attributes rather than free-text similarity. | Epic 3 — canonical substitute matching and comparison. | ✓ Scheduled |
| FR-032 | The user chooses whether to use a substitute; FitnessAI cannot silently replace the exercise in the current or future Training Plan. | Epic 3 — user-authoritative substitute selection. | ✓ Scheduled |
| FR-033 | At session completion, FitnessAI identifies material differences between the Training Plan and Actual Sets—including substituted, added, or skipped Exercises or sets and changed repetitions, Actual Load, or RPE—and presents the exact proposed field-level diff for user review. The proposal names the future plan instance or revision it would affect. | Epic 4 — exact post-session Plan reconciliation diff. | ✓ Scheduled |
| FR-034 | Declining a suggestion or plan update preserves the Actual Set and leaves the future Training Plan unchanged. | Epic 4 — rejection preserves Actual facts and future Plan. | ✓ Scheduled |
| FR-035 | The user can reuse a completed historical Workout Session as the starting point for a new draft session or Training Plan without modifying the source history; reuse is distinct from approving an update to an existing future Training Plan. | Epic 4 — historical session reuse as a new draft. | ✓ Scheduled |
| FR-036 | The user can browse completed planned and ad-hoc Workout Sessions in Training History. | Epic 4 — browsable complete/incomplete History. | ✓ Scheduled |
| FR-037 | The user can view how many Workout Sessions were completed in a selected week and which exercises were performed. | Epic 4 — weekly session and Exercise evidence. | ✓ Scheduled |
| FR-038 | FitnessAI calculates weekly and monthly training volume, intensity, load, and duration from Actual Sets rather than planned content. | Epic 4 — Actual-Set-based weekly/monthly Analysis. | ✓ Scheduled |
| FR-039 | The user can view performance trends for selected primary exercises over time. | Epic 4 — selected Primary Exercise trends. | ✓ Scheduled |
| FR-040 | History and analysis preserve corrected values and distinguish user-confirmed or auto-used RPE provenance where relevant. | Epic 4 — corrected-value/RPE provenance in Analysis. | ✓ Scheduled |
| FR-041 | The user can review the full information recorded for a completed Workout Session without fields disappearing after completion. | Epic 4 — complete session detail. | ✓ Scheduled |
| FR-042 | The user can sign in to a FitnessAI Account on a supported device. | Deferred — public-beta FitnessAI Account sign-in. | ◇ Intentionally deferred |
| FR-043 | Workout recording remains usable offline and does not depend on immediate iPhone or backend reachability. When more than one supported Watch starts or restores a Workout Session for the same FitnessAI Account, concurrent sessions remain distinct and recoverable until the user explicitly resolves them; FitnessAI cannot silently merge, discard, or reassign either session's records. | Epic 1 — offline local capture and distinct concurrent sessions. | ✓ Scheduled |
| FR-044 | After local commit, FitnessAI synchronizes account-scoped Training Plans, structured Training History, Actual Sets, confirmed or provenance-bearing RPE, analytics inputs, and compatible compact personal-model summaries to the application backend. | Deferred — public-beta application-cloud synchronization. | ◇ Intentionally deferred |
| FR-045 | Signing in on another supported device restores synchronized account-scoped data required to review history and continue training. | Deferred — public-beta account-scoped restoration. | ◇ Intentionally deferred |
| FR-046 | Interrupted, duplicated, delayed, reordered, or concurrent synchronization cannot silently overwrite a newer user correction or create duplicate Actual Sets. FitnessAI preserves every user-authored revision involved in conflicts over field corrections, split or merged sets, deletion, completion state, or Training Plan revisions until an effective revision is determined. FitnessAI cannot resolve these conflicts solely by device time; when deterministic resolution is unsafe, it shows the revisions on iPhone and requires the user to choose. Dependent Analysis and plan proposals remain visibly pending or stale while the effective revision is unresolved. | Epic 1 — causal/idempotent cross-device transfer and visible conflicts. | ✓ Scheduled |
| FR-047 | Complete high-frequency sensor streams remain local by default and are not required for ordinary cross-device restoration. | Epic 1 — raw high-frequency streams remain local. | ✓ Scheduled |
| FR-048 | The user can request account-scoped data export and account deletion through the product's applicable privacy workflow and can see when each request is accepted, in progress, completed, or failed. | Deferred — public-beta account export/deletion lifecycle. | ◇ Intentionally deferred |
| FR-049 | FitnessAI maps recognized, planned, substituted, and corrected exercise references to canonical Exercise records. | Epic 1 — canonical Exercise identity. | ✓ Scheduled |
| FR-050 | An Exercise record can identify target body areas and the movement information required for substitution and analysis. | Epic 1 — body-area and movement attributes. | ✓ Scheduled |
| FR-051 | The user can view explanatory exercise text and properly licensed or owned images on iPhone. | Deferred — rich teaching media. | ◇ Intentionally deferred |
| FR-052 | FitnessAI can explain concepts such as RPE without requiring the user to enable RPE tracking. | Epic 1 — concise RPE and concept explanation. | ✓ Scheduled |
| FR-053 | FitnessAI does not ship unlicensed exercise media or present wrist-only observations as precise full-body form judgments. | Epic 1 — licensed-content and support-claim boundary. | ✓ Scheduled |
| FR-054 | A trainee can start a text AI conversation to create or revise a Training Plan using goals, experience, availability, session time, equipment, preferences, and mandatory known injury or physical-limitation information. Missing answers and AI assumptions remain visible. | Epic 2 — bounded text AI Plan intake. | ✓ Scheduled |
| FR-055 | The user can describe equipment before generation or after reviewing a proposal. FitnessAI may propose a substitute only when its canonical Exercise mapping and relevant movement/body-area rationale are available. | Epic 2 — equipment context and mapped substitutions. | ✓ Scheduled |
| FR-056 | FitnessAI can produce a validated structured Training Plan Draft containing cycle duration, weekly frequency, session order, canonical Exercises, sets, repetitions or ranges, suggested load, and optional target RPE. A prose-only response is not a complete plan. | Epic 2 — complete structured Plan Draft. | ✓ Scheduled |
| FR-057 | Before native creation or revision, FitnessAI shows the complete plan or complete field-level diff, its unresolved fields, and Exercise mappings. One explicit approval triggers an atomic local commit of a complete Plan Revision without item-by-item manual import. | Epic 2 — complete review and one atomic approval. | ✓ Scheduled |
| FR-058 | Whenever a new or worsening injury, recovery state, or warning sign is disclosed during plan generation, session feedback, or later plan adaptation, FitnessAI stops recommendations for the affected scope until the user explicitly chooses an allowed continuation path. The user can exclude the affected training area or pause generation and seek qualified guidance. Warning signs stop generation and direct the user to offline medical care without naming a diagnosis; uncertainty or a declined answer never permits FitnessAI to infer severity. FitnessAI does not diagnose, assign injury severity, or prescribe rehabilitation. | Epic 2 — non-diagnostic safety stop. | ✓ Scheduled |
| FR-059 | At user request or after the user accepts the private-Alpha post-session review invitation, FitnessAI can use explicitly permitted user-confirmed or corrected FitnessAI structured records and concise subjective feedback to explain and propose a next-session or future-plan change. It applies FR-058 before showing a recommendation and identifies the records and assumptions used. | Epic 2 — explicitly invoked evidence-bounded revision proposal. | ✓ Scheduled |
| FR-060 | No AI-generated plan or progression change takes effect without explicit approval bound to the displayed immutable `proposalId`, base revision, and content digest. The complete field-level diff includes every added, removed, and changed field that will enter the new revision. Regeneration, editing, a base-revision change, or any content-digest change invalidates prior approval and requires the new proposal to be reviewed and approved; generation, conversation, or viewing alone never authorizes a change. | Epic 2 — digest/base/proposal-bound approval. | ✓ Scheduled |
| FR-061 | During and after a Workout Session, the user can correct repetitions, split or merge a detected set boundary, insert a missed Actual Set, and delete a false Actual Set. | Epic 1 — field/topology Actual Set correction. | ✓ Scheduled |
| FR-062 | The user can resolve every missing or pending required field before or after Finish. Finishing with unresolved fields creates an Incomplete Workout Session rather than discarding data or representing the session as complete. | Epic 1 — pending-field resolution and Incomplete Finish. | ✓ Scheduled |
| FR-063 | A post-completion correction creates an auditable revision, updates derived Analysis only after an effective revision is determined, and preserves the prior value and provenance without rewriting unrelated fields. Split/merge, deletion, and completion-state revisions follow the same rule. | Epic 1 — append-only auditable corrections. | ✓ Scheduled |
| FR-064 | After Watch app termination, device restart, recoverable battery interruption, sensor interruption, or Watch–iPhone disconnect/reconnect, FitnessAI restores the latest durably committed active Workout Session and lets the user Resume, Finish as incomplete, or discard only with explicit confirmation. | Epic 1 — active-session recovery choices. | ✓ Scheduled |
| FR-065 | If recovery finds a partial write or ambiguous set boundary, FitnessAI preserves the recoverable facts as one visible pending Actual Set; it does not silently drop the fragment or create multiple sets from the same event. | Epic 1 — one visible pending fragment. | ✓ Scheduled |
| FR-066 | Recovery and replay are idempotent: the same committed event, transfer, or retry cannot create a duplicate Actual Set or revert a later user correction. | Epic 1 — idempotent recovery and replay. | ✓ Scheduled |
| FR-067 | Deleting an Actual Set, Workout Session, or Training Plan creates a synchronized deletion state that prevents an offline device, replay, older revision, or pending synchronization queue from silently restoring the deleted item. Confirmed deletion propagates to every reachable product-managed copy with visible completion, failure, and retry state; recoverability, if offered, is explicit and time-bounded. | Deferred — public-beta deletion propagation/tombstones. | ◇ Intentionally deferred |
| FR-068 | Cross-device restoration reports whether restoration of the required account-scoped records is complete, still in progress, or has failed. The user can continue local recording while restoration is incomplete. | Deferred — public-beta cloud restoration status. | ◇ Intentionally deferred |
| FR-069 | On sign-out, FitnessAI asks whether to retain encrypted local account data for later sign-in or remove it from that device, and explains which unsynchronized records would be affected before removal. | Deferred — public-beta sign-out retain/remove. | ◇ Intentionally deferred |
| FR-070 | Signing in with a different FitnessAI Account never silently merges the prior local history. Any eligible transfer or merge requires an explicit, previewable user action. | Deferred — public-beta cross-account non-merge. | ◇ Intentionally deferred |
| FR-071 | The user can export one Training Plan to a documented, FitnessAI-owned, versioned, machine-readable file and invoke the native iOS Share Sheet for that file. The artifact includes the plan content and the schema, Exercise-catalog mapping, revision, and provenance information required for compatible re-import, and excludes Workout Sessions, Actual Sets, health information, and account credentials. | Epic 5 — one bounded Plan export and Share Sheet. | ✓ Scheduled |
| FR-072 | The user can import a compatible FitnessAI Training Plan file on iPhone. Before saving, FitnessAI validates the format and version, previews the complete plan and source, reports unsupported or unresolved fields, and creates a new draft; import never silently replaces or revises an existing Training Plan. | Epic 5 — validated preview-to-new-draft import. | ✓ Scheduled |
| FR-073 | Unknown Exercises, incompatible fields, duplicate imports, and newer or unsupported file versions remain visible and recoverable through mapping, explicit omission, cancellation, or a reported failure. FitnessAI cannot invent a mapping or represent a partial import as complete without the user's review. | Epic 5 — explicit mapping/omission/duplicate/version handling. | ✓ Scheduled |
| FR-074 | A future voice-entry capability may accept user-invoked spoken input for structured workout facts on a supported surface. Every parsed value first becomes a correctable draft with voice-derived provenance and remains distinguishable from sensed, planned, historical, and user-confirmed values. It becomes an effective workout fact only after the user explicitly confirms or corrects it and the local commit succeeds; it cannot silently overwrite a confirmed fact. | Deferred — Post-MVP voice draft capture. | ◇ Intentionally deferred |
| FR-075 | When voice input is unavailable, interrupted, ambiguous, or conflicts with a touch-entered value, sensor-derived value, or synchronized revision, FitnessAI preserves committed facts, exposes the draft or conflict for correction, and keeps an equivalent non-voice recording path available. | Deferred — Post-MVP voice conflict and fallback. | ◇ Intentionally deferred |
| FR-076 | Any future third-party plan import requires a named supported format and version, field and Exercise mapping, unit handling, a complete pre-save preview, partial-failure reporting, and creation of a new draft rather than silent mutation of an existing plan. | Deferred — Post-MVP/V2 third-party Plan formats. | ◇ Intentionally deferred |
| FR-077 | Any future QR- or link-based Training Plan share lets the recipient preview the shared plan and its source before creating a new draft. Sharing cannot include Workout Sessions, Actual Sets, health information, account credentials, or other data outside the explicitly shared Training Plan. | Deferred — Post-MVP/V2 link/QR sharing. | ◇ Intentionally deferred |
| FR-078 | Every AI Training Plan Draft and Plan Change Proposal carries an immutable `proposalId`, content digest, provenance, target Training Plan ID when applicable, base revision, generation time, permitted data scope, and unresolved assumptions. | Epic 2 — immutable proposal identity and scope. | ✓ Scheduled |
| FR-079 | A Plan Change Proposal shows field-level additions, removals, and modifications plus affected future sessions. Historical Actual Sets and an already-started Workout Session are never part of the mutation scope. | Epic 2 — complete future-scope diff. | ✓ Scheduled |
| FR-080 | User approval creates one new Plan Revision through an atomic, idempotent local commit. Any validation or commit failure leaves the prior active revision wholly effective and creates no partially active plan. | Epic 2 — atomic/idempotent revision commit. | ✓ Scheduled |
| FR-081 | An effective compatible Plan Revision is delivered directly to the paired Apple Watch with visible pending, delivered, and failed states. The user never has to recreate its Exercises or sets on Watch or iPhone. | Epic 1 — complete compatible Plan delivery to Watch. | ✓ Scheduled |
| FR-082 | In the first usable build, AI reads only the current conversation, user-provided profile and physical constraints, explicitly permitted FitnessAI structured records that the user confirmed or corrected, and user-selected local summaries from the versioned Apple Health allowlist. Every Apple Health summary category defaults off and requires the one-shot per-request authorization in FR-086; real transmission remains technically disabled until the current provider, legal, privacy, region, retention/cache, model-training-use, deletion/revocation, disclosure, and user-rights gate is documented and approved. Raw sensor streams, imported plans, cloud-restored copies, clinical categories, and unrestricted HealthKit access remain excluded. | Epic 2 — bounded AI source policy and Health-summary gate. | ✓ Scheduled |
| FR-083 | The user can modify a draft through continued conversation, regenerate it, or reject it. None of these actions changes the active Training Plan before the approval and commit in FR-057 and FR-080. | Epic 2 — non-effective conversation/regeneration/rejection. | ✓ Scheduled |
| FR-084 | Duplicate approval events, retries, Watch reconnection, or out-of-order delivery cannot duplicate or roll back a Plan Revision. Watch ultimately offers only the latest user-approved compatible revision for a future Workout Session. | Epic 2 — duplicate/retry/out-of-order Plan protection. | ✓ Scheduled |
| FR-085 | If AI is unavailable, returns invalid output, or plan delivery fails, the user can still view the last confirmed plan, record a Workout Session locally, and retry or discard the non-effective proposal. | Epic 2 — AI/delivery failure degradation. | ✓ Scheduled |
| FR-086 | Before any remote AI request uses profile, physical-limitation, conversation, or FitnessAI record data, the user must affirmatively approve the included data categories and record time window. Every category is excluded by default; general App consent or permission for local processing does not authorize remote processing. The user can inspect and withdraw the authorization. Withdrawal stops future remote AI use but does not rewrite an already approved Plan Revision or historical Actual Sets. | Epic 2 — one-shot remote-use authorization. | ✓ Scheduled |
| FR-087 | Before approval, FitnessAI validates the proposal against a versioned Alpha Plan Safety Rule Pack covering units, missing or contradictory schedule constraints, canonical Exercise support, and bounded plan volume, intensity, and load progression. The Product Owner owns the pack and must freeze its first version before the first AI-plan implementation Story begins; every change creates a new version. Each check returns a testable pass or blocking reason. A failed, missing, or unsupported check blocks commit and requires clarification, correction, or rejection rather than invented completion. | Epic 2 — deterministic Safety Rule Pack gating. | ✓ Scheduled |
| FR-088 | The user can grant and manage contextual, least-privilege Apple Health read access for the versioned private-Alpha allowlist: workouts; heart rate, resting heart rate, one-minute recovery, and HRV; sleep; active/resting energy, steps, and exercise time; body mass, height, body-fat, and lean-mass; VO2 max, respiratory rate, oxygen saturation, and sleeping wrist temperature where available; and explicitly allowed age/biological-sex characteristics. Clinical, medication, laboratory, reproductive, raw ECG, glucose, blood-pressure, and disease-specific types are excluded. FitnessAI distinguishes not requested, no accessible data, available, unavailable, and failed states; it never claims to know that read access was denied when HealthKit does not disclose that fact. | Epic 6 — least-privilege Apple Health reads. | ✓ Scheduled |
| FR-089 | After a Workout Session is durably completed, the user can enable FitnessAI to write the completed workout summary to Apple Health. Each write exposes pending, written, and failed/retry states and is idempotent; it never blocks or changes the FitnessAI local record. | Epic 6 — optional idempotent Health workout copy. | ✓ Scheduled |
| FR-090 | Deleting or changing the Apple Health copy does not silently delete or rewrite the FitnessAI copy. If the Apple Health copy disappears, FitnessAI marks its record `healthKitDetached` and does not recreate it without a new explicit write action. Remote AI use remains separately governed by FR-082 and FR-086. | Epic 6 — local authority and detached-copy behavior. | ✓ Scheduled |
| FR-091 | After a completed Workout Session becomes reviewable on iPhone, FitnessAI can show one non-blocking invitation to review future-plan adjustments. The user can Review, Later, or disable the invitation. Merely showing the invitation sends no remote data and creates no proposal; accepting it enters FR-059 and every effective change still requires FR-060 approval. | Epic 8 — one non-blocking post-session review invitation. | ✓ Scheduled |

### Missing Requirements

**Critical missing FRs:** None for the private-Alpha implementation scope.

**High-priority accidental omissions:** None.

The following 13 requirements are traceable but intentionally not scheduled into S0–S7 because the PRD places them in public-beta, Post-MVP, or V2 scope: `FR-042`, `FR-044`, `FR-045`, `FR-048`, `FR-051`, `FR-067`, `FR-068`, `FR-069`, `FR-070`, `FR-074`, `FR-075`, `FR-076`, and `FR-077`. They become blocking only when the project claims readiness for their named later release scope. Sprint Planning for the current private Alpha must preserve them as explicitly deferred and must not surface placeholders that imply delivery.

### Coverage Statistics

- Total PRD FRs: 91
- Private-Alpha FRs scheduled in Epics: 78 of 78
- Intentionally deferred FRs with explicit traceability: 13 of 13
- Accidental unmapped FRs: 0
- Private-Alpha implementation coverage: 100%
- Whole-PRD scheduled implementation coverage: 85.7%
- Whole-PRD roadmap traceability: 100%

## UX Alignment Assessment

### UX Document Status

UX documentation is present and comprehensive. The assessment used `EXPERIENCE.md`, `DESIGN.md`, `native-ui-spec.md`, `design-direction.md`, and `architecture-handoff.md`. The Architecture Spine explicitly binds the UX and Native UI sources through AD-14.

### UX ↔ PRD Alignment

- The PRD journeys UJ-1, UJ-2, UJ-4 and flows for phone-only recording, Watch execution, correction/recovery, AI planning, History/Analysis, Apple Health, Plan Exchange, and proactive review all have named surfaces and complete state families.
- Planned versus Actual truth, local-save truth, immutable Start snapshots, explicit AI approval, no silent mutation, uncertainty/abstention, and manual fallback are consistently reflected.
- The UX defines complete accessibility and exceptional-state behavior for the private Alpha, including Dynamic Type, VoiceOver, non-color meaning, input-preserving Retry, offline, pending, stale, conflicted, invalid, unsupported, failed, incomplete, and recovery states.
- Deferred account/cloud, voice, rich-media, third-party import, and link/QR surfaces are explicitly absent, matching the private-Alpha scope.

### UX ↔ Architecture Alignment

- AD-1, AD-3, AD-7, AD-9, AD-11, and AD-14 provide explicit implementation support for thin native presentation, typed navigation, device ownership, proposal approval, optional HealthKit, revision-bound Analysis, and accessibility.
- Architecture names the required state machines, component families, semantic tokens, durable states, Watch/iPhone handoff, and physical-device evidence plan.
- NFR-RES-002 supplies a measurable p95 ≤1 second interaction baseline for Start, correction, and Finish; UI loading, retry, offline, and failure states are architecturally represented.

### Alignment Issues

1. **High-priority, non-blocking — stale Apple Health exclusion in Native UI spec.** `native-ui-spec.md` §4 says Apple Health remains excluded from AI authorization categories. Current PRD FR-082/086, `EXPERIENCE.md`, Architecture AD-8/AD-9, and Stories 2.8, 6.2–6.4 allow only user-selected local Apple Health summaries after GATE-3 and a matching one-shot authorization. The documented authority order resolves implementation in favor of the current PRD/Experience/Architecture, but the Native UI sentence must be corrected before Story 2.8 or 6.4 enters implementation.
2. **Medium-priority, non-blocking — stale workflow status metadata.** PRD, `EXPERIENCE.md`, and `DESIGN.md` still declare `status: draft` despite being used as authoritative finalized inputs. `native-ui-spec.md` still says reviewers have not run and ND-04 is unstarted, while `architecture-handoff.md` records ND-01–ND-04 complete and the Product Owner gate accepted. Normalize metadata before baselining Sprint artifacts.
3. **Low-priority, non-blocking — historical direction language.** `design-direction.md` intentionally preserves the superseded Direction D decision. Its later section correctly names Titanium Measure as production authority, but implementers should receive the authority order with the Sprint package so historical content is not mistaken for the active direction.

### Warnings

- Physical-device validation remains owned work, not a missing design decision: Watch glanceability/Always On, largest Chinese text, P3/sRGB contrast, haptics, one-hand/sweat use, chart targeting, reconnect, and failure recovery must be evidenced before the applicable release gate closes.
- UX alignment is sufficient to enter Sprint Planning. The Apple Health sentence correction and metadata normalization are documentation hygiene items; they do not prevent sequencing foundational stories or gate prerequisites.

## Epic and Story Quality Review

### Quantitative Review

- Epics reviewed: 8 of 8
- Stories reviewed: 69 of 69
- Stories with Given/When/Then scenario blocks: 69 of 69
- Stories with explicit traceability: 69 of 69
- Explicit forward Story references: 0
- Circular Epic dependencies: 0
- Stories with more than 10 Given/When/Then scenarios: 10

### Epic Compliance

| Epic | User-value outcome | Independence and dependency result | Quality result |
|---|---|---|---|
| 1 | Complete trustworthy manual workout across iPhone and Watch | Stands alone; manual core has no AI, Health, cloud, or automation dependency | Pass with oversized Story concerns |
| 2 | Turn authorized conversation into approved Plan Revision | Uses Epic 1 Plan/persistence contracts; no later Epic required for non-Health AI path | Pass; gate/enabler classification needs clarity |
| 3 | Make user-authoritative in-workout decisions | Uses Epic 1 facts and manual RPE; does not require future Epic 7 automation | Pass |
| 4 | Review History/Analysis and reconcile future Plan | Uses Epics 1–2; does not depend on later exchange/Health/automation | Pass |
| 5 | Exchange one Plan as a safe independent draft | Uses earlier validation/commit path; GATE-7 is ordered before import acceptance | Pass; gate/parser Stories need enabler labels |
| 6 | Use Apple Health while retaining local truth | Uses earlier authorization preview; GATE-3 dependencies are backward and explicit | Pass; evidence Story needs enabler label |
| 7 | Gain evidence-gated Watch assistance with manual fallback | Depends only on Epic 1 manual core and earlier contracts; each automation gate is independent | Pass; many evidence/enabler Stories |
| 8 | Complete controlled review and reusable Alpha loop | Integration Epic intentionally consumes all earlier Epics; no forward dependency | Pass |

No Epic is a purely technical milestone. Every Epic title and goal states a trainee or Product Owner outcome, and Epic 1 remains a usable manual product even when later Epics are absent or disabled.

### 🔴 Critical Violations

None found. There are no technical-only Epics, forward dependencies on later Stories, circular Epic dependencies, or missing acceptance/traceability blocks.

### 🟠 Major Issues

1. **Ten Stories are oversized for reliable single-Sprint execution.** Stories 1.6 (11 scenarios), 1.7 (11), 1.8 (13), 1.9 (12), 1.10 (12), 1.11 (12), 1.12 (15), 1.13 (14), 1.14 (15), and 2.1 (13) combine multiple independently testable concerns. Stories 1.12–1.14 are the highest risk because each spans domain behavior, persistence, transport/runtime, accessibility, failure handling, idempotency, and integration evidence. Before Sprint commitment, split them along durable vertical boundaries or create explicit child tasks with independent completion evidence while preserving their parent acceptance contract.
2. **Twenty-three Stories are technical, gate, or evidence enablers rather than direct end-user slices.** They are 1.1–1.4; 2.1–2.3, 2.5–2.6; 5.2–5.3, 5.5; 6.3; 7.1–7.3, 7.7–7.8, 7.11–7.13; and 8.4–8.5. These controls are necessary and well ordered, but create-epics best practice should not disguise them as ordinary user Stories. Label them explicitly as `Enabler`, `Compliance`, or `Evidence` Stories, retain their user-risk rationale, and plan them as prerequisites to the named user-value path.
3. **The greenfield quality pipeline is implied but not scheduled early.** Architecture AD-13 requires compile/domain/schema/safety/persistence/sync/AI-contract and secret checks on every change. Story 1.1 defines builds and dependency tests but no CI runner, required-check policy, artifact retention, or secretless pull-request path. Add an acceptance criterion or early enabler to establish reproducible Apple Silicon/macOS CI and required checks before parallel implementation begins.

### 🟡 Minor Concerns

- Several Stories repeat cross-cutting accessibility, failure, idempotency, and scope-exclusion criteria. This is safe but verbose; shared acceptance policies or test suites could reduce drift while each Story retains only its unique proof obligations.
- Gate Stories correctly fail closed, but Sprint status must distinguish `implemented`, `evidence passed`, and `feature enabled`; otherwise a completed adapter Story could be misreported as a usable capability.
- Historical wording in supporting design artifacts should not be copied into Story refinements without the documented authority order.

### Dependency and Database Timing Findings

- No Story references a later-numbered Story as a prerequisite.
- Cross-Epic references are backward or deliberately use synthetic/fail-closed inputs. Epic 3 can use manual Actual RPE from Epic 1 without waiting for Epic 7; Epic 2.8 can render a fail-closed/synthetic Health preview before Epic 6 produces eligible summaries.
- Story 1.1 explicitly prohibits speculative tables. Story 1.4 creates only schema/revision/outbox/invalidation/idempotency foundations; business tables are introduced when the owning capability first needs them. This complies with incremental database creation.
- Architecture specifies a structural seed rather than an external starter template. Story 1.1 correctly owns workspace, targets, package boundaries, exact GRDB pinning, launchability, and dependency-direction tests.

### Remediation Before Sprint Commitment

1. Mark the 23 prerequisite/control items with explicit enabler types and Gate ownership.
2. Split or task-decompose the 10 oversized Stories, prioritizing 1.12–1.14 and 1.8–1.11.
3. Add early CI/required-check acceptance to Story 1.1 or a directly following enabler.
4. Preserve the existing Story order: it contains no forward dependency that requires reordering.

## Summary and Recommendations

### Overall Readiness Status

**READY FOR SPRINT PLANNING — refinement required before individual Sprint commitment.**

The private-Alpha planning baseline is coherent and traceable: 78 of 78 in-scope FRs are scheduled across 8 Epics and 69 Stories; all 13 later-scope FRs remain explicitly deferred; all Stories contain BDD acceptance criteria and traceability; and no forward or circular dependency was found. PRD, UX, Native UI, Architecture, and Epic sequencing agree on the core invariants and fail-closed Gate model.

This result authorizes Sprint Planning, not automatic enablement of gated capabilities. Each named Gate remains a hard prerequisite for its corresponding safety, remote-AI, Health-derived remote use, recognition, RPE, forgotten-Finish, or Plan-import path.

### Critical Issues Requiring Immediate Action

None block entry into Sprint Planning.

The following become blocking at the stated boundary:

- The Native UI Apple Health authorization wording must be corrected before Story 2.8 or 6.4 implementation is accepted.
- Oversized Stories must be decomposed before they are committed to a Sprint as independently deliverable units.
- GATE-1–GATE-7 cannot be bypassed; the corresponding capability remains disabled until its owned decision/evidence Story passes.
- Professional safety review remains mandatory before release beyond Product Owner testing.

### Non-Blocking Improvement Summary

Six issue clusters require attention across two categories:

1. **Document alignment and governance (3):** stale Apple Health exclusion in `native-ui-spec.md`; stale `draft`/reviewer-gate metadata; historical design-direction wording requiring the authority order.
2. **Epic/Story execution quality (3):** 10 oversized Stories; 23 technical/gate/evidence Stories needing explicit enabler classification; missing early CI/required-check acceptance despite AD-13.

### Recommended Next Steps

1. Proceed to Sprint Planning using the current Epic order and S0→S7 slices; preserve Gate Stories as explicit fail-closed prerequisites.
2. Before Sprint commitment, split or task-decompose Stories 1.6–1.14 and 2.1, prioritizing Stories 1.12–1.14, while retaining parent acceptance and traceability.
3. Label the 23 prerequisite/control Stories as `Enabler`, `Compliance`, or `Evidence`, with owner, evidence artifact, enabled path, and default-disabled path visible in Sprint status.
4. Update `native-ui-spec.md` to permit only GATE-3-approved, one-shot-authorized local Apple Health summaries, and normalize authoritative document status/frontmatter across PRD, UX, and Native UI artifacts.
5. Add reproducible Apple Silicon/macOS CI and required-check acceptance to Story 1.1 or a directly following enabler, implementing the AD-13 check set before parallel feature work.
6. In Sprint Planning, distinguish `implemented`, `evidence passed`, and `feature enabled`; never report a completed adapter or candidate model as an enabled user capability.

### Final Note

This assessment identified 6 non-blocking issue clusters across 2 categories and no critical Sprint-Planning blocker. FitnessAI may proceed to Sprint Planning now. The identified refinement items should be completed before committing affected Stories, and every named release/evidence Gate must close before its corresponding capability is enabled or release readiness is claimed.

**Assessment date:** 2026-09-11  
**Assessor:** Codex — BMAD Implementation Readiness workflow

---
title: FitnessAI
status: draft
created: 2026-07-19
updated: 2026-09-10
---

# PRD: FitnessAI

## 1. Vision

FitnessAI is an AI-native strength-training companion for Apple Watch and iPhone users in mainland China. It joins two product promises: a complete, truthful workout record with almost no interaction during training, and a conversation-to-plan path that turns the user's goals, experience, schedule, equipment, physical limitations, and permitted training evidence into an executable Training Plan without manual reconstruction.

Trustworthy recording is the product foundation, while native AI plan orchestration is the primary product differentiator. AI may create a complete structured Training Plan or Plan Change Proposal and write it into the App after one explicit user approval. It never silently changes an effective plan, historical Actual Sets, or an active Workout Session. Approved plans synchronize to Apple Watch for execution; confirmed training results can then inform the next user-invoked proposal.

## 2. Target User

FitnessAI serves strength trainees across experience levels. A user may arrive with an existing plan, need a first plan, or want to revise a current plan through AI conversation. Having a Training Plan changes the entry path but is not an eligibility requirement. The intermediate product-owner journey remains a representative seed journey, not an exclusion boundary.

### 2.1 Jobs To Be Done

- **Primary functional job:** When I am strength training, capture the exercise, sets, reps, load, and RPE that I actually complete with almost no manual interaction, so I can stay focused and still trust the final record.
- **Plan-execution job:** When reality differs from my Training Plan, help me adjust the next set or substitute an exercise without silently changing my decisions or losing what I completed.
- **Learning and planning job:** When I review a week, month, or cycle, show what I trained and how my primary exercises are progressing, so I can make the next Training Plan more deliberate.
- **AI planning job:** When I need to create or adjust a Training Plan, let me describe my goal, experience, schedule, equipment, preferences, and physical limitations in natural language; generate a complete executable plan or change proposal that I can review and approve once, without rebuilding it item by item.
- **Emotional job:** Let me see credible evidence that I am progressing, so the record reinforces motivation as well as planning.

### 2.2 MVP Success Definition

**Primary success metrics**

- **SM-COMP-001 — Recorded-information completeness:** Every piece of information the user records, enters, corrects, or confirms during a Workout Session must appear in the durable final record. If any such item is missing, the session is incomplete, even if the rest of the session is usable.
- **SM-ACC-001 — Initial recognition accuracy:** Automatic recognition is measured independently from recovery. If an exercise is recognized incorrectly and corrected promptly after the first set, the record may be successfully recovered, but the original recognition still counts as a recognition failure.
- **SM-PRES-001 — Correction data preservation:** Correcting an exercise label or other recognized field must preserve the already captured set, repetitions, load, RPE state, and timing. Any captured user information lost during correction is a core-function failure.
- **SM-RET-001 — Default-recorder continuation:** A user who concludes that FitnessAI is useful should use it for every subsequent strength-training session, rather than alternating with another recorder. The pilot measures four-week continuation and the share of the user's subsequent self-reported or observable strength sessions recorded with FitnessAI. The Product Owner must pre-register the cohort threshold, denominator, minimum completed-session count, and handling of unobservable or self-reported sessions before the first holdout result is viewed; the threshold cannot be changed after unblinding.
- **SM-FEED-001 — Core-function feedback:** No critical or recurring negative-feedback theme should remain unresolved for recording, correction, final-record trust, or session continuity. Before pilot interviews begin, the Product Owner must define criticality, recurrence, interview cadence, and closure evidence. This is measured through proactive session review and interviews, not inferred from user silence or the absence of store reviews.
- **SM-INT-001 — Proactive-interruption budget:** In a representative Workout Session of approximately five exercises and twenty working sets, Apple Watch may proactively request confirmation or correction no more than five times in total. The sixth request makes the session unacceptably interruptive. Exercise, rep, load, and RPE prompts all consume the same budget.
- **SM-AI-001 — Native plan conversion integrity:** Every user-approved AI plan proposal in the supported release path must become one complete structured Training Plan revision. A lost field, silently omitted unmapped Exercise, duplicate write, or partial activation is a failure.
- **SM-AI-002 — No silent plan mutation:** The number of effective Training Plan changes without the explicit approval required by this PRD must be zero.
- **SM-E2E-001 — First usable build loop:** The Product Owner can complete conversation → full-plan review → one approval → native App commit → paired-Watch execution → Actual Set return → AI change proposal without manually rebuilding exercises or sets.
- **SM-ALPHA-CORE-001 — Personally usable core loop:** Across representative personal training sessions, the Product Owner can use the same private-Alpha App for automatic supported-Exercise capture, opt-in RPE estimation, conservative forgotten-Finish assistance, complete History/Analysis, Apple Health round-trip, first-party plan exchange, and post-session AI review without returning to another primary workout recorder. Experimental model errors remain visible and correctable rather than being counted as successful automation.

**Counter-metrics**

- Completeness achieved through excessive prompts is not success; prompts and required corrections per Workout Session must be reported alongside completeness, with the five-request representative-session budget enforced separately.
- A recovered record must not inflate automatic-recognition accuracy.
- Retention must not be reported without the corresponding number of completed Workout Sessions and recording-abandonment rate.
- Fast-path completion of the private Alpha loop is not evidence of public-beta safety, retention, AI quality, or differentiation; those gates remain separate.

### 2.3 Key User Journeys

- **UJ-1. Wei, an intermediate trainee, completes a planned strength session quietly and leaves with a complete, truthful record.**
  - **Persona + context:** Wei is the product owner and a strength trainee with three years of experience who has moved beyond the beginner stage. Exercises and set counts are normally planned before the session, and target RPE guides load selection.
  - **Entry state:** He arrives at the gym, puts down his bag, and warms up. Today's Training Plan is available on iPhone, and Apple Watch is ready to carry the in-workout experience.
  - **Path:**
    1. He opens today's Training Plan and starts the Workout Session on Apple Watch.
    2. If planned equipment is occupied, he requests alternatives and FitnessAI recommends substitute exercises that target the same body area and use a similar movement pattern and range of motion.
    3. He chooses whether to use a substitute; the Training Plan is not silently changed.
    4. During formal training, FitnessAI stays quiet by default and captures or accepts the Actual Set with as little interaction as possible. The first planned set prefills its planned load, and each subsequent set defaults to the previous Actual Load; the user changes the value only when the real load differs.
    5. The RPE flow runs only if the user enables RPE display or tracking. The first five eligible estimates are confirmed or corrected by the user. If at least four are correct, FitnessAI offers to stop routine confirmation; after explicit consent, later high-confidence results may be automatically used while retaining model-derived provenance. If at least two are wrong, FitnessAI applies local personal calibration from the corrected labels and begins a new five-estimate verification window. Low-confidence, unfamiliar, or drifting cases may still abstain or ask a concise question.
    6. Using Actual RPE and the remaining Training Plan, FitnessAI may suggest a load adjustment for the next set.
    7. The user chooses whether to accept or reject the suggestion; FitnessAI never changes the next-set load without that choice.
    8. FitnessAI records the exercises, sets, reps, load, and Actual RPE that were actually completed, even when they differ from the Training Plan.
    9. The user normally finishes the Workout Session manually. If FitnessAI detects both sustained recovery toward the user's non-training state and sustained absence of strength-training activity, it may ask whether training is complete; it never ends the session automatically. After the user finishes or confirms completion, FitnessAI shows the complete session record and the body areas trained.
    10. If the completed content or Actual RPE differs from the Training Plan, FitnessAI asks whether the user wants to update the future Training Plan.
  - **Climax:** The user completes the session without repeatedly switching between Apple Watch and iPhone, while retaining a complete record that reflects what actually happened.
  - **Resolution:** The completed Workout Session becomes available in Training History for later trend and period analysis.
  - **Edge case:** Rejecting a load suggestion or declining a Training Plan update preserves the user's chosen Actual Set and leaves the future plan unchanged.

- **UJ-2. Wei reviews the week and adjusts the next Training Plan with evidence.**
  - **Persona + context:** Wei periodically wants to understand whether the week's work was sufficient and whether his primary exercises are progressing.
  - **Entry state:** At the end of a week or while preparing the next one, he opens Training History or Analysis on iPhone.
  - **Path:**
    1. He sees how many Workout Sessions he completed during the week and which exercises he performed.
    2. He reviews each session's training volume and intensity rather than relying on memory.
    3. He opens trend views for his primary exercises to see whether performance is improving over time.
    4. He uses the weekly evidence to decide whether the next Training Plan should change in frequency, exercise selection, volume, intensity, or load.
  - **Climax:** The user can explain what changed in his training and make a deliberate next-week adjustment.
  - **Resolution:** The review produces both a more informed next Training Plan and the emotional reward of seeing visible progress.
  - **Edge case:** Ad-hoc Workout Sessions are included from their Actual Sets so weekly analysis reflects completed work rather than planned work.

- **UJ-3. Kai completes a spontaneous session with a friend and later reuses what worked.**
  - **Persona + context:** While training with a friend, Kai may ignore existing templates and choose Exercises based on what they want to do in the moment.
  - **Entry state:** He begins an ad-hoc Workout Session without selecting a predefined Training Plan.
  - **Path:**
    1. He and his friend choose exercises freely during the session.
    2. Without exercise preselection, Apple Watch automatically recognizes the exercise and reps. The first set prefills the most recent Actual Load for that exercise when history exists; otherwise the user enters it. Each subsequent set inherits the previous Actual Load until the user changes it.
    3. FitnessAI asks for confirmation only when recognition is uncertain. If the exercise label is wrong, FitnessAI surfaces the correction after the first set rather than waiting until the Workout Session ends.
    4. FitnessAI persists the first Actual Set data, including reps, load, and Actual RPE, independently of the exercise label; correcting the label does not discard the set.
    5. Subsequent sets continue under the corrected exercise, and FitnessAI preserves every Actual Set even though no Training Plan exists.
    6. After the session, the complete ad-hoc Workout Session appears in Training History.
    7. If he wants to repeat that combination later, he opens the historical session and reuses it as the starting point for another session or a future Training Plan.
  - **Climax:** A spontaneous social session does not create more recording work than a planned session, and an early recognition error does not make completed effort feel wasted.
  - **Resolution:** An unplanned but successful session becomes reusable rather than disappearing into an incomplete log.
  - **Edge case:** If an exercise remains unrecognized after the first set, the user can correct its label without losing the current session or any captured Actual Set data.

- **UJ-4. Lin turns an AI conversation into an executable Training Plan and later revises it from trusted evidence.**
  - **Persona + context:** Lin wants a structured plan without manually programming every exercise and set. Lin may be a beginner creating a first cycle or an experienced trainee revising an existing plan.
  - **Entry state:** On iPhone, Lin starts a text conversation with AI to create or revise a Training Plan.
  - **Path:**
    1. Lin describes goals, experience, weekly availability, session time, equipment, preferences, and known injuries or physical limitations in natural language. FitnessAI asks only the clarifying questions needed to produce a usable proposal and keeps unresolved assumptions visible.
    2. If Lin reports a current injury, recovery state, or warning sign, FitnessAI applies the non-diagnostic safety behavior in FR-058 before continuing.
    3. AI produces a complete structured Training Plan Draft containing cycle duration, weekly frequency, exercises, session order, sets, repetitions, suggested load, and optional target RPE.
    4. FitnessAI maps every supported exercise to a canonical Exercise record. Unknown Exercises, unsupported fields, and conflicting constraints remain visible; the system does not invent mappings.
    5. Lin can continue the conversation to change the draft without manually rebuilding its exercises and sets.
    6. For a new plan FitnessAI shows the complete draft; for a revision it shows a field-level Plan Change Proposal against the active revision, including affected future sessions.
    7. One explicit approval causes an atomic local commit of a complete new Plan Revision. A failed validation or commit leaves the prior active plan unchanged.
    8. The approved Plan Revision synchronizes to the paired Apple Watch with a visible pending, delivered, or failed state; Lin does not recreate it on either device.
    9. Lin completes a Watch Workout Session against the plan snapshot that was active at Start, producing user-authoritative Actual Sets.
    10. When Lin explicitly requests a review, FitnessAI may use permitted confirmed records and subjective feedback to explain and propose the next change.
    11. Lin approves the complete diff once or rejects it. Approval creates another atomic revision; rejection leaves the active plan unchanged.
  - **Climax:** One conversation becomes a native, executable Training Plan on iPhone and Watch without item-by-item import.
  - **Resolution:** Trusted completed training can feed the next user-invoked proposal while the user remains the authority over every effective plan revision.
  - **Edge case:** AI, validation, commit, or synchronization failure never corrupts the active plan or blocks access to the last confirmed plan and local workout recording.

- **UJ-5. Ming changes devices and continues from the same trusted record.**
  - **Persona + context:** Ming replaces or adds an iPhone or Apple Watch and expects prior work to remain available.
  - **Entry state:** The new device has no FitnessAI local database yet.
  - **Path:**
    1. The user signs into the same FitnessAI Account on the new supported device.
    2. FitnessAI restores account-scoped Training Plans, structured Training History, Actual Sets, confirmed RPE, analytics inputs, and compatible compact personal-model summaries from the application cloud.
    3. New workout events continue to commit locally first and synchronize after the local write succeeds.
  - **Climax:** The user can review history and begin the next Workout Session without manually rebuilding plans or losing progress.
  - **Resolution:** The local device remains reliable offline while the FitnessAI Account provides continuity across supported devices.
  - **Edge case:** If the network is unavailable or synchronization is interrupted, local recording continues; pending events synchronize later without silently overwriting a newer user correction.

## 3. Product and Platform Boundaries

### 3.1 MVP Surfaces and Device Topology

- When Apple Watch is selected as the active capture device, it is the active-session surface and authority. A user can start, record, correct, resume, and finish that Workout Session without an iPhone or backend being reachable during the session.
- iPhone supports a first-class phone-only Workout Session path using the same session identities, durable states, correction rules, and Analysis as paired-Watch capture. It also owns AI conversation, data-scope consent, complete-plan or diff review, explicit plan approval, Training Plan management, complete correction and conflict resolution, Training History, complete Alpha Analysis, Apple Health controls, FitnessAI-plan import/export/share, recovery coordination, and supported-device state. FitnessAI Account and application-cloud restoration are not required for the private Alpha.
- Apple Watch executes only a locally committed and user-approved compatible Plan Revision. The first usable build may rely on paired iPhone–Watch delivery; application-cloud account synchronization is a separate public-beta and cross-device-continuity concern.
- The MVP implementation baseline is Apple Watch Series 6 or later on watchOS 11 or later, paired with iPhone 11 or later on iOS 18 or later. Architecture may narrow this matrix only when a documented physical-device capability test fails and the Product Owner approves the resulting support change.
- The release support matrix must name every supported Watch/iPhone/OS combination, required signal, and supported Exercise family. An unlisted combination or Exercise is unsupported and must fall back to manual recording without implying automatic coverage.

### 3.2 Evidence Gates

- **Recognition feasibility gate:** on a frozen evaluation set separate from development and calibration data, supported-Exercise classification accuracy must reach at least 75% of all confirmed working sets in the registered support matrix; abstentions and silent misses remain in the denominator and are not correct classifications. A predicted set boundary matches only when both its start and end are within ±3 seconds of the confirmed boundary; boundary precision and recall must each reach at least 80%. At least 80% of confirmed supported Actual Sets must have repetition error within ±2, with mean absolute error also reported. Results must include macro and micro aggregates, silent misses, false sets, abstentions, 95% confidence intervals, and every pre-registered Exercise/device/failure-family slice. Passing this feasibility gate permits expansion work; it is not permission to hide unsupported Exercises.
- **Recording integrity gate:** representative full Workout Sessions must survive sensor gaps, Watch–iPhone disconnection, app termination, device restart, and delayed synchronization without losing committed user information, duplicating Actual Sets, or silently changing a correction.
- **Differentiation validation gate:** automatic exercise and repetition recognition alone is not treated as differentiated because Chinese-localized competitors already offer it. Before public positioning is frozen, the Product Owner must validate whether trustworthy recovery, near-zero interaction, and user-authoritative correction are meaningfully preferred by the target cohort.
- **AI plan-commit gate:** an AI proposal cannot become effective until its versioned structure and canonical Exercise mappings validate, the user can review the complete plan or complete field-level diff, and one explicit approval produces an all-or-nothing local commit. A partially mapped or partially committed plan never becomes active.

## 4. Glossary and Measurement Definitions

- **Actual Set** — The user-authoritative record of one completed or attempted working set, including Exercise, order, repetitions, Actual Load, RPE state when enabled, timestamps, provenance, and completeness state.
- **Complete Workout Session** — A finished Workout Session in which every item the user recorded, entered, corrected, or confirmed is present in the durable record and no required field remains unresolved.
- **Incomplete Workout Session** — A finished or interrupted Workout Session with one or more visible missing or pending required fields. It remains editable and does not become complete until those fields are resolved.
- **Supported Exercise** — An Exercise explicitly listed for automatic recognition in the versioned release support matrix for the active device/signal combination.
- **Supported Device** — A named Watch/iPhone/OS combination in the release support matrix; the term never means merely “an Apple device on which the app installs.”
- **Recognition state** — The status of an automatic Exercise, repetition, or set-boundary result: accepted, uncertain, corrected, or unresolved. The state and provenance remain attached to the affected fact.
- **RPE state model** — Target RPE is planned guidance; Predicted RPE is a model output; User-confirmed Actual RPE is explicitly confirmed; Auto-used Actual RPE is a prediction used only under the opt-in trust policy; Corrected RPE replaces an earlier effective value by user action. Effective Actual RPE is the single value used by guidance and Analysis, always with its provenance.
- **Training History** — The user-visible collection of completed and Incomplete Workout Sessions and their revisions. “Workout History” is not a separate domain object.
- **Training volume** — For externally loaded sets, the sum of corrected repetitions multiplied by user-authoritative Actual Load. Bodyweight, assisted, timed, or otherwise non-comparable work is reported separately rather than converted by an invented load.
- **Training intensity** — The distribution and trend of corrected Actual Load, repetitions, and Actual RPE where available; it is not presented as percent-of-one-repetition-maximum unless that baseline was separately measured.
- **Training duration** — Elapsed time from user Start to authoritative Finish, with interrupted/recovered periods retained and visibly distinguished where analysis excludes them.
- **Primary Exercise** — An Exercise the user explicitly selects for a trend view; FitnessAI does not silently choose a permanent primary list.
- **Trend baseline** — Corrected, complete Actual Sets for the selected Exercise and comparison period. Incomplete sets remain visible but are excluded from aggregate claims unless the calculation labels their treatment.
- **Training Plan Draft** — A complete but non-effective candidate plan that can be edited or regenerated without changing the active plan.
- **Plan Change Proposal** — An immutable, non-effective, provenance-bearing field-level diff against a named base Plan Revision, identified by `proposalId` and a content digest. Any regenerated or edited content is a new proposal requiring new approval.
- **Plan Revision** — An immutable, versioned Training Plan state created by one successful atomic commit; a later change creates another revision rather than rewriting history.
- **Active Training Plan** — The latest user-approved compatible Plan Revision selected for future Workout Sessions.
- **Atomic Plan Commit** — An all-or-nothing local operation that creates and activates one complete Plan Revision or leaves the prior active revision unchanged.
- **User Approval** — A deliberate confirmation tied to one displayed complete plan or complete field-level diff; viewing, chatting, or requesting generation is not approval.

## 5. Non-Goals (Explicit)

- Diagnose injuries, determine injury severity, or recommend rehabilitation exercises.
- Claim precise joint angles, full-body form quality, true bar path, or true bar velocity from Apple Watch wrist data.
- Automatically sense external load from Apple Watch; user entry or correction is authoritative.
- Treat heart rate alone, or a model prediction outside the user's verified and explicitly enabled auto-use policy, as the user's Actual RPE.
- Let AI silently activate a new plan, rewrite historical Actual Sets, or change an active Workout Session.
- Provide a general medical, lifestyle, or unrestricted coaching assistant outside the bounded Training Plan creation and revision journey.
- Use voice entry, continuous listening, raw sensor streams, imported-plan contents, or cloud-restored copies as remote AI-planning inputs in the first usable build. User-selected, locally summarized Apple Health categories may be used only under a one-shot per-request authorization and only after the provider, legal, privacy, data-region, retention, training-use, deletion, revocation, and user-rights gate is closed; local Apple Health interoperability and first-party plan files remain available independently.
- Import arbitrary third-party plan formats or provide server-backed link/QR sharing in the first usable build.

## 6. MVP Scope

### 6.1 First Usable Build / Core-Product Private Alpha

“First version” means a personally usable core-product App for the Product Owner, not a narrow technical walking skeleton and not a public beta. It must support repeated real training and expose the product's core value:

- the complete AI conversation → structured Training Plan Draft or full field-level diff → digest-bound approval → atomic Plan Revision commit → paired-Watch delivery loop;
- a first-class phone-only planned and ad-hoc Workout Session path using the same identities, durable state machine, correction semantics, and Analysis as paired-Watch capture;
- Watch automatic Exercise/set/rep recognition for a frozen supported whitelist, with confidence, abstention, rapid correction, manual fallback, and durable Actual Sets;
- optional automatic RPE estimation under the five-estimate verification, provenance, abstention, correction, drift, and explicit auto-use rules;
- the conservative intelligent forgotten-Finish reminder using both required signals, never automatic session termination, and always retaining manual Finish;
- complete Alpha Training History and Analysis: weekly/monthly sessions, Exercise participation, volume, intensity, Actual Load, duration, and selected Primary Exercise trends derived from effective Actual Sets;
- contextual least-privilege Apple Health read access for necessary workout/health data and idempotent writing of completed FitnessAI Workout Sessions, with visible unavailable/failed/detached states;
- FitnessAI-owned versioned single-plan export/import, complete pre-save preview, and native iOS Share Sheet sharing; arbitrary third-party formats and server-backed link/QR sharing remain excluded;
- one non-blocking proactive post-session AI review invitation, which may be disabled or deferred and does not send data or create a proposal until the user accepts; every resulting change still requires complete diff review and explicit approval;
- a coherent, test-ready final visual system and complete layout for every private-Alpha surface, while public-launch brand polish and broad device optimization remain later gates;
- continued access to the current plan and local workout recording when AI, Apple Health, iPhone–Watch delivery, or import/export is unavailable.

Experimental automation may use a deliberately narrow Exercise/device whitelist, but private use does not relax record integrity, uncertainty, correction, privacy, safety, atomicity, or no-silent-mutation requirements. Passing this Alpha is not permission for public beta.

The normative private-Alpha acceptance set is `SM-COMP-001` through `SM-INT-001`, `SM-AI-001`, `SM-AI-002`, `SM-E2E-001`, and `SM-ALPHA-CORE-001`; `FR-001` through `FR-041`, `FR-043`, `FR-046` through `FR-047`, `FR-049` through `FR-050`, `FR-052` through `FR-066`, `FR-071` through `FR-073`, and `FR-078` through `FR-091`; plus the applicable `NFR-RPE`, `NFR-SESSION`, `NFR-REC`, `NFR-RECOV`, `NFR-COMPAT`, `NFR-PRIV-001`, `NFR-PRIV-003`, `NFR-PRIV-007`, `NFR-SEC-003`, `NFR-SAFE-001`, `NFR-AI-001` through `NFR-AI-006`, `NFR-PORT-001`, `NFR-HK-001` through `NFR-HK-002`, and `NFR-UX-001`. Rich exercise media under FR-051 and application-cloud account requirements remain later scope unless Architecture identifies a local dependency.

### 6.2 MVP / Public-Beta In Scope

- Automatic Workout Session recording and immediate correction: exercises, sets, reps, load, Actual RPE, confidence-based confirmation or abstention, and partial-data preservation. A model-suggested RPE remains provisional unless the user has explicitly enabled auto-use after a successful personal verification window; auto-used values retain model provenance and remain correctable.
- Training Plan execution and in-session adjustment: target RPE, next-set load suggestions, unavailable-equipment substitutes, Actual Set reconciliation, and user-authoritative load editing with plan/history/previous-set defaults.
- Training History and Analysis: history, primary-exercise trends, and weekly or monthly volume, intensity, load, and duration analysis.
- Local-first account synchronization: durable local workout writes, subsequent China-region application-cloud synchronization, and cross-device restoration of plans, structured history, confirmed RPE, analytics inputs, and compatible personal-model summaries. Complete high-frequency sensor streams remain local by default.
- Exercise catalog and teaching: Exercise mapping, target body areas, explanatory text, properly licensed images, and concept explanations such as RPE.
- AI-native Training Plan orchestration: bounded text conversation, complete structured plan creation, canonical Exercise mapping, full-plan or diff review, explicit approval, atomic Plan Revision, paired-Watch delivery, and user-invoked evidence-bounded revision.

### 6.3 Out of Scope for the First Usable Build

- Automatic activation of any AI plan or change without the explicit approval defined in this PRD.
- Autonomous plan mutation, weekly/cycle-end proactive cadence, unrestricted coaching, and remote AI use of raw sensor streams, imported-plan contents, or cloud-restored copies. Remote AI use of user-selected local Apple Health summaries is permitted only through the separate one-shot authorization and fail-closed provider/compliance gate. **Decide any broader scope from Alpha evidence.**
- Voice entry or continuous listening. **Reserved for Post-MVP.**
- Application-cloud accounts, cross-device history restoration, and rich teaching media may follow the private Alpha.
- Arbitrary third-party plan formats and server-backed link/QR sharing are **deferred to Post-MVP / V2**; native iOS Share Sheet sharing of a FitnessAI-owned plan file is in scope.
- Public-launch visual polish, marketing surfaces, and broad device-specific optimization remain separate from the complete test-ready Alpha visual/layout contract.

### 6.4 Planned Follow-On Scope

- **Public beta — Account continuity and release hardening:** China-region application-cloud account synchronization, cross-device history restoration, broad physical-device validation, professional safety review, and public-launch privacy/security approval.
- **Post-MVP — User-invoked voice entry:** reserve voice as an optional input source for structured workout facts. Parsed results remain provenance-bearing, correctable drafts until the user explicitly confirms or corrects them under the applicable conflict rules. Continuous listening and open-ended conversational coaching remain outside this commitment.
- **Post-MVP / V2 — Broader plan exchange:** evaluate third-party plan formats and QR/link sharing as separate capabilities, each requiring preview, compatibility handling, provenance, privacy boundaries, and protection against silent overwrite.
- **Post-Alpha — AI experience optimization:** use observed completion, correction, rejection, latency, and trust evidence to choose conversation form, explanation density, weekly/cycle-end cadence, broader permitted data sources, and any bounded auto-adjustment policy.

## 7. Functional Requirements

### 7.1 Workout Session and Record Integrity

- **FR-001:** The user can start a planned or ad-hoc Workout Session on iPhone or Apple Watch. Phone-only and paired-Watch sessions use the same identities, durable state model, correction rules, and Analysis; when Watch is the selected capture device, Watch remains authoritative for that active session.
- **FR-002:** FitnessAI records each Actual Set as a structured record containing the exercise state, set order, repetitions, Actual Load, RPE state when enabled, and timing required by history and analysis.
- **FR-003:** FitnessAI durably commits captured and user-entered workout information locally before treating it as saved or attempting cloud synchronization. It must not represent a user action as saved, corrected, finished, or discarded until that local commit succeeds.
- **FR-004:** The user can manually finish a Workout Session, and manual Finish is authoritative.
- **FR-005:** FitnessAI may ask whether a Workout Session is complete only when sustained recovery and sustained absence of strength-training activity are both present; it cannot end the session automatically.
- **FR-006:** After completion, FitnessAI shows the session's Actual Sets and body areas trained.
- **FR-007:** Missing or pending information remains visible as incomplete rather than being silently removed, guessed, or represented as confirmed.

### 7.2 Automatic Recognition and Correction

- **FR-008:** FitnessAI can attempt to recognize exercises during an ad-hoc Workout Session without requiring exercise preselection.
- **FR-009:** FitnessAI can attempt to detect working-set boundaries and count repetitions from supported Apple Watch signals.
- **FR-010:** FitnessAI assigns a confidence state to automatic exercise and repetition results and distinguishes accepted, uncertain, corrected, and unresolved states.
- **FR-011:** FitnessAI requests confirmation only when required by uncertainty, correction, or another explicitly defined trust gate, subject to the proactive-interruption budget.
- **FR-012:** If the exercise label is wrong, FitnessAI allows correction after the first Actual Set rather than waiting until session completion.
- **FR-013:** Exercise-label correction preserves the already captured set order, repetitions, load, RPE state, and timing.
- **FR-014:** After correction, subsequent Actual Sets continue under the corrected exercise while the correction history remains auditable.
- **FR-015:** FitnessAI reports initial recognition success separately from successful data recovery after correction.

### 7.3 Load, RPE, and Next-Set Guidance

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

### 7.4 Training Plan Execution and Adaptation

- **FR-028:** The user can select and start an existing Training Plan and view planned exercises, sets, repetitions, loads, and optional target RPE.
- **FR-029:** FitnessAI keeps planned content separate from Actual Sets when the completed exercise, set count, repetitions, load, or RPE differs.
- **FR-030:** When planned equipment is unavailable, the user can request substitute exercises.
- **FR-031:** Substitute recommendations must match the canonical primary target body area and movement-pattern category, must be usable with the equipment the user says is available, and must show any difference in secondary target areas or movement range before selection. Acceptance tests use the versioned canonical Exercise attributes rather than free-text similarity.
- **FR-032:** The user chooses whether to use a substitute; FitnessAI cannot silently replace the exercise in the current or future Training Plan.
- **FR-033:** At session completion, FitnessAI identifies material differences between the Training Plan and Actual Sets—including substituted, added, or skipped Exercises or sets and changed repetitions, Actual Load, or RPE—and presents the exact proposed field-level diff for user review. The proposal names the future plan instance or revision it would affect.
- **FR-034:** Declining a suggestion or plan update preserves the Actual Set and leaves the future Training Plan unchanged.
- **FR-035:** The user can reuse a completed historical Workout Session as the starting point for a new draft session or Training Plan without modifying the source history; reuse is distinct from approving an update to an existing future Training Plan.

### 7.5 Training History and Analysis

- **FR-036:** The user can browse completed planned and ad-hoc Workout Sessions in Training History.
- **FR-037:** The user can view how many Workout Sessions were completed in a selected week and which exercises were performed.
- **FR-038:** FitnessAI calculates weekly and monthly training volume, intensity, load, and duration from Actual Sets rather than planned content.
- **FR-039:** The user can view performance trends for selected primary exercises over time.
- **FR-040:** History and analysis preserve corrected values and distinguish user-confirmed or auto-used RPE provenance where relevant.
- **FR-041:** The user can review the full information recorded for a completed Workout Session without fields disappearing after completion.

### 7.6 Account, Offline Use, and Cross-Device Continuity

- **FR-042:** The user can sign in to a FitnessAI Account on a supported device.
- **FR-043:** Workout recording remains usable offline and does not depend on immediate iPhone or backend reachability. When more than one supported Watch starts or restores a Workout Session for the same FitnessAI Account, concurrent sessions remain distinct and recoverable until the user explicitly resolves them; FitnessAI cannot silently merge, discard, or reassign either session's records.
- **FR-044:** After local commit, FitnessAI synchronizes account-scoped Training Plans, structured Training History, Actual Sets, confirmed or provenance-bearing RPE, analytics inputs, and compatible compact personal-model summaries to the application backend.
- **FR-045:** Signing in on another supported device restores synchronized account-scoped data required to review history and continue training.
- **FR-046:** Interrupted, duplicated, delayed, reordered, or concurrent synchronization cannot silently overwrite a newer user correction or create duplicate Actual Sets. FitnessAI preserves every user-authored revision involved in conflicts over field corrections, split or merged sets, deletion, completion state, or Training Plan revisions until an effective revision is determined. FitnessAI cannot resolve these conflicts solely by device time; when deterministic resolution is unsafe, it shows the revisions on iPhone and requires the user to choose. Dependent Analysis and plan proposals remain visibly pending or stale while the effective revision is unresolved.
- **FR-047:** Complete high-frequency sensor streams remain local by default and are not required for ordinary cross-device restoration.
- **FR-048:** The user can request account-scoped data export and account deletion through the product's applicable privacy workflow and can see when each request is accepted, in progress, completed, or failed.

### 7.7 Exercise Catalog and Teaching

- **FR-049:** FitnessAI maps recognized, planned, substituted, and corrected exercise references to canonical Exercise records.
- **FR-050:** An Exercise record can identify target body areas and the movement information required for substitution and analysis.
- **FR-051:** The user can view explanatory exercise text and properly licensed or owned images on iPhone.
- **FR-052:** FitnessAI can explain concepts such as RPE without requiring the user to enable RPE tracking.
- **FR-053:** FitnessAI does not ship unlicensed exercise media or present wrist-only observations as precise full-body form judgments.

### 7.8 AI Conversation, Plan Generation, and Native Write

- **FR-054:** A trainee can start a text AI conversation to create or revise a Training Plan using goals, experience, availability, session time, equipment, preferences, and mandatory known injury or physical-limitation information. Missing answers and AI assumptions remain visible.
- **FR-055:** The user can describe equipment before generation or after reviewing a proposal. FitnessAI may propose a substitute only when its canonical Exercise mapping and relevant movement/body-area rationale are available.
- **FR-056:** FitnessAI can produce a validated structured Training Plan Draft containing cycle duration, weekly frequency, session order, canonical Exercises, sets, repetitions or ranges, suggested load, and optional target RPE. A prose-only response is not a complete plan.
- **FR-057:** Before native creation or revision, FitnessAI shows the complete plan or complete field-level diff, its unresolved fields, and Exercise mappings. One explicit approval triggers an atomic local commit of a complete Plan Revision without item-by-item manual import.
- **FR-058:** Whenever a new or worsening injury, recovery state, or warning sign is disclosed during plan generation, session feedback, or later plan adaptation, FitnessAI stops recommendations for the affected scope until the user explicitly chooses an allowed continuation path. The user can exclude the affected training area or pause generation and seek qualified guidance. Warning signs stop generation and direct the user to offline medical care without naming a diagnosis; uncertainty or a declined answer never permits FitnessAI to infer severity. FitnessAI does not diagnose, assign injury severity, or prescribe rehabilitation.
- **FR-059:** At user request or after the user accepts the private-Alpha post-session review invitation, FitnessAI can use explicitly permitted user-confirmed or corrected FitnessAI structured records and concise subjective feedback to explain and propose a next-session or future-plan change. It applies FR-058 before showing a recommendation and identifies the records and assumptions used.
- **FR-060:** No AI-generated plan or progression change takes effect without explicit approval bound to the displayed immutable `proposalId`, base revision, and content digest. The complete field-level diff includes every added, removed, and changed field that will enter the new revision. Regeneration, editing, a base-revision change, or any content-digest change invalidates prior approval and requires the new proposal to be reviewed and approved; generation, conversation, or viewing alone never authorizes a change.

### 7.9 Truth Correction and Active-Session Recovery

- **FR-061:** During and after a Workout Session, the user can correct repetitions, split or merge a detected set boundary, insert a missed Actual Set, and delete a false Actual Set.
- **FR-062:** The user can resolve every missing or pending required field before or after Finish. Finishing with unresolved fields creates an Incomplete Workout Session rather than discarding data or representing the session as complete.
- **FR-063:** A post-completion correction creates an auditable revision, updates derived Analysis only after an effective revision is determined, and preserves the prior value and provenance without rewriting unrelated fields. Split/merge, deletion, and completion-state revisions follow the same rule.
- **FR-064:** After Watch app termination, device restart, recoverable battery interruption, sensor interruption, or Watch–iPhone disconnect/reconnect, FitnessAI restores the latest durably committed active Workout Session and lets the user Resume, Finish as incomplete, or discard only with explicit confirmation.
- **FR-065:** If recovery finds a partial write or ambiguous set boundary, FitnessAI preserves the recoverable facts as one visible pending Actual Set; it does not silently drop the fragment or create multiple sets from the same event.
- **FR-066:** Recovery and replay are idempotent: the same committed event, transfer, or retry cannot create a duplicate Actual Set or revert a later user correction.

### 7.10 Account and Synchronization Lifecycle

- **FR-067:** Deleting an Actual Set, Workout Session, or Training Plan creates a synchronized deletion state that prevents an offline device, replay, older revision, or pending synchronization queue from silently restoring the deleted item. Confirmed deletion propagates to every reachable product-managed copy with visible completion, failure, and retry state; recoverability, if offered, is explicit and time-bounded.
- **FR-068:** Cross-device restoration reports whether restoration of the required account-scoped records is complete, still in progress, or has failed. The user can continue local recording while restoration is incomplete.
- **FR-069:** On sign-out, FitnessAI asks whether to retain encrypted local account data for later sign-in or remove it from that device, and explains which unsynchronized records would be affected before removal.
- **FR-070:** Signing in with a different FitnessAI Account never silently merges the prior local history. Any eligible transfer or merge requires an explicit, previewable user action.

### 7.11 Planned Input and Training Plan Portability

- **FR-071:** The user can export one Training Plan to a documented, FitnessAI-owned, versioned, machine-readable file and invoke the native iOS Share Sheet for that file. The artifact includes the plan content and the schema, Exercise-catalog mapping, revision, and provenance information required for compatible re-import, and excludes Workout Sessions, Actual Sets, health information, and account credentials.
- **FR-072:** The user can import a compatible FitnessAI Training Plan file on iPhone. Before saving, FitnessAI validates the format and version, previews the complete plan and source, reports unsupported or unresolved fields, and creates a new draft; import never silently replaces or revises an existing Training Plan.
- **FR-073:** Unknown Exercises, incompatible fields, duplicate imports, and newer or unsupported file versions remain visible and recoverable through mapping, explicit omission, cancellation, or a reported failure. FitnessAI cannot invent a mapping or represent a partial import as complete without the user's review.
- **FR-074 (Post-MVP):** A future voice-entry capability may accept user-invoked spoken input for structured workout facts on a supported surface. Every parsed value first becomes a correctable draft with voice-derived provenance and remains distinguishable from sensed, planned, historical, and user-confirmed values. It becomes an effective workout fact only after the user explicitly confirms or corrects it and the local commit succeeds; it cannot silently overwrite a confirmed fact.
- **FR-075 (Post-MVP):** When voice input is unavailable, interrupted, ambiguous, or conflicts with a touch-entered value, sensor-derived value, or synchronized revision, FitnessAI preserves committed facts, exposes the draft or conflict for correction, and keeps an equivalent non-voice recording path available.
- **FR-076 (Post-MVP / V2):** Any future third-party plan import requires a named supported format and version, field and Exercise mapping, unit handling, a complete pre-save preview, partial-failure reporting, and creation of a new draft rather than silent mutation of an existing plan.
- **FR-077 (Post-MVP / V2):** Any future QR- or link-based Training Plan share lets the recipient preview the shared plan and its source before creating a new draft. Sharing cannot include Workout Sessions, Actual Sets, health information, account credentials, or other data outside the explicitly shared Training Plan.

### 7.12 MVP AI Plan Lifecycle

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

### 7.13 Apple Health Interoperability

- **FR-088:** The user can grant and manage contextual, least-privilege Apple Health read access for the versioned private-Alpha allowlist: workouts; heart rate, resting heart rate, one-minute recovery, and HRV; sleep; active/resting energy, steps, and exercise time; body mass, height, body-fat, and lean-mass; VO2 max, respiratory rate, oxygen saturation, and sleeping wrist temperature where available; and explicitly allowed age/biological-sex characteristics. Clinical, medication, laboratory, reproductive, raw ECG, glucose, blood-pressure, and disease-specific types are excluded. FitnessAI distinguishes not requested, no accessible data, available, unavailable, and failed states; it never claims to know that read access was denied when HealthKit does not disclose that fact.
- **FR-089:** After a Workout Session is durably completed, the user can enable FitnessAI to write the completed workout summary to Apple Health. Each write exposes pending, written, and failed/retry states and is idempotent; it never blocks or changes the FitnessAI local record.
- **FR-090:** Deleting or changing the Apple Health copy does not silently delete or rewrite the FitnessAI copy. If the Apple Health copy disappears, FitnessAI marks its record `healthKitDetached` and does not recreate it without a new explicit write action. Remote AI use remains separately governed by FR-082 and FR-086.

### 7.14 Private-Alpha Proactive Review

- **FR-091:** After a completed Workout Session becomes reviewable on iPhone, FitnessAI can show one non-blocking invitation to review future-plan adjustments. The user can Review, Later, or disable the invitation. Merely showing the invitation sends no remote data and creates no proposal; accepting it enters FR-059 and every effective change still requires FR-060 approval.

## 8. Non-Functional Requirements

### 8.1 Application and Model Size

- **NFR-SIZE-001:** The user-acceptable ceiling for the thinned iPhone application variant is 500 MB installed. Download size and installed size must be measured and reported separately.
- **NFR-SIZE-002:** The watchOS application must remain below Apple's 75 MB maximum uncompressed size. FitnessAI adopts an internal target of no more than 25 MB installed on Apple Watch to preserve headroom for code, resources, and future compatibility.
- **NFR-SIZE-003:** For MVP, all machine-learning assets deployed to Apple Watch must total no more than 6 MB, and the per-set RPE component must total no more than 2 MB. Exceeding either budget requires a product-level PRD change supported by physical-device accuracy, energy, and size evidence; an architecture review alone cannot waive the limit.
- **NFR-SIZE-004:** Large exercise-teaching images and nonessential media must not be bundled into the Watch app. They remain on iPhone or are delivered through an appropriately licensed application content service.
- **NFR-SIZE-005:** Release size is verified using Xcode App Thinning size reports and App Store Connect/TestFlight device variants; debug `.app`, `.ipa`, and `.xcarchive` sizes are not acceptance measurements.

### 8.2 RPE Reliability and Uncertainty

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

### 8.3 Workout Session Completion

- **NFR-SESSION-001:** Manual Finish is the normal and authoritative way to complete a Workout Session.
- **NFR-SESSION-002:** A forgotten-finish reminder may appear only when both sustained physiological recovery toward the user's non-training state and sustained absence of detected strength-training activity are present. Either signal alone is insufficient.
- **NFR-SESSION-003:** FitnessAI must not automatically end a Workout Session from inferred inactivity. The reminder asks whether training is complete, and the user chooses Finish or Continue.
- **NFR-SESSION-004:** The reminder trigger and duration must be validated against long inter-set rests, equipment waits, and low-motion exercises. False reminders and missed reminders must be reported separately before release.
- **NFR-SESSION-005:** Before physical-device validation begins, the Product Owner and UX owner must pre-register the personalization rule, sustained-duration windows, missing-signal behavior, cooldown, and maximum false-reminder and missed-reminder rates. The reminder cannot ship if any registered threshold fails, and thresholds cannot be relaxed after the blinded sessions are reviewed.

### 8.4 Runtime Resource Baseline

- **NFR-RES-001:** MVP has no product-specific per-session battery-percentage acceptance target. Physical-device testing must still confirm that FitnessAI can complete representative Workout Sessions without resource-related session termination, material Watch unresponsiveness, or loss of recorded information.
- **NFR-RES-002:** In a representative 90-minute, twenty-working-set physical-device session on every supported Watch/OS pair, there must be zero memory, thermal, or resource-related process termination; zero loss of committed information; and p95 response within one second for Start, correction, and Finish actions. Battery change, thermal state, memory peak, and any interaction exceeding two seconds must be reported even though no battery-percentage release threshold is set.

### 8.5 Recognition, Recovery, and Compatibility

- **NFR-REC-001:** Before final holdout results are viewed, automatic-recognition evaluation must version-freeze participant and chronological partitions, the candidate model, eligibility rules, support matrix, §3.2 thresholds, denominators, and evaluation procedure. A viewed final holdout cannot be reused for tuning. Evaluation reports every registered slice and cannot adjust a rule after results are known.
- **NFR-REC-002:** Unsupported Exercises, devices, signals, and low-confidence results must visibly degrade to manual or pending recording. They cannot be counted as recognition success or represented as supported.
- **NFR-RECOV-001:** Recovery testing must cover app termination, Watch restart, recoverable battery interruption, sensor loss, Watch–iPhone disconnection, a partial local write, repeated transfer, and delayed/reordered cloud delivery. Every committed user item must appear exactly once after recovery, with the latest user correction effective.
- **NFR-COMPAT-001:** Each release must test every named MVP device/OS pair in the support matrix on physical devices. Simulator-only evidence cannot add a device, OS, signal, or Exercise family to supported status.
- **NFR-COMPAT-002:** Each Workout Session and model-derived record must retain the app/schema version and, when applicable, the model, Exercise catalog, and support-matrix versions that produced or interpreted it. Restoration, correction, and Analysis must not silently reinterpret historical values under a newer version.

### 8.6 Privacy, Security, and China-Region Data Governance

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

### 8.7 AI Planning Safety Gate

- **NFR-SAFE-001:** The non-diagnostic stop behavior in FR-058 and the units, contradiction, support, volume, intensity, and load-progression checks in FR-087 are required even in the private Alpha. Before UJ-4 and FR-054 through FR-060 and FR-078 through FR-087 enter any release beyond Product Owner testing, the screening questions, warning-sign rules, plan-safety bounds, allowed continuation paths, and escalation copy require documented review by a qualified exercise or healthcare professional. The reviewed bundle is versioned and acceptance-tested across plan generation, feedback, and adaptation; material change requires reapproval. The review cannot authorize diagnosis, injury-severity assignment, or rehabilitation prescription within ordinary fitness scope.

### 8.8 AI Plan Integrity and Availability

- **NFR-AI-001:** Every AI plan proposal must pass a versioned Training Plan schema and canonical Exercise-mapping validation before it can be committed.
- **NFR-AI-002:** Automated acceptance tests must observe zero effective Training Plan writes without the approval required by FR-057 and FR-060.
- **NFR-AI-003:** Local Plan Revision commit is atomic and idempotent. Paired-Watch delivery is eventually consistent and idempotent: Watch continues to expose the last delivered compatible revision until the complete new revision arrives, never a partial revision. Under fault injection there is no duplicate effective revision, silent rollback, or false “delivered” state.
- **NFR-AI-004:** AI unavailability, invalid output, or timeout cannot prevent access to the current plan, paired-Watch training, or durable local workout recording.
- **NFR-AI-005:** Every effective AI-origin Plan Revision retains the immutable `proposalId`, content digest, approval event, base revision, schema/model and Alpha Plan Safety Rule Pack versions, and data-source summary needed for audit. The committed digest must equal the approved digest; FitnessAI does not store or expose model chain-of-thought.
- **NFR-AI-006:** An unmapped, contradictory, structurally invalid, or safety-excluded output is rejected or returned for clarification rather than completed with invented facts.

### 8.9 Portability, Voice, and Sharing Constraints

- **NFR-PORT-001:** Training Plan files are treated as untrusted input. Import must enforce schema and size limits, reject executable content and malformed structures, preserve the source and format version, and fail safely without changing an existing plan. Share Sheet export is data-minimized to the selected Training Plan.
- **NFR-VOICE-001 (Post-MVP):** Voice input requires observable states for permission, listening, transcription, draft review, confirmation, commit, cancellation, interruption, and unavailability. Raw audio is a separate data class and is not retained, uploaded, or used for model development unless a later product decision defines the purpose and the user gives separate explicit consent.
- **NFR-SHARE-001 (Post-MVP / V2):** A shared plan payload is data-minimized to the intended Training Plan. If a server-backed link is used, access, expiry, revocation, forwarding risk, and China-region data placement must be defined and disclosed before release; a QR code alone is not treated as an authenticity, access-control, or privacy mechanism.

### 8.10 Apple Health and Private-Alpha Experience

- **NFR-HK-001:** Apple Health access follows capability-specific least privilege and remains optional. Missing authorization, unavailable data, or HealthKit failure cannot block the current Training Plan, manual correction, complete FitnessAI History/Analysis from local Actual Sets, or durable Watch recording.
- **NFR-HK-002:** HealthKit writes and retries are idempotent and auditable without storing health-content payloads in operational logs. FitnessAI never reports a write as complete before HealthKit confirms it and never silently recreates a detached Apple Health copy.
- **NFR-UX-001:** Every private-Alpha IA surface must implement the approved bilingual `DESIGN.md` and `EXPERIENCE.md` visual/layout contract with complete light/dark, Dynamic Type, VoiceOver, error, empty, loading, offline, and recovery states. A placeholder or developer-only screen does not satisfy the personally usable Alpha.

## 9. Deferred Validation Gates

These items are resolved as gated future decisions rather than silent open questions. They do not block MVP UX or architecture unless their named feature enters the next phase.

- **DV-001 — Pilot continuation acceptance:** Owner: Product Owner. Revisit before the first SM-RET-001 holdout result is viewed; freeze the cohort threshold, denominator, minimum completed-session count, and unobservable-session policy in the experiment plan.
- **DV-002 — Competitive differentiation:** Owner: Product Owner. Revisit before public positioning or acquisition messaging is frozen; validate the preference for trustworthy recovery, near-zero interaction, and user-authoritative correction against Chinese-localized alternatives. If the preference is not demonstrated, FitnessAI must not use the hypothesis as an acquisition claim; the Product Owner must narrow the target cohort, select and revalidate a different wedge, or stop public-launch expansion before further positioning spend.
- **DV-003 — AI adjustment cadence:** Owner: Product Owner. The private Alpha uses one non-blocking post-session review invitation under FR-091. After Alpha evidence, decide whether to retain it and whether weekly or cycle-end invitations add value; autonomous mutation remains prohibited.
- **DV-004 — Reminder operating point:** Owners: Product Owner and UX owner. The private-Alpha candidate uses 15 sustained minutes of both recovery and no strength activity, suppresses on missing signals, never auto-finishes, and applies a 15-minute cooldown after Continue. Before release validation, pre-register the remaining false-reminder and missed-reminder thresholds required by NFR-SESSION-005; broader operating points still require evidence.
- **DV-005 — RPE operating point:** Owners: Product Owner and model owner. Revisit before blinded RPE evaluation; pre-register all thresholds required by NFR-RPE-014.
- **DV-006 — Expanded AI data and coaching scope:** Owner: Product Owner. Alpha remote AI remains limited to FR-082 data, including only explicitly selected local Apple Health summaries after the separate one-shot authorization and provider/compliance gate. Local availability alone never authorizes remote use. After Alpha, decide whether additional sources, cloud-restored copies, broader windows, raw data, or coaching outside plan changes justify separate permissions and safety contracts.
- **DV-007 — Private-Alpha Training Plan file safety limits:** Owners: Product Owner and architecture owner. Before FR-071 through FR-073 enter Story acceptance, freeze maximum compressed/expanded sizes, nesting depth, plan-day/Exercise/set counts, parser time/memory budgets, and failure reporting; import cannot ship with an unbounded parser contract.
- **DV-008 — AI conversation form:** Owners: Product Owner and UX owner. After private Alpha, use completion, correction, and comprehension evidence to choose chat, cards, or a hybrid; this does not block the first-build data and interaction contract.
- **DV-009 — Proposal explanation density:** Owners: Product Owner and UX owner. After private Alpha, choose default explanation depth from observed comprehension; the complete plan/diff and approval gate cannot be removed.
- **DV-010 — Automatic recognition Alpha whitelist:** Owners: Product Owner and model owner. The first private-Alpha evidence row is frozen to Apple Watch Series 11 46 mm, left wrist, Crown on screen right, right-hand dominant, with v1 candidates barbell bench press, incline dumbbell press, assisted pull-up, barbell row, seated row, lateral raise, hammer curl, and barbell Romanian deadlift. Classification, set-boundary, and rep-count qualification remain independent; unsupported cases are explicit, and expansion requires physical-device evidence.
- **DV-011 — RPE automation Alpha operating mode:** Owners: Product Owner and model owner. Private Alpha includes opt-in prediction, verification, abstention, correction, and optionally verified auto-use; freeze the applicable NFR-RPE operating point before enabling auto-use.
- **DV-012 — AI performance operating point:** Owners: Product Owner and architecture owner. Measure Alpha latency, failure rate, and cost before freezing public-beta response-time, availability, and cost thresholds.

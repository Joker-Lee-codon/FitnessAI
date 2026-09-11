# FitnessAI PRD Addendum

This addendum preserves evidence, rejected alternatives, architecture-relevant mechanisms, and implementation due diligence. `prd.md` is authoritative for product behavior, scope, stable requirement IDs, and acceptance gates; if wording here appears normative, the referenced PRD requirement governs.

## Platform Route Decisions

### Initial delivery route: Apple Watch + iPhone

The initial application route uses the product owner's existing Apple Watch and iPhone. The prerequisite of having an Apple development machine has been met. The initial target users are Apple Watch users in mainland China.

### Rejected first route: vivo watch + vivo phone

The vivo proof of concept did not reach an end-to-end working path. The product owner attributes the failure to insufficient maturity and completeness across vivo's watch-and-phone ecosystem. The vivo route is therefore excluded from the initial product launch scope; this rationale is retained for downstream architecture and platform planning rather than treated as an end-user requirement.

## Exercise Teaching Asset Boundary

The first version may explain exercises with original or properly licensed text and images. Third-party online videos are not a default content source because public availability does not establish commercial reuse rights. Any future animation, GIF, or video library requires asset-level provenance and license review.

The product owner proposed `hasaneyldrm/exercises-dataset` as an image source. Repository review found that its MIT license covers code, tooling, dataset structure, and instruction text/translations, but explicitly excludes `images/` and `videos/`. Those media are attributed to Gym visual, and cloning or attributing the repository does not grant FitnessAI downstream commercial media rights. FitnessAI MUST NOT ship those images or GIFs unless it obtains and archives its own Gym visual license covering commercial mobile-app and Apple App Store distribution; otherwise the media must be replaced with owned, generated, or separately licensed assets. Any reused text or AI-generated teaching copy also requires provenance and professional exercise-safety review.

## Wrist Motion-Feedback Boundary

Prior FitnessAI brainstorming and product-brief work established a conservative boundary for wrist-only sensing. Apple Watch motion data can support exercise classification, rep counting, tempo, coarse wrist range-of-motion and acceleration trends, and within-exercise consistency signals after exercise-specific validation. These are observable proxies, not a reconstruction of the whole body.

A single wrist device cannot generally establish precise joint angles, full-body alignment, trunk compensation, bilateral symmetry, true bar path, or true bar velocity. FitnessAI must therefore not present a generic correct-versus-incorrect form judgment as an MVP fact or safety assessment. Any future Motion Quality Cue must be scoped to a named exercise and observable wrist signal, validated separately, confidence-bounded, explainable to the user, and framed as informational rather than medical or injury-prevention advice.

## Injury Screening and Rehabilitation Boundary

The product owner proposed asking follow-up questions after a disclosed physical limitation, avoiding an affected body area when the issue is severe, recommending rehabilitation-oriented work during recovery, and otherwise continuing normal recommendations. Official-source review found that the intended user benefit should be retained but the AI must not diagnose or assign injury severity in the ordinary fitness MVP.

China's medical-device rules classify software partly by its intended purpose and include software intended to diagnose, treat, alleviate, monitor, or compensate for disease or injury. Official guidance for rehabilitation digital-therapy software distinguishes ordinary fitness or daily health management from software-driven intervention for functional impairment caused by disease or injury. Apple likewise applies greater scrutiny to apps that may diagnose or treat and requires support for accuracy claims. A disclaimer does not change the product's actual intended purpose. Sources: [China Medical Device Regulation](https://www.samr.gov.cn/zw/zfxxgk/fdzdgknr/fgs/art/2023/art_70607fc4160041a383e68ff6bfb2826f.html), [Rehabilitation Digital-Therapy Classification Guidance](https://www.nifdc.org.cn/nifdc/bshff/ylqxbzhgl/qxfgwj/202507301629541662572.html), and [Apple App Review Guidelines 1.4.1](https://developer.apple.com/app-store/review/guidelines/).

**Confirmed product guardrail:** FitnessAI remains within non-diagnostic fitness scope, never recommends rehabilitation exercises, and stops planning for the affected area when warning signs require guidance from a qualified professional or in-person medical care. Ordinary planning covers only unaffected training scope. Professional review is mandatory; FR-058 and NFR-SAFE-001 define normative behavior.

## Persistence, Synchronization, and Data Placement

The rejected route is to use Apple iCloud or CloudKit to store personal health information or account-scoped FitnessAI workout data. The accepted route separates local authority over active sessions from a compliant China-region application backend: Watch owns live-session capture and immediate durable commits; iPhone coordinates correction, recovery, and transfer of the complete session record; the application backend provides account identity, structured synchronization, and cross-device restoration. The backend is not part of the live training control loop.

Synchronized classes are Training Plans, structured Workout Sessions and Actual Sets, corrections and provenance-bearing RPE, analysis inputs, and version-compatible compact personal-model state. Complete high-frequency motion and heart-rate streams remain local by default. Stable event identities, monotonic revisions, explicit deletion states, and idempotent replay are the preferred mechanisms for meeting FR-044 through FR-048 and FR-064 through FR-070; architecture may choose equivalent mechanisms if the same product-visible guarantees hold.

For the first private Alpha, reliable paired iPhone–Watch transfer is sufficient for the end-to-end loop. The China-region application backend remains the accepted route for public-beta account synchronization and cross-device restoration, but backend completion must not block the first locally usable vertical slice.

## First Usable Build Slicing Rationale

The private Alpha proves the narrowest differentiated loop: iPhone AI conversation → complete structured proposal → explicit approval → atomic native Plan Revision → paired-Watch execution → durable Actual Sets → user-invoked revision proposal. Automatic recognition, automatic RPE, account-cloud continuity, complete Analysis, and rich teaching content remain intended capabilities, but they follow rather than block this first executable loop. This slicing decision is a delivery sequence, not a rejection of the broader product.

Visual composition, exact conversation format, model/provider choice, prompting strategy, proactive-review cadence, explanation density, and public-beta performance/cost thresholds are deliberately not frozen by the PRD before the private Alpha. They should be decided from observed use without weakening the stable data-authority, approval, atomicity, safety, or synchronization contracts.

## AI Plan Orchestration and Deferred Input Boundaries

AI plan creation and bounded record-informed plan revision are now MVP core capabilities. AI produces only a Training Plan Draft or Plan Change Proposal. A versioned schema, canonical Exercise mapping, complete-plan or complete-field-diff review, one explicit user approval, and an atomic Plan Revision are fixed boundaries. The AI never gains authority over historical Actual Sets or an already-started Workout Session.

The first-build AI data boundary comprises the current conversation, user-provided profile and physical constraints, and explicitly permitted structured FitnessAI records that are stored locally and confirmed or corrected by the user. Apple Health, raw sensor streams, imported plans, cloud-restored copies, proactive autonomous adjustment, and coaching outside Training Plan changes require later product, permission, provenance, and safety decisions.

Voice is reserved as a future user-invoked input source, not a new authority over workout truth. Architecture should preserve an extensible input-source field and conflict rules so a future voice parser can produce provenance-bearing drafts without bypassing the existing durable-commit, correction, and user-confirmation contracts. Continuous listening and open-ended coaching are not implied. Raw audio is a separate data class and has no retention, upload, or model-training authorization under the existing workout-data consent.

V1.1 may define a FitnessAI-owned versioned Training Plan file for single-plan round-trip portability. The format should carry stable schema and Exercise-catalog versions, plan revision and source provenance, while excluding Workout Sessions, Actual Sets, health information, and credentials. Import is a validated, previewable conversion into a new draft, not a merge or overwrite operation. Arbitrary third-party mapping and QR/link sharing remain separate Post-MVP / V2 concerns; a QR code may transport a payload or link but supplies no authenticity, expiry, revocation, or access control by itself.

## Size-Budget and Release-Measurement Rationale

The Watch model allocations in NFR-SIZE-003 are hard MVP release budgets, not a promise of a specific model topology. Architecture may package, compress, or relocate noncritical work when physical-device evidence shows a better accuracy/energy/size trade-off, but exceeding either budget requires a product-level PRD change rather than an implementation waiver.

Release-size acceptance uses thinned device variants and distinguishes download from installed size. Xcode App Thinning reports and App Store Connect/TestFlight variants are the current verification mechanism; debug `.app`, `.ipa`, and `.xcarchive` sizes are diagnostic artifacts, not acceptance measurements. Tool names may change without changing NFR-SIZE-001 through NFR-SIZE-005.

## RPE Estimation Evidence and Deployment Boundary

### Evidence limitation

The completed technical research found that Apple Watch can support signal collection and compact local inference, but current evidence does not establish heart rate alone as a reliable identifier of set-level Actual RPE. Resistance-training RPE is affected by load relative to capacity, repetitions remaining, exercise, tempo, rest, accumulated fatigue, and individual scale interpretation; wrist PPG quality is also motion- and exercise-dependent. A population-level relationship between heart rate and exertion is therefore not equivalent to recovering one person's RPE for one set.

### Proposed deployment

The proposed experimental stack is multimodal: Apple-processed heart rate, wrist motion, exercise identity, load, repetitions, rest context, previous sets, and confirmed personal history. Start with simple context/history baselines and a compact feature model; consider a lightweight temporal model only if it delivers a stable improvement on held-out data. Inference runs locally during a workout, while heavier calibration can occur on iPhone. Data placement follows the dedicated persistence section above.

### Provenance and personal trust gate

The estimator is an advisory subsystem with an explicit user-controlled auto-use policy. `targetRPE`, `predictedRPE`, `userConfirmedRPE`, `autoAcceptedPredictedRPE`, and `effectiveActualRPE` remain distinct, and every effective value retains provenance. Only confirmed or corrected RPE can train personal calibration; predictions never become their own labels. Normative behavior and release gates are defined by FR-020 through FR-027 and NFR-RPE-001 through NFR-RPE-014.

When RPE tracking is enabled, the first five eligible estimates form a personal verification window. At least four correct results permit the app to offer routine-prompt removal. If the user consents, later high-confidence predictions can populate the effective workout record as `autoAcceptedPredictedRPE`, remain visibly correctable, and never masquerade as individually confirmed values. At least two errors trigger an iPhone- or locally computed lightweight personal calibration update from corrected labels, followed by a fresh five-estimate window. The verification state persists until recalibration or evidence of drift; it does not restart for every Workout Session. Low confidence, missing signals, unfamiliar exercise conditions, or drift continue to invoke abstention or bounded confirmation.

### Scientific release gate

The five-estimate window is a per-user interaction trust gate after a globally validated model exists; it is not scientific evidence that the model is release-ready and must not replace validation that groups data by participant, uses temporal splits, and compares results with simple baselines; uncertainty/risk–coverage analysis; missing-signal and subgroup reporting; physical-device resource tests; or measurement of prompt and correction burden. Full evidence and the Gate 0–6 validation route are documented in the bilingual technical research reports under `_bmad-output/planning-artifacts/research/`.

## Forgotten Workout-Finish Reminder Signals

Manual Finish remains authoritative. A reminder may use two independent evidence families: sustained heart-rate recovery toward a personalized non-training range and sustained absence of recognized strength-training motion. They form an AND gate, not an OR gate, because either signal alone can occur during legitimate inter-set rest, equipment waiting, or low-motion exercises. The Watch asks whether the Workout Session is complete and never ends it automatically. The exact personalization method, duration thresholds, missing-signal behavior, and cooldown rules require physical-device validation and measurement of false-positive and false-negative rates.

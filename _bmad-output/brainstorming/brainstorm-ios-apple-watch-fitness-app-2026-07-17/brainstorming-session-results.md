# Brainstorming Session Results: Intelligent Strength-Training Capture Across Wearables

**Session date:** 2026-07-17  
**Original topic:** iOS Apple Watch intelligent fitness app  
**Session mode:** Facilitator  
**Canonical source:** `.memlog.md` in this directory  
**Document status:** Complete synthesis of the recorded session, synchronized with confirmed follow-up decisions through 2026-07-19

## 1. Evidence and Status Conventions

This report is derived only from the session memlog. It does not independently verify time-sensitive prices, platform policies, API access, research claims, or licenses.

| Label | Meaning in this document |
|---|---|
| **Fact (F)** | A fact recorded in the memlog. It may still require current external verification before implementation or spending. |
| **Decision (D)** | A direction explicitly accepted or selected during the session. |
| **Recommendation (R)** | A route or next action recorded as an idea, insight, or recommendation, not yet a binding decision unless a related Decision says otherwise. |
| **Hypothesis (H)** | An assumption or expected benefit that remains to be validated. |
| **Open Question (Q)** | A material unknown left unresolved in the memlog. |

## 2. Executive Summary

The session began with an iOS/Apple Watch concept and, after follow-up market research, returned to Apple Watch as the first validation platform for a China-focused product. The product's primary job is to generate an accurate strength-training record with almost zero interaction, allowing the user to stay focused during active sets. AI-generated future training cycles remain a secondary, downstream job and must not displace the recording-first MVP.

The interaction model separates automation from correction by time and confidence. The user explicitly starts and finishes a workout. Active sets remain silent. High-confidence results are recorded without interruption; low-confidence results are surfaced during inter-set rest; complete recognition failures ask only for missing information; unanswered prompts create pending records without discarding recognized data. Corrections become the source of truth and improve the current user's personal model, but do not train the global model.

**D-027 supersedes the earlier vivo-first D-001/D-024 route.** The first implementation is an Apple Watch capability and recording-loop prototype with an iPhone companion, aimed at Chinese Apple Watch strength users. It must verify continuous workout motion access, sampling behavior, battery impact, Watch↔phone transfer, local recovery, and full-session reliability before a broad fitness UI is built. The first algorithm experiment may use a small representative exercise set and a 10-session development/calibration plus 5-session frozen evaluation design. That small set is a technical-validation scope only, not the launch catalog.

The current expansion path is Apple Watch validation for Chinese users, followed by explicitly supported Xiaomi models, then a separately validated Huawei/HarmonyOS path. Device fragmentation remains explicit through capability tiers rather than hidden behind one promise. The production-launch target is comprehensive coverage of mainstream gym strength training across free weights, machines, and bodyweight movements within a published supported catalog; unsupported or low-confidence cases retain fast manual fallback. External load is never sensed automatically: the user-entered value is authoritative, while plan/history may prefill it to reduce interaction. The previously recorded business model and cost estimates remain hypotheses requiring revalidation after market research, especially because the intended local price is materially below overseas products.

## 3. Session Scope and Methods

### 3.1 Scope

The initial scope was an iOS app using Apple Watch signals to recognize exercises, detect sets and repetitions, track rest, estimate training variables, and support common workout needs. The session then expanded into feasibility boundaries, data strategy, personalization, privacy, device compatibility, validation, platform roadmap, budget, and monetization.

### 3.2 Explicitly Used Techniques

| Technique | Recorded use | Main contribution |
|---|---|---|
| **SCAMPER Method** | Combine, Adapt, Modify, Put to Other Use, Eliminate, Reverse | Connected recognition to planned workouts; designed rest-period correction, personal learning, retention boundaries, and the recording-versus-coaching boundary. |
| **Six Thinking Hats** | White, Red, Yellow, Black, Green, and Blue outcomes | Grounded costs and platform facts; surfaced motivation and labeling aversion; framed value and fragmentation risks; created capability tiers and validation gates. |
| **Jobs to Be Done (JTBD)** | Drafted, selected, and refined the primary job and interaction boundary | Made near-zero-interaction accurate recording the primary job; placed AI cycle planning downstream; clarified mandatory and conditional user actions. |
| **TRIZ Contradiction** | Automation vs. accuracy; action coverage vs. labeling burden | Resolved contradictions through time/condition separation and public-data pretraining plus device-specific calibration and frozen evaluation. |

## 4. Primary JTBD and Product Vision

### 4.1 Primary JTBD

> When I am strength training, I want the app to capture the workout with almost no manual interaction and automatically produce an accurate daily training record afterward, so I can stay focused during the session.

**D-002 — Primary job:** Generate an accurate workout record with almost zero user interaction.

**D-003 — Secondary job:** Across training cycles, combine history with goals and preferences to generate the next cycle's plan. This is downstream of the recording-first MVP.

### 4.2 Vision

Create an automation-first, correction-friendly strength-training recorder that turns wearable motion and heart-rate signals into trustworthy workout history, learns the individual without silently contaminating a global model, and adapts its promises to each device's real sensor capability.

### 4.3 Product Principles

1. **Workout first.** The app assists recording; it does not continuously coach during an active set.
2. **Near-zero, not zero, interaction.** Start and Finish are mandatory. Correction and weight entry occur only when needed.
3. **Silence during effort.** Recognition must not interrupt the active set.
4. **Confidence controls interaction.** High-confidence records are silent; uncertainty moves to rest; failure requests only missing fields.
5. **Preserve partial success.** Never force the user to re-enter an entire set when some fields were recognized.
6. **Correction is truth.** User changes immediately become the source of truth for the set and personal history.
7. **Recording and prescription have different risk limits.** A log can be corrected later; weight, rest, form, and future-plan recommendations require stricter confidence, explanation, and confirmation.
8. **Honest device promises.** Capabilities depend on accessible continuous sensors, not merely hardware marketing specifications.
9. **Personal learning stays personal.** Unreviewed user corrections improve only that user's model.
10. **Prove narrowly, launch broadly enough.** Technical validation may use a small representative exercise set, but production launch requires comprehensive mainstream-gym coverage within a transparent supported catalog before claiming a complete recorder.

## 5. Core User Flows

### 5.1 Planned Workout Flow

1. The user explicitly taps **Start**.
2. The app loads today's planned exercises, historical weights, and relevant personal calibration summary.
3. The planned candidate set constrains exercise classification, especially on accelerometer-only devices.
4. During an active set, the app silently attempts set start/end detection, repetition segmentation/counting, tempo, rest transition, and exercise assignment.
5. If a planned or historical weight exists, it is recorded silently. If the user changes it, the correction immediately replaces the inherited value.
6. A high-confidence match to the planned exercise is accepted silently.
7. If the user skips a planned exercise or performs an unplanned exercise, the app does not interrupt the set. It asks for confirmation during the following rest period before changing today's record/plan.
8. If the prompt is unanswered, the detected exercise and all recognized set fields are retained as **pending confirmation**, and recording continues.
9. After confirmation, similar subsequent sets in the same workout may be assigned silently unless confidence drops or the motion materially changes.
10. The user explicitly taps **Finish**. The app produces the daily workout record; unresolved pending items remain available for later resolution.

### 5.2 Free Workout Flow

1. The user explicitly taps **Start** without a preset plan.
2. The app detects set boundaries and attempts open-library exercise recognition.
3. Because no planned candidate set narrows the classifier, confidence-based confirmation is used more often.
4. High-confidence results are recorded silently; low-confidence results are presented during rest.
5. Complete failure requests manual exercise selection or only the missing fields; successful fields such as repetitions or tempo are preserved.
6. Unanswered prompts become pending records and do not block continued training.
7. User confirmation may propagate to similar later sets within the same session.
8. The user taps **Finish**, and the app creates the training log from detected, confirmed, corrected, and pending data.
9. A future-plan generation feature may use the completed session, but it is not an MVP priority.

### 5.3 Plan Deviation and Recovery Rules

| Situation | Active set | Following rest | Stored result |
|---|---|---|---|
| High-confidence planned match | No interruption | No prompt | Silently accepted |
| Low-confidence match | No interruption | Ask for confirmation | Keep all recognized fields |
| Unplanned or skipped exercise | No interruption | Confirm before changing today's plan/record | Pending if unanswered |
| Complete recognition failure | No interruption | Request only missing information | Preserve successful fields |
| User correction | No interruption | Apply immediately when entered | Correction becomes source of truth |

## 6. Automatic Capabilities and Explicit Limits

### 6.1 Intended Automatic Capabilities

| Capability | First-version intent | Boundary/status |
|---|---|---|
| Set start/end detection | Automatic | Must pass the initial Apple Watch frozen evaluation and later multi-user full-session validation. |
| Repetition segmentation/counting | Automatic | Must achieve error within ±2 reps. |
| Rest timing | Automatic after set detection | Can be retained on limited devices. |
| Exercise classification | Automatic with plan-constrained or free-mode confidence logic | Must pass 75% accuracy; unknown/OOD rejection is preferred to forced classification. |
| Tempo and consistency | Automatic from motion segments | Retained on accelerometer-only limited devices. |
| ROM and acceleration trends | Coarse proxies | Do not present as precise joint angles or full-body form. |
| RPE | Model estimate plus user confirmation | Uses IMU features, history, and possibly normalized HR; not a reliable HR-only automatic truth. |
| Weight record | User-entered source of truth; plan/history may prefill | External load cannot be automatically sensed from wrist motion. Any prefill remains a convenience and must be manually confirmable/editable. |
| Next-set weight suggestion | Possible downstream prescription | Requires stricter confidence, explanation, and user confirmation. |
| AI training-cycle generation | Secondary downstream feature | Depends significantly on the connected large model and recorded history. |

### 6.2 Explicit Non-Promises

- No universal direct observation of external load from wrist IMU.
- No automatic external-load sensing claim based on Apple Watch or other wrist motion signals.
- No precise wrist rotation on accelerometer-only devices.
- No precise joint angles, full-body form, true bar path, or true bar velocity from limited wrist sensors.
- No reliance on blood oxygen, wrist temperature, or ECG as real-time exercise-recognition signals.
- No default reliance on raw Apple Watch PPG because SensorKit access is restricted to approved research projects.
- No population-level generalization claim from the developer-only N=1 MVP test.
- No claim that possession of a sensor means a third-party watch app can continuously access its raw stream.

### 6.3 Validation Set vs. Launch Catalog

**D-028:** Technical validation begins with a small representative exercise set chosen to test segmentation, repetition counting, confusing motion classes, and low-wrist-motion failure cases at low cost.

**D-029:** That validation set is not the production scope. Before public launch, FitnessAI must support a comprehensive catalog of mainstream gym strength movements across major muscle groups, free weights, common machines, and bodyweight training. “Comprehensive” means broad practical coverage for the declared target user—not a false claim to recognize every possible exercise. The launch catalog must publish per-exercise/per-device support status, confidence behavior, and manual fallback.

**D-030:** External load is always manually sourced. A plan or prior workout may prefill the most likely value, but the watch does not sense the actual machine plate, dumbbell, barbell, cable-stack, or body-assisted load. User entry/correction is authoritative.

## 7. Confidence, Rest-Period, and Safety Interaction Rules

**D-004 — Active-set invariant:** Never interrupt an active set for ordinary recognition, repetition, RPE, or logging issues.

**D-005 — High confidence:** Accept silently.

**D-006 — Low confidence:** Ask for confirmation during the following inter-set rest period.

**D-007 — Failure:** Ask only for missing information; do not require re-entry of the whole set.

**D-008 — No response:** Save detected exercise and recognized fields, mark pending, and continue.

**D-009 — Session propagation:** A confirmed exercise may be applied to similar later sets in the workout until confidence falls or motion changes materially.

**D-010 — Prescription boundary:** Outputs capable of changing training decisions—weight suggestions, rest suggestions, form correction, or future plans—need stricter confidence, explanation, and confirmation than ordinary recording outputs.

The key synthesis is that confidence is the common control plane for silent automation, rest-period correction, pending records, personalization, and safety.

## 8. Weight, RPE, and Form-Feedback Boundaries

### 8.1 Weight

**D-011 / D-030:** External load is manually recorded. A preset plan or historical record may prefill a candidate value to reduce interaction, but it is not a sensed measurement. If there is no prior value—or the load changes—the user enters/corrects it, and that value becomes the source of truth for the set and personal history.

Research recorded in the memlog supports this conservative boundary: Motra documents manual weight entry and historical recall; wrist IMU has no universal absolute-weight observation; other weight-estimation research relies on pressure sensors, equipment sensors, or raw PPG. PPGSpotter's reported result is not directly portable to a normal commercial Apple Watch app because raw PPG access is restricted.

### 8.2 RPE

**D-012:** RPE is an estimate to be confirmed or corrected by the user, not an unquestioned automatic label.

The model may use eccentric duration, repetition time, jerk, motion history, recent weight/repetition/rest/velocity-decline statistics, and optionally user-normalized heart-rate response and post-set recovery. Heart rate is an auxiliary feature, not the sole basis. Recorded research reached 41.4% exact and 85.9% within ±1 on only five men performing one-arm dumbbell curls, so generalization remains unproven.

### 8.3 Form Feedback

The session considered form assessment but selected recording as the app's main role. Limited devices may provide coarse ROM/acceleration trend proxies and consistency signals. They must not promise precise wrist rotation, joint angles, full-body form, or true bar path/velocity. Motra's form-feedback marketing claim lacks recorded detail on granularity, accuracy, and correctable errors; the LEAN research covers only three exercises with mostly single-user training data. Any future form or safety feedback therefore requires exercise-specific validation and a stricter prescription boundary.

## 9. Personalization, Retention, and Cloud Rules

### 9.1 Learning Order

**D-013:** Personal correction data improves, in order: (1) exercise classification, (2) repetition recognition, and (3) RPE estimation.

**D-014:** User correction data serves only the current user's personal model and does not train the global model. This avoids contaminating the base model with unreviewed noisy labels.

### 9.2 Storage Decisions

| Data | Local | Cloud | Retention decision |
|---|---|---|---|
| Complete raw sensor streams | Yes | No | Local only; not automatically deleted by default; provide manual cleanup. |
| Body data | Available to account experience | Yes | Long-term cloud retention. |
| Weight, repetitions, and workout history | Available locally/account-side | Yes | Long-term cloud retention. |
| Compressed personal-model summary | Generated from local data | Intended for account-bound personalization | Retain only fields needed for context and recognition performance. |
| Unreviewed personal corrections | Personal use | Not for global-model training | Never use to improve the global model. |

### 9.3 Personal-Model Summary Schema

**D-015:** The first version retains candidate fields 1–9 below and excludes representative feature snippets.

1. Exercise ID and exercise-variant ID.
2. Per-exercise personal feature prototypes, variability ranges, and valid sample counts.
3. Personal normalization statistics plus wrist and wearing-orientation information.
4. Summaries of movement duration, concentric/eccentric timing, ROM, peaks, and jerk distributions.
5. Per-exercise confidence calibration, common confusions, and user-correction statistics.
6. Recent rolling statistics for weight, repetitions, RPE, rest, and velocity decline.
7. Base-model version, feature version, summary creation time, and compatibility metadata.
8. User-baseline-normalized heart-rate response.
9. Post-set heart-rate recovery summary.

Excluded from the compressed summary: complete raw IMU waveforms, raw PPG/ECG, GPS, audio, unnecessary device identity, and small representative feature snippets. The memlog suggests creating a compressed summary every 3–5 workouts, but records this cadence as an idea rather than a final decision.

## 10. Public Data Sources and Their Proper Use

| Source | What the memlog records | Can be used for | Cannot prove / limitation | Status |
|---|---|---|---|---|
| Microsoft Exercise Recognition from Wearable Sensors | Accelerometer + gyroscope, 200+ participants, CDLA-Permissive-2.0 | Modality-matched pretraining/prototyping | Apple Watch feasibility, launch-catalog coverage, or commercial readiness by itself | Recorded research insight; current license copy should be checked before use. |
| MM-Fit | 800+ minutes, two 100 Hz smartwatches plus phone/earbud modalities, 10 exercises; starter code MIT | Pretraining, baselines, pipeline experiments | Direct transfer across device, placement, sampling, orientation, and gym context | Dataset's own commercial terms must be checked separately. |
| CrossFit smartwatch data | Real sensor-data candidate | Baseline/pretraining exploration | Direct transfer | Details and link not recorded in memlog. |
| SPAR/SPARS9x | Real sensor-data candidate | Baseline/pretraining exploration | Direct transfer | Details and link not recorded in memlog. |
| LEAN Apple Watch data | Apple Watch study on three exercises, mostly single-user training data | Error/rep/timing/ROM research reference | Broad action coverage or population generalization | Strong domain limitations. |
| hasaneyldrm/exercises-dataset | 1,324 exercise names, equipment, muscle groups, descriptions, thumbnails, GIFs; no IMU time series | Exercise catalog, label system, plan-generation knowledge base, UI media index | Training a wrist-IMU recognition model | Code/structure/docs are MIT; Gym visual media may require separate permission. |

**D-016 — Public-data rule:** Use compatible public wrist-IMU datasets to pretrain or prototype, normalize/resample compatible channels, then adapt on device-specific data. Public data reduces dedicated labeling but never replaces Apple Watch domain validation for the first product or later per-platform validation.

Domain-shift factors recorded in the session are device, sampling, placement, orientation, user, execution style, and continuous-gym background activity. The Apple Watch data loop still needs multi-user, multi-load, multi-tempo, left/right wrist, correct/incorrect form, inter-set daily activity, and user-correction labels.

## 11. Algorithm Route, Validation Design, and Numeric Gates

### 11.1 Gate 0: Device Capability Probe

**D-027:** Build the smallest Apple Watch workout/capability probe and iPhone receiver before a complete fitness UI. Measure:

- continuous accelerometer access;
- continuous gyroscope access;
- actual sampling rate;
- packet loss;
- background duration;
- heart-rate frequency;
- Watch-to-iPhone transfer;
- workout battery impact;
- local interruption/recovery behavior.

Passing criteria were not numerically defined in the memlog. The critical decision is that absence of sufficient continuous motion data can veto a platform or model.

### 11.2 Data and Model Route

**D-017 (revised by D-027):** Pretrain/prototype with compatible public wrist-IMU datasets; collect and calibrate on 10 Apple Watch sessions; freeze the model; evaluate on 5 untouched complete sessions. This is an initial personal feasibility experiment, not the production exercise-coverage or population-generalization gate.

The workout plan serves two functions: a product feature and a constrained candidate/weak-label source. Personal corrections provide targeted calibration while reducing long-term repetitive manual labeling. Open-set/OOD rejection should allow the classifier to decline unknown actions instead of forcing a wrong class.

### 11.3 N=1 Evaluation Design

**D-018:** The initial population is the developer alone (N=1). This proves personal Apple Watch feasibility, not population-level generalization or launch readiness.

**D-019:** Collect 15 complete personal workouts:

- Sessions 1–10: collection, annotation, model development, and personal calibration.
- Freeze the algorithm after session 10.
- Sessions 11–15: untouched final evaluation.
- Split by whole workout session, never by random sensor windows, to reduce leakage.

The initial experiment may use roughly 5–8 representative exercises and 3–4 sets per workout, producing a few hundred sets; this is an estimate, not a gate and not the public-launch catalog.

### 11.4 Passing Gates

| Gate ID | Metric | Minimum passing value | Scope |
|---|---|---|---|
| **G-01** | Set start/end detection rate | ≥80% | Frozen N=1 Apple Watch validation set |
| **G-02** | Exercise classification accuracy | ≥75% | Frozen N=1 Apple Watch validation set |
| **G-03** | Repetition-count error | Within ±2 reps | Frozen N=1 Apple Watch validation set |

**D-020 (revised):** Xiaomi/Huawei adaptation should not begin before the Apple validation gates pass. Public launch additionally requires broader multi-user and comprehensive-catalog gates that are not yet numerically defined.

## 12. Device Capability Tiers and Cross-Platform Architecture

### 12.1 Capability Tiers

| Tier | Required accessible signals | Product behavior | Explicit limitations |
|---|---|---|---|
| **Tier 1 — Full support** | Continuous accelerometer + gyroscope; HR where available | Comprehensive declared launch catalog, set/rep detection, tempo, rest, personalization | Still no automatic external-load sensing or full-body form promise. |
| **Tier 2 — Limited support** | Partial sensors, including accelerometer-only + HR cases | Set start/end, rep counting, tempo, rest; restricted exercise library; planned-workout constrained classification; more confirmation | No precise wrist rotation, joint angles/full-body form, true bar path/velocity, or automatic weight. |
| **Tier 3 — Unsupported for auto-recognition** | No continuous basic motion data | Disable automatic exercise recognition | Manual/basic logging may remain, but its exact scope was not decided. |

**D-021:** A Huawei or Xiaomi model exposing accelerometer and HR but not gyroscope may still receive a limited version, with reduced exercise coverage and clearly disclosed limitations.

### 12.2 Unified Wrist-Data Protocol

**R-001:** Define an internal protocol containing timestamp, three-axis acceleration, three-axis angular velocity, heart rate, device orientation, and data-quality metadata. Implement Apple Watch first, then explicit Xiaomi adapters, then a separate Huawei/HarmonyOS adapter where access permits, while sharing the canonical workout schema and portable segmentation/repetition/classification components where technically valid.

This architecture is a recorded idea, not yet an accepted implementation specification.

## 13. Platform Roadmap: Apple Watch → Xiaomi → Huawei

### Phase 1 — Apple Watch validation for Chinese users

- **D-027:** Use Apple Watch as the first technical and product-validation platform while keeping Chinese users as the target market.
- Build the smallest watchOS capability/recording-loop prototype and iPhone companion first.
- Verify motion access, workout runtime, battery, transport, local recovery, and full-session data integrity before broad UI investment.
- Use public data for prototyping and 10+5 personal sessions for initial calibration/evaluation.
- Use a small representative validation set first, then expand to a comprehensive mainstream-gym catalog before public launch.
- Stop platform expansion until G-01, G-02, and G-03 pass; do not confuse those N=1 gates with launch readiness.

### Phase 2 — selected Xiaomi expansion

- Select explicit models/OS versions by active devices, strength demand, continuous-IMU access, background stability, battery, and distribution—not brand totals alone.
- Apply the sensor-access veto per model; do not assume every Xiaomi watch shares Wear OS or the same API capability.
- Allow a clearly disclosed Tier 2 limited version where only partial signals are accessible.

### Phase 3 — separate Huawei/HarmonyOS path

- Treat Huawei as an independent platform effort, not a code port from Apple or Xiaomi.
- Validate development permissions, sensor/background access, health-data requirements, distribution, battery, and full-workout reliability.
- Retain capability tiers and manual fallback where full automatic recognition is not supportable.

### Phase 4 — cross-platform scale only after evidence

- Preserve one canonical workout model and user-owned history across supported platforms.
- Expand model/device coverage only after platform-specific technical and product gates pass.
- Apple Watch remains the first product and benchmark; success there does not prove Xiaomi/Huawei feasibility.

## 14. Business Model, Pricing, and Budget Facts

### 14.1 Business Model Decisions

**D-022:** Free download; basic functionality free; advanced functionality via Pro subscription.

**D-023:** Pro price is ¥28/month or ¥198/year with a 7-day trial; no lifetime purchase. The annual price equals ¥16.5/month, about a 41% discount.

The earlier ¥168/year idea was superseded by D-023. The proposed free/Pro boundary was: basic automatic recording free; advanced analytics, long-term history, weight recommendations, and AI cycle planning in Pro. That boundary was recorded as an idea and is not separately confirmed as a final packaging decision.

**F-001:** Initial in-app AI is planned around Alibaba Cloud Model Studio/Qwen API. Codex is already covered by an existing membership and is excluded from project development cost.

### 14.2 Recorded Cost and Policy Facts

| ID | Recorded fact |
|---|---|
| **F-002** | The developer has only a Windows computer and no Mac; already owns an iPhone, Apple Watch, old Android phone, and vivo WATCH GT 2. |
| **F-003** | iOS/watchOS final build, signing, simulator/physical-device debugging, and upload depend on macOS/Xcode; cloud Mac/Xcode Cloud is not suitable for frequent Apple Watch physical-device debugging. |
| **F-004** | Mac mini was recorded at approximately ¥5,999. |
| **F-005** | Apple Developer Program in mainland China was recorded at ¥688/year; free-device provisioning expires after 7 days, while TestFlight/App Store distribution needs paid membership. |
| **F-006** | The memlog records 25 Xcode Cloud hours/month with membership and up to 1 PB free CloudKit storage per app. |
| **F-007** | From 2026-03-15, eligible mainland-China Small Business Program in-app purchase commission was recorded as 12%; most other eligible markets 15%; free downloads/features have no sales commission. |
| **F-008** | Qwen recorded standard prices: qwen3.7-plus ¥2 input/¥8 output per million tokens; qwen3.7-max ¥12/¥36; qwen-turbo ¥0.3 input, ¥0.6 non-reasoning output, ¥3 reasoning output. Promotional discounts and a possible 90-day/1M-token allowance were also recorded. |
| **F-009** | Android Studio can be developed on Windows at no cost; Google Play full distribution was recorded as a one-time US$25, with new personal accounts requiring 12 testers for 14 continuous days before production release. |
| **F-010** | GPT-5.6 Sol/Terra/Luna API prices were recorded as US$5/30, US$2.5/15, and US$1/6 per million input/output tokens; OpenAI Codex average was recorded as US$100–200/developer/month with high variance. These are not part of the selected initial AI cost model. |

All time-sensitive facts above require current official revalidation before purchase, launch, or financial planning.

### 14.3 Recorded Budget Ranges

| Stage | Recorded estimate | Included/excluded context |
|---|---:|---|
| Technical validation, if Mac already owned | ¥2,500–¥6,000 | Early rough estimate. |
| Shippable MVP, if Mac already owned | ¥10,000–¥25,000 | Early rough estimate. |
| Stable first-year public beta, if Mac already owned | ¥30,000–¥70,000 | Early rough estimate. |
| Mac addition when not owned | About ¥5,999 | Current user does not own a Mac. |
| Revised first shippable MVP | About ¥11,000–¥20,000 | Excludes Codex; uses Qwen; includes new Mac (~¥5,999), Apple fee (¥688), and usually only hundreds of yuan in early Qwen calls. |

All estimates exclude personal labor. Dataset/media licensing, tester incentives, privacy compliance, and compatible devices are separate budget items.

**R-002 — Stage-gate budget:** Use a tightly capped first experiment to prove Apple Watch set detection and repetition counting on a small representative exercise set; expand data collection and action coverage only after the recognition gates pass. Passing this inexpensive experiment authorizes investment toward a comprehensive launch catalog—it does not authorize shipping the small validation set as the final product.

## 15. Risks and Mitigations

| Risk ID | Risk | Recorded mitigation or boundary | Residual uncertainty |
|---|---|---|---|
| **RK-01** | Apple Watch workout sampling, battery, interruption, or Watch↔phone transfer may fail over complete sessions. | Build the capability/recording-loop probe first; measure real rate, loss, runtime, battery, recovery, and transfer. | Physical-device validation and a Mac/Xcode workflow are required. |
| **RK-02** | Xiaomi/Huawei fragmentation causes sampling, coordinate, timestamp, loss, background, distribution, and model-transfer differences. | Platform/model adapters, capability tiers, device-specific validation, and sensor-access veto. | Per-model support burden remains unknown. |
| **RK-03** | A comprehensive launch catalog creates similar-class confusion and data-collection cost. | Small representative validation set first; then planned-workout constraints, confidence thresholds, OOD rejection, user correction, staged catalog expansion, and per-action support disclosure. | Exact launch catalog and numeric coverage gate remain open. |
| **RK-04** | Public datasets do not match Apple Watch or real gym conditions. | Normalize/resample, calibrate on 10 Apple sessions, freeze, evaluate on 5 untouched sessions, then expand to multi-user testing. | N=1 does not establish launch readiness or generalization. |
| **RK-05** | Manual labeling burden becomes unsustainable. | Use public pretraining, plan-derived weak labels, rest-period corrections, and personal learning. | Annotation tooling and effort are not specified. |
| **RK-06** | Overclaiming weight, RPE, form, or exercise coverage undermines trust or safety. | Manual load truth with optional history/plan prefill; confirmed RPE; limited form proxies; transparent catalog; stricter prescription boundary. | Exact confidence thresholds and launch coverage criteria are open. |
| **RK-07** | Corrections interrupt focus. | Keep active sets silent; ask during rest; allow pending records. | Prompt frequency and fatigue need usability validation. |
| **RK-08** | Personal data or noisy corrections harm privacy/model quality. | Raw data local only; compressed summary; personal-only learning; no global training from unreviewed corrections. | Consent, encryption, export, deletion, and compliance details are open. |
| **RK-09** | iOS development cost and Mac dependency delay Apple-first validation. | Secure a reliable macOS/Xcode and physical Watch workflow before significant model/UI investment; retain a stage-gate budget. | Exact current hardware/access cost requires revalidation. |
| **RK-10** | Dataset/media licenses block commercial reuse. | Verify each downloaded dataset's commercial terms; treat Gym visual media separately. | Exact terms for several named datasets were not recorded. |

## 16. Key Decision Register

| ID | Decision |
|---|---|
| **D-001** | Superseded by D-027; the earlier vivo-first probe is no longer the active first-platform decision. |
| **D-002** | Primary JTBD is near-zero-interaction accurate workout recording. |
| **D-003** | AI next-cycle planning is secondary and downstream. |
| **D-004** | Ordinary recognition/logging issues never interrupt an active set. |
| **D-005** | High-confidence results are silently accepted. |
| **D-006** | Low-confidence results are confirmed during rest. |
| **D-007** | Failure asks only for missing fields and preserves successful fields. |
| **D-008** | Unanswered confirmations create pending records and do not block training. |
| **D-009** | Confirmed exercise identity can propagate within the session unless confidence/motion changes. |
| **D-010** | Prescription outputs require stricter confidence, explanation, and confirmation. |
| **D-011** | Weight comes from plan/history or user entry; user correction is truth; no sensor-based weight claim. |
| **D-012** | RPE is model-estimated but user-confirmed/correctable. |
| **D-013** | Personal learning priority is exercise class, then repetitions, then RPE. |
| **D-014** | Personal corrections do not train the global model. |
| **D-015** | Personal summary keeps fields 1–9 and excludes representative feature snippets. |
| **D-016** | Public IMU data supports pretraining/prototyping but does not replace device validation. |
| **D-017** | Revised: public pretraining/prototyping + 10 Apple Watch calibration sessions + frozen 5-session evaluation for initial personal feasibility. |
| **D-018** | Initial validation is N=1 and proves only personal Apple Watch feasibility, not launch readiness. |
| **D-019** | Split by complete workout session, never random windows. |
| **D-020** | Xiaomi/Huawei adaptation waits for Apple G-01 through G-03; public launch separately requires broader catalog and multi-user evidence. |
| **D-021** | Accelerometer-only/HR devices may receive an explicitly limited version. |
| **D-022** | Business model is free download/basic free/Pro subscription. |
| **D-023** | Pro is ¥28/month or ¥198/year with a 7-day trial and no lifetime purchase. |
| **D-024** | Superseded by D-027; vivo → Huawei/Xiaomi → iOS is no longer the active expansion order. |
| **D-025** | Platform/model entry is vetoed by inadequate sensor access, not merely development complexity. |
| **D-026** | Raw sensor data stays local and is not automatically deleted by default; cloud keeps long-term body/workout history. |
| **D-027** | Target Chinese users; validate first on Apple Watch, then selected Xiaomi devices, then a separate Huawei/HarmonyOS path. |
| **D-028** | Technical validation uses a small representative exercise set to reduce cost and isolate feasibility. |
| **D-029** | Public launch requires comprehensive practical coverage of mainstream gym movements within a transparent supported catalog; the validation set is not the launch catalog. |
| **D-030** | External load is manually recorded; plan/history may prefill but never constitutes automatic sensing; user input/correction is authoritative. |

## 17. Open Questions and Unvalidated Hypotheses

| ID | Type | Question or hypothesis |
|---|---|---|
| **Q-001** | Capability | What sustained Apple Watch motion/HR rate, battery impact, interruption recovery, and Watch↔phone transfer quality are achieved during complete strength sessions? |
| **Q-002** | Capability | What numeric Gate 0 thresholds are sufficient to support the first classifier? |
| **Q-003** | Product | Which small validation set best tests feasibility, and what broader launch catalog/coverage threshold constitutes comprehensive mainstream-gym support? |
| **Q-004** | Algorithm | What confidence thresholds should drive silent acceptance, rest confirmation, and OOD rejection? |
| **Q-005** | UX | Which information requires immediate safety feedback versus rest-period or post-workout handling? |
| **Q-006** | Personalization | Should the 3–5-workout summary cadence become a decision, and what controls should users have over summary fields? |
| **Q-007** | Data governance | What consent, encryption, export, deletion, account recovery, and regulatory controls are required? |
| **Q-008** | Licensing | What are the current commercial terms for each downloaded public dataset and Gym visual media? |
| **Q-009** | Market | What is the serviceable population at the intersection of active compatible devices, strength-training demand, and continuous IMU access? |
| **Q-010** | Packaging | Is the proposed free/Pro feature boundary final? |
| **Q-011** | Resolved boundary | Regardless of Motra wording, FitnessAI does not claim automatic external-load sensing; load is manually sourced with optional plan/history prefill. |
| **H-001** | Market hypothesis | Apple Watch can validate retention and payment among Chinese strength users before Xiaomi/Huawei expansion. |
| **H-002** | Product hypothesis | Planned-workout constrained classification materially improves limited-device recognition. |
| **H-003** | UX hypothesis | Rest-period confirmation plus pending records preserves focus without causing excessive correction fatigue. |
| **H-004** | Learning hypothesis | Public pretraining plus personal calibration reduces dedicated labeling enough for a solo developer. |

## 18. Recommended Immediate Next Steps

These steps restate or order actions already supported by the memlog; they do not add new product decisions.

1. **R-003 — Build the Apple capability/recording-loop probe.** Implement the smallest watchOS workout app and iPhone receiver needed to measure motion, HR, sampling, loss, background/runtime behavior, battery, recovery, and transfer.
2. **R-004 — Record an Apple capability baseline.** Establish the first supported capability tier and the full-session data-integrity baseline.
3. **R-005 — Select two exercise scopes.** Define a small representative validation set and, separately, a comprehensive mainstream-gym launch catalog with per-action support status; never confuse the two.
4. **R-006 — Verify public-data terms.** Before training or commercial reuse, check the exact downloaded Microsoft, MM-Fit, CrossFit, SPAR/SPARS9x, LEAN, and Gym visual licenses/terms.
5. **R-007 — Prototype the shared pipeline.** Use compatible public wrist IMU to prototype normalization/resampling, set segmentation, rep counting, exercise classification, and OOD rejection.
6. **R-008 — Prepare session-level collection.** Capture full Apple Watch workouts with plan labels, manual load truth, and corrections; keep the first 10 sessions for development/calibration.
7. **R-009 — Freeze and evaluate.** Lock the pipeline after session 10 and run sessions 11–15 untouched against G-01, G-02, and G-03.
8. **R-010 — Decide launch and expansion separately.** If initial gates pass, expand action/data coverage toward the launch catalog and multi-user evidence; only then evaluate selected Xiaomi models, followed by Huawei.
9. **R-011 — Revalidate commercial facts.** Recheck current hardware prices, developer fees, store commissions, Qwen pricing, and distribution requirements before budgeting or launch.

## 19. Technique-by-Technique Synthesis

### 19.1 SCAMPER

- **Combine:** The workout plan and recognition system became one experience. The plan is not only display content; it constrains candidate exercises and supplies inherited weight/context.
- **Adapt:** Motra and Apple Watch research established a practical boundary: auto-recognition, set timing, rest, and personalization are plausible, while weight, RPE, and form need conservative claims.
- **Modify:** Correction moved from whole-set re-entry to field-level completion during rest. Confidence became the trigger for silence, confirmation, or manual fallback.
- **Put to Other Use:** Confirmations and corrections became personal calibration data and long-term workout history, not disposable fixes.
- **Eliminate:** Raw cloud uploads and noisy global-model learning were removed. Raw streams stay local; compressed personal summaries retain only useful model context.
- **Reverse:** Instead of maximizing live coaching, the product protects workout focus. Ordinary issues wait until rest; only decision-changing outputs receive stricter handling.

### 19.2 Six Thinking Hats

- **White Hat:** Recorded platform, hardware, API, cost, subscription, and distribution facts. Follow-up market research retained the Mac dependency but superseded the owned-vivo-first route with Apple-first validation for Chinese users.
- **Red Hat:** The developer accepts an incomplete first probe and values visible algorithm progress, but strongly dislikes prolonged repetitive labeling.
- **Yellow Hat:** Apple-first reduces early platform fragmentation and enables direct comparison with Motra; Xiaomi and Huawei remain later China-scale opportunities after platform-specific evidence.
- **Black Hat:** Vendor/model fragmentation and inaccessible sensors are the critical risks. Sensor access, not engineering inconvenience, is the platform veto.
- **Green Hat:** Capability-tiered products, accelerometer-only limited features, and planned-workout constrained classification turned fragmentation into explicit product behavior.
- **Blue Hat outcomes:** The N=1 10+5 design and 80%/75%/±2 gates remain initial feasibility gates on a small Apple validation set. They do not replace comprehensive launch-catalog and multi-user readiness criteria.

### 19.3 Jobs to Be Done (JTBD)

- **Primary job selection:** Near-zero-interaction accurate workout recording was selected as the core outcome, protecting workout focus rather than maximizing feature breadth.
- **Secondary job placement:** AI generation of the next training cycle remains valuable but was explicitly placed downstream of reliable recording.
- **Interaction boundary:** Start and Finish are mandatory; rest-period correction and manual load entry/correction are conditional; plan/history may prefill, but external load is never inferred from watch sensors.

### 19.4 TRIZ Contradiction

- **Automation vs. accuracy:** Separate by time and condition—silent active sets, silent high-confidence logging, rest-period low-confidence confirmation, manual fallback for failure, pending items when unanswered.
- **Coverage vs. labeling burden:** Separate a small representative technical-validation set from the comprehensive mainstream-gym launch catalog; use public compatible IMU for prototyping, plans as constrained candidates/weak labels, personal corrections for calibration, and staged catalog expansion with frozen evaluation.
- **Resulting synthesis:** The plan, confidence layer, personal model, and capability tiers are not separate features; together they form the control system that makes near-zero interaction plausible without pretending uncertainty does not exist.

## 20. Source Links Recorded in the Memlog

### Product and Competitor References

- Motra exercise auto-detection: https://help.motra.com/en/articles/9696451-exercise-auto-detection
- Motra rest time and alarm: https://help.motra.com/en/articles/9671219-rest-time-and-rest-alarm
- Motra getting started/correction: https://help.motra.com/en/articles/9980535-getting-started-with-motra
- Motra progressive learning: https://help.motra.com/en/articles/9889025-progressive-learning
- Motra weight input: https://help.motra.com/en/articles/9672229-weight-input
- Motra RPE entry: https://help.motra.com/en/articles/11831615-adding-rpe-effort-to-a-set
- Motra form-feedback marketing: https://www.motra.com/neural-kinetic-profiling
- Motra AI-generated workouts: https://help.motra.com/en/articles/14021528-ai-generated-workouts-how-to-use-motra-s-workout-generator
- Motra minimum-rep threshold: https://help.motra.com/en/articles/9696439-minimum-rep-threshold

### Apple Platform References

- Apple Watch Series 10 specifications: https://support.apple.com/en-us/121202
- Apple Watch Series 11 specifications: https://support.apple.com/en-us/125093
- Core Motion `CMMotionManager`: https://developer.apple.com/documentation/coremotion/cmmotionmanager
- HealthKit `HKWorkoutSession`: https://developer.apple.com/documentation/healthkit/hkworkoutsession
- SensorKit project configuration: https://developer.apple.com/documentation/sensorkit/configuring-your-project-for-sensor-reading

### Research and Dataset References

- Resistance-training wearable review: https://pmc.ncbi.nlm.nih.gov/articles/PMC12513948/
- Sensor-position/classification study: https://pmc.ncbi.nlm.nih.gov/articles/PMC6387025/
- LEAN Apple Watch study: https://pmc.ncbi.nlm.nih.gov/articles/PMC10222347/
- IMU-based RPE estimation: https://arxiv.org/abs/2510.03197
- Apple Watch HR in resistance training: https://pubmed.ncbi.nlm.nih.gov/34957939/
- Resistance-training HR study: https://www.tandfonline.com/doi/abs/10.1080/02640414.2023.2180160
- PPGSpotter: https://yetongcao.github.io/files/PPGSpotter.pdf
- Open-set/OOD reference: https://pmc.ncbi.nlm.nih.gov/articles/PMC7957807/
- OOD reference: https://arxiv.org/abs/1909.01202
- hasaneyldrm/exercises-dataset: https://github.com/hasaneyldrm/exercises-dataset

The memlog also mentions Apple Support, Microsoft Exercise Recognition from Wearable Sensors, MM-Fit, CrossFit smartwatch data, SPAR/SPARS9x, BlueOS, Huawei Wear Engine, Xiaomi Vela, Apple pricing/policies, Google Play policy, and Alibaba Cloud Model Studio/Qwen pricing without recording direct source URLs. No URLs have been invented for them in this report.

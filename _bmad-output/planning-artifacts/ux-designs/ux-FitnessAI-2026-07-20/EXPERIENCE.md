---
name: FitnessAI
status: draft
sources:
  - "{planning_artifacts}/briefs/brief-FitnessAI-2026-07-19/brief.md"
  - "{planning_artifacts}/prds/prd-FitnessAI-2026-07-19/prd.md"
  - "{planning_artifacts}/prds/prd-FitnessAI-2026-07-19/addendum.md"
  - "{planning_artifacts}/research/market-fitnessai-near-zero-interaction-strength-training-research-2026-07-18.md"
  - "{planning_artifacts}/research/technical-vivo-huawei-xiaomi-smartwatch-sensor-imu-research-2026-07-17.md"
  - "{planning_artifacts}/research/technical-rpe-estimation-from-heart-rate-for-strength-training-research-2026-07-19.md"
updated: 2026-09-10
---

# FitnessAI — Experience Spine

## Foundation

“First version” means a personally usable core-product private Alpha for the Product Owner, not a narrow technical walking skeleton and not public beta. It must support repeated real workouts through AI planning, automatic capture, trustworthy correction, complete Analysis, Apple Health interoperability, first-party plan exchange, proactive post-session review, and a coherent test-ready visual/layout system.

The Alpha is native SwiftUI on iPhone and, when available, paired Apple Watch. iPhone owns a first-class phone-only Workout Session path plus conversation, authorization, proposal review, approval, complete correction, History/Analysis, Apple Health, and plan-file controls. When selected as the capture device, Watch owns the active Workout Session, supported automatic recognition/RPE assistance, and durable local Actual Sets. Both capture paths use the same identities, durable states, correction semantics, and Analysis. A session executes the approved Plan Revision snapshot present at Start; later revisions never mutate active or historical sessions.

`DESIGN.md` owns the test-ready private-Alpha visual system; this spine owns IA, behavior, states, interaction, accessibility, and journeys. The approved Watch v11 reference may inform Watch layout only where the current spines agree. Other historical mockups remain discussion aids until their decisions are promoted into both bilingual spines. The spines always win.

## Information Architecture

### iPhone private-Alpha surfaces

| Surface | Responsibility | Lands in |
|---|---|---|
| Plan Home | Current effective revision, Watch delivery state, create/revise entry, returned sessions | UJ-4, Flows 2–4 |
| AI Plan Chat | Collect goals, experience, availability, session time, equipment, preferences, mandatory physical limitations; keep missing answers and assumptions visible; modify drafts by text | UJ-4, Flow 3 |
| Remote AI Authorization | Disclose purpose, provider/subprocessor, retention, model-training policy, selected categories and record window; grant, inspect, withdraw | UJ-4, Flows 3–4 |
| Proposal Review | Complete new plan or complete field-level diff; mappings, assumptions, unresolved fields, future scope, `proposalId`, base revision, digest | UJ-4, Flows 3–4 |
| Approval, Commit & Delivery | Bind approval to the displayed proposal, atomically commit, show Watch `pending/delivered/failed` | UJ-4, Flow 4 |
| Session Return & Review | Show all Actual Sets; edit reps/load; split, merge, insert, delete; resolve pending fields | Flows 2–3 |
| Phone-only Active Workout | Start a planned or ad-hoc session, manually complete/edit Actual Sets, finish, and recover on iPhone using the shared session state model | Flow 7 |
| Revision Proposal Review | On explicit “Ask AI to review,” collect feedback/permitted records, show one complete diff, approve or reject | Flow 3 |
| Training History | Browse complete/incomplete sessions and auditable corrections | UJ-1, UJ-2 |
| Analysis | Complete weekly/monthly sessions, Exercises, volume, intensity, Actual Load, duration, and selected Primary Exercise trends | UJ-2 |
| Exercise Catalog & Support | Canonical Exercise mapping, supported/limited/manual-only state, concise first-party teaching | UJ-1, Flow 2 |
| Apple Health | Manage contextual read/write capabilities, inspect no-data/pending/written/failed/`healthKitDetached`, and enter a separate default-off per-request preview for selected local summaries | Flow 6 |
| Plan Exchange | Export/import one FitnessAI-owned plan file, complete preview, new-draft creation, native Share Sheet | Flow 5 |
| Settings | Automatic recognition, RPE, finish reminder, proactive review, Apple Health, and accessibility controls | UJ-1, Flows 3–6 |

Plan Home is the Alpha root. Other surfaces are contextual routes, not a finalized tab-bar decision. Native back preserves unsent chat and non-effective drafts. Approval never appears inside a chat message.

### Apple Watch private-Alpha surfaces

| Surface | Responsibility | Lands in |
|---|---|---|
| Approved Plan | Last fully delivered compatible revision; planned Exercises, sets, reps, loads, optional target RPE; manual Start | Flow 2 |
| Active Workout | Fixed Start snapshot; supported automatic set/rep capture; manual Complete Set fallback; planned and Actual facts remain distinct | UJ-1, Flow 2 |
| Edit Actual Set | Necessary reps and Actual Load edits; user input is authoritative | Flow 2 |
| Rest Resolution | Resolve uncertain Exercise/reps, confirm/correct opt-in RPE, edit load, or choose Later only when safe for interaction | UJ-1, Flow 2 |
| Watch Recovery | Resume, Finish incomplete, or explicitly discard the latest durable active session after interruption | UJ-1, Flow 4 |
| Finish & Local Save | Manual Finish; conservative two-signal reminder may offer Finish/Continue; durable complete/incomplete Actual Sets; independent iPhone transfer | UJ-1, Flows 2, 4 |

Watch never exposes a partial revision. Offline or failed delivery leaves the last delivered compatible revision available. Plan delivery and Actual Set return are eventually consistent and idempotent; neither blocks local recording.

### Explicitly deferred; no first-build pages

Full cloud account/cross-device restoration, voice/continuous listening, rich teaching media, arbitrary third-party plan formats, server-backed link/QR sharing, weekly/cycle-end proactive cadence, autonomous plan mutation, and open-ended coaching are not Alpha surfaces. Public-launch brand polish and broad device optimization follow after the complete test-ready Alpha visual/layout contract. Architecture may preserve domain boundaries, but implementation must not add discoverable placeholders or imply availability.

## Voice and Tone

Chinese-first, literal, non-diagnostic, and explicit about what changed, what stayed effective, and the available action.

| Do | Don't |
|---|---|
| “This approval applies only to proposal P-104 and revision 7.” | “Approve AI changes” without identity/scope |
| “The proposal changed. Review and approve the new version.” | Reuse approval after edit/regeneration |
| “Revision 7 remains effective. Commit failed.” | Claim partial or optimistic success |
| “Watch delivery failed. Revision 7 remains available there.” | Say delivered while pending |
| “Recommendations for this area have stopped.” | Diagnose or assign injury severity |
| “Nothing is sent until you select and authorize it.” | Preselect sensitive categories |

## Component Patterns

| Pattern | Behavioral contract |
|---|---|
| `ai-conversation` | Text only; ask only necessary clarifications. Chat, edit, and regenerate never approve or commit. Conversation and structured non-effective draft remain distinct. |
| `remote-ai-authorization` | Every category defaults off: current conversation, profile/preferences, physical limitations, confirmed/corrected FitnessAI records, and eligible locally summarized Apple Health categories. Record and Health-summary use requires an explicit time window. Each request binds route/provider/account, purpose, categories/window, outbound digest, policy version, expiry, and one-time consumption. HealthKit permission never substitutes for remote authorization; scope expansion requires a new preview. Real Health-summary transmission remains disabled until the provider/compliance gate is approved. |
| `plan-diff-review` | New plan shows every structured field; revision shows every add/remove/change, before/after values, and affected future sessions. Always show mappings, assumptions, base revision, `proposalId`, digest, and blocking validation results. |
| `proposal-approval-gate` | Deliberate action after complete review, bound to `proposalId + base revision + digest`. Any content, mapping, rule result, or base change invalidates approval and requires full re-review. Duplicate approval/retry is idempotent. |
| `safety-stop` | New/worsening injury or recovery state stops the affected scope until the user excludes it or pauses for qualified guidance. Warning signs stop generation and direct offline care without diagnosis. Uncertainty/declined answers never authorize severity inference. |
| `session-control` | Manual Start/Finish are authoritative; one primary session action; Start snapshot stays fixed. |
| `actual-set-row` | Keep Exercise, order, reps, Actual Load, timing, completeness, provenance together. Planned and Actual values stay distinct; iPhone correction is field-scoped and auditable. |
| `load-stepper` | First load prefills from plan; later sets inherit prior Actual Load. User edit is authoritative; source/unit visible; no sensed-load claim. |
| `sync-state-indicator` | Separates local plan commit, Watch delivery, Watch workout save, and iPhone receipt. Each exposes pending/success/failed and idempotent Retry; remote state never revokes local save. |
| `recognition-state-chip` | Names accepted, uncertain, corrected, unresolved, manual-only, or unsupported Exercise/set/rep results. Low confidence abstains or asks during a safe pause; correction preserves sibling facts and initial errors remain recognition failures. |
| `rpe-verification-prompt` | Opt-in only. Shows predicted provenance and integer 1–10 confirmation/correction for the five-estimate window; low confidence abstains; verified auto-use requires explicit consent and remains correctable. |
| `forgotten-finish-prompt` | Appears only after sustained physiological recovery and sustained absence of strength activity, under the frozen operating point. Offers Finish or Continue, never auto-finishes, and respects cooldown/disable. |
| `analysis-summary` | Derives every metric from effective Actual Sets, labels excluded incomplete/conflicted facts, exposes period and Primary Exercise selection, and never substitutes planned values. |
| `healthkit-capability-row` | One row per read/write capability. Uses observable states only; write succeeds only after HealthKit confirmation; a missing external copy becomes `healthKitDetached` and is not silently recreated. |
| `plan-exchange-review` | Treats FitnessAI files as untrusted; shows source/version/full plan/mappings/omissions before creating a new draft. Export shares only the selected plan through native Share Sheet. |
| `proactive-review-invitation` | Once after a completed session: Review, Later, or Disable. Showing it sends no data and creates no proposal; Review enters the existing authorization and diff/approval flow. |

## State Patterns

### Proposal, approval, and authorization

| State | Treatment |
|---|---|
| Authorization required | Send no remote request; open default-off scope review. |
| Generating | Keep current plan usable; cancel returns without mutation. |
| Valid proposal | Open complete review; approval is proposal-specific. |
| Invalid/unmapped/contradictory/safety-blocked | Show blocking reasons; clarify, correct, regenerate, or reject. Never invent completion. |
| Approved, commit pending | Do not call the plan effective; status recovery is idempotent. |
| Commit failed | Prior revision remains wholly effective; Retry or discard the non-effective proposal. |
| Committed | Show immutable revision, then begin Watch delivery. |
| Approval invalidated | Name the cause, clear approval, recompute identity/digest, require complete review again. |
| Base revision stale | Never silently rebase; show the newer base and require regeneration/new review. |
| Not authorized / withdrawn | Current plan/local workout remain available; withdrawal stops future remote use and leaves prior records unchanged. |
| Scope changed / disclosure incomplete | Block the expanded request; send nothing until truthful disclosure and affirmative authorization. |

### Delivery, workout, return, and degradation

| State | Treatment |
|---|---|
| Watch plan pending | Watch keeps last delivered revision; automatic/manual retries do not duplicate. |
| Watch plan delivered | Both devices match revision/digest; Watch may offer it only for a future Start. |
| Watch plan failed/offline | Name failure and last usable revision; Retry; never expose partial content. |
| Actual Set saved locally | Durable on Watch; phone receipt is independent. |
| Local save failed | Retain entered values; never claim saved; prior durable sets remain effective. |
| Session incomplete | Missing/pending fields remain visible after Finish. |
| Return pending/failed/received | Watch remains authoritative until idempotent receipt; repeats create no duplicate. |
| AI unavailable/timeout/invalid/mapping failure | Current plan, Watch training, and local recording remain available. Preserve chat input; preserve a draft only when its identity/validation state is trustworthy. |
| Recognition accepted/uncertain/abstained | Accepted remains correctable; uncertain waits for a safe pause; abstention/manual-only keeps the manual Complete Set path and is not counted as success. |
| RPE verifying/auto-use/abstained/drifted | Preserve predicted, confirmed, corrected, and effective values separately; drift resumes confirmation immediately. |
| Finish reminder eligible/suppressed | Eligible shows one Finish/Continue prompt; missing/unreliable signals, cooldown, active movement, or unsafe interaction suppresses it without ending the session. |
| Analysis current/stale/empty | Current uses effective Actual Sets; stale names pending correction/transfer; empty routes to the first recorded session without invented insight. |
| Apple Health not requested/no accessible data/pending/written/failed/detached | Keep each capability observable and optional; failure never blocks FitnessAI records or Analysis. |
| Plan file valid/unresolved/invalid/imported/export failed | Preview before save; unresolved mappings remain explicit; invalid/cancel/failed commit changes no plan; successful import creates a new draft only. |
| Proactive review available/later/disabled | One non-blocking invitation; Later preserves no hidden approval; Disabled stops future invitations until re-enabled. |

## Interaction Primitives

- iPhone uses native text entry, scrolling review, disclosure rows, toggles, explicit time-window selection, and explicit buttons. Send is never approval.
- Complete review is linear. The sole Approve action follows all content and repeats proposal identity, base revision, digest-short form, and consequence. Reject and Continue Conversation remain distinct.
- Editing reviewable content creates a new proposal identity/digest and clears prior approval.
- Watch is tap-first. Digital Crown may accelerate reps/load editing but is never the sole path; accessibility-adjustable actions are equivalent.
- Automatic recognition, RPE, and reminder prompts appear only at `restSafeForInteraction`; supersets, circuits, drop sets, active movement, and minimal-rest transitions defer prompts without losing pending facts.
- A representative 20-set session permits at most five proactive recognition/RPE/correction prompts in total. The finish reminder and post-session iPhone invitation remain separately dismissible and never compete with active-set controls.
- Apple Health authorization is capability-specific. Import uses the system file picker; export invokes native Share Sheet only after the selected-plan scope is shown.
- Frequent Watch controls are at least 44 × 44 pt. Plan-effective/destructive actions are explicitly labeled and never swipe-only.
- Status does not steal focus. Local-save failure, safety stop, stale approval, or another action-blocking integrity failure may interrupt.
- **Banned:** chat-message approval, prechecked data categories, approval reuse, silent rebase, partial activation, “saved” before local commit, auto-Start/Finish, hidden retry, and AI mutation of Actual Sets.

## Accessibility Floor

- VoiceOver, Dynamic Type, Reduce Motion, increased contrast, and Full Keyboard Access on iPhone; VoiceOver and native adjustable controls on Watch.
- Proposal headings are navigable. Diff rows announce field path, before/after values, change type, and future-session scope.
- Authorization controls announce category, state, purpose, and record window; focus/scroll/general app consent never selects a category.
- Approval announces proposal identity, base revision, validation result, and that effectiveness follows local commit.
- Pending, delivered, failed, stale, withdrawn, incomplete, and safety-blocked use text/accessibility values, never color alone.
- Failure focus lands on error summary then recovery action; Retry retains input. Approval invalidation focuses its reason before refreshed review.
- Watch completion and reps/load editing remain usable with VoiceOver, sweat/reduced precision, and no Crown. Haptics have visible/spoken equivalents.
- Recognition/RPE updates coalesce and do not repeatedly announce during formal sets. At a safe pause, VoiceOver reads retained facts before uncertainty and choices.
- Analysis charts expose equivalent summaries, values, periods, and trends without requiring visual chart interpretation.
- Apple Health and plan-file states expose scope, provenance, success/failure, and Retry without depending on system icons or color.
- Largest supported Chinese text must not truncate consequence, values, or action labels.

## Trust, Privacy, and Safety Invariants

- Remote AI receives only affirmatively authorized categories/windows. Eligible Apple Health input is limited to user-selected local summaries from the versioned allowlist under a one-shot per-request authorization; HealthKit permission alone sends nothing. Raw sensor streams, imported-plan contents, cloud-restored copies, and excluded clinical/medical categories remain outside Alpha remote AI. All real Health-summary transmission fails closed until the provider/legal/privacy/region/retention/training-use/deletion/revocation/user-rights gate is approved.
- Authorization/proposal shows a data-source summary, never chain-of-thought; FitnessAI neither stores nor exposes model chain-of-thought.
- Displayed and committed digests match. Effective revisions retain `proposalId`, digest, approval event, base revision, schema/model version, Safety Rule Pack version, and data-source summary.
- Alpha Plan Safety Rule Pack checks units, missing/contradictory schedule constraints, canonical Exercise support, and bounded volume, intensity, and load progression; every check returns pass or blocking reason.
- Confirmed/corrected Actual Sets are evidence, never AI mutation targets. Proposals affect only named future sessions through a new revision.
- Unknown is safer than invented content; the prior active revision is safer than a partial/unapproved replacement.

## Offline, Synchronization, and Recovery

| Boundary | Authority and recovery |
|---|---|
| iPhone Plan commit | Atomic/idempotent local store; failure leaves prior revision effective. |
| Plan delivery | Full Watch receipt verification; retry/reconnect cannot duplicate/rollback; switch only after full compatible revision arrives. |
| Active Workout | Watch Start snapshot stays fixed through disconnect or newer commits. |
| Actual Set save | “Saved” only after durable Watch commit; recovery restores the latest session and one visible pending fragment rather than dropping/duplicating it. |
| Actual Set return | Idempotent transfer; repeats/out-of-order events produce one effective set/revision and never revert a later correction. |
| Apple Health | FitnessAI local record remains authoritative; read/write failure or external deletion cannot roll back or silently recreate either copy. |
| Plan file exchange | Import commits a new draft atomically; export/share failure changes no plan and retains no broader data payload. |

## Responsive & Platform

Private Alpha targets iPhone 11+/iOS 18+ and Apple Watch Series 6+/watchOS 11+, subject to physical-device checks. iPhone reviews use native scrolling/reflow; no iPad or landscape-specific layout is required. Watch keeps one primary task per surface and routes complete proposal/privacy review to iPhone.

## Key Flows

### UJ-1 — Wei completes a quiet automatically assisted strength session

1. Wei opens the delivered plan on Watch and manually starts; the session binds to that revision snapshot.
2. Within the frozen whitelist, Watch attempts Exercise, set-boundary, and rep recognition while keeping formal sets quiet. Each result retains confidence/provenance.
3. At `restSafeForInteraction`, uncertainty can be confirmed, corrected, or deferred with Later. Unsupported or abstained cases use manual Complete Set; correcting Exercise preserves reps, load, RPE, timing, and order.
4. If RPE is enabled, predicted values enter the five-estimate confirmation window. Low confidence abstains; verified auto-use requires explicit consent and remains correctable.
5. If both frozen finish signals later qualify, Watch may ask Finish or Continue; it never auto-finishes, and manual Finish remains available.
6. Every accepted or corrected Actual Set commits durably on Watch before appearing saved. Finish returns the Complete or Incomplete session to iPhone.
7. **Climax:** Wei finishes without repeated phone switching and sees a complete, truthful record where automation, correction, and manual fallback are distinguishable.

Failure: recognition/RPE/reminder failure degrades to manual recording without data loss or false success; all proactive prompts respect the shared session burden.

### UJ-2 — Wei reviews complete Analysis and decides what to change

1. Wei opens Training History and sees Complete/Incomplete sessions and auditable corrections.
2. He selects a week or month. Analysis derives session count, performed Exercises, volume, intensity, Actual Load, and duration only from effective Actual Sets.
3. He selects a Primary Exercise and sees its trend; excluded incomplete/conflicted inputs and RPE provenance remain visible.
4. Equivalent textual summaries expose every chart conclusion to VoiceOver.
5. Wei accepts the single non-blocking post-session review invitation or opens review himself; only then may permitted evidence enter the AI proposal flow.
6. **Climax:** Wei can explain what changed in training and decide whether the future plan should change without confusing planned work with completed work.

Failure: stale/conflicted inputs mark dependent analysis pending rather than presenting a false aggregate; Apple Health failure does not remove locally derived Analysis.

### UJ-4 — Lin creates and approves an executable first plan

1. Lin starts text chat and supplies goals, experience, schedule, session time, equipment, preferences, and physical limitations; gaps/assumptions remain visible.
2. Before remote use, all categories are off. Lin reviews purpose/provider/retention/training policy, selects categories and any record window, then affirmatively authorizes.
3. Injury/recovery disclosure stops the affected scope until exclusion or qualified guidance; warning signs stop generation and route offline care without diagnosis.
4. AI returns a complete structured draft. Schema, mappings, units, schedule, and Safety Rule Pack validate.
5. Lin continues chatting to edit; the prior proposal/approval becomes invalid.
6. Complete review shows duration, frequency, ordered sessions, Exercises, sets, reps/ranges, suggested loads, optional target RPE, mappings, assumptions, and unresolved fields.
7. Lin approves the displayed `proposalId`, base revision, and digest.
8. One immutable revision commits atomically; only success makes it effective and starts Watch delivery.
9. **Climax:** Watch reports the same delivered revision; Lin opens an executable plan without rebuilding items.

Failure: AI/validation/mapping/commit failure leaves the prior plan effective. Stale base requires a newly reviewed proposal; no silent rebase or old approval reuse.

### Flow 2 — Lin executes on Watch and returns truthful Actual Sets

1. Lin opens the fully delivered plan and taps Start; the session binds to that snapshot.
2. Supported recognition may complete a set automatically; abstained, unsupported, or incorrect results expose manual Complete Set or correction at a safe pause.
3. Planned first-load and previous-Actual-Load defaults remain visible. Lin edits reps/load when reality differs; Actual and planned facts remain distinct.
4. A set is saved only after durable local commit. Lin manually finishes; unresolved fields create an Incomplete session.
5. Transfer exposes pending/received/failed and idempotent Retry.
6. **Climax:** iPhone shows every set and supports full field correction plus split/merge/insert/delete without changing the plan snapshot.

Failure: offline, interruption, replay, or transfer failure preserves the Watch record and creates no duplicate; write failure retains input and never claims success.

### Flow 3 — Lin requests and decides one evidence-bounded revision

1. Lin corrects the returned session, adds concise feedback, and explicitly selects “Ask AI to review.”
2. Lin inspects authorization and selects only confirmed/corrected records with a time window.
3. AI names records/assumptions, applies the safety stop, and proposes against the current base.
4. Complete diff shows all additions/removals/changes and affected future sessions; historical Actual Sets and active/completed sessions are outside mutation scope.
5. Reject keeps the plan unchanged; approval uses the same identity, atomic commit, and delivery contract.
6. **Climax:** Lin understands and decides once without item-by-item reconstruction or silent mutation.

### Flow 4 — Lin recovers from AI or Watch-delivery failure

1. AI failure leaves the last confirmed plan visible and safe chat input retained.
2. Lin trains on the last delivered Watch revision and records locally.
3. iPhone names a new revision as pending/failed while Watch retains the old revision.
4. Reconnection retries idempotently; only a complete matching revision replaces the future Start offer.
5. **Climax:** remote failure cannot corrupt, duplicate, partially activate, or hide the plan/workout record.

### Flow 5 — Jia round-trips and shares one FitnessAI plan

1. Jia opens one Training Plan and chooses Export. The review names the selected plan, schema/catalog/revision/provenance, and excluded workout, health, and credential data.
2. FitnessAI creates the versioned file; Jia invokes the native iOS Share Sheet. Cancellation or share failure changes no plan.
3. Later Jia opens a FitnessAI plan file. The App treats it as untrusted, enforces bounded parsing, and shows the complete source/plan/mapping preview.
4. Unknown Exercises, incompatible fields, duplicates, and omissions remain visible. Jia maps, explicitly omits, or cancels; the App never guesses.
5. Confirm creates one new non-effective draft; it never overwrites an existing plan and still requires the normal proposal approval path to become active.
6. **Climax:** Jia can send and re-open a complete portable plan while explaining exactly what entered the library.

### Flow 6 — Wei connects Apple Health without surrendering local truth

1. From Apple Health settings, Wei enables only the read capability needed by selected workout/RPE/reminder/Analysis features; the UI reports observable availability, never an unknowable denial.
2. FitnessAI remains usable when data is unavailable and derives its complete local History/Analysis from Actual Sets.
3. After a durable Finish, an enabled write creates a pending HealthKit operation; written or failed/retry is separate from local save.
4. If the Apple Health copy is later removed, FitnessAI marks `healthKitDetached` and does not silently recreate it.
5. **Climax:** Wei sees the completed workout in Apple Health while the FitnessAI record remains authoritative and independently recoverable.

### Flow 7 — Mei records a complete phone-only workout

1. Mei opens a planned session or starts an ad-hoc session on iPhone; the App allocates the same stable session identity and immutable Plan snapshot used by paired capture.
2. She manually completes and edits Actual Sets with the same planned/history/previous-set load defaults, provenance, pending states, and durable local-commit rule.
3. She can correct, split, merge, insert, or delete sets without rewriting unrelated facts; unsupported Watch automation is absent rather than simulated.
4. Manual Finish remains authoritative. If fields remain unresolved, the result is an editable Incomplete Workout Session; app termination restores the latest durable state.
5. **Climax:** A user without a Watch completes the same trustworthy recording, correction, History, and Analysis loop without entering a second product model.

Failure: optional AI, Apple Health, or network failure does not block local capture; retries cannot duplicate or roll back a later correction.

## Requirements-to-Flow Coverage

| Requirement | Coverage |
|---|---|
| §6.1, UJ-1, UJ-2, UJ-4 | UJ-1/2/4, Flows 2–6: complete core-product Alpha loop |
| FR-001–041, NFR-RPE/SESSION/REC/RECOV/COMPAT | UJ-1, UJ-2, Flow 2: automatic capture/RPE/reminder, correction, Analysis, recovery |
| FR-054–060 | UJ-4, Flow 3: text intake, structured proposal, safety stop, complete review, immutable approval |
| FR-061–066 | Flow 2: correction, incomplete, audit revision, recovery, idempotence |
| FR-071–073, NFR-PORT-001 | Flow 5: bounded first-party file import/export, preview, Share Sheet, new draft only |
| FR-078–087; NFR-AI-001–006 | UJ-4, Flows 3–4: identity, validation, atomic commit, delivery, permitted data, failure behavior |
| FR-088–090, NFR-HK-001–002 | Flow 6: least-privilege read, idempotent write, local authority, detached state |
| FR-001–007, FR-016–019, FR-029, FR-036–041, FR-061–066 | Flow 7: first-class phone-only capture using the shared truth, correction, recovery, and Analysis model |
| FR-091 | UJ-2, Flow 3: one post-session invitation, Later/Disable, no data sent before acceptance |
| NFR-SAFE-001 | UJ-4, Flow 3: non-diagnostic stop and versioned review boundary |
| NFR-PRIV-007 | UJ-4, Flow 3: default-off categories, window, disclosure, inspection, withdrawal |
| NFR-UX-001 | All flows: coherent test-ready visual/layout and complete accessibility/error states |

## iPhone Layout and State Closure

The final private-Alpha iPhone layout contract is identified by `AI-L01`–`AI-L05`, `HX-L01`, `AN-L01`, `HK-L01`, `PX-L01`, and `RV-L01` in `DESIGN.md`, with the consolidated rendered review board at `native-ui-designs/native-ui-FitnessAI-2026-08-08/previews/iphone-core-alpha-final-v1.html`. The rendered examples use representative fixture values; their information hierarchy, containment, state grammar, navigation relationship, primary-action location, and responsive reflow are normative.

| Flow boundary | Required page sequence | State closure |
|---|---|---|
| Create a plan | Plan Home → AI Plan Chat → Remote AI Authorization → complete Proposal Review → separate Approval → local Commit result → Watch Delivery result | Authorization required/selected/withdrawn; generating/cancel/failure; valid/invalid/unmapped/safety-blocked/stale; approval ready/invalidated; commit pending/failed/succeeded; delivery pending/delivered/failed. |
| Revise a plan | Plan Home or Session Review → explicit review request → evidence authorization → complete field-level diff → separate Approval → Commit/Delivery | Every changed field and affected future session is shown; Reject retains the active revision; base/content change invalidates approval; historical/active sessions remain outside mutation scope. |
| Review history and evidence | Training History → Session Review and/or Analysis → exact unresolved record when needed | Ready, loading, empty, offline cache, incomplete, corrected, conflict, tombstone, stale/partial analysis, calculation failure, and current analysis. |
| Connect Apple Health | More/Settings → Apple Health capability list → system authorization when requested → per-record write state | Not requested, no accessible data, available, unavailable, write pending/written/failed, and `healthKitDetached`; local record remains authoritative in every state. |
| Exchange one plan | Plan detail → Export Review → native Share Sheet; or system file open/picker → Import Validation → complete preview/mapping → Create New Draft | Export ready/failed/cancelled; import loading/valid/unresolved/duplicate/invalid/unsupported/commit failed; no path replaces an existing plan. |
| Post-session invitation | Complete Session Review → one nonmodal invitation → Review/Later/Disable; Review → evidence authorization → existing revision proposal flow | Showing/dismissing sends nothing; Later creates no hidden approval; Disable stops future invitations; AI failure retains the session, feedback, and effective plan. |

Native back restores the originating object, filter, scroll position, and unsent/non-effective input. Loading cannot cover a usable current plan or cached history. A failed action preserves user input and the prior durable fact. Destructive deletion, explicit omission during import, authorization withdrawal, and proposal rejection each name their exact scope and do not share the primary action styling of creation or approval.

## Surface Closure and Handoff Boundary

Every §6.1 need has a surface, state, recovery path, and final layout contract; every Alpha surface lands in UJ-1, UJ-2, UJ-4, or Flows 2–7. Watch v11 is the accepted starting visual reference where it agrees with the spines. The iPhone phone-only workout, AI, History/Analysis, Apple Health, Plan Exchange, and proactive-review layouts are promoted into the bilingual DESIGN/EXPERIENCE contract. The Alpha is ready for implementation SPEC distillation, subject to the named Architecture and physical-device gates below.

There is no blocker to start lean `bmad-architecture`. Before implementation acceptance, Product/Architecture must freeze the recognition whitelist, RPE and reminder operating points, plan-file parser limits, Apple Health capability mapping, and Alpha Plan Safety Rule Pack v1. Before a real remote call, they must also name provider/subprocessor, retention, training policy, and request-field-to-authorization-category mapping. Professional review remains required before release beyond Product Owner testing.

## Deferred Decisions

1. Public-launch brand polish and broad device optimization remain later; the private-Alpha key-screen visual/layout contract is complete.
2. Post-Alpha conversation form/explanation density (DV-008/009): Alpha uses text chat plus complete linear review.
3. Weekly/cycle-end cadence, broader remote-AI data/coaching, and public performance targets (DV-003/006/012): Alpha uses one post-session invitation and explicitly permitted data.
4. Recognition whitelist, RPE auto-use threshold, and reminder operating point (DV-004/005/010/011) must be frozen for Alpha; broader coverage waits for evidence.
5. Cloud account/restoration, rich media, voice, arbitrary third-party formats, and server-backed link/QR sharing remain deferred.

# PRD → Architecture Spine Reconciliation Review

## Verdict

**REVISE BEFORE FINALIZE**

The spine captures the central architecture well, but reconciliation is not yet complete. Two Product Owner decisions now conflict directly with the authoritative PRD, and three cross-cutting PRD contracts are either missing or only broadly deferred. Finalization should not claim full PRD alignment until the two upstream contradictions are resolved and the missing shared budgets/lifecycle rules are bound or explicitly deferred.

Reviewed inputs:

- Primary: `../../../prds/prd-FitnessAI-2026-07-19/prd.md`
- Translation check: `../../../prds/prd-FitnessAI-2026-07-19/prd.zh-CN.md`
- Candidate spine: `../ARCHITECTURE-SPINE.md`

The English and Chinese PRDs agree on all findings below; no translation-only divergence was found in the inspected load-bearing passages.

## Highest-priority findings

### F1 — BLOCKER: phone-only capture is an accepted architecture override but contradicts the PRD's Watch-authority contract

**PRD:** §3.1 says Apple Watch is the active-session surface and authority (`prd.md:131`), and FR-001 says a planned or ad-hoc session starts on Apple Watch (`prd.md:227`). The private-Alpha normative set includes FR-001 (`prd.md:196`). The Chinese copy carries the same rule (`prd.zh-CN.md:131`, `:227`).

**Spine:** AD-3 explicitly binds phone-only sessions and gives iPhone capture the same IDs, states, persistence, and Analysis (`ARCHITECTURE-SPINE.md:43-47`); the capability map repeats an iPhone-local phone-only workout (`:154-165`). This matches the later Product Owner decision that many users have no Watch, but it is not the same product topology as the current PRD. The spine acknowledges the conflict under Deferred (`:169`) but does not define which requirement source wins for implementation before that reconciliation.

**Required disposition:** update the PRD/UX to make phone-only capture a first-class path and redefine “Watch authority” as authority only while a paired Watch is the active capture device; or remove phone-only capture from the first-build spine. Given the explicit Product Owner decision, the former is the expected resolution. Preserve one session/fact model across phone-only and paired modes as AD-3 already requires.

### F2 — BLOCKER: private-Alpha remote use of Apple Health summaries contradicts the PRD's explicit exclusion

**PRD:** Apple Health is an explicit non-input to remote AI in the first usable build (`prd.md:174`, `:210`); FR-082 limits Alpha AI input to conversation, profile/constraints, and explicitly permitted confirmed/corrected FitnessAI records (`:341`); DV-006 defers Apple Health AI use until after Alpha (`:453`). The Chinese copy says the same (`prd.zh-CN.md:174`, `:210`, `:341`, `:453`). FR-086/NFR-PRIV-007 define consent/minimization but do not cancel FR-082's Alpha exclusion (`prd.md:345`, `:414`).

**Spine:** AD-8 binds “remote health context” and authorizes every remote request after an exact per-request preview (`ARCHITECTURE-SPINE.md:73-77`); AD-9 makes a broad Alpha HealthKit allowlist available as local summaries to AD-8 (`:79-83`). This matches the later Product Owner approval, but changes the first-build scope and privacy threat surface. Deferred notes the unresolved source conflict (`:169`) and provider-policy prerequisites (`:170`).

**Required disposition:** update FR-082, the first-build non-goals, §6.3, and DV-006 to permit only user-selected, locally summarized Apple Health categories under AD-8's per-request authorization; retain the ban on raw motion/heart-rate streams. Until provider entity, region/cross-border path, retention/cache, model-training policy, deletion/revocation, and disclosure are frozen, the implementation must remain unable to send real health summaries, as the existing Deferred item requires.

### F3 — HIGH: the shared proactive-interruption budget was dropped

**PRD:** SM-INT-001 fixes a shared budget of no more than five proactive confirmation/correction requests in a representative five-exercise, twenty-working-set session; Exercise, rep, load, and RPE prompts all consume the same budget (`prd.md:35`). FR-011 and FR-025 explicitly depend on it (`:240`, `:257`), and NFR-RPE-005 requires RPE burden gates to fit inside it (`:374`). It is part of the normative private-Alpha acceptance set (`:196`).

**Spine:** AD-6 governs recognition, RPE, safe-rest prompting, and Forgotten Finish, but defines no shared counter/budget or arbitration rule (`ARCHITECTURE-SPINE.md:61-65`). Without a single cross-feature rule, recognition and RPE units can each remain locally compliant while collectively exceeding the product budget.

**Required disposition:** bind the five-request representative-session budget in AD-6 or a consistency convention; define one session-scoped budget shared by all proactive Exercise/rep/load/RPE prompts. Forgotten Finish should be classified explicitly as either inside or outside that budget, because the PRD's wording currently lists only confirmation/correction prompts.

### F4 — HIGH: Watch/app/model size budgets and release measurement are absent

**PRD:** NFR-SIZE-001 through NFR-SIZE-005 bind the thinned iPhone ceiling (500 MB installed), Watch ceiling/internal target (75 MB/25 MB), total Watch ML budget (6 MB), per-set RPE budget (2 MB), exclusion of large Watch media, and App Thinning/TestFlight measurement (`prd.md:362-366`). The Chinese copy is aligned (`prd.zh-CN.md:362-366`). These are especially load-bearing because Watch storage and future inference scope drove the phone-first topology.

**Spine:** AD-3 says only “minimum inference assets” stay on Watch (`ARCHITECTURE-SPINE.md:47`), and AD-13 requires physical-device evidence (`:103-107`), but neither binds the numeric budgets nor the release-size measurement method. Deferred mentions future battery budgets and 90-minute storage evidence, not the already-set size limits (`:172`).

**Required disposition:** add the existing numeric size ceilings/targets and App Thinning measurement as a convention or AD-13 rule. These are inherited PRD constraints, not operating points the architecture may silently replace.

### F5 — HIGH: public-beta account/cloud lifecycle is too broadly deferred to preserve its destructive-data semantics

**PRD:** public-beta account scope requires application-cloud restoration and local-first synchronization (UJ-5; §6.2), durable conflict preservation (FR-042–048), deletion tombstones that prevent offline resurrection (FR-067), observable restore state (FR-068), sign-out retain/remove handling (FR-069), cross-account non-merge (FR-070), 30-day deletion/de-identification (NFR-PRIV-004), self-service full account export (NFR-PRIV-005), secure authentication/session revocation/reauthentication (NFR-SEC-002), and China-region governance (`prd.md:109-125`, `:203`, `:283-289`, `:320-323`, `:409-416`).

**Spine:** AD-2/4 cover local revision and paired Watch synchronization, not application-cloud account synchronization. Deferred postpones selection and threat modelling of China-region account/sync infrastructure and “user-rights operations” (`ARCHITECTURE-SPINE.md:173`), but does not preserve the non-obvious lifecycle invariants above. A later cloud unit could therefore select last-write-wins deletion, merge local data into a different account, or provide support-only export while still appearing to satisfy the broad Deferred wording.

**Required disposition:** keep provider/infrastructure choices deferred, but expand the Deferred contract to name: local-first event sync; no time-only conflict resolution; deletion tombstones/no offline resurrection; visible restoration state; sign-out retain/remove choice with unsynced-data disclosure; no silent cross-account merge; self-service full export/deletion; 30-day deletion/de-identification; reauthentication for destructive privacy actions; and local capture survival during auth/cloud failure.

## Coverage matrix

| PRD load-bearing area | Spine disposition | Assessment |
|---|---|---|
| Truthful local commit, completeness, correction preservation, immutable Plan snapshot (SM-COMP, SM-PRES, FR-002–007, FR-012–014, FR-029, FR-061–066) | AD-2, AD-5; explicit-state conventions | **Covered.** Atomic revision/outbox/invalidation, visible branches, immutable active-session snapshot, unreadable-store rule, and idempotent recovery establish the needed ownership model. Story-level pending-fragment UI remains in PRD. |
| Phone-only users and paired-device ownership | AD-3; capability map; Deferred | **Conflict, not fully reconciled.** Architecture contains the later PO override, while PRD still makes Watch the first-build authority and Start surface. See F1. |
| Watch transfer, offline queue, acknowledgement, duplicates/reordering (FR-043, FR-046, FR-081, FR-084, NFR-AI-003, NFR-RECOV) | AD-4, AD-2, AD-5 | **Covered for iPhone↔Watch.** Durable outbox, causal envelopes, durable-receipt acknowledgement, last-complete-plan activation, and stable IDs prevent the principal divergences. |
| Concurrent field edits and conflict resolution | AD-2, AD-4, AD-11 | **Covered.** Different fields merge, same-field branches remain visible, and device clock/arrival order cannot select truth; iPhone resolves. |
| Recognition support matrix, abstention, correction provenance, manual fallback | AD-6; conventions; Stack baseline | **Mostly covered.** Series 11 Alpha evidence row and Series 6+/watchOS 11+ install baseline are explicit. However, the PRD's fixed feasibility metrics (75% classification; ±3-second boundaries with 80% precision/recall; 80% reps within ±2) are not named. They may remain PRD acceptance criteria, but AD-6's phrase “exact operating points” must not imply they can be re-decided without a PRD change. |
| Cross-feature proactive prompt burden (SM-INT-001) | None | **Missing.** See F3. |
| RPE opt-in, five-estimate gate, provenance, calibration, abstention, drift | AD-6; predicted/confirmed/corrected convention | **Covered at invariant level.** The exact ±1 correctness and rolling-two-of-five drift threshold is partly compressed; AD-6 explicitly binds the five-estimate gate and drift, while the PRD remains the detailed acceptance authority. |
| Forgotten Finish: manual authority, dual signal, no auto-finish, missing-signal suppression/cooldown | AD-6 | **Covered.** The accepted 15-minute trigger/cooldown is stronger and explicit. False/missed-rate validation remains correctly evidence-gated. |
| Plan execution defaults, next-set suggestion, substitutions (FR-016–019, FR-027–035) | AD-2, AD-3, AD-7; canonical Exercise/version conventions | **Partially covered.** User-authoritative facts and no active-session AI mutation are bound, but substitute matching and next-set suggestion acceptance are principally left to PRD/domain stories. This is acceptable only if the PRD remains a mandatory downstream source; no contradictory spine rule was found. |
| History/Analysis truth, stale results, incomplete/conflicted exclusion, versioning | AD-11; AD-2 | **Covered.** PRD retains the detailed formulas (bodyweight/assistance separation, no invented %1RM, interrupted duration, user-selected primary Exercises). |
| AI-native complete plan/diff, one approval, atomic commit, no silent mutation | AD-7, AD-2 | **Covered strongly.** AI is untrusted but produces a complete native structure; one digest-bound approval commits the entire revision, so there is no item-by-item re-entry. |
| Non-diagnostic safety stop and balanced deterministic rule pack | AD-7; Deferred professional review | **Covered.** The affected-scope stop, warning signs, units/contradiction/canonical support/personal progression checks, blocking outcomes, versioning, and review gate are present. |
| Built-in DeepSeek gateway and DeepSeek BYOK | AD-8, AD-5, AD-12 | **Covered.** Product key stays server-side; BYOK key is device-only and bypasses FitnessAI servers; arbitrary endpoints are excluded; adapters are capability-declared. |
| Remote-AI consent, minimum scope, provider isolation, audit without content/secrets | AD-8, AD-9; Deferred provider-policy gate | **Covered except for source-scope conflict.** Per-request allow/narrow/cancel and audit minimization are sound. Health-summary eligibility conflicts with FR-082; see F2. |
| Apple Health local access/copy, read-state honesty, idempotent write, detachment | AD-9 | **Covered.** Local FitnessAI truth remains authoritative; read status does not infer denial; copy identity/revision and no silent recreation are explicit. The broad Alpha allowlist represents a later PO decision and must be reconciled upstream. |
| Data classification, local protection, no iCloud/CloudKit/backup, raw-stream locality, secret handling | AD-5, AD-8, AD-9, AD-13 | **Covered for private Alpha.** Research/model-development upload remains implicitly outside enabled routes; if later added, NFR-PRIV-003's separate consent/retention/revocation contract must be made explicit. |
| Plan file portability and untrusted parser | AD-10 | **Covered.** Generic `.json` plus internal marker still satisfies a documented FitnessAI-owned versioned payload. Bounds, full preview, new-draft-only import, mapping, and no executable/external content are explicit. Parser time/memory budget is still absent and should remain a Story-acceptance deferred item if not fixed now. |
| Application/model size and Watch media placement | AD-3 only, qualitatively | **Missing numeric invariant.** See F4. |
| Runtime/battery/thermal/latency physical evidence | AD-13; Deferred | **Mostly covered.** Physical-device testing and 90-minute evidence are present; the PRD's p95 ≤1 second for Start/correction/Finish and zero resource termination/loss are not named in the spine but remain direct acceptance constraints. |
| Device/OS matrix and evidence-only expansion | AD-6, AD-13, Stack | **Covered.** iPhone 11+/iOS 18+ and Series 6+/watchOS 11+ are preserved; automation claims are narrower by evidence, with manual fallback. Expansion cannot rest on simulator evidence. |
| Environments, secret separation, optional-feature fail-closed controls, no accidental public release | AD-13 | **Covered.** Development/private Alpha/future production separation and release gates are explicit. |
| Public-beta account/cloud restoration, deletion/export/auth lifecycle | Broad Deferred only | **Under-specified.** See F5. |
| Post-MVP voice, broader providers/endpoints, Android, broader plan sharing/HealthKit | Deferred | **Covered as deferrals.** The spine correctly avoids premature binding while requiring new adapters/contracts/disclosures/evidence. |
| Private-Alpha complete visual/accessibility/state contract (NFR-UX-001) | AD-13 references accessibility; source list includes DESIGN/EXPERIENCE | **Partially covered by inheritance.** Light/dark, Dynamic Type, VoiceOver, and error/empty/loading/offline/recovery remain binding through the PRD/UX sources, but the spine does not restate them. No contradictory rule found. |

## Disposition summary

- **Covered by AD/Convention:** local truth and revision semantics; iPhone↔Watch causal synchronization; recovery and retention; evidence-gated automation; RPE/finish safety; AI proposal/approval/commit; DeepSeek gateway/BYOK boundaries; HealthKit copy/read-state rules; bounded JSON plan exchange; revision-bound Analysis; modular code boundaries; environment and physical-device gates.
- **Explicitly deferred with adequate revisit condition:** provider legal/policy details before real remote health traffic; Safety Rule Pack numeric fixtures/professional review; broader automation evidence; SQLCipher threat review; post-Alpha providers/endpoints/Android/sharing/medical categories.
- **Explicitly deferred but still too broad:** public-beta account/cloud lifecycle (F5).
- **Not landed:** shared five-request interruption budget (F3); numeric app/model size budgets and release measurement (F4).
- **Landed as architecture decisions but contradictory to current PRD:** phone-only capture (F1); private-Alpha remote Apple Health summaries (F2).

## Finalize gate recommendation

Do not mark the spine `status: final` as “PRD-reconciled” until F1–F4 are resolved. F5 may remain Deferred only after its non-negotiable lifecycle semantics are named explicitly. The preferred resolution is to preserve the later Product Owner choices in AD-3/AD-8/AD-9 and update both PRD language versions so downstream Story generation receives one coherent source of truth.

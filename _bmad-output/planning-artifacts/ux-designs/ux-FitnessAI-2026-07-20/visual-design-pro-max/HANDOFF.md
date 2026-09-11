---
title: FitnessAI Titanium Measure Visual Design Handoff
status: confirmed-ready-for-bmad-consumption
version: 1.1.0
confirmed_direction: Titanium Measure
stack: SwiftUI
platforms: [iOS 18+, watchOS 11+]
updated: 2026-08-08
---

# FitnessAI Titanium Measure Visual Design Handoff

## 1. Handoff Status

Direction A, Titanium Measure, is confirmed. This delivery is the visual authority for brand expression, composition, typography, color, spacing, component appearance, charts, icon strategy, motion, haptics, and light/dark/Always On adaptation.

It is not a PRD replacement and does not authorize implementation beyond existing scope. The static HTML/CSS previews are review carriers, not Web implementation guidance.

## 2. Authority Order

### Product and behavior authority

1. `../../../prds/prd-FitnessAI-2026-07-19/prd.md`
2. `../../../prds/prd-FitnessAI-2026-07-19/addendum.md`
3. `../EXPERIENCE.md`
4. `../review-accessibility.md`
5. `../review-trust-privacy-safety.md`
6. `../validation-report.md`
7. `../review-rubric.md`

These sources own functionality, MVP/Post-MVP scope, flows, safety, privacy, trust semantics, state behavior, data provenance, synchronization, recovery, and user authority.

### Visual authority

1. `../DESIGN.md` — BMAD visual identity spine and phase-aware component contract.
2. `../../../../../design-system/fitnessai/MASTER.md` — confirmed Titanium Measure system.
3. `../../../../../design-system/fitnessai/tokens.json`
4. `../../../../../design-system/fitnessai/pages/`
5. This `visual-design-pro-max/` delivery: page, component, state, preview, and SwiftUI specifications.

`DESIGN.md` inherits Titanium Measure. The master token file wins for raw visual values; `DESIGN.md` and `EXPERIENCE.md` win for phase scope, component availability, and behavior.

## 3. Artifact Map

| Artifact | Purpose |
|---|---|
| `../../../../../design-system/fitnessai/MASTER.md` | Confirmed global visual source of truth |
| `../../../../../design-system/fitnessai/MASTER.zh-CN.md` | Complete Chinese counterpart |
| `../../../../../design-system/fitnessai/tokens.json` | Machine-readable semantic tokens |
| `../../../../../design-system/fitnessai/pages/` | Platform/page-family overrides |
| `components/COMPONENT-SPECS.md` | Component anatomy, variants, states, and invariants |
| `components/SWIFTUI-MAPPING.md` | Native implementation mapping |
| `states/STATE-MATRIX.md` | State encoding and per-surface coverage |
| `states/ACCESSIBILITY-VALIDATION.md` | Accessibility and physical-device gates |
| `watch/` | Five Watch page specifications |
| `iphone/` | Nine MVP iPhone specifications, one V1.1 portability specification, and one gated Post-MVP specification |
| `previews/` | High-fidelity PNG review boards and static HTML carriers |

Every English Markdown artifact has a same-directory `.zh-CN.md` counterpart with matching structure and conclusions.

## 4. Platform Responsibility

| Concern | Apple Watch | iPhone |
|---|---|---|
| Active Workout Session | Local-first authority; start/resume, capture, set completion, manual Finish | Companion only; does not replace active-session authority |
| Fast correction | Safe-rest supported corrections; optional Crown accelerator; explicit commit | Complete field editing and long explanations |
| Complex records | Preserve pending fact and hand off exact context | Split/merge/insert/delete, conflicts, unsupported semantics |
| Plans | Start selected plan; view immediate context | View, create, edit, substitute, reuse history, approve changes |
| Analysis/history | Minimal finish summary only | Complete history, trends, exclusions, revisions |
| Sync/recovery | Local durable boundary, resumable session | Restoration, retry, conflict selection, lifecycle coordination |
| Privacy/account | Minimal observable status | Account, permissions, export, deletion, research, sign-out/switch |

## 5. Page-to-Requirement and Component Matrix

### Apple Watch

| Page/spec | Requirements and flows | Primary components | Trust/state responsibility | Preview |
|---|---|---|---|---|
| `watch/WORKOUT-ENTRY.md` | FR-001, FR-028, FR-030–032, FR-043, FR-049; UJ-1, UJ-3, Flow 8 | Primary Action, Support Boundary, Sync Boundary | offline start, plan/ad-hoc, supported/manual-only/unsupported | `previews/watch-pages-review.png` 01 |
| `watch/ACTIVE-SESSION.md` | FR-002–004, FR-008–010, FR-016–019, FR-043, FR-061; UJ-1, UJ-3, Flows 6/8 | Instrument Readout, Durability Rail, Fact State, Primary Action | actual vs planned, user load authority, local write, sensor gap | preview 02 |
| `watch/REST-RESOLUTION.md` | FR-007, FR-011–015, FR-019–027, FR-061–062; UJ-1, UJ-3, Flow 8 | Correction Boundary, Crown Adjustable, RPE Prompt, Set Row | safe interaction, retained facts, predicted/confirmed/corrected/pending | preview 03 |
| `watch/WATCH-RECOVERY.md` | FR-043, FR-046, FR-064–066; UJ-5, Flows 6/7 | Recovery Choice, Set Row, Durability, Sync | durable boundary, partial write, duplicate replay, concurrent session | preview 04 |
| `watch/WATCH-FINISH-REVIEW.md` | FR-004–007, FR-029, FR-033–034, FR-062–063; UJ-1, UJ-3, Flow 6 | Set Row, Fact State, Durability, Sync, Primary Action | Complete/Incomplete, manual Finish authority, local vs sync | preview 05 |

### iPhone

| Page/spec | Requirements and flows | Primary components | Trust/state responsibility | Preview |
|---|---|---|---|---|
| `iphone/TODAY-PLANS.md` | FR-028, FR-035, FR-043–045; UJ-1/2/3 | Plan ledger, Primary Action, Sync, Support | plan vs actual boundary, Watch route, offline cache | `previews/iphone-core-pages-review.png` 01 |
| `iphone/TRAINING-PLANS.md` | FR-028–035; UJ-1/2/3, Flow 8 | Plan ledger, Plan Diff, Support Boundary | explicit substitute/update choice, future revision, draft | core preview 02 |
| `iphone/SESSION-REVIEW.md` | FR-006–007, FR-026, FR-029, FR-033–035, FR-040–041, FR-061–063; UJ-1/3, Flows 7/8 | Set Row, Fact State, RPE Prompt, Plan Diff, Sync | complete correction, provenance, conflict, effective revision | core preview 03 |
| `iphone/TRAINING-HISTORY.md` | FR-035–041, FR-045–046, FR-063, FR-067–068; UJ-2/3/5 | Session ledger, Fact State, Sync, Lifecycle | Complete/Incomplete, offline cache, restoration, tombstone | core preview 04 |
| `iphone/ANALYSIS.md` | FR-037–040, FR-046, FR-063; UJ-2 | Trend Chart, metrics, Fact State, exclusion boundary | effective Actual Sets, excluded pending data, stale conflict | core preview 05 |
| `iphone/EXERCISE-CATALOG.md` | FR-030–032, FR-049–053; UJ-1/4, Flow 8 | Canonical identity, Support Boundary, attribute ledger | support/manual-only, licensed media, no wrist form claim | `previews/iphone-system-pages-review.png` 01 |
| `iphone/SYNC-RECOVERY.md` | FR-043–048, FR-063–070; UJ-5, Flows 6/7 | Sync, Lifecycle, Recovery, revision comparison | retries, replay, conflicts, restoration, concurrent sessions | system preview 02 |
| `iphone/ACCOUNT-PRIVACY.md` | FR-042–048, FR-067–070; UJ-5, Flow 9 | Lifecycle, Sync, capability/copy-scope rows | permission vocabulary, export, deletion, research, sign-out/switch | system preview 03 |
| `iphone/SUPPORT-MATRIX.md` | FR-049–053 and release gates; Flow 8 | Support Boundary, matrix ledger, Fact State | named supported/limited/manual-only/unsupported state | system preview 04 |
| `iphone/TRAINING-PLAN-PORTABILITY-V1-1.md` | FR-071–FR-073, NFR-PORT-001, DV-007; Flow 10 | Plan Exchange Review, Fact State, Support Boundary, Primary Action | **V1.1 only**; untrusted file, complete preview, mapping/omission, new draft, no overwrite | spine/page spec only; no MVP preview |
| `iphone/BEGINNER-PLAN-POST-MVP.md` | FR-054–060, NFR-SAFE-001; UJ-4 | labelled intake, Safety Boundary, Plan Diff | **Post-MVP only**; professional safety gate; explicit approval | system preview 05 |

## 6. Component State Inventory

| Component | Required states |
|---|---|
| `TitaniumPrimaryAction` | idle, pressed, disabled-with-reason, committing, committed, failed-preserving-draft |
| `InstrumentReadout` | planned prefill, previous-set/history prefill, user-entered, predicted, confirmed, corrected, unresolved |
| `DurabilityRail` | editing, committing locally, saved locally, sync pending, synchronized, failed |
| `FactStateLabel` | accepted, uncertain, corrected, unresolved, pending, stale, conflict, manual-only, unsupported |
| `ActualSetLedgerRow` | confirmed, auto-used RPE, corrected, required-field pending, tombstoned, conflict |
| `CorrectionBoundary` | safe, deferred, committing, committed, failed, safe-state withdrawn |
| `CrownAdjustableValue` | unchanged, drafting, limit, unsupported semantic, committing, failed |
| `RPEVerificationPrompt` | disabled, first-five, passed/offer, recalibrating, auto-used, drift, abstained, missing signal |
| `PlanDiffReview` | proposal, edited, accepted, declined, stale, conflict, failed |
| `SyncBoundaryIndicator` | saved locally, phone received, pending, synchronized, offline, retrying, failed, conflict |
| `RecoveryChoiceSheet` | exact recovery, partial write, ambiguous boundary, concurrent session, committing, failed |
| `SupportBoundaryNotice` | supported, limited, manual-only, unsupported, low confidence, matrix unavailable |
| `LifecycleRequestRow` | accepted, in progress, scoped completion, failed, offline device pending, retained exception |
| `TrendEvidenceChart` | loading, ready, empty, excluded pending input, stale conflict, calculation failed |
| `SystemStatePanel` | loading, empty, offline cached, error, unsupported, restoration, local-write failure |
| `PlanExchangeReview` | export ready/failed, validating, compatible, unsupported/newer, malformed/over-limit, duplicate, mapping required, explicit omission, ready, committing new draft, committed, failed |
| `StructuredInputDraft` | future permission/unavailable, listening/transcribing, interrupted, ambiguous, draft, conflict, edited/confirmed/rejected, committing, committed, failed |

## 7. Sync, Recovery, Privacy, and Confirmation Boundaries

- **Synchronization:** local durable success and cloud synchronization are separate. Never revoke “saved locally” because sync fails.
- **Recovery:** show the recovered identity and latest durable boundary. Partial writes become one pending Actual Set. Replay is idempotent.
- **Conflict:** preserve every involved user-authored revision. Device time alone cannot choose. Dependent Analysis and proposals remain stale/pending.
- **Privacy:** always name the copy—local structured, synchronized, Apple Health-owned, research-uploaded, exported, or local raw stream.
- **Permissions:** HealthKit read has observable data states and never claims denial.
- **Confirmation:** predictions, auto-used RPE, user confirmation, correction, and effective value remain distinguishable. Automation never becomes irreversible truth.
- **Unsupported semantics:** preserve supported sibling facts and hand off to the exact iPhone field.
- **Plan portability:** untrusted input is bounded, previewed, mapped, and converted into a new draft only. Existing plans remain unchanged on cancel or failure.
- **Future voice/share:** preserve extension states and provenance but add no MVP navigation, continuous listening, share affordance, or raw-audio authorization.
- **Record-informed AI:** DV-006 blocks UX/feature design. Architecture may preserve generic evidence/provenance/proposal/decision fields only; no AI page or service is implied.

## 8. Preview Inventory

| Preview | Coverage |
|---|---|
| `previews/watch-pages-review.png` | All five Watch surfaces |
| `previews/iphone-core-pages-review.png` | Today, Plans, Session Review, History, Analysis |
| `previews/iphone-system-pages-review.png` | Catalog, Sync, Account, Support, gated Beginner Plan |
| `previews/states-review.png` | Eight high-risk state treatments |
| `previews/themes-review.png` | Watch dark/Always On; iPhone dark/light/Increase Contrast |

The corresponding `.html` and `titanium.css` files are static review carriers. Do not translate them into Web architecture or Tailwind components.

## 9. SwiftUI Implementation Location

- Global system: `../../../../../design-system/fitnessai/MASTER.md`
- Tokens: `../../../../../design-system/fitnessai/tokens.json`
- Component contracts: `components/COMPONENT-SPECS.md`
- Native primitive mapping: `components/SWIFTUI-MAPPING.md`
- Page composition and state specs: `watch/` and `iphone/`
- Accessibility/device gates: `states/ACCESSIBILITY-VALIDATION.md`

Implementation uses semantic Color Assets, semantic Font roles, `@ScaledMetric`, `NavigationStack`, native controls, Swift Charts, environment accessibility values, and state models that separate draft/local commit/sync.

## 10. Instructions for BMAD Architecture

- Preserve Watch local-first active-session authority and distinct draft/local/sync states in architecture.
- Preserve stable IDs, auditable revisions, tombstones, idempotent replay, and exact-field handoff.
- Define semantic token assets and reusable component boundaries; do not encode raw visual values per screen.
- Do not turn HTML preview files into implementation dependencies.

## 11. Instructions for Epics and Stories

- Reference the page spec, component spec, state matrix, PRD FRs, and user flow in every UI story.
- Acceptance criteria must include normal, loading, empty, offline, failure, pending, conflict, recovery, and unsupported states applicable to that page.
- Add explicit accessibility, light/dark, Dynamic Type, VoiceOver, Reduce Motion, Increase Contrast, and safe-area criteria.
- Keep Post-MVP Beginner Plan stories out of MVP until its safety/product gates pass.
- Keep V1.1 plan portability out of MVP. Before its stories enter acceptance, Product and Architecture must freeze DV-007 parser limits.
- Keep voice, third-party formats, QR/link sharing, and record-informed AI out of MVP; future-state contracts are architecture boundaries, not story authorization.

## 12. Instructions for Dev Agent

- Read `MASTER.md`, the relevant design-system page override, the page spec, component specs, and state matrix before implementation.
- Use SwiftUI native semantics and SF Symbols. Do not introduce Web fonts, CSS values, generic card components, or hover behavior.
- Show success only after local commit; update sync separately.
- Preserve exact Chinese state vocabulary from `EXPERIENCE.md`.
- Verify previews are references, not pixel-fixed layouts; Dynamic Type and device adaptation take priority over literal screenshot geometry.

## 13. Physical-Device Validation Still Required

- two-second Watch glance under bright/dim gym lighting;
- sweat, one-hand touch, Crown, accidental-touch resistance, and haptic discernibility;
- Always On luminance/burn-in-safe behavior;
- small/large Watch and iPhone geometry, landscape where applicable;
- longest Chinese strings, 200% iPhone and 140% Watch enlargement;
- VoiceOver focus restoration across correction/recovery/handoff;
- P3/sRGB and Increase Contrast;
- offline, local-write failure, delayed/reordered replay, conflict, and restoration;
- SF Symbol availability/optical weight at deployment targets.

## 14. Open Release Gates

1. Watch load semantics subset (unit, increment, per-side, assisted, bodyweight, timed set, custom Exercise).
2. Chinese RPE anchors and education placement; literal integers remain the safe interim.
3. Forgotten-Finish dual-signal physical-device evidence; feature stays unavailable until passed.
4. Post-MVP Beginner Plan professional safety review and NFR-SAFE-001.
5. Licensed/owned Exercise media availability.
6. DV-007 bounded parser limits for V1.1 Training Plan files.
7. Future voice supported surfaces/facts, duplicate identity, recognition mode, and separate raw-audio policy/consent.
8. Future sharing transport, access, expiry, revocation, forwarding risk, authenticity, and China-region placement.
9. DV-006 Product definition before any record-informed AI UX or feature architecture.

## 15. Conflict Resolution Rule

1. Functionality, scope, safety, privacy, state behavior, and data semantics: PRD, Addendum, `EXPERIENCE.md`, and review documents win.
2. Color, typography, composition, visual hierarchy, component appearance, chart language, and brand expression: this confirmed UI UX Pro Max delivery wins.
3. `DESIGN.md` and Titanium Measure are reconciled peers: raw visual token values come from the master system; phase scope and component availability come from the spines.
4. Implementation convenience cannot change confirmed product boundaries.
5. If a new conflict remains ambiguous, stop the affected implementation, document the exact conflict, and return it to Product/UX rather than guessing.

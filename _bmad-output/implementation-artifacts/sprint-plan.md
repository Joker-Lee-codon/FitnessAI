---
workflow: bmad-sprint-planning
project: FitnessAI
date: 2026-09-11
status: complete
tracking_file: sprint-status.yaml
source_of_truth: epics.md
readiness: READY FOR SPRINT PLANNING — refinement required before individual Sprint commitment
language_copy: sprint-plan.zh-CN.md
---

# FitnessAI Sprint Plan

## 1. Planning Verdict

FitnessAI may enter Sprint Planning. This plan is an ordered private-Alpha delivery ledger, not a capacity or calendar commitment: team size, velocity, and Sprint length were not provided and are not invented.

The current Epic order and S0→S7 delivery spine are preserved. A Story may move from `backlog` to `ready-for-dev` only when its commitment controls below are satisfied. A completed implementation never implies that evidence passed or that a feature is enabled.

## 2. Authoritative Baseline and Sequence

The implementation authority order is the current PRD, `EXPERIENCE.md`, `DESIGN.md` plus Titanium Measure, `native-ui-spec.md`, `architecture-handoff.md`, and then the Architecture Spine where it does not supersede a higher authority. `epics.md` is the complete Story inventory.

| Slice | Epic / Stories | Exit outcome |
|---|---|---|
| S0 | Epic 1, Stories 1.1–1.5 | Runnable workspace, platform-neutral contracts, revision policy, persistence boundary, and canonical catalog |
| S1 | Epic 1, Stories 1.6–1.10 | Trustworthy phone-only manual workout |
| S2 | Epic 1, Stories 1.11–1.14 | Trustworthy paired-Watch manual workout and exactly-once return |
| S3 | Epic 2, Stories 2.1–2.14 | Authorized AI conversation to approved Plan Revision, with GATE-1–3 fail closed |
| S4A | Epic 3, Stories 3.1–3.3 | User-authoritative in-workout decisions |
| S4B | Epic 4, Stories 4.1–4.7 | Truthful History, Analysis, and future-Plan reconciliation |
| S5A | Epic 5, Stories 5.1–5.6 | Bounded Plan exchange, with GATE-7 fail closed |
| S5B | Epic 6, Stories 6.1–6.6 | Optional Apple Health context/copy, with GATE-3 fail closed |
| S6 | Epic 7, Stories 7.1–7.13 | Evidence-gated Watch assistance with complete manual fallback |
| S7 | Epic 8, Stories 8.1–8.6 | Controlled review and private-Alpha integration/release evidence |

The 13 later-scope requirements remain explicitly deferred and must not appear as delivered placeholders in S0–S7: `FR-042`, `FR-044`, `FR-045`, `FR-048`, `FR-051`, `FR-067`–`FR-070`, and `FR-074`–`FR-077`.

## 3. Sprint Commitment Policy

A Story can be committed only when all applicable conditions pass:

1. Its predecessor contracts exist and no forward dependency is introduced.
2. Any oversized parent has child tasks with independent evidence and unchanged parent acceptance/traceability.
3. Its Gate prerequisites are closed for the exact version and scope; otherwise the named capability remains disabled.
4. Story 1.1's AD-13 CI overlay is included before it becomes `ready-for-dev`.
5. Applicable document-governance actions are closed by their stated boundary.
6. Release beyond Product Owner testing retains the mandatory professional safety review.

The tracking file separates three facts for every Gate: `implemented`, `evidence_passed`, and `feature_enabled`. All begin `false`.

## 4. Enabler, Compliance, and Evidence Classification

The 23 prerequisite/control Stories retain their existing order and user-risk rationale but are not reported as ordinary user-value delivery.

| Classification | Story IDs | Count |
|---|---|---:|
| Enabler | 1.1–1.4; 2.2; 2.5; 5.3; 7.1; 7.11 | 9 |
| Compliance | 2.1; 5.2; 7.2; 7.7; 7.12; 8.5 | 6 |
| Evidence | 2.3; 2.6; 5.5; 6.3; 7.3; 7.8; 7.13; 8.4 | 8 |
| **Total** |  | **23** |

## 5. Fail-Closed Gate Ledger

| Gate | Ordered ownership | Enabled path | Required behavior while open or failed |
|---|---|---|---|
| GATE-1 | 2.1 prerequisite → 2.2 implementation → 2.3 evidence | Safety-eligible AI proposal and Plan commit | Proposal commit disabled |
| GATE-2 | 2.5 disabled adapter → 2.6 evidence | Built-in DeepSeek traffic | Built-in traffic technically disabled; local fake/BYOK contract work only |
| GATE-3 | 2.8 preview → 6.2 local summary → 6.3 evidence → 6.4 use | Real Health-derived remote send | Preview/local summary only; send fails closed |
| GATE-4 | 7.1 candidate → 7.2 preregistration → 7.3 evidence → 7.4/7.5 use | Passing recognition rows only | Manual Complete Set remains available |
| GATE-5 | 7.6 state flow → 7.7 preregistration → 7.8 evidence → 7.9 verification → 7.10 use | Evidence-bound, explicitly enabled RPE auto-use | RPE off or approved confirmation-only path |
| GATE-6 | 7.11 disabled candidate → 7.12 preregistration → 7.13 evidence/use | Conservative Finish-or-Continue prompt | Manual Finish only; never automatic Finish |
| GATE-7 | 5.2 budgets → 5.3 parser → 5.4 preview → 5.5 evidence → 5.6 use | Plan import acceptance | Export allowed; import acceptance and draft creation disabled |

Gate closure is version- and scope-bound. A later version change, missing evidence, failed slice, or emergency disable returns only the affected capability to fail-closed behavior without blocking manual local workout capture.

## 6. Oversized Story Refinement

The following parent Stories remain in the canonical inventory but are blocked from Sprint commitment until the listed child-task boundaries are written. Child tasks must each produce independent completion evidence and collectively preserve every parent acceptance criterion and traceability link.

| Parent | Scenarios | Required child-task boundaries |
|---|---:|---|
| 1.6 | 11 | Local Plan creation and validation; immutable Start snapshot; iPhone entry/UI and atomic start failure recovery |
| 1.7 | 11 | Actual Set domain contract; atomic persistence/idempotency; iPhone capture UI and accessibility/error states |
| 1.8 | 13 | Field correction/revision; incomplete/pending fact behavior; active-session UI, recovery, and preservation evidence |
| 1.9 | 12 | Manual Finish state transition; post-Finish derivation/review; failure/idempotency and accessibility evidence |
| 1.10 | 12 | Startup recovery; offline/partial-write replay; conflict/incomplete presentation and fault evidence |
| 1.11 | 12 | Compatibility handshake/manifest; chunked durable delivery/acknowledgement; activation, retry, cleanup, and UI truth |
| 1.12 | 15 | Watch Start snapshot/runtime; manual set capture and local persistence; interruption/accessibility/failure evidence |
| 1.13 | 14 | Watch recovery state machine; correction and manual Finish; reconnect/restart/fault and UI evidence |
| 1.14 | 15 | iPhone receive/durable commit; exactly-once apply and revision reduction; acknowledgement/cleanup/conflict evidence |
| 2.1 | 13 | Numeric rule manifest; golden fixture corpus; decision record/versioning and professional-review boundary |

Refinement priority is 1.12 → 1.13 → 1.14 → 1.8 → 1.9 → 1.10 → 1.11 → 1.6 → 1.7 → 2.1.

## 7. AD-13 Apple Silicon/macOS CI Overlay

Story 1.1 owns the early quality pipeline. Before parallel feature work, its acceptance contract must include:

- A reproducible Apple Silicon/macOS runner using the bound Xcode 26.6 and Swift 6.3.3 toolchain.
- Required checks for compile, domain, schema, safety, persistence, sync, AI contract, and secrets on every change.
- Full iPhone and Watch build jobs, deterministic dependency resolution, and committed `Package.resolved`.
- Retained test artifacts with privacy-safe logs and a secretless pull-request path.
- A required-check policy that prevents merge when any mandatory check fails or is absent.

This is a Sprint acceptance overlay, not a new Epic or reordered Story; it preserves Story 1.1 as the first Enabler.

## 8. Document Governance Actions

| ID | Action | Owner | Blocking boundary |
|---|---|---|---|
| GOV-01 | Correct `native-ui-spec.md` so Apple Health summaries are allowed only after matching GATE-3 evidence and one-shot authorization; raw/unselected Health data remains excluded | Product Owner + UX | Before Story 2.8 or 6.4 implementation acceptance |
| GOV-02 | Normalize authoritative PRD, UX, and Native UI status/frontmatter; remove stale `draft` and reviewer-gate ambiguity without changing requirement content | Product Owner | Before parallel feature Sprint commitment |
| GOV-03 | Apply the documented authority order during every refinement; historical Direction D and stale addendum wording are non-normative | Product Owner + Delivery Lead | Every Story refinement |
| REF-01 | Complete the 10 parent-preserving decompositions in Section 6 | Delivery Lead | Before each affected Story is committed |

These actions are tracked as open `action_items` in `sprint-status.yaml`; source documents are not silently rewritten by Sprint Planning.

## 9. First Executable Work Item

**Enabler Story 1.1 — Launch the Runnable iPhone, Watch, and Shared-Contract Workspace** is first.

Immediate execution sequence:

1. Run Create Story for 1.1 and copy the Section 7 AD-13 CI overlay into its acceptance contract.
2. Confirm no speculative feature tables or future-capability placeholders are added.
3. Mark 1.1 `ready-for-dev` only after the story file contains the complete overlay.
4. Implement the runnable iPhone/Watch/shared-package seed and CI required checks.
5. Move through `in-progress` → `review` → `done`; its completion still does not close any GATE-1–7 capability.

## 10. Generated Status Summary

- Tracking files: `sprint-status.yaml` and `sprint-status.zh-CN.yaml`
- Total Epics: 8
- Total Stories: 69
- Epics in progress: 0
- Stories completed: 0
- Story files detected: 0
- Development status: all Epics and Stories remain `backlog`; all retrospectives remain `optional`


# FitnessAI AI-MVP Fast-Path Review

**Date:** 2026-09-08  
**Review scope:** Critical/high issues introduced or exposed by the AI-native MVP and First Usable Build / private-Alpha split.  
**Artifacts reviewed:** `prd.md`, `prd.zh-CN.md`, `addendum.md`, and `addendum.zh-CN.md`.  
**Verdict:** **CHANGES REQUIRED — no critical findings; five high findings.**

The update establishes the intended AI-native loop and preserves stable IDs and bilingual structure. It is not yet safe to hand directly to Architecture/Epics for the fast path because the private-Alpha applicability boundary remains non-normative, Watch delivery conflicts with the atomicity wording, approval can still hide non-“material” changes, AI data permission is underspecified, and the safety gate covers disclosed injuries more clearly than ordinary generated-plan safety.

## High Findings

### H1 — The private-Alpha slice has no normative FR/NFR applicability contract

**Locations:** `prd.md:176-205`, especially §6.1 and §6.3; all unqualified requirements in §7–§8. Chinese equivalent: `prd.zh-CN.md:176-205`.

Section 6 says that automatic recognition, automatic RPE, intelligent finish reminders, application-cloud accounts, complete Analysis, and rich teaching media do not block the First Usable Build. However, their FRs and NFRs remain unqualified requirements under a document titled “MVP Scope.” A downstream Architecture or Epic generator can reasonably treat FR-005, FR-008–015, FR-020–027, FR-036–048, FR-051–053, FR-067–070, the recognition/RPE/session gates, and public-cloud constraints as mandatory acceptance for the first build. This defeats the fast path even though the prose intends otherwise.

**Required resolution:** Add one normative release-applicability table or explicit requirement-set statement defining the exact First Usable Build IDs and the later Public-Beta IDs. At minimum the Alpha set must cover the manual planned-session path, local persistence/recovery, canonical exercise mapping, FR-054–060, FR-078–085, the applicable local runtime/security requirements, and the minimum safety/privacy clauses. State that requirements outside that set remain valid Public-Beta commitments but do not block Alpha Architecture, stories, or acceptance. Do not renumber existing IDs.

### H2 — Watch delivery is described both as eventually observable and as atomic with local activation

**Locations:** `prd.md:132`, `prd.md:162`, `prd.md:184-186`, FR-081–084 at `prd.md:331-335`, and NFR-AI-003 at `prd.md:407`. Chinese equivalents: `prd.zh-CN.md:132`, `162`, `184-186`, `331-335`, and `407`.

FR-081 explicitly permits pending and failed Watch delivery after a Plan Revision becomes effective, while NFR-AI-003 says “plan commit and delivery retry are atomic” and permits only the complete prior or complete new effective state. A cross-device transfer cannot be atomic with an iPhone-local commit under the stated offline model. The current text therefore cannot determine which revision the Watch may show or execute while delivery is pending or failed.

**Required resolution:** Limit atomicity to creation/activation of the iPhone-local Plan Revision. Define Watch transfer as idempotent and eventually consistent. While delivery is pending or failed, Watch may continue showing the last successfully delivered compatible revision, clearly labeled with its revision/status; it must never claim the new revision is available. A Workout Session snapshots the Watch revision at Start and remains on that snapshot. NFR-AI-003 must not treat remote delivery success as part of the local atomic transaction.

### H3 — “Material diff” leaves an approval loophole for omitted effective changes

**Locations:** UJ-4 step 6 at `prd.md:107`, AI plan-commit gate at `prd.md:140`, User Approval definition at `prd.md:163`, FR-057 at `prd.md:296`, and FR-060 at `prd.md:299`. Chinese equivalents: `prd.zh-CN.md:107`, `140`, `163`, `296`, and `299`.

The PRD repeatedly requires a “material” field-level diff, but never defines materiality. An implementation could classify a changed field as non-material, omit it from the review, and still obtain approval for a revision containing that hidden change. That contradicts SM-AI-002 and the user's no-silent-rewrite decision.

**Required resolution:** Require every effective addition, removal, and modification to appear in the approval payload. “Material” may control visual emphasis or summary ordering only; it cannot control inclusion. Approval must bind to an immutable proposal/revision identifier or content digest, and any regeneration or content change after display invalidates the earlier approval and requires a new review.

### H4 — Sensitive AI input permission is not specific enough to authorize remote processing

**Locations:** iPhone data-scope consent at `prd.md:130`, First Usable Build input at `prd.md:182`, FR-054 and FR-059 at `prd.md:293-298`, FR-078 and FR-082 at `prd.md:329-333`, NFR-PRIV-007 at `prd.md:394`, and addendum AI boundary at `addendum.md:49-55`. Chinese equivalents are at the same lines in the `.zh-CN.md` files.

FR-082 requires “explicitly permitted” structured records, but the PRD does not define when permission is requested, whether it is per proposal or persistent, which record/time range is included, how it is revoked, or what happens to an already generated draft. NFR-PRIV-007 requires disclosure before remote AI transfer but does not require an affirmative action tied to the disclosed data classes. This matters because physical limitations, injuries, subjective feedback, and workout history may be sensitive inputs even in a Product Owner Alpha.

**Required resolution:** Define a minimal permission state before any remote request: the user sees and affirmatively approves the included data classes and record/time range; the proposal retains that scope; withdrawal prevents future use and invalidates or visibly marks drafts whose permitted basis is no longer available. Distinguish local processing from remote transfer. Provider, retention, model-training use, and cross-border handling may remain implementation/configuration choices for Alpha, but they must be disclosed before transmission and cannot be inferred from general App consent.

### H5 — The safety gate protects disclosed injury cases but not ordinary generated-plan content

**Locations:** FR-058 at `prd.md:297`, NFR-SAFE-001 at `prd.md:401`, and NFR-AI-006 at `prd.md:410`; addendum safety boundary at `addendum.md:27-33`. Chinese equivalents: `prd.zh-CN.md:297`, `401`, `410`; `addendum.zh-CN.md:27-33`.

The normative safety behavior is strong when the user discloses an injury, recovery state, or warning sign. It does not define the minimum validation for an otherwise ordinary AI-generated plan: contradictory schedule/volume, unsupported load units, impossible or missing set prescriptions, excessive progression, or advice outside the supported fitness scope. NFR-AI-006 refers to “safety-excluded” output without defining the exclusion contract. A structurally valid plan can therefore pass schema validation while remaining unsafe or nonsensical.

**Required resolution:** Add a versioned minimum plan-safety validation contract that applies before commit even in private Alpha: supported units/ranges, required rest/recovery fields where applicable, contradiction detection, unsupported-prescription rejection, and the non-medical scope boundary. Product Owner-only Alpha may use a clearly labeled test rule bundle and need not wait for full professional sign-off; any release beyond Product Owner testing remains blocked by documented professional review of both injury flows and the plan-safety rule/content bundle.

## Stable-ID and Bilingual Audit

- FR numbering remains continuous through FR-085; the new FR-078–085 range does not collide with existing IDs.
- DV numbering remains continuous through DV-012.
- English and Chinese PRDs contain the same UJ, SM, FR, NFR, and DV ID sets and matching section structure.
- English and Chinese addenda contain matching section structure and materially equivalent AI/Alpha decisions.
- No critical/high bilingual semantic mismatch was found in the reviewed change set.

## Gate Recommendation

Resolve H1–H5 before treating the updated PRD as Architecture/Epic-ready. H1 is the direct speed blocker; H2–H5 are contract defects that would otherwise create rework or unsafe behavior inside the supposedly narrow Alpha path.

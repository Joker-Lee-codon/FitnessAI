# Addendum Reconciliation Report

**Date:** 2026-07-20  
**Sources reconciled:** `addendum.md`, `addendum.zh-CN.md`, `prd.md`, `prd.zh-CN.md`, `.memlog.md`  
**Scope:** Addendum role, PRD/addendum boundary, memlog decision coverage, and bilingual parity. Source documents were not modified.

## Gate Verdict

The addendum is substantively sound and its bilingual pair is synchronized. Most retained content correctly serves as downstream rationale, evidence, rejected-alternative history, or technical mechanism. Finalization should first resolve four boundary and coverage gaps: promote one safety release constraint into the PRD, record the cloud-data architecture rationale in the addendum while preserving its product-level constraints in the PRD, move technology-specific model and size-verification details out of the normative product contract, and prevent duplicated rules from becoming competing sources of truth.

## Content Disposition

| Content cluster | Current disposition | Recommended authoritative home |
|---|---|---|
| Rejected vivo route and Apple-route readiness rationale | Correctly retained as platform history and architecture context | Keep in addendum; retain only the launch platform and market in the PRD |
| `hasaneyldrm/exercises-dataset` media-license findings and provenance rationale | Correctly retained as asset due diligence; product prohibition is already represented by FR-051 and FR-053 | Keep detailed findings in addendum; keep licensed-content capability and prohibition in the PRD |
| Wrist-only sensing limitations and future motion-cue validation conditions | Correctly retained as feasibility evidence; user-facing claims are already bounded by the PRD | Keep evidence and mechanism in addendum; keep capability/non-goal boundary in the PRD |
| Injury and rehabilitation regulatory rationale | Correctly retained, but one product release constraint is missing from the PRD | Keep legal/medical rationale in addendum; promote the missing release constraint into the PRD |
| RPE evidence, experimental stack, named provenance fields, local inference/calibration placement, and Gate 0–6 research route | Mostly correct addendum material; some technology-specific detail is duplicated in the PRD | Keep technical mechanism and evidence in addendum; keep user-visible trust gates and measurable release outcomes in the PRD |
| Forgotten-finish signal rationale and physical-device validation detail | Correctly retained as mechanism and rationale; the AND-gate user behavior is already normative in the PRD | Keep rationale and validation detail in addendum; cross-reference rather than restating the full normative rule |

## Reconciliation Gaps

### GAP-ADD-001 — Injury warning escalation and professional review are not normative in the PRD

**Severity:** High for the Post-MVP beginner-planning release; not an MVP launch blocker while UJ-4 remains deferred.

The addendum records two confirmed product constraints that FR-058 does not fully capture: warning signs stop plan generation and direct the user to offline medical care without naming a diagnosis, and screening questions plus escalation copy require professional review before launch. These are user-visible safety behavior and a release gate, not merely regulatory rationale.

**Recommended resolution:** Add a Post-MVP functional or safety NFR preserving both constraints. Keep the regulatory analysis, rejected rehabilitation route, and source links in the addendum. Do not promote the detailed legal explanation into the PRD.

### GAP-ADD-002 — The accepted cloud-data decision lacks an addendum architecture record and a complete PRD governance constraint

**Severity:** High for architecture handoff.

The memlog distinguishes FitnessAI application-cloud synchronization from Apple iCloud/CloudKit and records that personal health information must not be stored in iCloud/CloudKit; it therefore requires a separately designed compliant China-region application backend, while complete high-frequency sensor streams remain local. The PRD captures local-first writes, China-region synchronization, restoration, and local sensor-stream retention, but it does not state the accepted iCloud/CloudKit prohibition. The addendum contains no dedicated persistence/synchronization rationale at all.

**Recommended resolution:** Add a product-level data-governance NFR stating the prohibited iCloud/CloudKit storage boundary and retain the required cross-device outcome, offline behavior, China-region compliance, conflict safety, export, and deletion in the PRD. Add an addendum section covering the rejected iCloud/CloudKit route, local-first/application-backend mechanism, synchronized-data classes, compact-model-summary compatibility, and high-frequency-stream locality. Avoid making a particular backend vendor part of the PRD.

### GAP-ADD-003 — Technology-specific model and release-size mechanisms are over-specified in the PRD

**Severity:** Medium.

The PRD legitimately needs measurable size ceilings, uncertainty behavior, release evidence, and user-burden gates. However, `Core ML` artifact allocation, per-model packaging targets, the 8–10 MB architecture-review trigger, local/iPhone placement of lightweight calibration, content-service placement, and Xcode/App Store Connect/TestFlight measurement mechanics describe solution and verification implementation. The addendum already contains part of the RPE deployment mechanism but none of the size-budget rationale or release-measurement method.

**Recommended resolution:** Keep platform hard limits, user-accepted installed-size ceiling, Watch headroom target, release evidence requirement, and product-visible RPE trust behavior as NFRs. Move or mirror the technology-specific allocation, compute placement, packaging strategy, measurement tooling, and architecture-review rationale into the addendum; simplify FR-023/NFR-RPE-008 to require recalibration from corrected labels without prescribing where it executes. Preserve stable IDs when editing the PRD.

### GAP-ADD-004 — The addendum repeats normative product rules without declaring the PRD authoritative

**Severity:** Medium drift risk.

The addendum restates exact RPE verification thresholds, auto-use policy, injury behavior, media prohibitions, and the forgotten-finish AND gate using normative language. These repetitions currently agree with the PRD, but future edits could create two competing requirement contracts. The addendum's proper role is evidence, rationale, alternatives, and mechanism.

**Recommended resolution:** Add a short scope note stating that the PRD is authoritative for product behavior and acceptance requirements. In repeated sections, retain the rationale and technical detail, then reference the stable FR/NFR IDs for normative behavior. Keep only addendum-only prohibitions where they document downstream implementation due diligence, such as the direct Gym visual license condition.

## Open Item That Must Stay in the PRD

`SM-RET-001` and the memlog still leave the pilot cohort acceptance threshold unset. This is a product success decision, not addendum material. It must either be resolved before pilot holdout evaluation or explicitly deferred with an owner and revisit condition; moving it into the addendum would hide a product gate.

## Bilingual Parity

**Status: PASS.**

- `addendum.md` and `addendum.zh-CN.md` both contain 49 lines, the same heading hierarchy, the same five content clusters, and matching paragraph structure.
- All three source links, inline paths, repository names, field identifiers, and the research-report path are preserved in both versions.
- The English and Chinese versions express the same platform choice, licensing prohibition, wrist-sensing limits, injury guardrail, RPE trust policy, and forgotten-finish behavior. No substantive translation divergence was found.
- `prd.md` and `prd.zh-CN.md` both contain 262 lines and preserve the same FR-001–FR-060, NFR, SM, and UJ identifiers. No addendum-related bilingual mismatch was found in the PRD pair.

## Memlog Coverage Conclusion

The addendum correctly preserves the major rejected alternatives and downstream technical depth for platform choice, teaching assets, motion sensing, injury scope, RPE estimation, and forgotten-finish reminders. The material omission is the accepted cloud-data architecture rationale. The material promotion gap is the injury-warning/professional-review release constraint. The remaining issue is placement: technology-specific RPE and size-verification mechanics should be consolidated under the addendum so the PRD remains the stable product contract.

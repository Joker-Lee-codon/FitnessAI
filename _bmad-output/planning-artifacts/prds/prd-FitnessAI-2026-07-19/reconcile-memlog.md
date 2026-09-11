# FitnessAI PRD Memlog Reconciliation

## 1. Scope and Gate Verdict

This audit reconciles all 81 entries in `.memlog.md` against `prd.md` and `addendum.md` as of 2026-07-20. It does not modify any source artifact.

**Gate verdict: CONDITIONAL PASS.** The current artifacts capture 70 entries, explicitly set aside 7 superseded or process-only entries, leave 3 unresolved decisions, and partially capture 1 data-governance clarification. No unresolved contradiction currently causes the PRD to state two incompatible product rules, but G-01 through G-04 must be resolved or formally deferred before finalization.

| Disposition | Count | Meaning |
|---|---:|---|
| Captured | 70 | The operative meaning is present in the PRD, addendum, or both. |
| Set aside | 7 | The entry is workflow history or was superseded by a later explicit decision. |
| Open gap | 3 | The memlog explicitly leaves a decision or validation obligation unresolved. |
| Partial | 1 | Most of the clarification is present, but a material boundary is absent. |
| **Total** | **81** | Every memlog entry is classified below. |

## 2. Material Gaps and Conflicts

### G-01 — Competitive differentiation remains unvalidated

- **Memlog:** M-005 records that Motra already offers Chinese-localized Apple Watch exercise and rep recognition and that differentiation must extend beyond recognition alone.
- **Artifact state:** The Vision differentiates implicitly through truthful record integrity, correction, RPE, plan control, and continuity, but neither artifact states the competitive hypothesis or how it will be validated.
- **Disposition required:** Resolve the differentiation hypothesis or defer it with a product owner and a revisit condition before positioning or launch validation. This is not an architecture blocker, but it remains an unresolved PRD strategy item.

### G-02 — Post-MVP beginner-plan review cadence remains open

- **Memlog:** M-036 leaves the trigger and precedence among post-session, weekly, and cycle-end review unresolved.
- **Artifact state:** UJ-4 says “approximately weekly or at cycle end,” which preserves the uncertainty but does not resolve precedence; FR-059 and FR-060 do not define it.
- **Disposition required:** Because beginner planning is Post-MVP, defer it explicitly with an owner and a revisit condition before UJ-4/FR-054–FR-060 enter epic or UX design. It does not block the MVP architecture.

### G-03 — Pilot continuation threshold remains open

- **Memlog:** M-062 says the four-week continuation cohort threshold must be fixed before holdout evaluation.
- **Artifact state:** SM-RET-001 accurately exposes the missing threshold, but no owner or decision date/revisit gate is recorded.
- **Disposition required:** Assign the product/experiment owner and set the threshold before pilot holdout evaluation. The metric cannot serve as a release gate until this is resolved.

### G-04 — iCloud/CloudKit health-data prohibition is only partially captured

- **Memlog:** M-051 distinguishes FitnessAI application-cloud synchronization from iCloud/CloudKit and states that personal health information must not be stored in iCloud/CloudKit.
- **Artifact state:** PRD §6.1 and FR-044–FR-047 capture a separate China-region backend and local high-frequency streams, but neither the PRD nor addendum explicitly preserves the iCloud/CloudKit prohibition.
- **Disposition required:** Add the explicit prohibition to the data-governance or architecture boundary before architecture handoff. This is the only material partial-capture issue and is an architecture/data-governance blocker.

## 3. Resolved Historical Conflicts

| Conflict | Earlier entry | Resolving entry | Current artifact state |
|---|---|---|---|
| Ad-hoc exercise selection | M-021 assumed recognition or quick confirmation with an open boundary. | M-022 removed preselection and requires automatic recognition with uncertainty prompts. | PRD follows M-022 in UJ-3 and FR-008–FR-011. |
| Beginner plans in MVP | M-028 placed limited AI beginner planning in the first version. | M-048 deferred AI beginner plans to Post-MVP. | PRD follows M-048 in §2, §5, §6.2, UJ-4, and FR-054–FR-060. |
| Exercise media licensing | M-037 treated repository images as a proposed source pending verification. | M-038 found the MIT license excludes images and videos. | Addendum and FR-051/FR-053 follow M-038. |
| Injury and rehabilitation behavior | M-043 proposed severity branching and rehabilitation-oriented work. | M-045 and M-046 reject rehabilitation prescription and retain non-diagnostic screening. | Addendum, Non-Goals, UJ-4, and FR-058 follow M-045/M-046. |
| Unconfirmed RPE truth | M-055 treated every unconfirmed prediction as provisional. | M-068 explicitly permits consented, high-confidence auto-use with provenance. | UJ-1, §6.1, FR-024–FR-026, and NFR-RPE-008–NFR-RPE-010 follow M-068. |
| Mac delivery prerequisite | M-002 required acquiring a Mac. | M-081 records that the Apple Silicon Mac and Xcode are ready. | Addendum records the prerequisite as satisfied. |

## 4. Entry-by-Entry Audit

| ID | Type | Disposition | Artifact mapping or set-aside reason |
|---|---|---|---|
| M-001 | change | Captured | Addendum, “Rejected first route: vivo watch + vivo phone.” |
| M-002 | decision | Captured | Addendum, “Initial delivery route”; prerequisite status updated by M-081. |
| M-003 | decision | Captured | PRD Vision and addendum identify mainland China Apple Watch users. |
| M-004 | decision | Set aside | Coaching path is workflow process history, not product content. |
| M-005 | event | Open gap | Motra differentiation obligation is not explicitly resolved; see G-01. |
| M-006 | decision | Set aside | Journey-led entry is workflow process history, not product content. |
| M-007 | decision | Captured | UJ-1 persona and Target User. |
| M-008 | decision | Captured | UJ-1 entry state and focus on formal training. |
| M-009 | decision | Captured | Vision and UJ-1 subsume the Watch/iPhone switching pain; naming Xunji is not required. |
| M-010 | decision | Captured | UJ-1, FR-028/FR-029, and RPE requirements preserve plan versus actual state. |
| M-011 | decision | Captured | UJ-1 quiet-default behavior and SM-INT-001 interruption budget. |
| M-012 | decision | Captured | FR-006 and FR-041. |
| M-013 | decision | Captured | FR-002, FR-026, FR-028, and FR-029. |
| M-014 | decision | Captured | UJ-1 and FR-027. |
| M-015 | decision | Captured | UJ-1 and FR-033/FR-034. |
| M-016 | decision | Captured | MVP Scope and FR-036–FR-039. |
| M-017 | decision | Captured | UJ-2 and FR-036–FR-039. |
| M-018 | decision | Captured | Emotional JTBD and UJ-2 Resolution. |
| M-019 | decision | Captured | UJ-3 and FR-001/FR-008. |
| M-020 | decision | Captured | UJ-3 and FR-035. |
| M-021 | assumption | Set aside | Superseded by M-022. |
| M-022 | change | Captured | UJ-3 and FR-008–FR-011. |
| M-023 | decision | Captured | UJ-3 and FR-012. |
| M-024 | decision | Captured | UJ-3 and FR-013. |
| M-025 | decision | Captured | UJ-1 and FR-030/FR-031. |
| M-026 | change | Captured | Target User broadens eligibility across experience levels. |
| M-027 | decision | Captured | Target User identifies the product-owner journey as a seed, not a boundary. |
| M-028 | change | Set aside | Superseded by M-048. |
| M-029 | decision | Captured | Addendum teaching-assets boundary and FR-051/FR-053. |
| M-030 | event | Captured | Addendum, “What wrist data can and cannot support.” |
| M-031 | decision | Captured | Non-Goals, addendum, and FR-053. |
| M-032 | decision | Captured | UJ-4 and FR-054. |
| M-033 | decision | Captured | UJ-4 and FR-056. |
| M-034 | decision | Captured | UJ-4 and FR-057. |
| M-035 | decision | Captured | UJ-4 and FR-059/FR-060. |
| M-036 | assumption | Open gap | Review cadence and precedence remain unresolved; see G-02. |
| M-037 | assumption | Set aside | Superseded by M-038 after license verification. |
| M-038 | change | Captured | Addendum teaching-assets boundary and FR-053. |
| M-039 | decision | Captured | Addendum separates code/data/text/media provenance and professional review. |
| M-040 | decision | Captured | UJ-4 and FR-055. |
| M-041 | decision | Captured | UJ-4 equipment edge and FR-030/FR-031 principle. |
| M-042 | decision | Captured | UJ-4 and FR-054. |
| M-043 | assumption | Captured | Addendum retains the proposed branch as rejected rationale; resolved by M-045/M-046. |
| M-044 | event | Captured | Addendum regulatory rationale and confirmed guardrail. |
| M-045 | change | Captured | Non-Goals, addendum, and FR-058. |
| M-046 | decision | Captured | UJ-4, addendum, and FR-058. |
| M-047 | decision | Captured | Vision and Target User. |
| M-048 | change | Captured | Target User, Non-Goals, MVP Scope, UJ-4, and FR-054–FR-060. |
| M-049 | decision by user | Captured | UJ-5, MVP Scope, FR-003/FR-043/FR-044. |
| M-050 | decision by user | Captured | UJ-5 and FR-042–FR-047. |
| M-051 | clarification | Partial | Separate China-region backend and local sensor streams are captured; explicit iCloud/CloudKit prohibition is absent. See G-04. |
| M-052 | decision by user | Captured | NFR-SIZE-001. |
| M-053 | requirement | Captured | NFR-SIZE-002–NFR-SIZE-004. |
| M-054 | event | Captured | Addendum RPE evidence boundary and NFR-RPE-001. |
| M-055 | decision | Set aside | Superseded by the explicit auto-use override in M-068; remaining multimodal boundary is captured. |
| M-056 | decision | Captured | FR-025 and NFR-RPE-003. |
| M-057 | requirement | Captured | NFR-RPE-004/NFR-RPE-005. |
| M-058 | decision | Captured | SM-COMP-001, SM-ACC-001, SM-RET-001, and SM-FEED-001. |
| M-059 | decision | Captured | SM-COMP-001. |
| M-060 | decision | Captured | SM-ACC-001 and SM-PRES-001. |
| M-061 | decision | Captured | SM-RET-001. |
| M-062 | assumption | Open gap | Threshold is visible in SM-RET-001 but remains undecided and unowned; see G-03. |
| M-063 | decision | Captured | SM-INT-001 and its counter-metric. |
| M-064 | change | Captured | UJ-1, FR-021/FR-022/FR-024, and NFR-RPE-008/NFR-RPE-009. |
| M-065 | change | Captured | UJ-1, FR-023, and NFR-RPE-008. |
| M-066 | decision | Captured | FR-020 and NFR-RPE-007. |
| M-067 | assumption | Set aside | Resolved by M-068/M-071. |
| M-068 | override | Captured | UJ-1, §6.1, FR-024–FR-026, and NFR-RPE-009. |
| M-069 | decision | Captured | UJ-1, FR-021/FR-023, and addendum verification state. |
| M-070 | decision | Captured | FR-025 and NFR-RPE-010. |
| M-071 | decision | Captured | FR-024/FR-026 and NFR-RPE-009. |
| M-072 | decision | Captured | Non-Goals and FR-019. |
| M-073 | decision | Captured | UJ-1 and FR-016/FR-018. |
| M-074 | decision | Captured | UJ-3 and FR-017/FR-018. |
| M-075 | decision | Captured | UJ-1, FR-005, and NFR-SESSION-001–NFR-SESSION-003. |
| M-076 | assumption | Captured | NFR-SESSION-002/NFR-SESSION-004 and addendum preserve the AND gate and validation condition. |
| M-077 | decision | Captured | FR-005 and NFR-SESSION-002. |
| M-078 | decision | Captured | FR-004/FR-005 and NFR-SESSION-001/NFR-SESSION-003. |
| M-079 | event | Captured | PRD contains FR-001–FR-060, with FR-054–FR-060 marked Post-MVP. |
| M-080 | decision | Captured | NFR-RES-001. |
| M-081 | change | Captured | Addendum records the Mac/Xcode prerequisite as satisfied. |

## 5. Final Reconciliation Conclusion

The PRD and addendum are materially aligned with the canonical memlog and contain no live product-rule contradiction. Finalization should proceed only after the explicit iCloud/CloudKit prohibition is restored (G-04) and G-01 through G-03 are either resolved or deferred with an owner and revisit condition. Historical conflicts listed in §3 are fully resolved in favor of the latest memlog decision and require no further product change.

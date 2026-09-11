# Structural Review — FitnessAI PRD Addendum

## Document Summary

- **Purpose:** Preserve evidence, rationale, rejected alternatives, and architecture-relevant mechanisms that support the chain-top PRD without becoming a second normative specification.
- **Audience:** Architecture, UX, compliance, and downstream workflow readers.
- **Reader type:** Humans; preserve evidence, source links, explanatory scaffolding, and compact summaries that aid cross-functional review.
- **Core question:** What evidence, rejected options, and implementation boundaries must downstream readers understand when applying the authoritative PRD?
- **Purpose statement:** This document exists to help architecture, UX, compliance, and downstream workflow readers understand the evidence and rationale behind the PRD's boundaries and make consistent downstream decisions.
- **Structure model:** Strategic/Context (Pyramid), with concern-based grouping for human random access.
- **Style guide:** Project `AGENTS.md` bilingual parity and the `bmad-prd` addendum role override generic brevity rules; the PRD remains normative, while the addendum retains evidence, rationale, rejected alternatives, mechanisms, and technical due diligence.
- **Current length:** 1,437 English words across 11 sections below the title (7 major sections and 4 subsections). The synchronized Chinese version contains approximately 2,619 countable units (Han characters plus Latin/alphanumeric tokens) across the same 11 sections.

## Structural Map

| Major section | English words | Directly serves purpose? | Structural finding |
|---|---:|---|---|
| Introduction | 39 | Yes | Front-loads authority and scope correctly; preserve. |
| Platform Route Decisions | 123 | Yes | The rejected route precedes the accepted conclusion, contrary to Pyramid ordering; the Mac setup detail can be tighter. |
| Content and Motion-Feedback Boundaries | 286 | Yes | Combines two non-overlapping concerns: asset licensing and wrist-sensing feasibility. |
| Injury Screening and Rehabilitation Boundary | 267 | Yes | The evidence and conclusion are essential, but the final paragraph partially restates normative PRD behavior. |
| Persistence, Synchronization, and Data Placement | 143 | Yes | Appropriate architecture mechanism and rejected-option rationale; it is the correct source of truth for local-versus-backend placement. |
| Size-Budget and Release-Measurement Rationale | 103 | Yes | Compact, decision-oriented, and correctly distinguishes product budget from verification tooling. |
| RPE Estimation Evidence and Deployment Boundary | 392 | Yes | The longest section buries its evidence/conclusion/mechanism layers and repeats some normative gate detail and one data-placement rule. |
| Forgotten Workout-Finish Reminder Signals | 84 | Yes | Compact mechanism rationale with an explicit validation boundary; preserve. |

The document has no unsupported appendix, FAQ, or overview-that-repeats-the-body anti-pattern. The main scope pressure is duplicated normative behavior that is already authoritative in `prd.md`, not evidence or rationale that belongs elsewhere.

## Flow Analysis

The current sequence is readable for an implementation-oriented reader, but it does not match the likely cross-functional journey. The highest-risk safety and licensing boundaries appear only after platform setup, while related architecture concerns and model-evidence concerns are separated rather than grouped. The content is adequately scaffolded and visually paced, but the dense RPE section lacks subheadings for evidence limitation, deployment mechanism, interaction trust gate, and scientific release validation. The direct source links and PRD requirement references are useful comprehension aids and should remain.

## Recommendations

### 1. MOVE - Group sections by downstream decision concern

**Rationale:** Reorder the body into Safety and Content Boundaries, Architecture and Data Decisions, and Model/Evidence Mechanisms so readers encounter risk constraints before implementation detail and can scan by responsibility.
**Impact:** ~0 words.
**Comprehension note:** Improves the human reader journey without removing content; suggested order is Injury Screening, Motion-Feedback Boundary, Exercise Teaching Assets, Platform Route, Persistence/Data Placement, Size Budget, RPE, then Forgotten-Finish Signals.

### 2. MOVE - Put the accepted Apple route before the rejected vivo route

**Rationale:** Pyramid structure requires the current decision and status before historical rejected-alternative rationale.
**Impact:** ~0 words.
**Comprehension note:** Keeps the vivo rationale intact but makes the operative platform route immediately visible.

### 3. QUESTION - Split asset licensing from motion-feedback feasibility

**Rationale:** `Content and Motion-Feedback Boundaries` mixes legally governed content provenance with sensor-capability limits, so two H2 sections would make the structure more MECE and easier to route to compliance versus architecture/UX readers.
**Impact:** ~0 words.
**Comprehension note:** This adds one major heading but preserves every paragraph and improves random access; the author should confirm the two-section boundary before applying it.

### 4. CONDENSE - Injury Screening and Rehabilitation Boundary

**Rationale:** Retain the proposed behavior, official-source reasoning, confirmed non-diagnostic boundary, and `FR-058`/`NFR-SAFE-001` references, while compressing the final paragraph's repeated operational behavior into a shorter conclusion because `prd.md` is authoritative.
**Impact:** ~45 words saved.
**Comprehension note:** Do not remove the regulatory distinction, source links, warning-sign escalation boundary, or professional-review requirement.

### 5. CONDENSE - RPE Estimation Evidence and Deployment Boundary

**Rationale:** Split the section into Evidence Limitation, Proposed Deployment, Provenance and Trust Gate, and Scientific Release Gate, then compress numeric interaction behavior already governed by `FR-020` through `FR-027` and `NFR-RPE-001` through `NFR-RPE-014` while retaining why the five-estimate window is not release evidence.
**Impact:** ~80 words saved.
**Comprehension note:** Preserve the multimodal rationale, abstention conditions, label-provenance rule, participant/temporal validation requirement, and research-report pointer; these are essential evidence and safeguards rather than expendable detail.

### 6. CUT - Repeated high-frequency sensor-placement sentence in the RPE section

**Rationale:** `Complete high-frequency sensor streams remain local by default` is already established in `Persistence, Synchronization, and Data Placement`, so the RPE section can refer to that section instead of repeating the rule.
**Impact:** ~11 words saved.
**Comprehension note:** The rule remains available in its single authoritative addendum location, so this cut does not remove meaning.

### 7. CONDENSE - Apple development-machine setup detail

**Rationale:** Preserve the fact that the former Apple-platform hardware prerequisite is resolved, but shorten the acquisition/configuration narrative because it is operational status rather than enduring platform rationale.
**Impact:** ~15 words saved.
**Comprehension note:** Keep the Apple Watch + iPhone route and mainland-China target market explicit.

### 8. PRESERVE - Introduction, source links, data-placement mechanism, size rationale, and reminder-signal rationale

**Rationale:** These elements are compact, correctly scoped to the addendum, and provide the authority boundary, auditable evidence, or mechanism rationale downstream readers need.
**Impact:** ~0 words.
**Comprehension note:** Cutting these elements would reduce cross-functional comprehension and auditability more than it would improve brevity.

## Summary

- **Total recommendations:** 8.
- **Estimated reduction:** ~150 English words (10.4% of the original) if all recommendations are accepted; the Chinese reduction should be meaning-equivalent rather than mechanically matched by character count.
- **Meets length target:** No target specified.
- **Comprehension trade-offs:** No recommended cut sacrifices an evidence source, safety boundary, rejected-alternative rationale, or downstream mechanism; the only direct cut consolidates a repeated data-placement rule.
- **Overall verdict:** The addendum's content is sound and in scope, but concern-based reordering, one section split, and targeted condensation would improve Pyramid flow and reinforce `prd.md` as the sole normative source.

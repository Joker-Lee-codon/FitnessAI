## Document Summary

- **Purpose:** Chain-top launch PRD for product, UX, architecture, and epic readers.
- **Audience:** Decision makers and downstream product-development workflows.
- **Reader type:** Humans; preserve orientation, named journeys, examples, edge cases, and scanning aids that materially improve comprehension.
- **Core question:** What must the FitnessAI MVP deliver and prove before it can launch as a trustworthy, near-zero-interaction strength-training recorder?
- **This document exists to help:** Product, UX, architecture, and epic decision makers align on the FitnessAI MVP scope, user-authority invariants, requirements, and release gates.
- **Structure model:** Strategic/Context (Pyramid).
- **Style guide applied:** Preserve bilingual structural parity, stable requirement and decision IDs, tables, code, links, and conclusions; keep grouped features with nested FRs and cross-cutting NFRs; keep implementation detail in the addendum when it does not earn a place in the PRD.
- **Current length:** 7,178 English words across 9 major numbered sections and 24 subsections (33 sections total). The synchronized Chinese source has the same 349-line structure; its 1,382 whitespace-delimited tokens are not directly comparable to an English word count.

### Current Structure Map

| Major section | Words | Directly serves purpose? | Structural observation |
|---|---:|---|---|
| 1. Vision | 105 | Yes | States the product promise and user-authority foundation clearly. |
| 2. Target User | 2,189 | Yes | The 1,572-word journey block delays scope, boundaries, and release-gate decisions. |
| 3. Product and Platform Boundaries | 366 | Yes | Critical support and evidence gates appear after the longest narrative section. |
| 4. Glossary and Measurement Definitions | 399 | Yes | Provides necessary scaffolding, but several terms are used extensively before they are defined. |
| 5. Non-Goals (Explicit) | 80 | Yes | Clear, with one direct duplication in MVP Out of Scope. |
| 6. MVP Scope | 173 | Yes | Useful orientation, but some acceptance-policy detail repeats later FRs and NFRs. |
| 7. Functional Requirements | 1,912 | Yes | Complete, but session lifecycle and account lifecycle requirements are split into distant groups. |
| 8. Non-Functional Requirements | 1,691 | Yes | Appropriate gate detail; RPE policy partly repeats functional behavior. |
| 9. Deferred Validation Gates | 210 | Yes | Owner and revisit conditions are useful, but release-decision context is buried at the end. |

## Recommendations

### 1. MOVE - Key User Journeys after the decision-ready scope and gate summary

**Rationale:** Decision makers currently traverse 1,572 words of journeys before learning the supported-device boundary, MVP scope, and evidence gates; keep Target User and Jobs To Be Done early, then place journeys after scope so narrative demonstrates an already-defined product.

**Impact:** ~0 words.

**Comprehension note:** Preserve all named protagonists, entry states, climaxes, resolutions, and distinct edge cases; this changes sequence, not meaning.

### 2. MOVE - Consolidate release decisions and gates near the front

**Rationale:** Create one decision-ready “MVP Release Decision and Gates” section immediately after success metrics by consolidating the existing §3.2 gate summaries, procedural gate clauses embedded in §2.2, and §9 owner/revisit conditions, while retaining each SM/DV ID and detailed acceptance threshold exactly once.

**Impact:** ~160 words saved by removing repeated pre-registration, holdout, and revisit phrasing.

**Comprehension note:** This front-loads launch status and evidence obligations without weakening any gate.

### 3. CONDENSE - Key User Journeys

**Rationale:** Retain each UJ ID and its persona/context, entry state, essential decision path, climax, resolution, and unique edge case, but remove sentences that restate detailed FR/NFR policies already defined later, especially RPE verification, correction preservation, plan-update authority, and synchronization behavior.

**Impact:** ~700 words.

**Comprehension note:** Do not reduce journeys to requirement references alone; the named narratives are high-value human comprehension aids.

### 4. MOVE - Group every Post-MVP beginner-planning item into one terminal section

**Rationale:** Move UJ-4, FR-054 through FR-060, NFR-SAFE-001, and DV-003 into a single “Post-MVP Beginner Planning” section after all MVP requirements so future-phase material no longer interrupts the MVP reading path.

**Impact:** ~0 words.

**Comprehension note:** Preserve the injury-safety gate and explicit-approval behavior in full; the recommendation changes phase grouping only.

### 5. MERGE - Rebuild Functional Requirements around two end-to-end lifecycles

**Rationale:** Merge §7.1 with §7.9 as “Workout Session Recording, Correction, and Recovery,” and merge §7.6 with §7.10 as “Account, Offline Use, and Synchronization Lifecycle,” ordering requirements from start through recovery/deletion while preserving every FR ID and statement.

**Impact:** ~0 words.

**Comprehension note:** Lifecycle grouping reduces random jumps without altering downstream requirement references.

### 6. CONDENSE - Separate RPE capability rules from measurable reliability gates

**Rationale:** Keep user-visible enablement, five-estimate verification, consent, correction, and provenance behavior in FR-020 through FR-026, and keep evaluation, uncertainty, drift, burden, and holdout acceptance in §8.2, shortening NFR-RPE-007 through NFR-RPE-010 where they repeat the functional policy while retaining all NFR IDs and conclusions.

**Impact:** ~130 words.

**Comprehension note:** Preserve the integer scale, eligibility denominator, drift trigger, frozen-gate record, and every measurable threshold.

### 7. CONDENSE - MVP Scope to an orientation layer

**Rationale:** Keep the five in-scope capability groups, but shorten sentence-level policy and acceptance detail already expressed in FRs/NFRs so §6 answers “what is in MVP” rather than partially repeating “how it is accepted.”

**Impact:** ~85 words.

**Comprehension note:** The concise scope remains a useful scan aid and should not be removed.

### 8. MERGE - Non-Goals and MVP Out of Scope

**Rationale:** Move the single §6.2 beginner-planning exclusion into §5 and remove the now-empty subsection because the same post-MVP boundary is already stated there.

**Impact:** ~15 words.

**Comprehension note:** Keep the explicit Post-MVP label and UJ-4 reference.

### 9. PRESERVE - Human comprehension and acceptance anchors

**Rationale:** Preserve the glossary, counter-metrics, named journey personas, distinct edge cases, support-matrix language, and numeric evidence thresholds because they prevent ambiguous interpretation by decision makers and downstream workflows.

**Impact:** ~0 words.

**Comprehension note:** Cutting these elements would reduce scanability, testability, or shared understanding more than it would improve brevity.

## Summary

- **Total recommendations:** 9
- **Estimated reduction:** 1,090 words (about 15.2% of the 7,178-word English source), yielding approximately 6,088 words if all recommendations are accepted.
- **Meets length target:** No target specified.
- **Comprehension trade-offs:** The reduction is concentrated in duplicated policy prose and journey-level restatement. Named journeys, edge cases, definitions, stable IDs, and measurable gates remain intact.


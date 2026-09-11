# Input Reconciliation — 2026-08-08 PRD Update

## Verdict

**PASS WITH ONE DOWNSTREAM UX FOLLOW-UP.** The updated PRD and addendum faithfully preserve the user's final product decisions and do not introduce a general record-informed AI feature into MVP. No critical or high-severity omission, scope conflict, silent-overwrite path, or local/cloud/privacy contradiction was found. The only genuine gap is that the pre-existing UX specification still traces requirements only through FR-070 and therefore does not yet cover the newly planned FR-071 through FR-077. That is a downstream UX-alignment task, not a PRD finalization blocker.

## Inputs Reconciled

- `prd.md` and `prd.zh-CN.md`, updated 2026-08-08
- `addendum.md` and `addendum.zh-CN.md`
- The user's change signals and final Coaching-path decisions in this update run
- `brief.md` and `brief.zh-CN.md`
- `EXPERIENCE.md` and `EXPERIENCE.zh-CN.md`
- `DESIGN.md` and `DESIGN.zh-CN.md`
- Project-level `AGENTS.md` requirements for bilingual document parity and product communication

## Decision-by-Decision Reconciliation

| Decision or boundary | PRD/addendum evidence | Reconciliation result |
|---|---|---|
| MVP must not add a general reader of local workout history or generalized record-informed AI advice; the idea is retained for later discovery | PRD §§5, 6.2, 6.3 and DV-006; addendum “Deferred Input and Training Plan Exchange Boundaries” | **Captured.** The PRD distinguishes the already-defined bounded capabilities—RPE, next-set load, substitution, plan-difference review, and Analysis—from the genuinely new generalized AI concept. No release is committed for the latter. |
| Revisit record-informed AI only after the core recording proposition is proven | PRD §6.3 and DV-006 | **Captured.** Recording, correction, recovery, and continuation gates are explicit prerequisites. A concrete journey, advice classes, evidence/explanation rules, safety exclusions, and permissions are required before UX, architecture, or epic design. |
| Voice belongs in the roadmap, with implementation Post-MVP | PRD §§5, 6.2, 6.3, FR-074–FR-075, NFR-VOICE-001; addendum deferred-input section | **Captured.** Voice is not an MVP input path and is described only as a future capability. |
| Voice is user-invoked, not continuous listening or an open-ended conversational coach | PRD §6.3 and FR-074; addendum deferred-input section | **Captured.** User invocation is explicit; continuous listening and open-ended coaching are expressly outside the commitment. |
| Voice parsing must create a correctable, provenance-bearing draft and must not silently overwrite confirmed data | PRD §6.3, FR-074–FR-075, NFR-VOICE-001 | **Captured.** Draft, confirmation, commit, cancellation, conflict, and unavailable states are preserved. Confirmed facts remain authoritative and an equivalent non-voice path remains available. |
| Raw audio has a separate permission and privacy boundary | NFR-VOICE-001; addendum deferred-input section | **Captured.** Existing workout-data consent does not authorize audio retention, upload, or model development. A later named purpose and separate explicit consent are required. |
| A FitnessAI-owned, versioned, single-Training-Plan file supports round-trip import/export in V1.1 | PRD §§6.2–6.3, FR-071–FR-073, NFR-PORT-001; addendum deferred-input section | **Captured.** Format/version validation, Exercise-catalog mapping, source/revision provenance, untrusted-input handling, preview, and compatible re-import are specified. |
| Plan import creates a new draft and never silently merges with or overwrites an existing plan | PRD §6.3, FR-072–FR-073, NFR-PORT-001 | **Captured.** Unknown fields, duplicate imports, unsupported versions, omissions, and failures remain visible rather than being guessed or represented as complete. |
| Arbitrary third-party formats and QR/link sharing remain Post-MVP / V2 | PRD §§6.2–6.3, FR-076–FR-077, NFR-SHARE-001; addendum deferred-input section | **Captured.** Third-party mapping and sharing are treated as separate capabilities rather than being smuggled into V1.1 portability. |
| QR/link sharing must preserve preview, provenance, minimization, and security/privacy boundaries | FR-077 and NFR-SHARE-001 | **Captured.** Shared payloads exclude sessions, Actual Sets, health data, and credentials. A QR code is explicitly not treated as authenticity, access control, expiry, revocation, or privacy. |
| AI, voice, import, sync, or recovery must not silently overwrite user-confirmed facts | PRD Vision; FR-003, FR-029–FR-034, FR-046, FR-063–FR-077; NFR-RPE-002, NFR-COMPAT-002, NFR-PORT-001, NFR-VOICE-001 | **Captured across the product contract.** The new roadmap items reuse the established user-authoritative, previewable, auditable, reversible data model. |
| Local, application-cloud, Apple Health, imported-plan, raw-signal, and raw-audio boundaries remain distinct | PRD §§6.1, 7.6, 8.6, 8.8 and DV-006; addendum persistence and deferred-input sections | **Captured.** Local durable commit remains authoritative; account continuity uses a governed China-region backend; high-frequency streams remain local by default; Apple Health, imported plans, and cloud-restored copies are not automatically eligible for future record-informed AI; raw audio requires a separate future decision and consent. |

## Cross-Input Consistency

### Product Brief

No conflict was found. The brief's core promise remains near-zero-interaction, trustworthy recording with reversible automation and user authority. Its exclusion of an expansive AI coach before recording integrity is proven is strengthened, not contradicted, by the updated PRD. The brief's generic account-level export remains distinct from the newly planned V1.1 single-plan round-trip file: PRD NFR-PRIV-005 governs the former, while FR-071 through FR-073 govern the latter.

### Existing UX EXPERIENCE and DESIGN

The existing UX remains consistent with the MVP boundary and with the new guardrails:

- Apple Watch remains the active-session authority and local durable commit remains the saved boundary.
- Suggested substitutions, next-set loads, plan diffs, and future progression require explicit user action.
- Provenance, pending/conflict states, correction, auditability, and local-versus-cloud truth are already central UX principles.
- `DESIGN.md` reserves action styling for user-authoritative actions and explicitly avoids treating visual state as “AI approved.”

The UX documents do not currently claim voice, portable single-plan files, third-party formats, or QR/link sharing as MVP features, so there is no scope contradiction.

## Genuine Gap

### UX-01 — Existing UX traceability ends at FR-070

- **Severity:** Medium downstream alignment; not a PRD blocker.
- **Evidence:** `EXPERIENCE.md`'s Requirements-to-Flow Coverage table ends with FR-067–FR-070. It has no flow or state coverage for FR-071–FR-077 or NFR-PORT-001, NFR-VOICE-001, and NFR-SHARE-001.
- **Why this is real:** The PRD now contains planned capabilities and architecture-preserving constraints that did not exist when the UX documents were finalized. Without an explicit UX delta, future teams could interpret V1.1 plan portability as ordinary account export, or design voice/share flows without the required draft, provenance, preview, conflict, permission, and minimization states.
- **Required follow-up:** Update UX as a phased addendum or revision. Define the V1.1 single-plan export/import journey and its untrusted-file, preview, mapping, partial-failure, duplicate, cancel, and new-draft states. For Post-MVP, record non-implementing state contracts for user-invoked voice and QR/link sharing; do not add them to MVP IA or visual implementation scope.

## Bilingual Parity Check

The English and Chinese PRD copies have matching line counts, section order, stable requirement identifiers, phase labels, and conclusions for this update. The addendum copies likewise match in section order and preserve the same scope, privacy, provenance, and overwrite constraints. No bilingual semantic divergence was found in the updated material reviewed here.

## Final Reconciliation Conclusion

No PRD correction is required from this reconciliation. The updated PRD/addendum can proceed through the remaining Finalize gates. The sole follow-up is to align the existing UX documentation with FR-071–FR-077 while keeping all new flows outside MVP and maintaining the PRD's phased implementation boundaries.

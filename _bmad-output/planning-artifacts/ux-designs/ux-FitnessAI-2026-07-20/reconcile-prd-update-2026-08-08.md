# UX Reconciliation — 2026-08-08 PRD Update

## Verdict

**Aligned with phase constraints.** The updated UX closes the prior FR-071–FR-077 traceability gap without expanding MVP. MVP keeps its existing Apple Watch/iPhone IA. V1.1 receives a complete single-plan portability contract; Post-MVP voice and broader plan exchange receive non-implementing boundaries; record-informed AI remains blocked by DV-006.

## Requirement-to-UX Delta

| PRD item | Phase | UX update | Implementation boundary |
|---|---|---|---|
| FR-071 | V1.1 | Flow 10 export preview names one plan, schema/catalog version, revision/source provenance, and excluded data classes. | Contextual iPhone route only; absent in MVP. |
| FR-072 | V1.1 | `Training Plan Portability` validates and previews complete content before creating a new draft. | No merge, overwrite, or revise-existing action. |
| FR-073 | V1.1 | Unknown Exercise, incompatible field/unit, duplicate, omission, newer version, malformed/over-limit, cancel, and failed-commit paths remain visible/recoverable. | DV-007 limits block story acceptance until frozen. |
| NFR-PORT-001 | V1.1 | Untrusted-file state model, parser failure boundary, source/version retention, safe no-mutation failure. | Parser executes no embedded content; existing plans stay unchanged. |
| FR-074–FR-075, NFR-VOICE-001 | Post-MVP | Future Flow Boundary 11 and `StructuredInputDraft` define user invocation, permission/listening/transcription/draft/conflict/confirm/local-commit/cancel/unavailable states. | No MVP route, continuous listening, open-ended coaching, raw-audio authorization, or silent overwrite. |
| FR-076 | Post-MVP / V2 | Future Flow Boundary 12 extends V1.1 preview/new-draft rules with named format/version, unit handling, mapping, and partial failures. | No third-party format is implied supported. |
| FR-077, NFR-SHARE-001 | Post-MVP / V2 | Recipient preview, minimized plan-only scope, new-draft creation, and explicit expired/revoked/inaccessible/invalid states. | QR alone proves no authenticity/access/privacy; transport decisions remain gated. |
| DV-006 | Deferred exploration | Architecture invariant preserves evidence/provenance/proposal/edit/accept/reject/audit fields. | No journey, screen, component instance, service, or story is authorized. |

## MVP Contract Check

- Apple Watch remains the standalone active-session authority and local durable saved boundary.
- iPhone remains responsible for complete correction, Training Plans, history, Analysis, lifecycle, conflicts, and future file preview/mapping.
- Active-set silence and the shared interruption budget are unchanged.
- User-confirmed/corrected facts outrank sensor, voice, import, AI, sync, and recovery outputs; conflicts create visible drafts and require a new successful local commit.
- No V1.1 or Post-MVP destination appears in MVP navigation or existing preview boards.

## Architecture Handoff Status

MVP UX is ready for `bmad-architecture`, subject to the existing release/device validation gates already carried by the spine. Architecture may define extension seams for source/provenance, draft/conflict, proposal decisions, file-version metadata, and bounded parsing. It must not implement deferred capability.

V1.1 portability is architecture-ready at the UX-contract level but not story-acceptance-ready until DV-007 numeric parser limits are frozen. Voice, sharing, and record-informed AI remain product-gated future boundaries.

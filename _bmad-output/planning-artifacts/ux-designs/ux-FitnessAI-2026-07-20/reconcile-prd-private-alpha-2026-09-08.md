---
name: FitnessAI PRD Private-Alpha UX Reconciliation
status: checkpoint
source: "{planning_artifacts}/prds/prd-FitnessAI-2026-07-19/prd.md"
updated: 2026-09-08
---

# FitnessAI PRD Private-Alpha UX Reconciliation

## Authority and Intent

The 2026-09-08 PRD and the Product Owner's subsequent clarification are authoritative. “First version” now means a personally usable core-product private Alpha, not a narrow technical walking skeleton and not public beta.

## Conflicts Resolved

| Prior UX | PRD authority | Resolution |
|---|---|---|
| UJ-4 beginner AI planning was Post-MVP | UJ-4 and FR-054–060/078–087 are in the first usable build | UJ-4 is now the primary Alpha journey |
| Recognition, automatic RPE, finish reminder, Analysis, Apple Health, portability, proactive review, and final visual/layout were removed from the narrow Alpha | Product Owner confirmed they are core to personally useful testing | Restored to first-build IA with bounded experimental/manual fallback contracts |
| Apple Health scope was ambiguous | Product Owner confirmed necessary read plus completed-workout write | Added capability-specific permissions, local authority, idempotent write, failure, and `healthKitDetached` states |
| Plan portability was V1.1 and sharing was later | Product Owner confirmed FitnessAI-owned files plus native iOS Share Sheet | FR-071–073/NFR-PORT-001 and the complete preview/new-draft flow moved into Alpha; third-party and server link/QR remain later |
| Existing Watch/iPhone mocks could imply implementation layout | Alpha now requires test-ready final visual/layout | Watch v11 is the accepted starting reference where spines agree; iPhone key-screen layout must still be promoted into both spines |
| AI data scope was a future generic boundary | FR-086 and NFR-PRIV-007 require affirmative category/window authorization | Added default-off authorization, inspection, withdrawal, and truthful disclosure states |
| Generic plan approval lacked complete immutable binding | FR-057/060/078–080/085 require complete review, identity binding, invalidation, and atomic failure safety | Added full-plan/diff review, `proposalId` + base revision + digest binding, stale-base and commit-failure recovery |
| Watch synchronization was a generic sync concern | FR-081/084 and NFR-AI-003 require eventually consistent idempotent delivery | Added explicit pending/delivered/failed states and last-delivered-revision fallback |

## Preserved Invariants

- Native paired iPhone + Apple Watch topology.
- Watch authority for active Workout Session and durable local Actual Sets.
- Planned and Actual facts remain distinct; user-entered reps/load are authoritative.
- Manual Start and Finish, visible incomplete data, atomic local writes, and idempotent replay.
- Non-diagnostic safety language and no silent AI mutation.

## Explicitly Deferred

Full cloud account/cross-device recovery, rich teaching media, voice, arbitrary third-party plan formats, server-backed link/QR sharing, weekly/cycle-end proactive cadence, open-ended coaching, public-launch brand polish, and broad device optimization.

## Architecture Handoff

No blocker prevents lean Architecture from starting. Before implementation acceptance, Product/Architecture must freeze the recognition whitelist, RPE/reminder operating points, plan-file parser limits, Apple Health capability mapping, and Alpha Plan Safety Rule Pack v1. Before real remote-AI traffic, provider/subprocessor, retention, model-training policy, and request-field-to-authorization-category mapping must be resolved. Professional review remains required before release beyond Product Owner testing.

## Checkpoint

`prd.md`, `EXPERIENCE.md`, and `DESIGN.md` are updated as bilingual drafts for the core-product Alpha. Reviewer Gate has not run. iPhone key-screen visual/layout completion remains a required UX follow-up before implementation readiness.

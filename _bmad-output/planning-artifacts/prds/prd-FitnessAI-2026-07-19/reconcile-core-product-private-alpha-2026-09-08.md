---
title: Core-Product Private-Alpha Scope Reconciliation
status: checkpoint
updated: 2026-09-08
---

# Core-Product Private-Alpha Scope Reconciliation

## Change Signal

The Product Owner clarified that the personally tested first version must contain the product's core capabilities rather than only a technical end-to-end skeleton.

## Confirmed Scope Changes

| Capability | Private-Alpha decision | Boundary |
|---|---|---|
| Automatic recognition | Required for a frozen Exercise/device/signal whitelist | Abstention, correction, manual fallback, and honest initial-accuracy reporting remain mandatory |
| Automatic RPE | Required as opt-in experimental assistance | Five-estimate verification, provenance, abstention, drift, correction, and explicit auto-use consent apply |
| Intelligent Finish | Required as a conservative reminder | Two-signal eligibility; Finish/Continue only; never auto-end |
| Complete Analysis | Required | Weekly/monthly sessions, Exercises, volume, intensity, Actual Load, duration, and selected Primary Exercise trends from effective Actual Sets |
| Apple Health | Required | Necessary least-privilege read plus completed-workout write; local FitnessAI record remains authoritative; remote AI use is not authorized |
| Plan exchange | Required | FitnessAI-owned versioned file import/export plus native iOS Share Sheet; third-party formats and server link/QR remain later |
| Proactive AI review | Required | One non-blocking post-session invitation; no request/proposal before acceptance; full diff and approval still required |
| Visual/layout | Required | Coherent test-ready final contract for every Alpha surface; public-launch polish remains later |

## Stable Requirement Impact

FR-071–073 and NFR-PORT-001 move into private Alpha without renumbering. FR-088–090 define Apple Health interoperability. FR-091 defines the proactive post-session invitation. NFR-HK-001–002 and NFR-UX-001 define degradation, integrity, and visual completeness.

## Remaining Deferred Scope

Full application-cloud accounts/cross-device restoration, voice, rich teaching media, arbitrary third-party plan formats, server-backed link/QR sharing, weekly/cycle-end proactive cadence, open-ended coaching, and public-launch polish.

## Checkpoint

The bilingual PRD is structurally aligned and remains `status: draft`. Reviewer Gate and editorial polish have not run.

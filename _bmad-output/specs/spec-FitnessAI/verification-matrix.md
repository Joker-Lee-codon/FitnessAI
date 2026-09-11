# FitnessAI Verification Matrix

## Capability Coverage

| Capability | Primary automated and human checks | Binding references |
|---|---|---|
| CAP-1 | Schema/mapping rejection; Safety outcomes; complete diff accessibility; digest/base/policy invalidation; duplicate approval replay; commit and delivery fault injection | FR-054–060, FR-078–087; NFR-AI-001–006; AD-2, AD-7, AD-8 |
| CAP-2 | Offline Start/Finish; local commit failure; app termination, Watch restart, sensor loss, disconnect, partial write, repeated/reordered transfer; immutable Start snapshot | FR-001–007, FR-028–035, FR-061–066; NFR-RECOV-001; AD-3–5 |
| CAP-3 | Planned/ad-hoc iPhone session parity; correction/recovery; optional-service outage; no Watch-only state or second reducer | FR-001–007, FR-016–019, FR-029, FR-036–041, FR-061–066; AD-2, AD-3 |
| CAP-4 | Frozen holdout: ≥75% classification including abstentions/misses; boundary precision and recall ≥80% with ±3 s match; ≥80% reps within ±2 plus MAE; macro/micro/slices/CIs | SM-ACC-001, SM-PRES-001; FR-008–015; NFR-REC-001/002; AD-6 |
| CAP-5 | Opt-in isolation; five chronological eligible predictions; ±1 correctness plus exact match; ≥4 offer; ≥2 recalibration; rolling two-of-five drift; no prediction as label | FR-020–027; NFR-RPE-001–014; AD-6 |
| CAP-6 | 15-minute AND gate; missing-signal suppression; Finish/Continue only; 15-minute cooldown; long-rest/equipment-wait/low-motion physical sessions; false/missed rates | FR-004/005; NFR-SESSION-001–005; AD-6 |
| CAP-7 | Golden revision DAG/reducer vectors; concurrent same/different-field edits; topology conflicts; missing parent; replay; epoch quarantine; deletion/cleanup retention | SM-COMP-001, SM-PRES-001; FR-003, FR-043, FR-046, FR-061–070; AD-2–5 |
| CAP-8 | PRD formula fixtures; correction invalidation; stale/pending labels; incomplete/conflicted exclusion; bodyweight/assisted/timed separation; chart text/table parity | FR-036–041; AD-11; AN-L01 |
| CAP-9 | Capability-specific permissions; observable read states; idempotent export generations; detach/relink table; no silent recreate; one-shot remote preview; disabled real send | FR-088–090; NFR-HK-001/002, NFR-PRIV-007; AD-8, AD-9 |
| CAP-10 | Boundary corpus at every size/depth/count limit; malformed/executable/external input; unknown required/optional fields; aliases; duplicate; omission; new-draft-only commit | FR-071–073; NFR-PORT-001; AD-10 |
| CAP-11 | Once-per-session trigger; Review/Later/Disable persistence; no network/auth/proposal on display/dismiss; route into normal authorization and approval | FR-091; AD-7; RV-L01 |
| CAP-12 | All named screen states; light/dark; largest Chinese Dynamic Type; VoiceOver order; Full Keyboard Access; Reduce Motion/contrast; 44 pt controls; error/back focus restoration | NFR-UX-001; AD-13/14; DESIGN and EXPERIENCE |
| CAP-13 | Canonical mapping and substitution fixtures; explicit support boundary; licensed/owned asset provenance; no forbidden full-body or medical claims | FR-030–032, FR-049–053; AD-6; UX support components |
| CAP-14 | Planned/Actual separation; planned/history/previous-set load provenance; explicit accept/edit/reject; canonical substitute attribute comparison; exact future-plan diff; rejection preservation | FR-016–019, FR-027–035; AD-2, AD-7; UJ-1 and Flow 2 |

## Cross-Cutting Release Checks

| Check | Pass condition |
|---|---|
| Truth and completeness | Every recorded, entered, corrected, or confirmed item is durable and present; missing data stays visibly incomplete |
| Interruption burden | At most five Exercise/rep/load/RPE proactive prompts in the representative approximately 20-set session; counts accompany completeness and accuracy |
| Performance and resources | On every supported physical Watch/OS pair, the 90-minute/20-set session has zero resource termination and zero committed-data loss; Start/correction/Finish p95 ≤1 s; battery, thermal, memory, and >2 s interactions reported |
| Size | App-thinning evidence satisfies iPhone ≤500 MB installed, Watch <75 MB uncompressed and ≤25 MB installed target, Watch ML ≤6 MB, and RPE ≤2 MB |
| Secrets and diagnostics | No product/BYOK key, body, free text, Health value, raw signal, or Exercise/load/RPE content enters disallowed storage, logs, backup, synchronization, or diagnostics |
| Degradation | Independent fail-closed controls disable AI, recognition, RPE, Finish assistance, Health, or exchange without deleting facts or blocking manual local capture |
| Alpha outcome | The Product Owner completes repeated end-to-end workouts and `SM-E2E-001` plus `SM-ALPHA-CORE-001` without returning to another primary recorder |

## Evidence Package

For each candidate build, archive exact versions, support matrix, environment, golden-fixture results, automated reports, physical-device protocol/results, counter-metrics, size reports, known exclusions, open Gate states, and the Product Owner verdict. A simulator result can validate logic or layout but cannot qualify sensors, HealthKit, background execution, file delivery, battery, recovery, recognition, RPE, Finish assistance, or a supported device row.

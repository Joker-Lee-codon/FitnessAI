---
title: 'Validate the vivo WATCH GT2 Raw-IMU-to-Phone Path'
type: 'feature'
created: '2026-07-18'
status: 'in-progress'
baseline_commit: 'NO_VCS'
review_loop_iteration: 0
context:
  - '{project-root}/_bmad-output/planning-artifacts/research/technical-vivo-huawei-xiaomi-smartwatch-sensor-imu-research-2026-07-17.md'
---

<frozen-after-approval reason="human-owned intent — do not modify unless human renegotiates">

## Intent

**Problem:** FitnessAI cannot commit to vivo until a retail WATCH GT2 proves that a third-party BlueOS app can capture raw accelerometer and gyroscope events, survive screen-off, and deliver an intact session to a paired phone.

**Approach:** Time-box a feasibility spike for WATCH GT2 (`WA2536A`, BlueOS 3.0, `DPD2508AB_A_1.44.5`) and the user-reported vivo phone (`Vivo12`, OriginOS 4, Android 14): onboard the toolchain, then build a minimal watch recorder, Android receiver, and offline verifier.

## Boundaries & Constraints

**Always:** Use documented APIs in the installed official SDK; use raw Sensor events, not Health Kit records; persist before transfer; hash immutable source files; record device/tool versions; keep English documents and matching `.zh-CN` copies; test firmware `1.44.5` first.

**Ask First:** Firmware updates; paid account/certificate/hardware/store actions; security-sensitive debug or reset actions; undocumented APIs; replacing the official template; lowering the 20 Hz per-stream gate.

**Never:** Generalize beyond the tested combination; treat Studio preview as device proof; substitute derived records; build recognition, rep counting, production UI, cloud, store release, or training; invent BlueOS APIs.

## I/O & Edge-Case Matrix

| Scenario | Input / State | Expected Output / Behavior | Error Handling |
|----------|---------------|----------------------------|----------------|
| Full path | Paired devices; raw streams exposed | Session persists, reaches phone, and verifies | `PASS` with evidence |
| Watch only | Capture/storage work; phone path fails | Session remains exportable | `PARTIAL`; no full-path claim |
| Capability failure | Deploy, Sensor, timestamp, >=20 Hz, or screen-off gate fails | No fabricated fallback | `NO-GO` with evidence |
| Interrupted transfer | Bluetooth off for 30 seconds | Retry completes without duplicates; hashes match | Retain source and expose failure |

</frozen-after-approval>

## Code Map

- `poc/vivo-watch-gt2/docs/` — bilingual onboarding, device baseline, and feasibility evidence.
- `poc/vivo-watch-gt2/contracts/session.schema.json` — vendor-neutral session manifest and sample contract.
- `poc/vivo-watch-gt2/watch/` — official BlueOS Studio watch template plus recorder, append-only store, and transfer adapter.
- `poc/vivo-watch-gt2/phone/` — minimal Android 14 receiver under namespace `com.fitnessai.vivopoc`.
- `poc/vivo-watch-gt2/tools/verify_session.py` and `tests/` — offline quality verifier and fixtures.

## Tasks & Acceptance

**Execution:**
- [x] `poc/vivo-watch-gt2/docs/onboarding.md`, `device-baseline.md`, and `.zh-CN` peers — cover official Studio 2.0.5 installation, account/debug checks, exact versions, and `blueos@vivo.com` escalation.
- [x] `poc/vivo-watch-gt2/contracts/session.schema.json` — define session/device, stream, monotonic timestamp, sequence, axes/unit, chunk, byte-count, and SHA-256 fields.
- [ ] `poc/vivo-watch-gt2/watch/` — generate the official template, map its files, use documented Sensor/storage/communication APIs, store immutable ACC+gyro chunks, and transfer with safe retries.
- [ ] `poc/vivo-watch-gt2/phone/` — receive/deduplicate chunks, show counts/hashes, retain sessions, and export them.
- [x] `poc/vivo-watch-gt2/tools/verify_session.py` and `tests/` — test schema, hash, sequence, timestamps, median rate, and gaps with pass/fail fixtures.
- [ ] `poc/vivo-watch-gt2/docs/feasibility-report.md` and `.zh-CN.md` — record three runs and decide `PASS/PARTIAL/NO-GO`; stop after 2–5 workdays without a credible SDK/device/support path.

**Acceptance Criteria:**
- Given BlueOS Studio/SDK is installed and the account is accepted for debugging, when the signed debug build is deployed, then `WA2536A` launches it with a visible unique build ID and retained install evidence.
- Given Sensor permission, when the watch is still for 60 seconds then rotated for 60 seconds, then raw ACC and gyro each provide three axes, increasing sequences, monotonic timestamps, known units, >=20 Hz median delivery, no reversals, no unexplained gap over one second, and >=95% of `duration × 20` samples.
- Given a 10-minute recording, when the screen sleeps after minute two and the user returns to the watch face, then capture continues, closed files survive app restart, and hashes verify.
- Given a saved session and paired Android 14 phone, when Bluetooth is disabled for 30 seconds mid-transfer and restored, then the complete session arrives once, sender and receiver hashes match, and no duplicate session/chunk remains.
- Given the full procedure has passed once, when three consecutive 10-minute sessions are run, then all three complete without silent stop, corruption, or hash conflict.

## Spec Change Log

## Design Notes

`PASS` requires all criteria. `PARTIAL` means watch capture/persistence works but phone transfer does not. Failure of deployment, raw streams, timestamps, 20 Hz, screen-off, persistence, or verified delivery is `NO-GO`. Publication, fleet support, battery life, and model accuracy remain separate.

## Verification

**Commands:**
- `python -m unittest discover -s poc/vivo-watch-gt2/tests -v` — expected: all verifier tests pass.
- `python poc/vivo-watch-gt2/tools/verify_session.py <exported-session-directory>` — expected: exit 0 with schema, sequence, timing, rate, gap, and hash checks passing.
- `poc\vivo-watch-gt2\phone\gradlew.bat testDebugUnitTest` — expected: Android receiver unit tests pass after the official project is generated.

**Manual checks:** Studio creates/builds/previews the official template; the retail watch installs and launches the build; evidence covers still/motion, screen-off, watch-face return, Bluetooth interruption, restart, and three repeated runs.

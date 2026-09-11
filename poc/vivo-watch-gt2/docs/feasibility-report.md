# vivo WATCH GT2 Raw-IMU-to-Phone Feasibility Report

## Current Decision

**State:** `BLOCKED_AT_PHYSICAL_DEVICE_GATE`

No physical-device claim has been made. BlueOS Studio 2.0.5 is installed, account real-name verification is complete, the generated template previews successfully in the simulator, and the phone reaches authorized ADB state `device`. Retail-watch deployment, debug entitlement, and a raw Sensor session remain unproven. The vendor-neutral contract and offline verifier can be tested independently, but they cannot substitute for BlueOS device evidence.

## Tested Baseline

See `device-baseline.md`. The intended first baseline is `WA2536A`, BlueOS 3.0, firmware `DPD2508AB_A_1.44.5`, paired with the user-reported `Vivo12`, OriginOS 4, Android 14.

## Gate Results

| Gate | Required evidence | Current result |
|---|---|---|
| Official template build/preview | Build log and preview screenshot | Partial: preview screenshot passed; build log and exact SDK version not captured |
| Retail-watch deployment | Install log, screenshot, unique build ID | Phone discovery passed (`V2162A`/`PD2162`); watch load/install not run |
| Raw ACC and gyro | SDK source/API evidence plus exported samples | Not run |
| Timestamp/unit/rate | Verifier report for still/motion session | Not run |
| Screen-off persistence | 10-minute session, restart, matching hashes | Not run |
| Phone transfer/recovery | Bluetooth interruption and matching hashes | Not run |
| Three-run repeatability | Three complete 10-minute reports | Not run |

## Required Physical Procedure

1. Run the signed build on the retail watch and record its unique build ID.
2. Record 60 seconds still and 60 seconds of multi-axis wrist rotation.
3. Run a 10-minute session; after minute two let the screen sleep and return to the watch face at least once.
4. Restart the application and confirm the closed session remains listed.
5. Transfer the session; disable Bluetooth for 30 seconds mid-transfer, restore it, and retry.
6. Export the received directory and run `python poc/vivo-watch-gt2/tools/verify_session.py <directory>`.
7. Repeat the complete 10-minute procedure three times.

## Decision Rules

- `PASS`: deployment, both raw streams, timestamps/units, >=20 Hz median per stream, no reversals, no unexplained gap over one second, screen-off persistence, verified retry-safe phone delivery, and all three runs pass.
- `PARTIAL`: watch capture and persistence pass, but the approved phone path does not.
- `NO-GO`: deployment, either raw stream, usable timestamps, 20 Hz, screen-off, persistence, or integrity-checked export fails.
- Time-box exit: no credible SDK, device, or vivo-support path after 2–5 working days.

Passing applies only to the recorded device/firmware/tool versions. Store publication, other vivo devices, long-duration battery behavior, and model accuracy are separate gates.

"""Deterministic exported-session fixtures for verifier tests."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
from typing import Callable


SampleMutator = Callable[[list[dict]], None]


def build_session(
    root: Path,
    *,
    rate_hz: int = 20,
    count_per_stream: int = 40,
    mutate: SampleMutator | None = None,
) -> Path:
    root.mkdir(parents=True, exist_ok=True)
    interval = 1_000_000_000 // rate_hz
    samples: list[dict] = []
    for seq in range(count_per_stream):
        timestamp = 10_000_000_000 + seq * interval
        samples.extend(
            [
                {
                    "stream": "acc",
                    "seq": seq,
                    "sensor_ts_ns": timestamp,
                    "x": 0.0,
                    "y": 0.0,
                    "z": 9.80665,
                    "unit": "m/s^2",
                },
                {
                    "stream": "gyro",
                    "seq": seq,
                    "sensor_ts_ns": timestamp,
                    "x": 0.01,
                    "y": -0.01,
                    "z": 0.0,
                    "unit": "rad/s",
                },
            ]
        )
    if mutate:
        mutate(samples)
    payload = "".join(json.dumps(sample, separators=(",", ":"), sort_keys=True) + "\n" for sample in samples)
    data = payload.encode("utf-8")
    chunk_name = "chunks/chunk-0000.ndjson"
    chunk_path = root / chunk_name
    chunk_path.parent.mkdir(parents=True, exist_ok=True)
    chunk_path.write_bytes(data)
    timestamps = [sample["sensor_ts_ns"] for sample in samples]
    manifest = {
        "schema_version": "1.0.0",
        "session_id": "fixture-session-0001",
        "created_at_utc": "2026-07-18T00:00:00Z",
        "device": {
            "vendor": "vivo",
            "watch_model": "WA2536A",
            "watch_hardware": "MP_0.1",
            "watch_os": "BlueOS",
            "watch_os_version": "3.0",
            "watch_firmware": "DPD2508AB_A_1.44.5",
            "watch_app_version": "fixture",
            "phone_model": "Vivo12-user-reported",
            "phone_os": "OriginOS",
            "phone_os_version": "4 / Android 14",
            "phone_app_version": "fixture",
            "blueos_studio_version": "fixture",
            "blueos_sdk_version": "fixture",
        },
        "timebase": {
            "sensor_clock": "fixture_monotonic",
            "timestamp_unit": "ns",
            "wall_clock_anchor_utc": "2026-07-18T00:00:00Z",
        },
        "streams": [
            {"name": "acc", "unit": "m/s^2", "requested_rate_hz": rate_hz},
            {"name": "gyro", "unit": "rad/s", "requested_rate_hz": rate_hz},
        ],
        "quality_gates": {
            "required_streams": ["acc", "gyro"],
            "min_median_rate_hz": 20,
            "max_unexplained_gap_ns": 1_000_000_000,
            "min_retained_ratio": 0.95,
        },
        "known_gaps": [],
        "chunks": [
            {
                "chunk_index": 0,
                "file": chunk_name,
                "byte_count": len(data),
                "sha256": hashlib.sha256(data).hexdigest(),
                "sample_count": len(samples),
                "first_sensor_ts_ns": min(timestamps),
                "last_sensor_ts_ns": max(timestamps),
            }
        ],
    }
    (root / "manifest.json").write_text(
        json.dumps(manifest, indent=2, ensure_ascii=False, sort_keys=True) + "\n",
        encoding="utf-8",
    )
    return root

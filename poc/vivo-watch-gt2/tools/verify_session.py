#!/usr/bin/env python3
"""Verify an exported FitnessAI raw-IMU session using only the Python stdlib."""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import statistics
import sys
from collections import defaultdict
from pathlib import Path
from typing import Any


MANIFEST_NAME = "manifest.json"
SCHEMA_VERSION = "1.0.0"
REQUIRED_SAMPLE_FIELDS = {"stream", "seq", "sensor_ts_ns", "x", "y", "z", "unit"}
REQUIRED_CHUNK_FIELDS = {
    "chunk_index",
    "file",
    "byte_count",
    "sha256",
    "sample_count",
    "first_sensor_ts_ns",
    "last_sensor_ts_ns",
}


def _error(report: dict[str, Any], code: str, message: str) -> None:
    report["errors"].append({"code": code, "message": message})


def _safe_chunk_path(session_dir: Path, relative: str) -> Path:
    if not relative or Path(relative).is_absolute():
        raise ValueError("chunk path must be a non-empty relative path")
    root = session_dir.resolve()
    candidate = (root / relative).resolve()
    try:
        candidate.relative_to(root)
    except ValueError as exc:
        raise ValueError("chunk path escapes the session directory") from exc
    return candidate


def _sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def _is_finite_number(value: Any) -> bool:
    return isinstance(value, (int, float)) and not isinstance(value, bool) and math.isfinite(value)


def _gap_is_explained(stream: str, start: int, end: int, known_gaps: list[dict[str, Any]]) -> bool:
    return any(
        gap.get("stream") == stream
        and isinstance(gap.get("start_ts_ns"), int)
        and isinstance(gap.get("end_ts_ns"), int)
        and gap["start_ts_ns"] <= start
        and gap["end_ts_ns"] >= end
        and bool(gap.get("reason"))
        for gap in known_gaps
    )


def _validate_manifest(manifest: Any, report: dict[str, Any]) -> bool:
    if not isinstance(manifest, dict):
        _error(report, "manifest_type", "manifest.json must contain a JSON object")
        return False
    required = {
        "schema_version",
        "session_id",
        "created_at_utc",
        "device",
        "timebase",
        "streams",
        "quality_gates",
        "known_gaps",
        "chunks",
    }
    missing = sorted(required - manifest.keys())
    if missing:
        _error(report, "manifest_fields", f"missing manifest fields: {', '.join(missing)}")
    if manifest.get("schema_version") != SCHEMA_VERSION:
        _error(report, "schema_version", f"expected schema_version {SCHEMA_VERSION}")
    if not isinstance(manifest.get("session_id"), str) or len(manifest["session_id"]) < 8:
        _error(report, "session_id", "session_id must be a string of at least 8 characters")
    if not isinstance(manifest.get("streams"), list):
        _error(report, "streams", "streams must be an array")
    if not isinstance(manifest.get("chunks"), list) or not manifest.get("chunks"):
        _error(report, "chunks", "chunks must be a non-empty array")
    if not isinstance(manifest.get("known_gaps"), list):
        _error(report, "known_gaps", "known_gaps must be an array")
    return not report["errors"]


def verify_session(session_dir: Path) -> tuple[dict[str, Any], bool]:
    session_dir = Path(session_dir)
    report: dict[str, Any] = {
        "session_dir": str(session_dir),
        "session_id": None,
        "status": "FAIL",
        "chunks": [],
        "streams": {},
        "errors": [],
    }
    manifest_path = session_dir / MANIFEST_NAME
    try:
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        _error(report, "manifest_read", f"cannot read manifest.json: {exc}")
        return report, False

    if not _validate_manifest(manifest, report):
        return report, False
    report["session_id"] = manifest["session_id"]

    stream_units: dict[str, str] = {}
    for stream in manifest["streams"]:
        if not isinstance(stream, dict) or stream.get("name") not in {"acc", "gyro"}:
            _error(report, "stream_definition", "each stream must define name acc/gyro and a unit")
            continue
        unit = stream.get("unit")
        if not isinstance(unit, str) or not unit:
            _error(report, "stream_unit", f"stream {stream.get('name')} has no unit")
            continue
        if stream["name"] in stream_units:
            _error(report, "stream_duplicate", f"stream {stream['name']} is defined more than once")
        stream_units[stream["name"]] = unit

    gates = manifest.get("quality_gates", {})
    required_streams = gates.get("required_streams", ["acc", "gyro"])
    min_rate = gates.get("min_median_rate_hz", 20)
    max_gap = gates.get("max_unexplained_gap_ns", 1_000_000_000)
    min_ratio = gates.get("min_retained_ratio", 0.95)
    if required_streams != ["acc", "gyro"]:
        _error(report, "required_streams", "required_streams must be ['acc', 'gyro']")
    if not _is_finite_number(min_rate) or min_rate < 20:
        _error(report, "min_rate_gate", "min_median_rate_hz must be at least 20")
        min_rate = 20
    if not isinstance(max_gap, int) or max_gap < 1:
        _error(report, "max_gap_gate", "max_unexplained_gap_ns must be a positive integer")
        max_gap = 1_000_000_000
    if not _is_finite_number(min_ratio) or not 0.95 <= min_ratio <= 1:
        _error(report, "retained_ratio_gate", "min_retained_ratio must be between 0.95 and 1")
        min_ratio = 0.95

    samples_by_stream: dict[str, list[dict[str, Any]]] = defaultdict(list)
    seen_chunk_indexes: set[int] = set()
    total_samples = 0

    for chunk in manifest["chunks"]:
        if not isinstance(chunk, dict):
            _error(report, "chunk_type", "each chunk entry must be an object")
            continue
        missing = sorted(REQUIRED_CHUNK_FIELDS - chunk.keys())
        if missing:
            _error(report, "chunk_fields", f"chunk is missing fields: {', '.join(missing)}")
            continue
        index = chunk["chunk_index"]
        if not isinstance(index, int) or index < 0 or index in seen_chunk_indexes:
            _error(report, "chunk_index", f"invalid or duplicate chunk_index: {index!r}")
            continue
        seen_chunk_indexes.add(index)
        try:
            chunk_path = _safe_chunk_path(session_dir, chunk["file"])
            data = chunk_path.read_bytes()
        except (OSError, TypeError, ValueError) as exc:
            _error(report, "chunk_read", f"cannot read chunk {index}: {exc}")
            continue

        actual_hash = _sha256(data)
        chunk_result = {
            "chunk_index": index,
            "file": chunk["file"],
            "byte_count": len(data),
            "sha256": actual_hash,
            "sample_count": 0,
        }
        report["chunks"].append(chunk_result)
        if len(data) != chunk["byte_count"]:
            _error(report, "byte_count", f"chunk {index} byte_count mismatch")
        if actual_hash != chunk["sha256"]:
            _error(report, "hash", f"chunk {index} SHA-256 mismatch")

        chunk_samples: list[dict[str, Any]] = []
        try:
            text = data.decode("utf-8")
            for line_number, line in enumerate(text.splitlines(), start=1):
                if not line.strip():
                    continue
                sample = json.loads(line)
                if not isinstance(sample, dict) or set(sample) != REQUIRED_SAMPLE_FIELDS:
                    raise ValueError(f"line {line_number} does not match the sample contract")
                stream = sample["stream"]
                if stream not in stream_units:
                    raise ValueError(f"line {line_number} uses undeclared stream {stream!r}")
                if sample["unit"] != stream_units[stream]:
                    raise ValueError(f"line {line_number} unit differs from stream definition")
                if not isinstance(sample["seq"], int) or sample["seq"] < 0:
                    raise ValueError(f"line {line_number} has invalid seq")
                if not isinstance(sample["sensor_ts_ns"], int) or sample["sensor_ts_ns"] < 0:
                    raise ValueError(f"line {line_number} has invalid sensor_ts_ns")
                if not all(_is_finite_number(sample[axis]) for axis in ("x", "y", "z")):
                    raise ValueError(f"line {line_number} has non-finite axes")
                chunk_samples.append(sample)
        except (UnicodeError, json.JSONDecodeError, ValueError) as exc:
            _error(report, "sample_decode", f"chunk {index}: {exc}")
            continue

        chunk_result["sample_count"] = len(chunk_samples)
        total_samples += len(chunk_samples)
        if len(chunk_samples) != chunk["sample_count"]:
            _error(report, "sample_count", f"chunk {index} sample_count mismatch")
        if chunk_samples:
            timestamps = [sample["sensor_ts_ns"] for sample in chunk_samples]
            if min(timestamps) != chunk["first_sensor_ts_ns"]:
                _error(report, "first_timestamp", f"chunk {index} first timestamp mismatch")
            if max(timestamps) != chunk["last_sensor_ts_ns"]:
                _error(report, "last_timestamp", f"chunk {index} last timestamp mismatch")
        for sample in chunk_samples:
            samples_by_stream[sample["stream"]].append(sample)

    known_gaps = manifest.get("known_gaps", [])
    for stream in required_streams:
        samples = samples_by_stream.get(stream, [])
        stats: dict[str, Any] = {
            "sample_count": len(samples),
            "median_rate_hz": None,
            "retained_ratio": 0.0,
            "sequence_errors": 0,
            "timestamp_reversals": 0,
            "unexplained_gaps": 0,
        }
        report["streams"][stream] = stats
        if len(samples) < 2:
            _error(report, "stream_missing", f"stream {stream} has fewer than two samples")
            continue
        intervals: list[int] = []
        for previous, current in zip(samples, samples[1:]):
            if current["seq"] != previous["seq"] + 1:
                stats["sequence_errors"] += 1
            delta = current["sensor_ts_ns"] - previous["sensor_ts_ns"]
            if delta <= 0:
                stats["timestamp_reversals"] += 1
            else:
                intervals.append(delta)
                if delta > max_gap and not _gap_is_explained(
                    stream, previous["sensor_ts_ns"], current["sensor_ts_ns"], known_gaps
                ):
                    stats["unexplained_gaps"] += 1
        if intervals:
            median_interval = statistics.median(intervals)
            stats["median_rate_hz"] = 1_000_000_000 / median_interval
            duration_s = (samples[-1]["sensor_ts_ns"] - samples[0]["sensor_ts_ns"]) / 1_000_000_000
            expected = duration_s * float(min_rate)
            stats["retained_ratio"] = len(samples) / expected if expected > 0 else 0.0
        if stats["sequence_errors"]:
            _error(report, "sequence", f"stream {stream} has {stats['sequence_errors']} sequence errors")
        if stats["timestamp_reversals"]:
            _error(report, "timestamp", f"stream {stream} has timestamp reversals/duplicates")
        if stats["unexplained_gaps"]:
            _error(report, "gap", f"stream {stream} has unexplained gaps over the configured limit")
        if stats["median_rate_hz"] is None or stats["median_rate_hz"] < float(min_rate):
            _error(report, "rate", f"stream {stream} median rate is below {min_rate} Hz")
        if stats["retained_ratio"] < float(min_ratio):
            _error(report, "retained_ratio", f"stream {stream} retained ratio is below {min_ratio}")

    report["total_samples"] = total_samples
    report["status"] = "PASS" if not report["errors"] else "FAIL"
    return report, not report["errors"]


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("session_directory", type=Path, help="directory containing manifest.json and chunks")
    args = parser.parse_args(argv)
    report, ok = verify_session(args.session_directory)
    print(json.dumps(report, indent=2, ensure_ascii=False, sort_keys=True))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())

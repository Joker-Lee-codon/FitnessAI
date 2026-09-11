from __future__ import annotations

import json
import sys
import tempfile
import unittest
from pathlib import Path


TEST_DIR = Path(__file__).resolve().parent
POC_DIR = TEST_DIR.parent
sys.path.insert(0, str(POC_DIR / "tools"))
sys.path.insert(0, str(TEST_DIR))

from fixture_factory import build_session  # noqa: E402
from verify_session import verify_session  # noqa: E402


class VerifySessionTests(unittest.TestCase):
    def run_fixture(self, **kwargs):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        session_dir = build_session(Path(temporary.name) / "session", **kwargs)
        return session_dir, verify_session(session_dir)

    def test_valid_session_passes(self):
        _, (report, ok) = self.run_fixture()
        self.assertTrue(ok, report)
        self.assertEqual("PASS", report["status"])
        self.assertGreaterEqual(report["streams"]["acc"]["median_rate_hz"], 20)
        self.assertGreaterEqual(report["streams"]["gyro"]["median_rate_hz"], 20)

    def test_hash_mismatch_fails(self):
        session_dir, _ = self.run_fixture()
        manifest_path = session_dir / "manifest.json"
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
        manifest["chunks"][0]["sha256"] = "0" * 64
        manifest_path.write_text(json.dumps(manifest), encoding="utf-8")
        report, ok = verify_session(session_dir)
        self.assertFalse(ok)
        self.assertIn("hash", {error["code"] for error in report["errors"]})

    def test_low_rate_fails(self):
        _, (report, ok) = self.run_fixture(rate_hz=10)
        self.assertFalse(ok)
        self.assertIn("rate", {error["code"] for error in report["errors"]})

    def test_sequence_gap_fails(self):
        def mutate(samples):
            next(sample for sample in samples if sample["stream"] == "acc" and sample["seq"] == 10)["seq"] = 11

        _, (report, ok) = self.run_fixture(mutate=mutate)
        self.assertFalse(ok)
        self.assertIn("sequence", {error["code"] for error in report["errors"]})

    def test_timestamp_duplicate_fails(self):
        def mutate(samples):
            acc = [sample for sample in samples if sample["stream"] == "acc"]
            acc[10]["sensor_ts_ns"] = acc[9]["sensor_ts_ns"]

        _, (report, ok) = self.run_fixture(mutate=mutate)
        self.assertFalse(ok)
        self.assertIn("timestamp", {error["code"] for error in report["errors"]})

    def test_path_escape_fails(self):
        session_dir, _ = self.run_fixture()
        manifest_path = session_dir / "manifest.json"
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
        manifest["chunks"][0]["file"] = "../outside.ndjson"
        manifest_path.write_text(json.dumps(manifest), encoding="utf-8")
        report, ok = verify_session(session_dir)
        self.assertFalse(ok)
        self.assertIn("chunk_read", {error["code"] for error in report["errors"]})


if __name__ == "__main__":
    unittest.main()

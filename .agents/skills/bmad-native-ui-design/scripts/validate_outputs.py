#!/usr/bin/env python3
"""Validate stage-appropriate native UI artifacts and bilingual parity."""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path


STAGE_FILES = {
    "ND-01": ("design-direction.md", "design-direction.zh-CN.md"),
    "ND-02": ("native-ui-spec.md", "native-ui-spec.zh-CN.md", "tokens.json"),
    "ND-03": ("native-ui-spec.md", "native-ui-spec.zh-CN.md", "tokens.json"),
    "ND-04": ("architecture-handoff.md", "architecture-handoff.zh-CN.md"),
}
PAIR_BASES = ("design-direction", "native-ui-spec", "architecture-handoff")
ID_PATTERN = re.compile(r"\b(?:FR|NFR|UJ|DV)-[A-Z0-9-]+\b")


def headings(path: Path) -> list[int]:
    levels: list[int] = []
    in_fence = False
    for line in path.read_text(encoding="utf-8").splitlines():
        if line.startswith("```"):
            in_fence = not in_fence
        elif not in_fence and re.match(r"^#{1,6}\s", line):
            levels.append(len(line) - len(line.lstrip("#")))
    return levels


def stable_ids(path: Path) -> list[str]:
    return ID_PATTERN.findall(path.read_text(encoding="utf-8"))


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--workspace", required=True)
    parser.add_argument("--strict", action="store_true")
    args = parser.parse_args()

    workspace = Path(args.workspace).expanduser().resolve()
    status_path = workspace / ".native-ui-status.json"
    errors: list[str] = []
    warnings: list[str] = []
    if not status_path.is_file():
        errors.append(f"missing status file: {status_path}")
        status = {"stages": {}}
    else:
        try:
            status = json.loads(status_path.read_text(encoding="utf-8"))
        except json.JSONDecodeError as exc:
            errors.append(f"invalid status JSON: {exc}")
            status = {"stages": {}}

    for stage, required in STAGE_FILES.items():
        state = status.get("stages", {}).get(stage, {}).get("state")
        if args.strict or state == "completed":
            for name in required:
                if not (workspace / name).is_file():
                    errors.append(f"{stage} marked complete but missing {name}")

    for base in PAIR_BASES:
        english = workspace / f"{base}.md"
        chinese = workspace / f"{base}.zh-CN.md"
        if english.exists() != chinese.exists():
            errors.append(f"bilingual pair incomplete: {english.name} / {chinese.name}")
            continue
        if not english.exists():
            continue
        if headings(english) != headings(chinese):
            errors.append(f"heading-level structure differs for {base}")
        if stable_ids(english) != stable_ids(chinese):
            errors.append(f"stable requirement ID order differs for {base}")

    tokens = workspace / "tokens.json"
    if tokens.is_file():
        try:
            json.loads(tokens.read_text(encoding="utf-8"))
        except json.JSONDecodeError as exc:
            errors.append(f"invalid tokens.json: {exc}")
    elif status.get("stages", {}).get("ND-02", {}).get("state") == "completed":
        errors.append("ND-02 marked complete but tokens.json is missing")

    if status.get("current_stage") == "complete" and status.get("stages", {}).get(
        "ND-04", {}
    ).get("state") != "completed":
        errors.append("current_stage is complete but ND-04 is not completed")

    if not any((workspace / f"{base}.md").exists() for base in PAIR_BASES):
        warnings.append("no formal native UI documents exist yet")

    for warning in warnings:
        print(f"warning: {warning}")
    for error in errors:
        print(f"error: {error}", file=sys.stderr)
    if errors:
        return 1
    print("native UI artifacts: valid")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())


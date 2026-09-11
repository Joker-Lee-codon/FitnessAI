#!/usr/bin/env python3
"""Read and update progress for the BMAD native UI design workflow."""

from __future__ import annotations

import argparse
import json
import os
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


STAGES = ("ND-01", "ND-02", "ND-03", "ND-04")
STAGE_LABELS = {
    "ND-01": "Visual direction",
    "ND-02": "SwiftUI design system",
    "ND-03": "MVP screen batches",
    "ND-04": "Native gate and Architecture handoff",
}
VALID_STATES = ("pending", "ready", "in_progress", "completed", "blocked")


def utc_now() -> str:
    return datetime.now(timezone.utc).isoformat(timespec="seconds")


def default_state() -> dict[str, Any]:
    return {
        "schema_version": 1,
        "workflow": "bmad-native-ui-design",
        "current_stage": "ND-01",
        "selected_direction": None,
        "updated": utc_now(),
        "stages": {
            "ND-01": {
                "state": "ready",
                "note": "Select one of two native visual directions.",
            },
            "ND-02": {
                "state": "pending",
                "note": "Freeze the SwiftUI design system.",
            },
            "ND-03": {
                "state": "pending",
                "note": "Expand and accept MVP screen batches.",
                "completed_batches": [],
            },
            "ND-04": {
                "state": "pending",
                "note": "Pass native gates and produce Architecture handoff.",
            },
        },
    }


def resolve_project_root(value: str) -> Path:
    root = Path(value).expanduser().resolve()
    if not root.is_dir():
        raise ValueError(f"Project root does not exist: {root}")
    return root


def ensure_workspace(project_root: Path, value: str) -> Path:
    workspace = Path(value).expanduser()
    if not workspace.is_absolute():
        workspace = project_root / workspace
    workspace = workspace.resolve()
    try:
        workspace.relative_to(project_root)
    except ValueError as exc:
        raise ValueError("Workspace must be inside the project root") from exc
    return workspace


def output_root(project_root: Path, explicit: str | None) -> Path:
    if explicit:
        return ensure_workspace(project_root, explicit)
    return project_root / "_bmad-output" / "planning-artifacts" / "native-ui-designs"


def latest_workspace(root: Path) -> Path | None:
    if not root.is_dir():
        return None
    candidates = [
        path
        for path in root.iterdir()
        if path.is_dir() and (path / ".native-ui-status.json").is_file()
    ]
    return max(candidates, key=lambda path: path.stat().st_mtime) if candidates else None


def prerequisites(project_root: Path) -> dict[str, bool]:
    planning = project_root / "_bmad-output" / "planning-artifacts"
    return {
        "prd": any(planning.glob("prds/**/prd.md")),
        "ux_design": any(planning.glob("ux-designs/**/DESIGN.md")),
        "ux_experience": any(planning.glob("ux-designs/**/EXPERIENCE.md")),
    }


def read_state(workspace: Path) -> dict[str, Any]:
    path = workspace / ".native-ui-status.json"
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError as exc:
        raise ValueError(f"Status file not found: {path}") from exc
    except json.JSONDecodeError as exc:
        raise ValueError(f"Invalid status JSON: {path}: {exc}") from exc
    if data.get("workflow") != "bmad-native-ui-design":
        raise ValueError(f"Unexpected workflow in {path}")
    if not isinstance(data.get("stages"), dict):
        raise ValueError(f"Missing stages in {path}")
    return data


def write_state(workspace: Path, data: dict[str, Any]) -> None:
    workspace.mkdir(parents=True, exist_ok=True)
    data["updated"] = utc_now()
    target = workspace / ".native-ui-status.json"
    temporary = workspace / f".{target.name}.{os.getpid()}.tmp"
    temporary.write_text(
        json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    temporary.replace(target)


def next_action(data: dict[str, Any]) -> str:
    stages = data["stages"]
    for stage in STAGES:
        state = stages.get(stage, {}).get("state", "pending")
        if state == "blocked":
            return f"Resolve the blocker recorded for {stage}."
        if state != "completed":
            if stage == "ND-01":
                return "Create and select one of two representative native visual directions."
            if stage == "ND-02":
                return "Freeze the selected SwiftUI design system and semantic tokens."
            if stage == "ND-03":
                batches = stages[stage].get("completed_batches", [])
                return f"Continue the next MVP screen batch ({len(batches)} accepted so far)."
            return "Run the native quality gate and complete the Architecture handoff."
    return "Start bmad-architecture using the completed native UI handoff."


def render_markdown(
    project_root: Path,
    workspace: Path | None,
    data: dict[str, Any] | None,
) -> str:
    prereq = prerequisites(project_root)
    lines = ["# BMAD Native UI Design status", ""]
    lines.append(f"- Project: `{project_root}`")
    lines.append(
        "- Prerequisites: "
        + ", ".join(f"{key}={'ready' if value else 'missing'}" for key, value in prereq.items())
    )
    if workspace is None or data is None:
        lines.extend(
            [
                "- Run: not started",
                "- Current stage: ND-01 Visual direction",
                "- Next: Create and select one of two representative native visual directions."
                if all(prereq.values())
                else "- Next: Complete the missing PRD/UX prerequisite before native UI design.",
            ]
        )
        return "\n".join(lines)

    lines.append(f"- Run: `{workspace}`")
    lines.append(f"- Updated: {data.get('updated', 'unknown')}")
    if data.get("selected_direction"):
        lines.append(f"- Selected direction: {data['selected_direction']}")
    lines.append("")
    lines.append("| Stage | State | Note |")
    lines.append("|---|---|---|")
    for stage in STAGES:
        entry = data["stages"].get(stage, {})
        note = str(entry.get("note", "")).replace("|", "\\|")
        lines.append(
            f"| {stage} {STAGE_LABELS[stage]} | {entry.get('state', 'pending')} | {note} |"
        )
    lines.extend(["", f"- Next: {next_action(data)}"])
    return "\n".join(lines)


def command_show(args: argparse.Namespace) -> int:
    project_root = resolve_project_root(args.project_root)
    workspace = (
        ensure_workspace(project_root, args.workspace)
        if args.workspace
        else latest_workspace(output_root(project_root, args.output_root))
    )
    data = read_state(workspace) if workspace else None
    if args.format == "json":
        payload = {
            "project_root": str(project_root),
            "workspace": str(workspace) if workspace else None,
            "prerequisites": prerequisites(project_root),
            "status": data,
            "next_action": next_action(data) if data else "Start ND-01 after prerequisites pass.",
        }
        print(json.dumps(payload, ensure_ascii=False, indent=2))
    else:
        print(render_markdown(project_root, workspace, data))
    return 0


def command_init(args: argparse.Namespace) -> int:
    project_root = resolve_project_root(args.project_root)
    workspace = ensure_workspace(project_root, args.workspace)
    status_path = workspace / ".native-ui-status.json"
    if status_path.exists():
        raise ValueError(f"Refusing to overwrite existing status: {status_path}")
    write_state(workspace, default_state())
    print(status_path)
    return 0


def command_set(args: argparse.Namespace) -> int:
    project_root = resolve_project_root(args.project_root)
    workspace = ensure_workspace(project_root, args.workspace)
    data = read_state(workspace)
    entry = data["stages"].setdefault(args.stage, {})
    entry["state"] = args.state
    if args.note is not None:
        entry["note"] = args.note
    if args.direction is not None:
        data["selected_direction"] = args.direction
    if args.batch:
        batches = data["stages"].setdefault("ND-03", {}).setdefault(
            "completed_batches", []
        )
        if args.batch not in batches:
            batches.append(args.batch)

    if args.state == "completed":
        index = STAGES.index(args.stage)
        if index + 1 < len(STAGES):
            next_stage = STAGES[index + 1]
            next_entry = data["stages"].setdefault(next_stage, {})
            if next_entry.get("state", "pending") == "pending":
                next_entry["state"] = "ready"
            data["current_stage"] = next_stage
        else:
            data["current_stage"] = "complete"
    else:
        data["current_stage"] = args.stage
    write_state(workspace, data)
    print(workspace / ".native-ui-status.json")
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="command", required=True)

    show = subparsers.add_parser("show", help="Show the newest or selected run")
    show.add_argument("--project-root", required=True)
    show.add_argument("--workspace")
    show.add_argument("--output-root")
    show.add_argument("--format", choices=("markdown", "json"), default="markdown")
    show.set_defaults(func=command_show)

    init = subparsers.add_parser("init", help="Initialize a new run status")
    init.add_argument("--project-root", required=True)
    init.add_argument("--workspace", required=True)
    init.set_defaults(func=command_init)

    update = subparsers.add_parser("set", help="Update one stage or accepted batch")
    update.add_argument("--project-root", required=True)
    update.add_argument("--workspace", required=True)
    update.add_argument("--stage", choices=STAGES, required=True)
    update.add_argument("--state", choices=VALID_STATES, required=True)
    update.add_argument("--note")
    update.add_argument("--direction")
    update.add_argument("--batch")
    update.set_defaults(func=command_set)
    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    try:
        return args.func(args)
    except ValueError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())


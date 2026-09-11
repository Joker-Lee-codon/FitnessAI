#!/usr/bin/env python3
"""Run the project-local UI/UX Pro Max search with a stable Codex path."""

from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--project-root", required=True)
    parser.add_argument(
        "uiux_args",
        nargs=argparse.REMAINDER,
        help="Arguments passed to ui-ux-pro-max search.py (prefix with --)",
    )
    args = parser.parse_args()

    project_root = Path(args.project_root).expanduser().resolve()
    search_script = (
        project_root
        / ".agents"
        / "skills"
        / "ui-ux-pro-max"
        / "scripts"
        / "search.py"
    )
    if not search_script.is_file():
        print(f"error: UI/UX Pro Max search script not found: {search_script}", file=sys.stderr)
        return 2

    forwarded = list(args.uiux_args)
    if forwarded and forwarded[0] == "--":
        forwarded = forwarded[1:]
    if not forwarded:
        print("error: no UI/UX Pro Max arguments supplied", file=sys.stderr)
        return 2

    command = [sys.executable, str(search_script), *forwarded]
    completed = subprocess.run(command, cwd=project_root, check=False)
    return completed.returncode


if __name__ == "__main__":
    raise SystemExit(main())


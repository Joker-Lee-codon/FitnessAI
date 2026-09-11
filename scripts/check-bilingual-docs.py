#!/usr/bin/env python3
"""Check machine-verifiable structure shared by English/Chinese Markdown pairs."""

from __future__ import annotations

import re
import sys
from collections import Counter
from pathlib import Path


FENCE_RE = re.compile(r"^```[^\n]*\n(.*?)^```\s*$", re.MULTILINE | re.DOTALL)
HEADING_RE = re.compile(r"^(#{1,6})\s+", re.MULTILINE)
LINK_RE = re.compile(r"!?\[[^\]]*\]\(([^)]+)\)")
INLINE_CODE_RE = re.compile(r"(?<!`)`([^`\n]+)`(?!`)")
ID_RE = re.compile(r"\b(?:FR|NFR|AC|REQ|ADR|UJ)-[A-Za-z0-9.-]+\b")


def table_shapes(text: str) -> list[int]:
    return [line.count("|") for line in text.splitlines() if line.strip().startswith("|")]


def signature(text: str) -> dict[str, object]:
    inline_code = [token.replace(".zh-CN.md", ".md") for token in INLINE_CODE_RE.findall(text)]
    link_targets = [target.replace(".zh-CN.md", ".md") for target in LINK_RE.findall(text)]
    return {
        "heading_levels": HEADING_RE.findall(text),
        "fenced_code": FENCE_RE.findall(text),
        "link_targets": link_targets,
        "inline_code": Counter(inline_code),
        "requirement_ids": ID_RE.findall(text),
        "table_shapes": table_shapes(text),
    }


def main(argv: list[str]) -> int:
    if len(argv) < 3 or len(argv) % 2 == 0:
        print(f"usage: {argv[0]} EN.md ZH.md [EN.md ZH.md ...]", file=sys.stderr)
        return 2

    failed = False
    for en_name, zh_name in zip(argv[1::2], argv[2::2]):
        en_path, zh_path = Path(en_name), Path(zh_name)
        en_sig = signature(en_path.read_text(encoding="utf-8"))
        zh_sig = signature(zh_path.read_text(encoding="utf-8"))
        differences = [key for key in en_sig if en_sig[key] != zh_sig[key]]
        if differences:
            failed = True
            print(f"FAIL {en_path} <-> {zh_path}: {', '.join(differences)}")
        else:
            print(f"PASS {en_path} <-> {zh_path}")

    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))

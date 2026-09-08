#!/usr/bin/env python3
"""Regenerate extracted_hours.csv and extracted_journal.md from entries/*.md.

Every work session is logged as one markdown file in entries/ following
entries/_template.md. This script is the single source of truth for the two
aggregate files at the repo root, which must never be edited by hand.

Usage:
    python3 scripts/extract_journal.py            # write both files
    python3 scripts/extract_journal.py --check    # exit 1 if they are stale
"""

from __future__ import annotations

import csv
import io
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import NoReturn

TARGET_HOURS = 270  # total hours budgeted for the project
JOURNAL_TITLE = "# Journal entries for the Pool Party project"

REPO_ROOT = Path(__file__).resolve().parent.parent
ENTRIES_DIR = REPO_ROOT / "entries"
HOURS_CSV = REPO_ROOT / "extracted_hours.csv"
JOURNAL_MD = REPO_ROOT / "extracted_journal.md"

DATE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}$")
H1_RE = re.compile(r"^#\s+(.*?)\s*$")
HOURS_RE = re.compile(r"^##\s*Hours worked\s*:\s*(.*?)\s*$", re.IGNORECASE)
HTML_COMMENT_RE = re.compile(r"<!--.*?-->", re.DOTALL)

# Section heading a slice of body text starts at, matched case-insensitively.
DESCRIPTION_HEADINGS = ("description",)
APPENDIX_HEADINGS = ("appendix", "annex", "annexe")


@dataclass
class Entry:
    path: Path
    date: str
    hours: float
    description: str
    appendix: str


def fail(path: Path, message: str) -> NoReturn:
    """Abort loudly: a skipped entry would silently under-count hours."""
    rel = path.relative_to(REPO_ROOT)
    print(f"error: {rel}: {message}", file=sys.stderr)
    sys.exit(1)


def parse_hours(raw: str, path: Path) -> float:
    try:
        return float(raw.replace(",", "."))
    except ValueError:
        fail(path, f"'## Hours worked:' is not a number: {raw!r}")


def heading_name(line: str) -> str | None:
    """Return the lowercased name of an H2 heading, without '##' or ':'."""
    if not line.startswith("## "):
        return None
    return line[3:].strip().rstrip(":").strip().lower()


def extract_section(lines: list[str], names: tuple[str, ...]) -> str:
    """Text between an H2 heading in `names` and the next H2 heading (or EOF)."""
    collected: list[str] = []
    inside = False
    for line in lines:
        name = heading_name(line)
        if name is not None:
            if inside:
                break
            inside = name in names
            continue
        if inside:
            collected.append(line)
    return "\n".join(collected).strip("\n")


def parse_entry(path: Path) -> Entry:
    text = HTML_COMMENT_RE.sub("", path.read_text(encoding="utf-8"))
    lines = text.splitlines()

    date = None
    for line in lines:
        match = H1_RE.match(line)
        if match:
            date = match.group(1)
            break
    if date is None:
        fail(path, "no '# yyyy-mm-dd' heading found")
    if not DATE_RE.match(date):
        fail(path, f"heading '# {date}' is not a yyyy-mm-dd date")

    hours = None
    for line in lines:
        match = HOURS_RE.match(line)
        if match:
            hours = parse_hours(match.group(1), path)
            break
    if hours is None:
        fail(path, "no '## Hours worked: N' line found")

    description = extract_section(lines, DESCRIPTION_HEADINGS)
    if not description:
        fail(path, "'## Description:' section is missing or empty")

    return Entry(
        path=path,
        date=date,
        hours=hours,
        description=description,
        appendix=extract_section(lines, APPENDIX_HEADINGS),
    )


def collect_entries() -> list[Entry]:
    if not ENTRIES_DIR.is_dir():
        print(f"error: {ENTRIES_DIR} does not exist", file=sys.stderr)
        sys.exit(1)
    # A leading underscore marks a non-entry, e.g. entries/_template.md.
    paths = sorted(p for p in ENTRIES_DIR.glob("*.md") if not p.name.startswith("_"))
    if not paths:
        print(f"error: no entry files found in {ENTRIES_DIR}", file=sys.stderr)
        sys.exit(1)
    return [parse_entry(p) for p in paths]


def format_hours(hours: float) -> str:
    """15.0 -> '15', 3.5 -> '3.5'."""
    return f"{hours:g}"


def render_hours_csv(entries: list[Entry]) -> str:
    # Oldest first: a spreadsheet wants ascending dates for charts and running totals.
    ordered = sorted(entries, key=lambda e: (e.date, e.path.name))
    buffer = io.StringIO(newline="")
    writer = csv.writer(buffer, lineterminator="\n")
    writer.writerow(["date", "hours"])
    for entry in ordered:
        writer.writerow([entry.date, format_hours(entry.hours)])
    return buffer.getvalue()


def render_journal_md(entries: list[Entry]) -> str:
    # Newest first: the most recent work reads at the top of the journal.
    ordered = sorted(entries, key=lambda e: (e.date, e.path.name), reverse=True)
    total = sum(entry.hours for entry in entries)
    percent = total / TARGET_HOURS * 100 if TARGET_HOURS else 0.0

    parts = [
        JOURNAL_TITLE,
        "",
        f"## Total hours currently worked : {format_hours(total)} h ({percent:.1f} %)",
        "",
    ]
    for entry in ordered:
        parts += [
            f"## {entry.date}: {format_hours(entry.hours)}h",
            "### Description:",
            entry.description,
            "",
        ]
        if entry.appendix:
            parts += ["### Annex:", entry.appendix, ""]
    return "\n".join(parts)


def main(argv: list[str]) -> int:
    check_only = "--check" in argv[1:]
    unknown = [arg for arg in argv[1:] if arg != "--check"]
    if unknown:
        print(f"usage: {Path(argv[0]).name} [--check]", file=sys.stderr)
        return 2

    entries = collect_entries()
    outputs = {
        HOURS_CSV: render_hours_csv(entries),
        JOURNAL_MD: render_journal_md(entries),
    }

    if check_only:
        stale = [
            path
            for path, content in outputs.items()
            if not path.exists() or path.read_text(encoding="utf-8") != content
        ]
        if stale:
            names = ", ".join(p.relative_to(REPO_ROOT).as_posix() for p in stale)
            print(f"stale: {names} (run scripts/extract_journal.py)", file=sys.stderr)
            return 1
        print(f"up to date: {len(entries)} entries")
        return 0

    for path, content in outputs.items():
        path.write_text(content, encoding="utf-8")
    total = format_hours(sum(entry.hours for entry in entries))
    print(f"wrote extracted_hours.csv and extracted_journal.md "
          f"({len(entries)} entries, {total} h)")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))

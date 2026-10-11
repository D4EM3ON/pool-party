#!/usr/bin/env python3
"""
* File generated mainly via Claude

Regenerate extracted_hours.csv and extracted_journal.md from entries/*.md.

Images pasted next to the entries (entries/*.png, ...) are first moved into
entries/images/, and the links pointing at them in entries/*.md are rewritten,
so entries/ only holds markdown files.

Every work session is logged as one markdown file in entries/ following
entries/_template.md. This script is the single source of truth for the two
aggregate files at the repo root, which must never be edited by hand.

Usage:
    python3 scripts/extract_journal.py            # write both files
    python3 scripts/extract_journal.py --check    # exit 1 if they are stale or
                                                  # images still need moving
"""

from __future__ import annotations

import csv
from datetime import date, datetime
import io
import posixpath
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import NoReturn
from urllib.parse import quote, unquote

TARGET_HOURS = 270  # total hours budgeted for the project
JOURNAL_TITLE = "# Journal entries for the Pool Party project"

REPO_ROOT = Path(__file__).resolve().parent.parent
ENTRIES_DIR = REPO_ROOT / "entries"
IMAGES_DIR = ENTRIES_DIR / "images"
HOURS_CSV = REPO_ROOT / "extracted_hours.csv"
JOURNAL_MD = REPO_ROOT / "extracted_journal.md"

DATE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}$")
H1_RE = re.compile(r"^#\s+(.*?)\s*$")
HOURS_RE = re.compile(r"^##\s*Hours worked\s*:\s*(.*?)\s*$", re.IGNORECASE)
HTML_COMMENT_RE = re.compile(r"<!--.*?-->", re.DOTALL)

# ![alt](target "title") and <img src="target">, target captured on its own so
# it can be rewritten without touching the alt text or the trailing title.
MD_IMAGE_RE = re.compile(r"(!\[[^\]]*\]\(\s*<?)([^\s<>()]+)(>?[^)]*\))")
HTML_IMAGE_RE = re.compile(
    r"""(<img\b[^>]*?\bsrc\s*=\s*["'])([^"']+)(["'])""", re.IGNORECASE
)
# A scheme, a protocol-relative or root-relative path, or a bare fragment:
# already resolvable as written, so it must be left alone.
ABSOLUTE_TARGET_RE = re.compile(r"^(?:[A-Za-z][A-Za-z0-9+.-]*:|//|/|#)")
IMAGE_SUFFIXES = {".png", ".jpg", ".jpeg", ".gif", ".svg", ".webp"}
# Trailing "-N" of a pasted image name, e.g. "-3" in "image-3".
NUMBERED_STEM_RE = re.compile(r"-\d+$")

# Section heading a slice of body text starts at, matched case-insensitively.
DESCRIPTION_HEADINGS = ("description",)
APPENDIX_HEADINGS = ("appendix", "annex", "annexe")


@dataclass
class Entry:
    path: Path
    date: date
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


def rewrite_image_paths(text: str, path: Path) -> str:
    """Re-root an entry's relative image paths at the repo root.

    Entries live in entries/ but the rendered journal sits at the repo root, so
    `![](image.png)` has to become `![](entries/image.png)` to keep resolving.
    """
    base = path.parent.relative_to(REPO_ROOT).as_posix()

    def relocate(match: re.Match[str]) -> str:
        prefix, target, suffix = match.groups()
        if ABSOLUTE_TARGET_RE.match(target):
            return match.group(0)
        return f"{prefix}{posixpath.normpath(f'{base}/{target}')}{suffix}"

    return HTML_IMAGE_RE.sub(relocate, MD_IMAGE_RE.sub(relocate, text))


def plan_image_moves() -> dict[Path, Path]:
    """Map every image sitting directly in entries/ to its spot in entries/images/.

    Editors paste images next to the markdown file with names like image-3.png,
    so a fresh paste can clash with an image moved earlier: the clashing one
    takes the lowest free number instead of overwriting it, e.g. a new
    image-1.png becomes image-51.png when image-50.png and image-52.png exist
    but image-51.png does not (and every number below 50 is taken).
    """
    sources = sorted(
        p for p in ENTRIES_DIR.iterdir()
        if p.is_file() and p.suffix.lower() in IMAGE_SUFFIXES
    )
    taken = {p.name for p in IMAGES_DIR.iterdir()} if IMAGES_DIR.is_dir() else set()
    moves: dict[Path, Path] = {}
    for source in sources:
        name = source.name
        if name in taken:
            base = NUMBERED_STEM_RE.sub("", source.stem)
            numbers = {
                int(match.group(1))
                for match in (
                    re.match(rf"^{re.escape(base)}-(\d+)(\.[^.]+)$", t) for t in taken
                )
                if match and match.group(2).lower() in IMAGE_SUFFIXES
            }
            free = 1
            while free in numbers:
                free += 1
            name = f"{base}-{free}{source.suffix}"
        taken.add(name)
        moves[source] = IMAGES_DIR / name
    return moves


def relink_images(text: str, path: Path, moves: dict[Path, Path]) -> str:
    """Point the image links of the markdown file at `path` to their new location."""
    def relink(match: re.Match[str]) -> str:
        prefix, target, suffix = match.groups()
        if ABSOLUTE_TARGET_RE.match(target):
            return match.group(0)
        resolved = Path(posixpath.normpath((path.parent / unquote(target)).as_posix()))
        if resolved not in moves:
            return match.group(0)
        new_target = posixpath.relpath(moves[resolved].as_posix(), path.parent.as_posix())
        return f"{prefix}{quote(new_target)}{suffix}"

    return HTML_IMAGE_RE.sub(relink, MD_IMAGE_RE.sub(relink, text))


def organize_images(check_only: bool) -> int:
    """Move loose images into entries/images/ and fix the links to them.

    Returns how many images were (or, with `check_only`, would be) moved.
    """
    moves = plan_image_moves()
    if not moves or check_only:
        return len(moves)

    for md_path in sorted(ENTRIES_DIR.glob("*.md")):
        text = md_path.read_text(encoding="utf-8")
        relinked = relink_images(text, md_path, moves)
        if relinked != text:
            md_path.write_text(relinked, encoding="utf-8")

    IMAGES_DIR.mkdir(exist_ok=True)
    for source, destination in moves.items():
        source.rename(destination)
    return len(moves)


def parse_entry(path: Path) -> Entry:
    text = HTML_COMMENT_RE.sub("", path.read_text(encoding="utf-8"))
    text = rewrite_image_paths(text, path)
    lines = text.splitlines()

    date_text = None
    for line in lines:
        match = H1_RE.match(line)
        if match:
            date_text = match.group(1)
            break
    if date_text is None:
        fail(path, "no '# yyyy-mm-dd' heading found")
    if not DATE_RE.match(date_text):
        fail(path, f"heading '# {date_text}' is not a yyyy-mm-dd date")

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
        date=datetime.strptime(date_text, "%Y-%m-%d").date(),
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
    current_week = date.today().isocalendar()[:2]
    weekly_total = sum(
        entry.hours for entry in entries
        if entry.date.isocalendar()[:2] == current_week
    )
    percent = total / TARGET_HOURS * 100 if TARGET_HOURS else 0.0

    parts = [
        JOURNAL_TITLE,
        "",
        f"## Total hours currently worked : {format_hours(total)} h ({percent:.1f} %)",
        "",
        f"## Total hours worked this week : {format_hours(weekly_total)} h",
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

    if not ENTRIES_DIR.is_dir():
        print(f"error: {ENTRIES_DIR} does not exist", file=sys.stderr)
        return 1
    moved = organize_images(check_only)
    if moved and check_only:
        print(f"stale: {moved} image(s) in entries/ must move to entries/images/ "
              f"(run scripts/extract_journal.py)", file=sys.stderr)
        return 1
    if moved:
        print(f"moved {moved} image(s) to entries/images/")

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

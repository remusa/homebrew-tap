#!/usr/bin/env python3
"""Verify and re-pin cask SHA256s.

Why this exists as its own script (and why the workflow runs it daily):

`update-casks.yml` only commits when the upstream *version* changes. Upstreams
that rebuild and re-upload the artifact under the SAME version tag leave a stale
sha256 behind with no version bump, so `brew bundle` starts failing with
"Cask reports different checksum" until someone re-hashes by hand. nuvio-desktop
and aerion have both been rebuilt upstream like that.

The old safety net (`verify-cask-shas.yml`) kept a hand-written matrix of
affected casks. That matrix duplicated `update-casks.yml`, drifted from it, and
silently skipped every cask that was not listed. This script instead reads each
cask file as the source of truth: the version and the asset URLs are already
written there, so the check needs no second list to maintain.

What it refuses to do, so it can never corrupt a cask:
  * casks with `sha256 :no_check` (nightly builds) are skipped
  * casks without a literal `version "..."` (`version :latest`) are skipped
  * URLs that are not direct assets (no .dmg/.zip/.pkg/... suffix — e.g. GitHub
    `releases/latest`, lewitt's `/latest` landing page) are ignored
  * a cask is only touched when the number of literal sha256 values equals the
    number of asset URLs, so the pairing is unambiguous
  * a download that fails, or whose body is empty, never produces a rewrite

The pairing is positional: casks list the arm64 block then the intel block, each
with its own sha256 and url, so the Nth sha pairs with the Nth asset URL.

`set` exists because update-casks.yml used to rewrite version/sha/url with
`sed` patterns that assumed single-line, no-`verified:` call syntax — see that
function's docstring for the two real failures that caused.
"""

from __future__ import annotations

import glob
import hashlib
import json
import os
import re
import subprocess
import sys

CASK_GLOB = "Casks/*.rb"

# `sha256("...")`, `sha256 "..."` and the same for url — the tap uses both styles.
SHA_RE = re.compile(r'sha256\(?\s*"([0-9a-f]{64})"\s*\)?')
URL_RE = re.compile(r'url\(?\s*"([^"]+)"\s*\)?')
VERSION_RE = re.compile(r'version\(?\s*"([^"]+)"')
NO_CHECK_RE = re.compile(r"sha256\s+:no_check")

ASSET_RE = re.compile(r"\.(dmg|zip|pkg|tgz|tar\.gz|tar\.xz|tar\.bz2|exe)$", re.I)

# sha256 of an empty body — a truncated download must never be recorded as a pin.
EMPTY_SHA = hashlib.sha256(b"").hexdigest()


def parse(path: str) -> dict:
    """Extract the pinned version, sha256 values and asset URLs in file order."""
    src = open(path, encoding="utf-8").read()
    version_match = VERSION_RE.search(src)
    version = version_match.group(1) if version_match else None
    urls = [
        u.replace("#{version}", version or "") for u in URL_RE.findall(src)
    ]
    return {
        "source": src,
        "version": version,
        "no_check": bool(NO_CHECK_RE.search(src)),
        "shas": SHA_RE.findall(src),
        "assets": [u for u in urls if ASSET_RE.search(u)],
    }


def skippable(parsed: dict) -> str | None:
    """Return a reason when a cask must be left alone, else None."""
    if parsed["no_check"]:
        return "sha256 :no_check"
    if not parsed["version"]:
        return "no literal version"
    if not parsed["shas"]:
        return "no literal sha256"
    if not parsed["assets"]:
        return "no direct asset url"
    if len(parsed["shas"]) != len(parsed["assets"]):
        return (
            f"{len(parsed['shas'])} sha256 vs {len(parsed['assets'])} asset url "
            "— pairing ambiguous"
        )
    return None


def download_sha(url: str) -> str | None:
    """sha256 of the body at url, or None when the download is unusable."""
    result = subprocess.run(
        ["curl", "-fsSL", "--retry", "3", url], capture_output=True
    )
    if result.returncode != 0:
        print(f"    download failed (curl exit {result.returncode})")
        return None
    digest = hashlib.sha256(result.stdout).hexdigest()
    if digest == EMPTY_SHA:
        print("    download empty")
        return None
    return digest


def cmd_discover() -> int:
    """Emit the workflow matrix for casks that pin a verifiable sha256."""
    include = []
    for path in sorted(glob.glob(CASK_GLOB)):
        parsed = parse(path)
        if skippable(parsed):
            continue
        include.append({"name": os.path.basename(path)[:-3], "file": path})

    matrix = json.dumps({"include": include})
    print(f"discovered {len(include)} cask(s) with pinned sha256")
    if os.environ.get("GITHUB_OUTPUT"):
        with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as fh:
            fh.write(f"matrix={matrix}\n")
            fh.write(f"count={len(include)}\n")
    else:
        print(matrix)
    return 0


def cmd_verify(path: str, apply: bool) -> int:
    """Check one cask, rewriting stale sha256 values when --apply is given."""
    name = os.path.basename(path)[:-3]
    parsed = parse(path)
    reason = skippable(parsed)
    if reason:
        print(f"{name}: skipped ({reason})")
        return 0

    print(f"{name}: {parsed['version']} — checking {len(parsed['assets'])} asset(s)")
    replacements: list[tuple[int, int, str]] = []
    stale = 0

    # Pair by position, then rewrite in reverse so earlier offsets stay valid.
    for match, url in zip(SHA_RE.finditer(parsed["source"]), parsed["assets"]):
        print(f"  {url}")
        actual = download_sha(url)
        if actual is None:
            continue
        if actual == match.group(1):
            print("    sha256 ok")
            continue
        stale += 1
        print(f"    sha256 stale: {match.group(1)} -> {actual}")
        replacements.append((match.start(1), match.end(1), actual))

    if not stale:
        return 0

    if not apply:
        print(f"{name}: {stale} stale sha256 (dry run — nothing written)")
        return 0

    updated = parsed["source"]
    for start, end, value in reversed(replacements):
        updated = updated[:start] + value + updated[end:]
    with open(path, "w", encoding="utf-8") as fh:
        fh.write(updated)
    print(f"{name}: rewrote {stale} sha256 value(s)")

    if os.environ.get("GITHUB_OUTPUT"):
        with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as fh:
            fh.write("changed=true\n")
    return 0


def cmd_set(path: str, version: str | None, sha: str | None,
            sha_intel: str | None, url: str | None) -> int:
    """Rewrite a cask's version / sha256 / url regardless of formatting.

    update-casks.yml used `sed 's|sha256(\".*\")|...|'` and
    `sed 's@url(\"[^\"]*\")@...@'`, which silently match nothing when the cask
    wraps those calls over several lines or passes `verified:`. Two real
    failures came from that: librewolf's `sha256(\n "..."\n)` was never
    re-hashed on a bump, and bambu-studio-beta's version moved while its url
    stayed on the old asset, so the cask 404'd. This does the rewrite on the
    parsed value instead, so formatting cannot defeat it.
    """
    src = open(path, encoding="utf-8").read()
    replacements: list[tuple[int, int, str]] = []

    if version:
        match = VERSION_RE.search(src)
        if not match:
            print(f"{path}: no literal version to set")
            return 1
        replacements.append((match.start(1), match.end(1), version))

    if url:
        match = URL_RE.search(src)
        if not match:
            print(f"{path}: no url literal to set")
            return 1
        replacements.append((match.start(1), match.end(1), url))

    sha_values = [sha] if sha else []
    if sha_intel:
        sha_values.append(sha_intel)
    for index, value in enumerate(sha_values):
        matches = list(SHA_RE.finditer(src))
        if len(matches) <= index:
            print(f"{path}: no sha256 #{index + 1} to set")
            return 1
        match = matches[index]
        replacements.append((match.start(1), match.end(1), value))

    if not replacements:
        print(f"{path}: nothing to set")
        return 1

    # Apply in reverse so earlier offsets stay valid.
    for start, end, value in sorted(replacements, reverse=True):
        src = src[:start] + value + src[end:]
    with open(path, "w", encoding="utf-8") as fh:
        fh.write(src)
    print(f"{os.path.basename(path)}: set " + ", ".join(
        filter(None, [f"version={version}" if version else None,
                      f"url={url}" if url else None,
                      f"sha256={sha}" if sha else None,
                      f"sha256_intel={sha_intel}" if sha_intel else None])))
    return 0


def main(argv: list[str]) -> int:
    if len(argv) < 2:
        print(__doc__)
        return 2
    command = argv[1]
    if command == "discover":
        return cmd_discover()
    if command == "verify" and len(argv) >= 3:
        return cmd_verify(argv[2], apply="--apply" in argv[3:])
    if command == "set" and len(argv) >= 3:
        flags = argv[3:]
        values = {}
        for flag in ("--version", "--sha", "--sha-intel", "--url"):
            if flag in flags:
                values[flag] = flags[flags.index(flag) + 1]
        return cmd_set(
            argv[2],
            values.get("--version"),
            values.get("--sha"),
            values.get("--sha-intel"),
            values.get("--url"),
        )
    print(f"unknown arguments: {' '.join(argv[1:])}")
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv))

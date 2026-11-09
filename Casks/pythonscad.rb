cask("pythonscad") do
  # Pinned to an upstream-master build, NOT an upstream release tag.
  #
  # Why: the released v1.1.2 DMG bundles mimalloc 3.4.0, whose macOS malloc-zone
  # interposition faults under pointer authentication and kills the app on the
  # first AppKit layout pass (`mi_heap_main` <- `zone_free` <- CA::Transaction::pop).
  # Upstream issues #965 (arm64, Apple Silicon) and #1041 (Intel) track it;
  # PR #999 "disable mimalloc to stop Apple Silicon startup crash" (merged
  # 2026-08-26) fixes it but is in NO release yet — release PR #897 is still open.
  #
  # The DMG below is upstream's own CI output (workflow "Build and upload macOS
  # build", run 40523603780 on master @ f64848c73), re-hosted unchanged under a
  # permanent public URL because GitHub Actions artifacts need auth and expire.
  # Signed Developer ID (39F2MHZ52W) and notarized by upstream — only re-hosted.
  #
  # WHEN UPSTREAM PUBLISHES A RELEASE CONTAINING #999 (1.2.0): revert this cask
  # to the released DMG and restore the pythonscad entry in
  # .github/workflows/update-casks.yml (commented out there, points back here).
  version("1.1.2-606-gf64848c73")
  sha256("4320bdfeb1173539792c5377e913cb41026ad74352daa560f4558a074749505e")

  url("https://github.com/remusa/pythonscad/releases/download/master-2026-10-27/PythonSCAD-master-2026-10-27.dmg")
  name("PythonSCAD")
  desc("OpenSCAD fork with Python scripting support")
  homepage("https://github.com/pythonscad/pythonscad")

  # livecheck intentionally disabled while pinned to the re-hosted master build:
  # it would report upstream 1.1.2 as "newer" and invite a downgrade onto the
  # broken mimalloc DMG. Re-enable together with the revert above.
  #
  # livecheck do
  #   url("https://github.com/pythonscad/pythonscad/releases/latest")
  #   strategy(:github_latest)
  # end

  app("PythonSCAD.app")

  zap(
    trash: [
      "~/Library/Application Support/PythonSCAD",
      "~/Library/Preferences/org.pythonscad.pythonscad.plist"
    ]
  )
end

# Feishin - modern Subsonic/Jellyfin desktop music player.
# https://github.com/jeffvli/feishin
#
# Why a cask rather than the nixpkgs derivation this replaced:
#
# The nix package carried a permanent `overrideAttrs` that rebuilds the blank
# icon. Keeping it meant feishin's dependency chain lived in the Nix closure,
# and in the 2026-11 nixpkgs-darwin bump that chain pulled mpv 0.42.0, which
# depends on swift 6.4.0 — neither in the binary cache for aarch64-darwin.
# Building swift needs ~40 GB, so the whole darwin bump was blocked on a music
# player. A cask downloads the upstream DMG instead: no electron rebuild, no
# mpv, no swift.
#
# The icon problem is upstream's, not nixpkgs':
#   * Contents/Resources/icon.icns is a placeholder with only 16px and 128px
#     representations, so Finder/Dock/Launchpad show a white square;
#   * Info.plist declares CFBundleIconName = "Icon" while the file is
#     "icon.icns" (lowercase), and the lookup for a named icon misses.
# The real artwork ships inside the bundle at assets/icons/1024x1024.png, so the
# postflight below regenerates icon.icns from it with sips/iconutil (macOS
# native — no nix deps), drops CFBundleIconName, and re-signs ad-hoc because
# touching bundle resources invalidates the signature.
#
# Bumping: change version + sha256 from the arm64 DMG release asset.
#   brew livecheck --cask remusa/tap/feishin   # what upstream has
#   shasum -a 256 Feishin-<version>-mac-arm64.dmg
cask("feishin") do
  version("1.17.0")
  sha256("48d3f97408b616ca6a4262371a7daefda2ea29d6922717dede40fbf91ffb31b8")

  url("https://github.com/jeffvli/feishin/releases/download/v#{version}/Feishin-#{version}-mac-arm64.dmg")
  name("Feishin")
  desc("Modern Subsonic/Jellyfin desktop music player")
  homepage("https://github.com/jeffvli/feishin")

  # Only the arm64 DMG is wired up: both Macs here are Apple Silicon. Add an
  # on_intel block with the x64 asset's sha256 if that ever changes.
  depends_on arch: :arm64

  livecheck do
    url("https://api.github.com/repos/jeffvli/feishin/releases/latest")
    strategy(:github_latest)
  end

  app("Feishin.app")

  uninstall(quit: "org.jeffvli.feishin")

  zap(
    trash: [
      "~/Library/Application Support/Feishin",
      "~/Library/Caches/org.jeffvli.feishin",
      "~/Library/Preferences/org.jeffvli.feishin.plist",
      "~/Library/Saved Application State/org.jeffvli.feishin.savedState"
    ]
  )

  postflight do
    # Dir.tmpdir is only defined once the stdlib file is loaded; Homebrew loads
    # it in practice, but the postflight must not depend on that.
    require "tmpdir"

    # Runs after the artifact is moved into /Applications, as the installing
    # user (nix-homebrew sets user = "rms"), so no sudo is involved. That
    # matters: a cask needing root makes `brew bundle` fail, and darwin-rebuild
    # then aborts outright.
    app = "#{appdir}/Feishin.app"
    logo = "#{app}/Contents/Resources/assets/icons/1024x1024.png"

    if File.directory?(app) && File.exist?(logo)
      # electron-builder output is read-only; the icon file must be replaced.
      system_command("/bin/chmod", args: ["-R", "u+w", app])

      iconset = "#{Dir.tmpdir}/feishin.iconset"
      FileUtils.rm_rf(iconset)
      FileUtils.mkdir_p(iconset)

      # iconutil needs the full set or the resulting icns is rejected as
      # incomplete; every size is derived from the single 1024px source.
      [16, 32, 128, 256, 512].each do |size|
        system_command("/usr/bin/sips",
                       args: ["-z", size.to_s, size.to_s, logo,
                              "--out", "#{iconset}/icon_#{size}x#{size}.png"])
        system_command("/usr/bin/sips",
                       args: ["-z", (size * 2).to_s, (size * 2).to_s, logo,
                              "--out", "#{iconset}/icon_#{size}x#{size}@2x.png"])
      end

      system_command("/usr/bin/iconutil",
                     args: ["-c", "icns", iconset, "-o",
                            "#{app}/Contents/Resources/icon.icns"])

      # Drop the key that points at a non-existent "Icon"; CFBundleIconFile
      # ("icon.icns") then wins. PlistBuddy is not used because this key is
      # absent on some builds and `-remove` on a missing key is what we want.
      system_command("/usr/bin/plutil",
                     args: ["-remove", "CFBundleIconName",
                            "#{app}/Contents/Info.plist"])

      # Ad-hoc re-sign: only digests, no certificate. Without it macOS refuses
      # to launch the patched bundle on Apple Silicon.
      system_command("/usr/bin/codesign",
                     args: ["--force", "--deep", "--sign", "-", app])

      FileUtils.rm_rf(iconset)
    end
  end

  caveats <<~EOS
    This cask patches Feishin's app icon on install, because upstream ships a
    blank 16/128-only icon.icns plus a CFBundleIconName key that points at a
    file which does not exist. The postflight rebuilds icon.icns from the
    bundled 1024x1024.png, drops the bogus key and re-signs the bundle ad-hoc.
    If an upgrade ever shows a white icon again, the postflight did not run:
    reinstall with `brew reinstall --cask remusa/tap/feishin`.

    Upstream is signed ad-hoc, not notarized (no Developer ID), so Gatekeeper
    rejects it when com.apple.quarantine is set. Homebrew does not set it, so
    normal launches are unaffected; if one is ever blocked, allow it in
    System Settings > Privacy & Security > Open Anyway.
  EOS
end

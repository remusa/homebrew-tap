# Thaw — pinned to the 1.x line.
#
# WHY: the official homebrew-cask tap moved to 2.0.x which requires
# macOS 26 (Tahoe). This private tap freezes brew at 1.2.0 (the newest
# stable 1.x; Sparkle minSystemVersion 14.0 = Sonoma), so rebuilds stop
# trying to upgrade and failing on Sequoia 15.
#
# Bump policy (1.x only):
#   * Keep version/sha256 at the newest STABLE 1.x whose Sparkle
#     minimumSystemVersion is <= the macOS on the hosts (14.0/15.x).
#   * NEVER bump to 2.x — it requires macOS 26.
#   * The installed app self-updates via Sparkle (auto_updates), so it
#     follows newer 1.x automatically; brew only books the version.
#   * To bump: `brew bump-cask-pr remusa/tap/thaw` (livecheck reads the
#     appcast below and is scoped to compatible 1.x), verify download,
#     then `nix flake update remusa-homebrew-tap` in nix-config.
#
# NOTE: upstream GitHub 1.x archives are gone (only the appcast lists them,
# and those URLs 404). This tap now HOSTS the 1.2.0 archive in its own GitHub
# release (tag 1.2.0) so fresh installs on macOS < Tahoe work.
#
# Upstream 2.0 notes say macOS 14/15 users "stay on 1.3.0-beta.1", but that
# beta's archive is also 404 upstream (verified 2026-09). Pin stays at the
# installed 1.2.0; if a downloadable stable 1.x appears, bump to it.
cask("thaw") do
  version "1.2.0"
  sha256 "99fdacde2c110e1fd8c43ff754c5f4d207aaf6ef6524d9d289ba1b2ac48a9e3c"

  url "https://github.com/remusa/homebrew-tap/releases/download/1.2.0/Thaw_#{version}.zip"

  name "Thaw"
  desc "Menu bar manager"
  homepage "https://github.com/stonerl/Thaw/"

  auto_updates true
  depends_on macos: :sonoma

  app "Thaw.app"

  uninstall quit: ["com.stonerl.Thaw", "com.stonerl.Thaw.MenuBarItemService"]

  zap trash: [
    "~/Library/Caches/com.stonerl.Thaw",
    "~/Library/HTTPStorages/com.stonerl.Thaw",
    "~/Library/Preferences/com.stonerl.Thaw.plist",
    "~/Library/WebKit/com.stonerl.Thaw",
  ]

  livecheck do
    url "https://stonerl.github.io/Thaw/appcast.xml"
    strategy :sparkle
  end
end
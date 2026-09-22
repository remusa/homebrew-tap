cask("opencode-desktop-v2") do
  # OpenCode 2 desktop app, pinned to the official stable release artefact.
  # Replaces opencode-desktop-beta.rb (channel URL, :latest + :no_check).
  #
  # NOTE: the official v2 DMG uses bundle id `ai.opencode.desktop` and installs
  # "OpenCode.app" — identical to the homebrew-cask `opencode-desktop` cask
  # (still v1.18.31 upstream). The two therefore CANNOT coexist; the v1 cask is
  # removed from modules/darwin/homebrew.nix.
  #
  # There is no official v2 desktop cask upstream (anomalyco/homebrew-tap ships
  # only formulae for the CLI). The stable download is versioned, not
  # channel-based, so pin version + sha256 explicitly. Bump both together:
  #   https://opencode.ai/files/bin/<version>/opencode-desktop-mac-arm64.dmg
  version("2.0.12")
  sha256("b87b67d3ed722fd977f7ae71d6394a8ee60ac477b4453730fbc9bc149e7c570f")

  url("https://opencode.ai/files/bin/#{version}/opencode-desktop-mac-arm64.dmg",
      verified: "opencode.ai/files/bin/")

  name("OpenCode")
  desc("AI coding agent desktop client (v2)")
  homepage("https://opencode.ai/")

  depends_on arch: :arm64

  app("OpenCode.app")

  zap(
    trash: [
      "~/Library/Application Support/ai.opencode.desktop",
      "~/Library/Caches/ai.opencode.desktop",
      "~/Library/Preferences/ai.opencode.desktop.plist",
      "~/Library/Saved Application State/ai.opencode.desktop.savedState",
      "~/Library/WebKit/ai.opencode.desktop"
    ]
  )
end

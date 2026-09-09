cask("opencode-desktop-beta") do
  # Beta channel (OpenCode 2). URL is channel-based and serves whatever the
  # current beta build is, so pin :latest + :no_check rather than a version.
  # Coexists with the stable `opencode-desktop` cask: the bundle id is
  # ai.opencode.desktop.beta and the app is "OpenCode Beta.app".
  version :latest
  sha256 :no_check # channel URL, contents change per beta release

  url("https://opencode.ai/download/beta/darwin-aarch64-dmg",
      verified: "opencode.ai/download/")

  name("OpenCode Beta")
  desc("AI coding agent desktop client (v2 beta)")
  homepage("https://opencode.ai/")

  depends_on arch: :arm64

  app("OpenCode Beta.app")

  zap(
    trash: [
      "~/Library/Application Support/ai.opencode.desktop.beta",
      "~/Library/Caches/ai.opencode.desktop.beta",
      "~/Library/Preferences/ai.opencode.desktop.beta.plist",
      "~/Library/Saved Application State/ai.opencode.desktop.beta.savedState",
      "~/Library/WebKit/ai.opencode.desktop.beta"
    ]
  )
end

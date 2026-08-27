cask("opencode-bar-fork") do
  version("0.0.1")

  on_arm do
    sha256("0867561bfe06291e143dc8270e47ca5b04fda2098d30a40de8091a26aa6191e0")
    url("https://github.com/remusa/opencode-bar/releases/download/v#{version}/OpenCodeUsageMonitor-v#{version}.dmg")
  end

  on_intel do
    sha256("0867561bfe06291e143dc8270e47ca5b04fda2098d30a40de8091a26aa6191e0")
    url("https://github.com/remusa/opencode-bar/releases/download/v#{version}/OpenCodeUsageMonitor-v#{version}.dmg")
  end

  name("OpenCode Bar")
  desc("Monitor all your AI provider usage from OpenCode in real-time from the macOS menu bar")
  homepage("https://github.com/remusa/opencode-bar")

  app("OpenCode Bar.app")

  zap(
    trash: [
      "~/Library/Application Support/OpenCodeBar",
      "~/Library/Preferences/com.opencode.bar.plist",
      "~/Library/Saved Application State/com.opencode.bar.savedState"
    ]
  )
end

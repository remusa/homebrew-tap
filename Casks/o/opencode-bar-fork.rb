cask("opencode-bar-fork") do
  version("0.0.1")

  on_arm do
    sha256("d8f5921d33982304a44e52f37438a72cd3a88126cf8963c47f5cb08b264b50aa")
    url("https://github.com/remusa/opencode-bar/releases/download/v#{version}/OpenCodeUsageMonitor-v#{version}.dmg")
  end

  on_intel do
    sha256("d8f5921d33982304a44e52f37438a72cd3a88126cf8963c47f5cb08b264b50aa")
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

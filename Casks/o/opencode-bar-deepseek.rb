cask("opencode-bar-deepseek") do
  version("0.0.1")

  on_arm do
    sha256("08b2a759130b8922d481503897924a57be86de6da78128c9161623a25361b88e")
    url("https://github.com/remusa/opencode-bar/releases/download/v#{version}/OpenCodeUsageMonitor-v#{version}.dmg")
  end

  on_intel do
    sha256("08b2a759130b8922d481503897924a57be86de6da78128c9161623a25361b88e")
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

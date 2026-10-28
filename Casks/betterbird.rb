cask("betterbird") do
  version("153.6.0esr-bb12")

  on_arm do
    # Get via: curl -L https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac-arm64.dmg | shasum -a 256
    sha256("981fc3b606fe8e5304cac219a10d116bf0af05cfce71a2c27c4e0f95b8d99595")
    url("https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac-arm64.dmg")
  end

  on_intel do
    # Get via: curl -L https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac.dmg | shasum -a 256
    sha256("c9bc8a7af549205ea4299dc614ce22905347cc10399cd605be7257efa6a8af84")
    url("https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac.dmg")
  end

  name("Betterbird")
  desc("Fine-tuned version of Mozilla Thunderbird")
  homepage("https://www.betterbird.eu/")

  app("Betterbird.app")

  # Note: Betterbird is not notarised. After install, run:
  # xattr -r -d com.apple.quarantine /Applications/Betterbird.app
  postflight do
    system_command(
      "/usr/bin/xattr",
      args: ["-r", "-d", "com.apple.quarantine", "#{appdir}/Betterbird.app"],
      sudo: false
    )
  end

  zap(
    trash: [
      "~/Library/Application Support/Betterbird",
      "~/Library/Caches/Betterbird",
      "~/Library/Preferences/eu.betterbird.Betterbird.plist",
      "~/Library/Saved Application State/eu.betterbird.Betterbird.savedState"
    ]
  )
end

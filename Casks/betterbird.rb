cask("betterbird") do
  version("153.7.0esr-bb13")

  on_arm do
    # Get via: curl -L https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac-arm64.dmg | shasum -a 256
    sha256("b5eacb2ba1c11b6e1b36c73898611246b0a7f38431a73dfbb4762116393a98d9")
    url("https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac-arm64.dmg")
  end

  on_intel do
    # Get via: curl -L https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac.dmg | shasum -a 256
    sha256("bf7f0dc3658acd28376fec734017846b630887d6ff1ee3d0e2aa07b5e8b25268")
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

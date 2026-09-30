cask("betterbird") do
  version("153.4.0esr-bb10")

  on_arm do
    # Get via: curl -L https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac-arm64.dmg | shasum -a 256
    sha256("9b81a006da056a4b6fbed6345a27902ad4aa8121bdb88be1d7fcf14345fa3a7e")
    url("https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac-arm64.dmg")
  end

  on_intel do
    # Get via: curl -L https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac.dmg | shasum -a 256
    sha256("7becb7279c1e3b73075ebed3c553a2fa03212309d4d298b69cb655f707967f93")
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

cask("betterbird") do
  version("140.13.0esr-bb25")

  on_arm do
    # Get via: curl -L https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac-arm64.dmg | shasum -a 256
    sha256("35df2df65104cd83af36348eed0023feca110f48bd6a77cfc87845dcf107dd7d")
    url("https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac-arm64.dmg")
  end

  on_intel do
    # Get via: curl -L https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac.dmg | shasum -a 256
    sha256("94fb76e1e81bd2488e6c9f93a93f753f0012969ed223c8555e75636d14f480fc")
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

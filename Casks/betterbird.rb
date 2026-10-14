cask("betterbird") do
  version("153.5.0esr-bb11")

  on_arm do
    # Get via: curl -L https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac-arm64.dmg | shasum -a 256
    sha256("84e9e9506b6030547253fba8bdc434b40df3da944fa68ec286c74c16ac91ee97")
    url("https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac-arm64.dmg")
  end

  on_intel do
    # Get via: curl -L https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac.dmg | shasum -a 256
    sha256("7d9af427c7993984671e8806c4390f51cfbf216dc365f2d405d3e5d08790e04f")
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

cask("aerion") do
  version("0.2.5")

  on_arm do
    sha256("352744e0c214f22c0d5547cbb6f96b7b10881a34bb7b47e28b0a56518875e214")
    url("https://github.com/hkdb/aerion/releases/download/v#{version}/Aerion-darwin-arm64.zip")
  end

  on_intel do
    sha256("84fe2c6b4a3f1cd6ce21648b361e8913d959a052857c1d44a44d7c2e005e8a41")
    url("https://github.com/hkdb/aerion/releases/download/v#{version}/Aerion-darwin-amd64.zip")
  end

  name("Aerion")
  desc("Open source lightweight email client")
  homepage("https://github.com/hkdb/aerion")

  app("Aerion.app")

  zap(
    trash: [
      "~/Library/Application Support/Aerion",
      "~/Library/Preferences/com.hkdb.aerion.plist",
      "~/Library/Saved Application State/com.hkdb.aerion.savedState"
    ]
  )
end

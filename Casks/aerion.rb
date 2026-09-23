cask("aerion") do
  version("0.3.5")

  on_arm do
    sha256("0d2e01dd0505b13edfc287290c57322859a7fcc79f8a142dff94c6baebea7490")
    url("https://github.com/hkdb/aerion/releases/download/v#{version}/Aerion-darwin-arm64.zip")
  end

  on_intel do
    sha256("07cd3581d5d56d3d91d71936ae875acd944c32c80cb1102f8ca3def3f300edff")
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

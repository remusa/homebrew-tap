cask("aerion") do
  version("0.3.6")

  on_arm do
    sha256("9bb613d402bdf5b8beeea65926dc2c13bb379003c08dfd138bd0750ba3aae767")
    url("https://github.com/hkdb/aerion/releases/download/v#{version}/Aerion-darwin-arm64.zip")
  end

  on_intel do
    sha256("800beac959a66d3e31c4af1157618b4dc6b65ce40899f99d456d0163fbeb93ea")
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

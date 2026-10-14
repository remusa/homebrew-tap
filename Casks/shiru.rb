cask("shiru") do
  version("6.9.1")
  sha256("49703739be05dd6f0ade92e251ea216192eeb24610c3e0765bfdac740a7eb95a")

  url("https://github.com/RockinChaos/Shiru/releases/download/v#{version}/mac-Shiru-v#{version}.dmg")
  name("Shiru")
  desc(
    " A personal anime library manager for watching and tracking your collection in real time. Lightweight, powerful, and paws-itively fast. No waiting required!"
  )
  homepage("https://github.com/RockinChaos/Shiru")

  livecheck do
    url("https://github.com/RockinChaos/Shiru/releases/latest")
    strategy(:github_latest)
  end

  app("Shiru.app")

  zap(
    trash: [
      "~/Library/Application Support/Shiru",
      "~/Library/Preferences/com.rockinchaos.shiru.plist"
    ]
  )
end

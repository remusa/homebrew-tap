cask("shiru") do
  version("6.10.0")
  sha256("2574ecd237ea3bce18f55599a1b168ad45acd44b138f460f37272ad5a72de5e0")

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

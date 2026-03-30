cask("shiru") do
  version("6.5.2")
  sha256("3f65324e5236ce037db66a76b5c6c4a25565fbeba0f00d0139f02bfabbf3ca51")

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

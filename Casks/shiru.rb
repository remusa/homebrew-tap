cask("shiru") do
  version("6.7.0")
  sha256("d002d880a4a0d0d4773ab456599286f3cb3697d61a05ce6094577b39867a06e4")

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

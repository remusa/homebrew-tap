cask("shiru") do
  version("6.6.0")
  sha256("953319e355cb23f9aebaacf9c9d0f6eb4ef60c06d6aaabf4dda98a73b435d008")

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

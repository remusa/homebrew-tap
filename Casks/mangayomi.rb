cask("mangayomi") do
  version("0.8.5")
  sha256("6c7a58ab584ad6438662056b3cb9ff2b697aa3d9fec0f2a8a9914bb8802e2fbe")

  url("https://github.com/kodjodevf/mangayomi/releases/download/v#{version}/Mangayomi-v#{version}-macos.dmg")
  name("Mangayomi")
  desc("Free and open source application for reading manga and watching anime")
  homepage("https://github.com/kodjodevf/mangayomi")

  livecheck do
    url("https://github.com/kodjodevf/mangayomi/releases/latest")
    strategy(:github_latest)
  end

  app("Mangayomi.app")

  zap(
    trash: [
      "~/Library/Application Support/Mangayomi",
      "~/Library/Preferences/com.kodjodevf.mangayomi.plist"
    ]
  )
end

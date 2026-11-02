cask("mangayomi") do
  version("0.9.95")
  sha256("655f1b6f8062859c05fbed51997fdaf7bd8a8b47916d452962ac84c39a373899")

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

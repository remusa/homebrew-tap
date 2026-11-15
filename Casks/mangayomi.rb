cask("mangayomi") do
  version("0.9.96")
  sha256("d00038a37e7ceb48c5597e0cc480adf116386770c22f362ec676a19ca4104743")

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

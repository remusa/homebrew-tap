cask("mangayomi") do
  version("0.9.9")
  sha256("d484c1a9cb67e06bf467b7ec075d7fe917d590a473641918b2b64e68477d5d67")

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

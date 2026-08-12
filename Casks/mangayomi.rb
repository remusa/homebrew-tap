cask("mangayomi") do
  version("0.8.3")
  sha256("4313274c6ce9ff60e4867cf86107eefd4ea13a0426118e938b8cfc0365506034")

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

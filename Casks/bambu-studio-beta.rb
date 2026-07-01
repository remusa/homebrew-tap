cask("bambu-studio-beta") do
  version("02.08.00.50")
  sha256("fc7a60ed2d412f8f7b897f2e468bd1062a0b7fbf9437d1ede2100cb51c4eaf2d")

  url(
    "https://github.com/bambulab/BambuStudio/releases/download/v#{version}/Bambu_Studio_mac-v02.08.00.50-20260625193201.dmg",
    verified: "github.com/bambulab/BambuStudio/"
  )

  name("Bambu Studio Beta")
  desc("PC Software for BambuLab and other 3D printers (beta)")
  homepage("https://github.com/bambulab/BambuStudio")

  app("BambuStudio.app")

  zap(
    trash: [
      "~/Library/Application Support/BambuStudio",
      "~/Library/Caches/BambuStudio",
      "~/Library/Preferences/com.bambulab.BambuStudio.plist",
      "~/Library/Saved Application State/com.bambulab.BambuStudio.savedState",
      "~/Library/WebKit/com.bambulab.BambuStudio"
    ]
  )
end

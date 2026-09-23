cask("bambu-studio-beta") do
  version("02.08.04.57")
  sha256("6d0099f60bb4449ee9066160cb65a8a1f639650a3f48cddf13566fe0c520ac66")

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

cask("bambu-studio-beta") do
  version("02.08.01.55")
  sha256("17eca4d63b909c728bf6d0cf8753397820f15b372e1ce69d6ab71be796a3af0d")

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

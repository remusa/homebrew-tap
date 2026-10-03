cask("typewhisper") do
  version("1.7.0")
  sha256("d059e6c2330129be920ffb5bc0c8a95e988a0a85184b49c8ad8761adf46ef013")

  url(
    "https://github.com/TypeWhisper/typewhisper-mac/releases/download/v#{version}/TypeWhisper-v#{version}.dmg",
    verified: "github.com/TypeWhisper/typewhisper-mac/"
  )

  name("TypeWhisper")
  desc("Speech-to-text and AI text processing for macOS")
  homepage("https://github.com/TypeWhisper/typewhisper-mac")

  livecheck do
    url(:url)
    strategy(:github_latest)
  end

  auto_updates(true)
  depends_on macos: :sonoma

  app("TypeWhisper.app")

  zap(
    trash: [
      "~/Library/Application Support/TypeWhisper",
      "~/Library/Preferences/com.typewhisper.mac.plist",
      "~/Library/Caches/com.typewhisper.mac",
      "~/Library/HTTPStorages/com.typewhisper.mac"
    ]
  )
end

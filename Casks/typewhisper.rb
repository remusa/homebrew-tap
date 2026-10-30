cask("typewhisper") do
  version("1.8.1")
  sha256("dc0e7963d58831e6824621af77ecba69fa8a33e65587655905707ee23d23a459")

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

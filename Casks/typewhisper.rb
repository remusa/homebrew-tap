cask("typewhisper") do
  version("1.4.0")
  sha256("7158c9169f366affcfc235eeac58f14564063f6cf3d1dc602ab5cf09ea8995db")

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
  depends_on(macos: ">= :sequoia")

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

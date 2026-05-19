cask("typewhisper") do
  version("plugin-granite-1.0.8")
  sha256("0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5")

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

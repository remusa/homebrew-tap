cask("typewhisper") do
  version("1.5.1")
  sha256("3b4d52abc085b51225b3fe7c7763baf1ee2edb1c07bc0e9c02e2fb2edca6fb8c")

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

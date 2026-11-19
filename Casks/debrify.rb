cask("debrify") do
  version("0.11.0-beta.1")
  # Get via: curl -L [URL] | shasum -a 256
  sha256("d6918307b7799c2278f3d368b041abc77ffe00763bda937f7db71f7ca9742cac")

  # One universal .dmg (x86_64 + arm64 in the same Mach-O), so no on_arm/on_intel split.
  url("https://github.com/varunsalian/debrify/releases/download/v#{version}/debrify-v#{version}.dmg")
  name("Debrify")
  desc("Personal media hub for browsing and streaming your own sources")
  homepage("https://github.com/varunsalian/debrify")

  livecheck do
    url("https://api.github.com/repos/varunsalian/debrify/releases/latest")
    strategy(:github_latest)
  end

  # Upstream ships unsigned / un-notarized, and its bundle id is still the
  # Flutter placeholder com.example.torrentSearchApp. The darwin hosts strip
  # com.apple.quarantine for every declared cask, so no postflight is needed here.
  app("Debrify.app")

  zap(
    trash: [
      "~/Library/Application Support/com.example.torrentSearchApp",
      "~/Library/Preferences/com.example.torrentSearchApp.plist",
      "~/Library/Caches/com.example.torrentSearchApp"
    ]
  )
end

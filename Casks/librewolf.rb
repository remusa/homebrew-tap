cask("librewolf") do
  version("160.0-1")
  # Get via: curl -L [URL] | shasum -a 256
  sha256(
    "416a2fa78e4b67e97a48751aaf783f1fe5711d9495a52a3b1f245b89adc1c638"
  )

  url(
    "https://codeberg.org/api/packages/librewolf/generic/librewolf/#{version}/librewolf-#{version}-macos-arm64-package.dmg"
  )
  name("LibreWolf")
  desc("Web browser focused on privacy, security, and freedom")
  homepage("https://librewolf.net/")

  app("LibreWolf.app")

  zap(
    trash: [
      "~/Library/Application Support/LibreWolf",
      "~/Library/Caches/LibreWolf",
      "~/Library/Preferences/io.gitlab.librewolf-community.librewolf.plist",
      "~/Library/Saved Application State/io.gitlab.librewolf-community.librewolf.savedState"
    ]
  )
end

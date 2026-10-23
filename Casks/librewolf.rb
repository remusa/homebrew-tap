cask("librewolf") do
  version("158.0.1-2")
  # Get via: curl -L [URL] | shasum -a 256
  sha256(
    "974703e22c5710529b0dc0e14259eafbb9e2d4767180353da722c2f25db0d81e"
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

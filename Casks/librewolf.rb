cask("librewolf") do
  version("159.0.1-1")
  # Get via: curl -L [URL] | shasum -a 256
  sha256(
    "ed92b13a015059fda2e27e8b2c5de7d801843e5fa0d7ee92b11bd487f5c68bf4"
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

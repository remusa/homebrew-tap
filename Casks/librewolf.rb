cask("librewolf") do
  version("156.0.1-1")
  # Get via: curl -L [URL] | shasum -a 256
  sha256(
    "d67ebcc8f3711b398979facfec9a5cf086fb055a81f8b95094bb2d81c9dc0061"
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

cask("librewolf") do
  version("150.0.1-1")
  # Get via: curl -L [URL] | shasum -a 256
  sha256(
    "21e794d6dde202c2882e6b901f1d01fb942069169162c650453a80aea9412ee3"
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

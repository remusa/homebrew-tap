cask("nuvio-desktop") do
  version("0.1.35-alpha")

  on_arm do
    sha256("927b9a29da9dd3215fecbb4108e7a91731e3583c9f8a4056d5635ba04a5db778")
    url("https://github.com/NuvioMedia/NuvioDesktop/releases/download/#{version}/Nuvio-macOS-arm64-#{version}.dmg")
  end

  on_intel do
    sha256("6e652baca94bf7181a93d25fee977940cc350c92521819889f0b024341cd851e")
    url("https://github.com/NuvioMedia/NuvioDesktop/releases/download/#{version}/Nuvio-macOS-x86_64-#{version}.dmg")
  end

  name("Nuvio")
  desc("Desktop client for browsing and streaming media (alpha)")
  homepage("https://github.com/NuvioMedia/NuvioDesktop")

  livecheck do
    url("https://api.github.com/repos/NuvioMedia/NuvioDesktop/releases/latest")
    strategy(:github_latest)
  end

  # NOTE: As of 0.1.22-alpha, macOS builds are unsigned and not notarized.
  # Users may need to right-click the app in /Applications and choose Open
  # the first time, then approve in System Settings → Privacy & Security.
  app("Nuvio.app")
end
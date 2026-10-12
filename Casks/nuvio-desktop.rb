cask("nuvio-desktop") do
  version("0.1.30-alpha")

  on_arm do
    sha256("11f469d7efbbaaeca65aee3d2f5e990f9ed1f8b4a1d0ce529722fc6ea7844bb9")
    url("https://github.com/NuvioMedia/NuvioDesktop/releases/download/#{version}/Nuvio-macOS-arm64-#{version}.dmg")
  end

  on_intel do
    sha256("4388e7d9c43f7c7d00c4d41389624be5f9dcfe5af94606bb0fdd0b9d20d949be")
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
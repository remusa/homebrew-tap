cask("nuvio-desktop") do
  version("0.1.32-alpha")

  on_arm do
    sha256("0e18a27fce67f0291e2d46d3bfa95e6323cb2c0e83941b9a87193f954aeb61bd")
    url("https://github.com/NuvioMedia/NuvioDesktop/releases/download/#{version}/Nuvio-macOS-arm64-#{version}.dmg")
  end

  on_intel do
    sha256("ce2ebd3367eb3d3ee3079431c4eb8d4ff27fe96a2517fb81cba1a591349c84db")
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
cask("nuvio-desktop") do
  version("0.1.31-alpha")

  on_arm do
    sha256("380c98b78373a01a6701f81bc8c765a92fa33ab5fb8bf4d7395df55a5f2b4e7c")
    url("https://github.com/NuvioMedia/NuvioDesktop/releases/download/#{version}/Nuvio-macOS-arm64-#{version}.dmg")
  end

  on_intel do
    sha256("2f3590ed780aeb1023fe4790abe518f471822e9d250eee0bc3bed73c69ee03ec")
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
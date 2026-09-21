cask("nuvio-desktop") do
  version("0.1.24-alpha")

  on_arm do
    sha256("e847768f5ccc30e51b5f9d6484c737c6017cf0ce1301ecf36a1605a9df422612")
    url("https://github.com/NuvioMedia/NuvioDesktop/releases/download/#{version}/Nuvio-macOS-arm64-#{version}.dmg")
  end

  on_intel do
    sha256("9e9419093d07f68a36668d1513f3850ce2ee05f0b63fd3e6e7cea361b1299500")
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
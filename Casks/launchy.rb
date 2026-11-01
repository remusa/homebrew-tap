cask("launchy") do
  version("2026.9.0")
  sha256("509ebc9bffe4ccee0333eb61e89e2fe4d50b8657746f356b39a4f19f97404d8c")

  url(
    "https://github.com/Punshnut/macos-launchy/releases/download/v#{version}/Launchy.dmg",
    verified: "github.com/Punshnut/macos-launchy/"
  )

  name("Launchy")
  desc("Free open-source Launchpad alternative for macOS")
  homepage("https://github.com/Punshnut/macos-launchy")

  livecheck do
    url("https://api.github.com/repos/Punshnut/macos-launchy/releases/latest")
    strategy(:github_latest)
  end

  app("Launchy.app")
end
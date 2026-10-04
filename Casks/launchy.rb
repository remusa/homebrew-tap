cask("launchy") do
  version("2026.8.0")
  sha256("f84e868ba63e3fa83af5fe607c7eaaea9d39b9d86772e1b18e044105fa7e6b4e")

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
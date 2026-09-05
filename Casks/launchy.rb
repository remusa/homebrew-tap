cask("launchy") do
  version("2026.7.0")
  sha256("85f65c4ba2c181c4b5a74562dba91578496017bb6fda798891f4f514a6544573")

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
cask("mornye") do
  version("5.3.1")

  sha256("c1729bfb7a468b9985254979ee178c6412567d48859cc0cefd1f22a4d6e0a54e")

  url("https://github.com/mornyeapp/Mornye-Desktop/releases/download/v#{version}/Mornye-v#{version}-macos-universal.dmg")

  name("Mornye")
  desc("Desktop music player for your personal library")
  homepage("https://github.com/mornyeapp/Mornye-Desktop")

  livecheck do
    url("https://api.github.com/repos/mornyeapp/Mornye-Desktop/releases/latest")
    strategy(:github_latest)
  end

  app("Mornye.app")
end

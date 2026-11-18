cask("mornye") do
  version("5.4.0")

  sha256("a4f910527f8d25418acb87718e7738b1da4dfc554b073a6f6621b072727076a9")

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

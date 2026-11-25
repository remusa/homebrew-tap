cask("mornye") do
  version("5.4.5")

  sha256("0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5")

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

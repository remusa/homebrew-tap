cask "shiru" do
  version "6.5.2"
  sha256 "0734a17960307c89f5597968600889241b617066f1969963e7b1735155f98592"

  # Updated to match the new "mac-Shiru-v{version}.dmg" format
  url "https://github.com/RockinChaos/Shiru/releases/download/v#{version}/mac-Shiru-v#{version}.dmg"
  name "Shiru"
  desc "Specialized audio/visual tool"
  homepage "https://github.com/RockinChaos/Shiru"

  livecheck do
    url "https://github.com/RockinChaos/Shiru/releases/latest"
    strategy :github_latest
  end

  app "Shiru.app"

  zap trash: [
    "~/Library/Application Support/Shiru",
    "~/Library/Preferences/com.rockinchaos.shiru.plist",
  ]
end
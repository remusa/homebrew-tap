cask "shiru" do
  version "6.5.2"
  sha256 "3f65324e5236ce037db66a76b5c6c4a25565fbeba0f00d0139f02bfabbf3ca51"

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
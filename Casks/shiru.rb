cask "shiru" do
  version "6.5.1"
  sha256 "302a5051ea5ff5ba545e8ad7a224ad31b4ddfcbb26af0e30f05efbcc0faf739e"

  url "https://github.com/RockinChaos/Shiru/releases/download/v#{version}/Shiru-macOS.dmg"
  name "Shiru"
  desc "Specialized audio/visual tool"
  homepage "https://github.com/RockinChaos/Shiru"

  app "Shiru.app"

  zap trash: [
    "~/Library/Application Support/Shiru",
    "~/Library/Preferences/com.rockinchaos.shiru.plist",
  ]
end
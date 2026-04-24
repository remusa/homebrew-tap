cask("openmessage") do
  version("0.2.9")

  sha256("a0f96618f65b4ecbc7bbe005229040fd70ccaa9e760b0b48761d36a6f7bd9ad9")

  url("https://github.com/MaxGhenis/openmessage/releases/download/v#{version}/OpenMessage.dmg")
  name("OpenMessage")
  desc("Signal message identity manager")
  homepage("https://github.com/MaxGhenis/openmessage")

  app("OpenMessage.app")

  zap(trash: ["~/Library/Application Support/OpenMessage"])
end
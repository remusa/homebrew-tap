cask("input-leap") do
  version("3.0.3")

  on_arm do
    sha256("131745b9be83cbee825df6d0975d1da0c13e32ad10e11109c0f4251ac21661f4")
    url("https://github.com/input-leap/input-leap/releases/download/v#{version}/macOS-Apple_Silicon-debug-v#{version}.tar.gz")
    container nested: "macOS-Apple_Silicon-debug/InputLeap-macOS-Apple_Silicon.tar.gz"
  end

  on_intel do
    sha256("32357f64d4890289cb617b5b15386beb26492e407d70ea88ba4053e4b733aef3")
    url("https://github.com/input-leap/input-leap/releases/download/v#{version}/macOS-x86_64-debug-v#{version}.tar.gz")
    container nested: "macOS-x86_64-debug/InputLeap-macOS-x86_64.tar.gz"
  end

  name("Input Leap")
  desc("Open-source KVM software")
  homepage("https://github.com/input-leap/input-leap")

  app("InputLeap.app")

  zap(
    trash: [
      "~/Library/Application Support/InputLeap",
      "~/Library/Preferences/com.input-leap.input-leap.plist",
      "~/Library/Saved Application State/com.input-leap.input-leap.savedState"
    ]
  )
end

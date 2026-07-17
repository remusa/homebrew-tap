cask("pythonscad") do
  version("1.1.2")
  sha256("bcb790891ec005da81c8a7b509fc73eda5609adbda15f9f5d81afe3592d42f29")

  url("https://github.com/pythonscad/pythonscad/releases/download/v#{version}/PythonSCAD-v#{version}.dmg")
  name("PythonSCAD")
  desc("OpenSCAD fork with Python scripting support")
  homepage("https://github.com/pythonscad/pythonscad")

  livecheck do
    url("https://github.com/pythonscad/pythonscad/releases/latest")
    strategy(:github_latest)
  end

  app("PythonSCAD.app")

  zap(
    trash: [
      "~/Library/Application Support/PythonSCAD",
      "~/Library/Preferences/org.pythonscad.pythonscad.plist"
    ]
  )
end

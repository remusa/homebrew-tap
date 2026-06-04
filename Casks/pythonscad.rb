cask("pythonscad") do
  version("1.0.0")
  sha256("f85f57253156ba27320332ae1e70192e7564ef0232561ea1c7cbb74dd21f3fdd")

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

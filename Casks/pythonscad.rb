cask("pythonscad") do
  version("1.1.0")
  sha256("ce825517445d43c7ab7da93f779b3c15287e750e9748cb2bb34f843311bfac13")

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

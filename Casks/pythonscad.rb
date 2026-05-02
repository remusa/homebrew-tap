cask("pythonscad") do
  version("0.20.0")
  sha256("3c251c5e9606e05d0d3c9d027b9a60f5d0cf54510a585ad45974530911ff2b47")

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

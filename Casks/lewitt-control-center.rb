cask("lewitt-control-center") do
  version("5.2.2")
  sha256("16442bfae3513e7c7edd95103afc5097c1155b03442a6b649b11ca32479616ad")
  url("https://www.lewitt-audio.com/software/cc3-mac/latest")

  name("LEWITT CONTROL CENTER")
  desc("Control software for LEWITT CONNECT 2 audio interface")
  homepage("https://www.lewitt-audio.com/support/online-guides/connect2")

  pkg("lewitt_control_center_installer_6.pkg")

  uninstall(
    pkgutil: [
      "com.Lewitt-audio.pkg.LewittInstaller",
      "com.Lewitt-audio.pkg.Misc"
    ],
    delete: "/Applications/LEWITT CONTROL CENTER.app"
  )

  zap(
    trash: [
      "~/Library/Caches/com.LewittGmbH.LEWITTCONTROLCENTER",
      "~/Library/Preferences/com.LewittGmbH.LEWITTCONTROLCENTER.plist"
    ]
  )
end

cask("futo-notes") do
  version("1.6.1")
  sha256("df4adc98027751f36e4de093718046556e67c247859158f9eb4a38da643d3c29")

  url("https://gitlab.futo.org/api/v4/projects/488/packages/generic/futo-notes/#{version}/FUTO-Notes-#{version}-universal.dmg",
      verified: "gitlab.futo.org")
  name("FUTO Notes")
  desc("Notes, but smart")
  homepage("https://gitlab.futo.org/futo-notes/futo-notes")

  app("FUTO Notes.app")

  zap(
    trash: [
      "~/Library/Application Support/FUTO Notes",
      "~/Library/Caches/FUTO Notes",
      "~/Library/Preferences/org.futo.notes.plist",
      "~/Library/WebKit/org.futo.notes"
    ]
  )
end

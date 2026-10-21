cask("futo-notes") do
  version("1.9.0")
  sha256("102993be49b966808aa1bcf1cd1743c36f33c399b77577e72839df172f66db51")

  url("https://gitlab.futo.org/api/v4/projects/488/packages/generic/futo-notes/v#{version}/FUTO-Notes-#{version}-universal.dmg",
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

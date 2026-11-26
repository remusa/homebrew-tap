cask("futo-notes") do
  version("2.0.1")
  sha256("66760213a2133ea08ad4fe4b3694801096d68c726b619d782c3b9cceddc722cf")

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

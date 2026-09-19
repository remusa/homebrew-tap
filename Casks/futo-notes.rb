cask("futo-notes") do
  version("1.8.0")
  sha256("8667978f261b591020e6b515acb327f988b5c512ddd10cadd5efdb802c900bc9")

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

cask("futo-notes") do
  version("1.9.3")
  sha256("0dafb2c89cc55d272ba3c19f7a605f98537d17774d941b162da5893155dcef79")

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

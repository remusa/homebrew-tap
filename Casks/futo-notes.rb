cask("futo-notes") do
  version("1.6.1")
  sha256("9491d4737000e80bcbdd7a39e9dc13c2178ff865beff7d800d6159bfc395e8fa")

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

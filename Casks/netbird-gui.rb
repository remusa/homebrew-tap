# NetBird GUI, vendored from netbirdio/tap/netbird-ui (0.81.3).
#
# WHY THIS EXISTS (2026-10-22). The upstream cask manages a **root-owned
# LaunchDaemon**, through sudo in two places:
#   postflight_steps            -> "Netbird UI.app/installer.sh" (netbird service install + start)
#   uninstall_preflight_steps   -> launchctl bootout system/netbird + rm the plist
# Both need sudo **with a TTY**, which means:
#   * the repo's daily brew-upgrade agent could never upgrade it (it had to be
#     denylisted in modules/darwin/brew-upgrade.nix), and
#   * every attempted upgrade could leave the Mac half-converted. Observed in full:
#     the plist rewritten with RunAtLoad false, the daemon job GONE, an explicit
#     "netbird => enabled" launchctl override added, and /Applications/Netbird UI.app
#     gutted to a single uninstaller.sh.
#
# This cask ships ONLY the GUI. The LaunchDaemon is declared in nix-darwin
# (modules/darwin/netbird.nix -> launchd.daemons.netbird), so:
#   * RunAtLoad cannot be reset behind our back,
#   * no sudo is needed to install or upgrade the GUI,
#   * `brew upgrade` (and the daily agent) can move it like any other cask.
#
# The token is `netbird-gui`, NOT `netbird-ui`, on purpose: the upstream tap still
# defines `netbird-ui` and two taps providing the same token is ambiguous. The app
# still installs as /Applications/Netbird UI.app because the artifact keeps its
# target name.
#
# Bumping: change version + both sha256s from the upstream release assets.
# `brew livecheck --cask remusa/tap/netbird-gui` reports what upstream has.
cask "netbird-gui" do
  version "0.82.0"

  if Hardware::CPU.intel?
    url "https://github.com/netbirdio/netbird/releases/download/v0.81.3/netbird-ui_0.81.3_darwin_amd64_signed.zip"
    sha256 "0ac46b7e2d1d6b0ec987212ed8b3bcde23976f2efb5539ac1ebc0d8052ecee06"
  else
    url "https://github.com/netbirdio/netbird/releases/download/v0.81.3/netbird-ui_0.81.3_darwin_arm64_signed.zip"
    sha256 "690a266cfb15367973707f0616f0d1a9691ce026cd346ad4e4225e680e9a99a1"
  end

  name "Netbird GUI"
  desc "Netbird UI client (GUI only; the daemon is managed by nix-darwin)"
  homepage "https://www.netbird.io/"

  livecheck do
    url "https://github.com/netbirdio/netbird/releases/latest"
    strategy :github_latest
  end

  # The daemon binary comes from the formula, and modules/darwin/homebrew.nix
  # declares it in `brews` for exactly that reason. Keep the two in step: the CLI
  # and the GUI version independently otherwise.
  depends_on formula: "netbird"

  app "netbird_ui_darwin", target: "Netbird UI.app"

  # DELIBERATELY ABSENT -- do not add these back:
  #   postflight_steps          (installer.sh: installs and starts the LaunchDaemon)
  #   uninstall_preflight_steps (sudo launchctl bootout + rm of the plist)
  # They are the sudo/TTY dependency this cask exists to avoid. The daemon's
  # lifecycle is nix-darwin's job now; see the header.
end

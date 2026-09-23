# heimdall-graftd — prebuilt graftd for Heimdall's graft backend.
#
# WHY a cask and not a formula: graftd has no upstream release and no npm
# binary. Heimdall ships it as graft source (`vendor/graft/`, a git subtree of
# a local fork of NanoNets/Graft) and compiles it on first `heimdall setup` —
# which fetches and statically links llama.cpp over the network. Building it
# once here and hosting the tarball in this tap's releases (same pattern as
# `thaw`) makes `heimdall setup` work on a machine that has no toolchain.
#
# Bump policy:
#   * version tracks the HEIMDALL version the binary was built from (the
#     vendored graft fork `v0.1.0-heimdall.2` lands with heimdall 0.12.4).
#   * To bump: unpack the new `@arihantdeva/heimdall` npm tarball, build
#     `vendor/graft` (llama.cpp tag is pinned in its CMakeLists), tar
#     `graftd` + `NOTICE.md` + `licenses/`, compare the `--help` output on a
#     host running the matching model/config, upload to a
#     `heimdall-graftd-<version>` release, then update version/sha256 here.
#   * Do NOT add a matrix entry in .github/workflows/update-casks.yml: the
#     artifact is self-hosted, so a version bump needs a rebuild, not a
#     download. Same reason `thaw` is absent from the matrix.
#
# Provenance, build command and bundled third-party licenses (llama.cpp,
# BLAKE3, mpack, sqlite-vec, Graft) travel inside the tarball as NOTICE.md.
cask "heimdall-graftd" do
  version "0.12.4"
  sha256 "c41d493c4c4b6eb44a48ced94e3e7f3993f07cd023f63bbad036212edc3bdeb9"

  url "https://github.com/remusa/homebrew-tap/releases/download/heimdall-graftd-#{version}/graftd-darwin-arm64.tar.gz"
  name "heimdall-graftd"
  desc "Prebuilt graftd retrieval daemon for Heimdall's graft backend"
  homepage "https://github.com/ArihantDeva/heimdall"

  # arm64-only: the tarball is a Mach-O arm64 build (no universal binary).
  # libyaml is the one non-system dylib graftd links against.
  depends_on arch: :arm64
  depends_on formula: "libyaml"

  binary "graftd"

  postflight do
    # Unsigned ad-hoc-signed build fetched over the network — drop the
    # quarantine flag so Gatekeeper does not block the daemon on first run.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{staged_path}/graftd"],
                   sudo: false
  end

  caveats <<~EOS
    graftd is only half of Heimdall's retrieval stack. The CLI itself is an
    npm package, and the Python bridge for symbol/graph depth needs its own
    venv:

      npm i -g @arihantdeva/heimdall @nanonets/graft
      heimdall setup --graftd #{HOMEBREW_PREFIX}/bin/graftd

    `heimdall setup` writes ~/.graft/config.yaml (model, threads, accel) and
    installs its launchd agent. It still needs an embedding model at
    ~/.graft/models/bge-m3.gguf — heimdall 0.12.4's model catalog has stale
    byte sizes and refuses the download, so fetch the GGUF manually if setup
    complains. See docs/heimdall.md in the nix-config repo.
  EOS
end

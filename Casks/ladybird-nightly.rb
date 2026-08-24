cask 'ladybird-nightly' do
  version :latest
  sha256 :no_check # unsigned nightly builds; content changes every release

  url 'https://github.com/remusa/ladybird-builds/releases/latest/download/Ladybird-macos-arm64.zip'
  name 'Ladybird (nightly, unofficial)'
  desc 'Unofficial nightly arm64 build of the Ladybird browser'
  homepage 'https://ladybird.org'

  depends_on arch: :arm64
  depends_on macos: '>= :sonoma'

  app 'Ladybird.app'

  postflight do
    # Builds aren't notarized/signed, so strip the quarantine flag on install.
    system_command '/usr/bin/xattr',
                   args: ['-dr', 'com.apple.quarantine', "#{appdir}/Ladybird.app"],
                   sudo: false
    # ditto resolves symlinks when extracting, but dyld needs versioned
    # library links (e.g. libfoo.0.dylib -> libfoo.0.1.0.dylib).
    lib = "#{appdir}/Ladybird.app/Contents/lib"
    Dir.glob("#{lib}/*.[0-9]*.[0-9]*.dylib").each do |real|
      base = File.basename(real, '.dylib')
      name_major = base.sub(/([^.]*\.[0-9]+)\..+$/, '\1')
      short = "#{lib}/#{name_major}.dylib"
      next if File.exist?(short)
      FileUtils.ln_s(File.basename(real), short)
    end
  end

  caveats <<~EOS
    This is an unofficial, unsigned nightly build of Ladybird, built from
    source in CI. It is pre-alpha software — expect crashes and missing
    features. See:
      https://github.com/remusa/ladybird-builds
  EOS
end

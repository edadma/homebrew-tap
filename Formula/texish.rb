# Homebrew formula for the texish command-line tool.
#
# This is a template: `tools/brew-formula.sh <version>` fills in the version and the four SHA256
# fields from the assets the "Release binaries" workflow attaches, and the release workflow runs it
# and pushes the result to Formula/texish.rb in the edadma/homebrew-tap repository. See README.md in
# this directory.
#
# The formula installs a prebuilt binary rather than building from source, because building means
# a JDK, sbt, Scala Native's LLVM toolchain and a full compile — a lot to ask of a package that
# ships as one static-ish executable. Cairo, FreeType and libjpeg-turbo remain runtime dependencies
# because the binary links against them.

class Texish < Formula
  desc "TeX-style typesetting engine that renders documents to PDF"
  homepage "https://texish.edadma.dev"
  version "0.31.2"
  license "ISC"

  depends_on "cairo"
  depends_on "freetype"
  depends_on "jpeg-turbo"

  on_macos do
    on_arm do
      url "https://github.com/edadma/texish/releases/download/v#{version}/texish-#{version}-macos-arm64"
      sha256 "79d52755c2c2129fff1bfa5032c518e93c23b8c480dd69b33bbcb5231f854156"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/edadma/texish/releases/download/v#{version}/texish-#{version}-linux-x86_64"
      sha256 "d55d34afa515db82c2e3848a3dc7a0b0e15f84aa29b6272bf602822fd7cfbc0b"
    end
    on_arm do
      url "https://github.com/edadma/texish/releases/download/v#{version}/texish-#{version}-linux-arm64"
      sha256 "9035bee8b1cb164db7e948dac26c0f77c9f37ea2a37bb568c332a8569931942b"
    end
  end

  # The font catalogue and the packages, identical on every platform. Without it texish still
  # renders an ordinary document from its compiled-in core; with it, the complex scripts, the CJK
  # cuts and every package beyond base and document work too.
  #
  # The version is written out rather than interpolated: inside a resource block `version` is the
  # *resource's* own version (Resource#version), not the formula's, and it is nil while the block is
  # being evaluated — so `#{version}` here would silently produce `.../download/v/texish--share.tar.gz`.
  resource "share" do
    url "https://github.com/edadma/texish/releases/download/v0.31.2/texish-0.31.2-share.tar.gz"
    sha256 "e598598fb7a4213d996156b18344964bb2ccda2cd57cb52bc6c6d8677f092649"
  end

  def install
    bin.install Dir["texish-*"].first => "texish"

    resource("share").stage do
      # The archive holds share/texish/{fonts,packages}. Homebrew descends into a staged archive's
      # sole top-level directory, so the tree is reached as texish/ — but match both shapes rather
      # than depend on that.
      (share/"texish").install Pathname.glob("{,share/}texish").first.children
    end
  end

  # texish locates its own executable and looks upward for share/texish, so it finds the tree
  # through the Cellar path as well as through the prefix's link farm — no wrapper, no environment
  # variable. This test would fail if the resource landed anywhere else: usfm is not compiled in.
  test do
    (testpath/"probe.texish").write <<~EOS
      \\use{usfm}
      Hello from {\\font hebrew 12 regular שלום}.
    EOS

    system bin/"texish", testpath/"probe.texish"
    assert_path_exists testpath/"probe.pdf"
  end
end

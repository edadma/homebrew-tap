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
  version "0.31.0"
  license "ISC"

  depends_on "cairo"
  depends_on "freetype"
  depends_on "jpeg-turbo"

  on_macos do
    on_arm do
      url "https://github.com/edadma/texish/releases/download/v#{version}/texish-#{version}-macos-arm64"
      sha256 "5826f44a1749c4f43ad3bc8d5b3b94c14d92249efe99507bdfb71d19e18ee280"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/edadma/texish/releases/download/v#{version}/texish-#{version}-linux-x86_64"
      sha256 "37500c0ad5be9447b54e419874fc06d37bc1a0dabb90ac0c276504e03748dca9"
    end
    on_arm do
      url "https://github.com/edadma/texish/releases/download/v#{version}/texish-#{version}-linux-arm64"
      sha256 "ed0c672ee4a2df88e71e5390ab74edb9a7fea0b78c8148e8dbe5095c09f1ddf1"
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
    url "https://github.com/edadma/texish/releases/download/v0.31.0/texish-0.31.0-share.tar.gz"
    sha256 "f478b8de30276cc410f9b3804d04959e7c38c832ee0f0d17f23e7df78e03088e"
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

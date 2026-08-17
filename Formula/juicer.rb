# Homebrew formula for juicer.
#
# This is a template: `tools/brew-formula.sh <version>` fills in the version and the three SHA256
# fields from the binaries the "Release binaries" workflow attaches, and the release workflow runs it
# and pushes the result to Formula/juicer.rb in the edadma/homebrew-tap repository. See README.md in
# this directory.
#
# The formula installs a prebuilt binary rather than building from source, because building means a
# JDK, sbt and Scala Native's LLVM toolchain for what ships as one executable.

class Juicer < Formula
  desc "Small, cross-platform static site generator for Scala 3"
  homepage "https://github.com/edadma/juicer"
  version "0.3.0"
  license "ISC"

  # libuv is linked into the binary; sass and esbuild are shelled out to by the asset pipeline, and
  # are deliberately not vendored so a site gets the current versions of both (see
  # AssetBuilderBackend.scala). A site with no SCSS and no JS to bundle never invokes them.
  depends_on "libuv"
  depends_on "esbuild"
  depends_on "sass"

  on_macos do
    on_arm do
      url "https://github.com/edadma/juicer/releases/download/v#{version}/juicer-#{version}-macos-arm64"
      sha256 "e7f2dde2bdb01dc15054e61995aaccc985ede5aaf2243f0bc0983da4e338c172"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/edadma/juicer/releases/download/v#{version}/juicer-#{version}-linux-x86_64"
      sha256 "fbd80297120b06ed4fd76021dc0717c5f96fe4751d313c5e375ca84bbc870526"
    end
    on_arm do
      url "https://github.com/edadma/juicer/releases/download/v#{version}/juicer-#{version}-linux-arm64"
      sha256 "085e6a4d23cf15bcc803775ca4d6c9fbd03f6060609d026aedaac8312d3ebd47"
    end
  end

  def install
    bin.install Dir["juicer-*"].first => "juicer"
  end

  # Build the smallest site that is still a site — a config, one markdown page, and the one layout
  # that renders a section index — and check the markdown came through the template. That exercises
  # the whole path the tool exists for: read the tree, parse the frontmatter, render markdown, apply
  # a squiggly template, write the file.
  test do
    (testpath/"site.toml").write "title = \"probe\"\n"

    (testpath/"content").mkpath
    (testpath/"content/_index.md").write <<~EOS
      ---
      title: Home
      ---

      Hello from juicer.
    EOS

    (testpath/"layouts/_default").mkpath
    (testpath/"layouts/_default/folder.html").write "<html><body>{{ .content }}</body></html>\n"

    system bin/"juicer", "build", "-s", testpath, "-d", testpath/"out"
    assert_match "Hello from juicer", (testpath/"out/index.html").read
  end
end

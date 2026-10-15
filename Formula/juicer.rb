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
  version "0.4.7"
  license "ISC"

  # libuv is linked into the binary and is the only thing it needs.
  #
  # The asset pipeline's `sass` and `esbuild` are NOT dependencies, even though the pipeline shells
  # out to them: what this formula ships is the Scala Native binary, and on Native
  # newAssetBuilderBackend() is AssetBuilderBackend.Unavailable, so neither tool is ever invoked
  # (SCSS and JS entries degrade to verbatim copies). Depending on them would install two tools the
  # binary cannot use — and `sass` is not a core formula, so it would drag the untrusted sass/sass
  # and dart-lang/dart taps and a Dart SDK build into every `brew install juicer`. If the pipeline
  # is ever promoted to Native, `depends_on "dart-sass"` is the core formula that provides `sass`.
  depends_on "libuv"

  on_macos do
    on_arm do
      url "https://github.com/edadma/juicer/releases/download/v#{version}/juicer-#{version}-macos-arm64"
      sha256 "436d4bb3017d62d7ca1fd2edad270619eb92f5c04b1aa387f904387744a475e2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/edadma/juicer/releases/download/v#{version}/juicer-#{version}-linux-x86_64"
      sha256 "74871179554906f6a3f50bc5935b66c5db91ecbb023faa106082da284002537f"
    end
    on_arm do
      url "https://github.com/edadma/juicer/releases/download/v#{version}/juicer-#{version}-linux-arm64"
      sha256 "541800b863180727acc9b2dfbb12633e18206eb38d92f29fb7f64ca0920efec1"
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

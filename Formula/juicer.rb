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
  version "0.4.3"
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
      sha256 "358498e05bd02e584fed5645f1588fbf312249b04575b06e78ffc55842d19555"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/edadma/juicer/releases/download/v#{version}/juicer-#{version}-linux-x86_64"
      sha256 "fe89508124f487236618bebb765d3bb1bc3a33a22ac6791768b00fb63eb0705e"
    end
    on_arm do
      url "https://github.com/edadma/juicer/releases/download/v#{version}/juicer-#{version}-linux-arm64"
      sha256 "982b2aee476b609980510f8ece0f4f2b80a46bb98ccf6795fc6936533817f389"
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

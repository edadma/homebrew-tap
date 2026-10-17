# Homebrew formula for FunL: one backtracking VM running FunL, regular expressions and ISO Prolog.
#
# The formula installs the prebuilt macOS binaries rather than building from source, because
# building needs the sysl compiler. The tarball holds one executable, `funl`, and the formula links
# it as `fprolog`, under which name it is the standalone standard-Prolog top level. It links
# only against libraries macOS ships (libSystem, libcurl, libsqlite3, libobjc), except for
# Homebrew's libuv for `funl:async` and SDL3 for `funl:graphics`' windows, hence the two
# dependencies.

class Funl < Formula
  desc "FunL language, regex engine and ISO Prolog on one backtracking machine"
  homepage "https://github.com/edadma/funl"
  version "0.0.11"
  license "ISC"

  depends_on "libuv"
  depends_on "sdl3"

  on_macos do
    on_arm do
      url "https://github.com/edadma/funl/releases/download/v#{version}/funl-#{version}-macos-arm64.tar.gz"
      sha256 "3df553c33e1c29d72fff0b10af26c77711cc3b1d7bd6c68240388c0bf6b9ec2d"
    end
  end

  def install
    bin.install "funl"
    bin.install_symlink "funl" => "fprolog"
  end

  test do
    (testpath/"probe.funl").write "write( 6 * 7 )\n"
    assert_match "42", shell_output("#{bin}/funl #{testpath}/probe.funl")

    assert_match "X = 42.", pipe_output("#{bin}/fprolog", "X is 6 * 7.\n")
  end
end

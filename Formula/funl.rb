# Homebrew formula for FunL: one backtracking VM running FunL, regular expressions and ISO Prolog.
#
# The formula installs the prebuilt macOS binaries rather than building from source, because
# building needs the sysl compiler. The tarball holds both executables, `funl` and `prolog`; each
# links only against libraries macOS ships (libSystem, libcurl, libsqlite3, libobjc), except that
# `funl` also links Homebrew's libuv for `funl:async` and SDL3 for `funl:graphics`' windows, hence
# the two dependencies.

class Funl < Formula
  desc "FunL language, regex engine and ISO Prolog on one backtracking machine"
  homepage "https://github.com/edadma/funl"
  version "0.0.8"
  license "ISC"

  depends_on "libuv"
  depends_on "sdl3"

  on_macos do
    on_arm do
      url "https://github.com/edadma/funl/releases/download/v#{version}/funl-#{version}-macos-arm64.tar.gz"
      sha256 "c8a737b379f16dcf36ee23b18edb5600bc4796ab442dbb4c0a380d2d3acdd92c"
    end
  end

  def install
    bin.install "funl", "prolog"
  end

  test do
    (testpath/"probe.funl").write "write( 6 * 7 )\n"
    assert_match "42", shell_output("#{bin}/funl #{testpath}/probe.funl")

    assert_match "X = 42.", pipe_output("#{bin}/prolog", "X is 6 * 7.\n")
  end
end

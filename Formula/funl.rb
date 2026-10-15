# Homebrew formula for FunL: one backtracking VM running FunL, regular expressions and ISO Prolog.
#
# The formula installs the prebuilt macOS binaries rather than building from source, because
# building needs the sysl compiler. The tarball holds both executables, `funl` and `prolog`; each
# links only against libraries macOS ships (libSystem, libcurl, libsqlite3), except that `funl`
# also links Homebrew's libuv for `funl:async`, hence the one dependency.

class Funl < Formula
  desc "FunL language, regex engine and ISO Prolog on one backtracking machine"
  homepage "https://github.com/edadma/funl"
  version "0.0.7"
  license "ISC"

  depends_on "libuv"

  on_macos do
    on_arm do
      url "https://github.com/edadma/funl/releases/download/v#{version}/funl-#{version}-macos-arm64.tar.gz"
      sha256 "e793cf523b69677abcb48fc33c267f8f34263b0a53eab946528618a011014a40"
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

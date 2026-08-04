class Sysl < Formula
  desc "Ref-counted systems language that compiles through LLVM"
  homepage "https://sysl.sh/"
  version "0.0.1"
  license "ISC"

  # Apple silicon only for 0.0.1 -- this is what the author's machine can build.
  # A Linux binary needs a build runner and is not here yet; every other platform
  # builds from source, which is a clone and one sbt invocation.
  on_macos do
    on_arm do
      url "https://github.com/edadma/sysl/releases/download/v#{version}/sysl-#{version}-darwin-arm64.tar.gz"
      sha256 "f40ea6d8bf5d470e8a2184a0cda469a848637c3d1b8cbd754ce8a5a0f8bfe8e6"
    end
  end

  # A *runtime* dependency rather than a build one. sysl emits textual LLVM IR and
  # shells out from there: clang assembles and links it, and llvm-ar is what builds
  # a library into a .syslib. Apple's command-line tools ship a clang but no
  # llvm-ar, which is why this cannot be left to whatever is already on the machine
  # -- and why Toolchain.arCandidates already looks in /opt/homebrew/opt/llvm/bin.
  depends_on "llvm"

  def install
    bin.install "sysl"
  end

  test do
    assert_match "sysl #{version}", shell_output("#{bin}/sysl --version")

    (testpath/"hello.sysl").write <<~SYSL
      print("Hello, sysl!")
      print(6 * 7)
    SYSL

    # Deliberately more than a smoke test of the binary starting. This drives the
    # whole toolchain: it builds the standard-module artifact into the cache on
    # first use, emits IR, and hands it to clang to assemble and link -- so it
    # fails if the llvm dependency is not actually reachable at runtime, which is
    # the one thing about this formula that could be wrong and still install.
    #
    # assert_equal rather than assert_match, so this pins the *whole* of stdout
    # rather than passing on the text appearing somewhere in it. And 42 is
    # computed by the compiled program rather than echoed, so a back end that
    # got arithmetic wrong fails here instead of printing a greeting and passing.
    # The artifact-build notice goes to stderr and so is not part of this.
    assert_equal "Hello, sysl!\n42\n", shell_output("#{bin}/sysl run #{testpath}/hello.sysl")
  end
end

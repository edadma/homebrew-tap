cask "asteroids" do
  version "0.0.2"
  sha256 "1891699a669ab9aa3a1604470c20e59f1df778fee3ddeb6f306de8376d3ed928"

  url "https://github.com/edadma/asteroids/releases/download/v#{version}/Asteroids-#{version}-arm64.zip"
  name "Asteroids"
  desc "Retro vector Asteroids game (Scala Native + suit)"
  homepage "https://github.com/edadma/asteroids"

  depends_on arch: :arm64
  depends_on formula: "sdl3"
  depends_on formula: "cairo"
  depends_on formula: "freetype"

  app "Asteroids.app"
  binary "Asteroids.app/Contents/MacOS/asteroids"
end

cask "asteroids" do
  version "0.0.1"
  sha256 "1f332762c488c838316bb5a11f970470340107886dd281c5957838e31555e409"

  url "https://github.com/edadma/asteroids/releases/download/v#{version}/asteroids-#{version}-arm64.tar.gz"
  name "Asteroids"
  desc "Retro vector Asteroids game (Scala Native + suit)"
  homepage "https://github.com/edadma/asteroids"

  depends_on arch: :arm64
  depends_on formula: "sdl3"
  depends_on formula: "cairo"
  depends_on formula: "freetype"

  binary "asteroids"
end

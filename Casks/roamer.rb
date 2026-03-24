cask "roamer" do
  version "0.0.21"
  sha256 "84bccfc6fa40bddb03fe01fb62d53e9d64a47f24c0ce16ea50f6c8d3f3dc1b2f"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
  binary "Roamer.app/Contents/Resources/bin/roamer"
end

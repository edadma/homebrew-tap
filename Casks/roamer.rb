cask "roamer" do
  version "0.0.9"
  sha256 "cc9a3c15d4969fdfec5cc931b347017002c69165ca52f05d09f1016c119a3e4d"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
end

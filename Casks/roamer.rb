cask "roamer" do
  version "0.0.12"
  sha256 "256671daefc7121db4e0d870977f23908c6aaf12ece3cde4ba4c2657bac44f0f"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
  binary "Roamer.app/Contents/Resources/bin/roamer"
end

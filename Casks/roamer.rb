cask "roamer" do
  version "0.0.3"
  sha256 "9fcd6b5dd10849430a45808b23017afc0a707be8d55bf55e67dbb9ef6ed1091f"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
end

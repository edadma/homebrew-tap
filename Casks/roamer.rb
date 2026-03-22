cask "roamer" do
  version "0.0.18"
  sha256 "fbf7aa4f7264dc4e32708c5737c58934b471323d44b901ea65e9ce9490dc364f"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
  binary "Roamer.app/Contents/Resources/bin/roamer"
end

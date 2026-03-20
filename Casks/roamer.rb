cask "roamer" do
  version "0.0.11"
  sha256 "e00caeb47907ae15b440d0643debb1f2353a910fbac990d9448319203a6cda44"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
  binary "Roamer.app/Contents/Resources/bin/roamer"
end

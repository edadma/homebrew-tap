cask "roamer" do
  version "0.0.15"
  sha256 "b40090bd94272481fb00c2cc45a06a8f706d572bc72d755e83a301d1adfb6a62"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
  binary "Roamer.app/Contents/Resources/bin/roamer"
end

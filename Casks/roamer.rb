cask "roamer" do
  version "0.0.8"
  sha256 "d27f98a4ff76ac4f70bbc2d356c52dd5f04c51747be7feab2f63cd379c676636"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
end

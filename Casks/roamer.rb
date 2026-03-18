cask "roamer" do
  version "0.0.1"
  sha256 "a379474a9b4435dc89db8c88b00a4b330251143362f9e4d5d4efbdea2fbcad3b"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
end

cask "roamer" do
  version "0.0.5"
  sha256 "a1e6878377b203960200b3a7a1a09777b083f807be15a777efc31ee71e435890"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
end

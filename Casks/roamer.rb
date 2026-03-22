cask "roamer" do
  version "0.0.19"
  sha256 "71cbca83c2a0ea37b26603f9d7e0e5199ad6f097cfed6d84f3fc5c88ae44aacc"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
  binary "Roamer.app/Contents/Resources/bin/roamer"
end

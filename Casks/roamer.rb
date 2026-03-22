cask "roamer" do
  version "0.0.20"
  sha256 "6686b7e0d5f36a272cded9a36a60d04fab867538fd9509ac4fe907836d24ce91"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
  binary "Roamer.app/Contents/Resources/bin/roamer"
end

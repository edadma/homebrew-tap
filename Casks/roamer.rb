cask "roamer" do
  version "0.0.14"
  sha256 "b2445d5e47682a4bb46a1644a78db80e720ccb10d4714ebdc5acb747d2b4a76c"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
  binary "Roamer.app/Contents/Resources/bin/roamer"
end

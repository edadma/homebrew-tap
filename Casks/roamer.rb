cask "roamer" do
  version "0.0.13"
  sha256 "2d15ec845ae8f2ee3e5e382a232daf975b245b88cbe6ceb0ab1a01b706381dfa"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
  binary "Roamer.app/Contents/Resources/bin/roamer"
end

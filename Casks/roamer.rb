cask "roamer" do
  version "0.0.6"
  sha256 "b3f8d92bcea3f87e03bf9a2320169b5b0a29c917e2ebdb505ae4ff797f680ce4"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
end

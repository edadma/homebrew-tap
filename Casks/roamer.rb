cask "roamer" do
  version "0.0.7"
  sha256 "7ea8ed4626e55a4213e3482868dd135922a799ded21b81c0afb76ab88dfcea8e"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
end

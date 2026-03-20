cask "roamer" do
  version "0.0.10"
  sha256 "e6d5970b29409ab6447eca39d25696d15cd7655e86c7e48dca0a0a59174064cc"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
  binary "Roamer.app/Contents/Resources/bin/roamer"
end

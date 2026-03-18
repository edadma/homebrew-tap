cask "roamer" do
  version "0.0.2"
  sha256 "fdb22938096eeb812b34465b414ad6f23ec256fa64f9d1f104eb8817093b0d94"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
end

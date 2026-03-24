cask "caldera" do
  version "0.0.1"
  sha256 "3fbf2213d2a0e190cff8e1e37e8e3c6ffa0912f96b325a5367ab0727092f779e"

  url "https://github.com/edadma/caldera/releases/download/v#{version}/Caldera-#{version}-arm64.dmg"
  name "Caldera"
  desc "Native macOS GUI for Colima"
  homepage "https://github.com/edadma/caldera"

  app "Caldera.app"
end

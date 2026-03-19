cask "roamer" do
  version "0.0.4"
  sha256 "bb37269352c106e1027487eae0b8ba96bf9953686769cf5806491218be1a5db4"

  url "https://github.com/edadma/roamer/releases/download/v#{version}/Roamer-#{version}-arm64.dmg"
  name "Roamer"
  desc "Cross-platform file explorer with an integrated terminal"
  homepage "https://github.com/edadma/roamer"

  app "Roamer.app"
end

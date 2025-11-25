cask "rainaissance" do
  version "2.0.1"
  sha256 "ec80e5aa7f4b26a6716b2487b5edcfd3ad9dc0fc5d1f9a7b958b13a2dbdd4ee3"

  url "https://github.com/freepicheep/rainaissance-releases/releases/download/v#{version}/Rainaissance.#{version}.dmg"
  name "Rainaissance"
  desc "Customizable rain and snow on your mac. Works everywhere."
  homepage "https://rainaissance.app"

  app "Rainaissance.app"

  zap trash: [
    "~/Library/Preferences/com.freepicheep.rainaissance.plist",
    "~/Library/Application Support/Rainaissance",
  ]
end

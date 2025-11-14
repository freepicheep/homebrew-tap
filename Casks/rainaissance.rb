cask "rainaissance" do
  version "1.2.1"
  sha256 "20aba2c892e371ebaa23653d9f953547578e3563fba25806e79bebd846810aa0"

  url "https://github.com/freepicheep/rainaissance-releases/releases/download/v#{version}/Rainaissance.#{version}.dmg"
  name "Rainaissance"
  desc "Customizable rain on your mac with glorious splashes"
  homepage "https://rainaissance.app"

  app "Rainaissance.app"

  zap trash: [
    "~/Library/Preferences/com.freepicheep.rainaissance.plist",
    "~/Library/Application Support/Rainaissance",
  ]
end

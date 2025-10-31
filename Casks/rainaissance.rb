cask "rainaissance" do
  version "1.1.7"
  sha256 "9e71659384b46ac266b5571ddc005483fd2e8355bfbcf37b9a24d37446bc37db"

  url "https://github.com/freepicheep/rainaissance-releases/releases/download/v.#{version}/Rainaissance.#{version}.dmg"
  name "Rainaissance"
  desc "Customizable rain on your mac with glorious splashes"
  homepage "https://rainaissance.app"

  app "Rainaissance.app"

  zap trash: [
    "~/Library/Preferences/com.freepicheep.rainaissance.plist",
    "~/Library/Application Support/Rainaissance",
  ]
end

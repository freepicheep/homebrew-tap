cask "rainaissance" do
  version "1.1.4"
  sha256 "e08b23790bb216b17856a615bfa55559492ff801ac54a5761ccc1fbd653c0127"

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

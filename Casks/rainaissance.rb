cask "rainaissance" do
  version "1.1.5"
  sha256 "6e016af457523b4ff0ae8f2b2220d1a2d1bc9a8524c8fbcfe606892e116c0149"

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

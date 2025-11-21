cask "rainaissance" do
  version "2.0.0"
  sha256 "55e2b00c88753ad2f48c656b28f48066cfa49f84411dbf7184c592c2773ae272"

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

cask "rainaissance" do
  version "2.2.0"
  sha256 "162d6470469c2e5ca2652ac77f9dea6aa5b64c08ebeb0ace5f826b588b3a53f1"

  url "https://github.com/freepicheep/rainaissance-releases/releases/download/v#{version}/Rainaissance.#{version}.dmg",
      verified: "github.com/freepicheep/rainaissance-releases/"
  name "Rainaissance"
  desc "Customizable rain and snow on your mac"
  homepage "https://rainaissance.app"

  depends_on macos: ">= :sonoma"

  app "Rainaissance.app"

  zap trash: [
    "~/Library/Caches/com.freepicheep.Rainaissance",
    "~/Library/Containers/com.freepicheep.Rainaissance",
    "~/Library/Preferences/com.freepicheep.Rainaissance.plist",
  ]
end

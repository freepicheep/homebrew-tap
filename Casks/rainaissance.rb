cask "rainaissance" do
  version "1.1.4"
  sha256 "62807c37584798fc8f1a296a13fe3bcdf2ab82db2c2d8b657bdb2683d953cf58"

  url "https://github.com/freepicheep/rainaissance-releases/archive/refs/tags/v#{version}.tar.gz"
  name "Rainaissance"
  desc "Customizable rain on your mac with glorious splashes"
  homepage "https://rainaissance.app"

  app "Rainaissance.app"

  zap trash: [
    "~/Library/Preferences/com.freepicheep.rainaissance.plist",
    "~/Library/Application Support/Rainaissance",
  ]
end

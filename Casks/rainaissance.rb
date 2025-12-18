cask "rainaissance" do
  version "2.1.0"
  sha256 "33a7b06df18ce200e3f21041643ffb988ac0e8a27ec0ea26d11eaedd6927f161"

  url "https://github.com/freepicheep/rainaissance-releases/releases/download/v#{version}/Rainaissance.#{version}.dmg"
  name "Rainaissance"
  desc "Customizable rain and snow on your mac. Works everywhere."
  homepage "https://rainaissance.app"

  app "Rainaissance.app"

  zap trash: [
    "~/Library/Caches/com.freepicheep.Rainaissance",
    "~/Library/Containers/com.freepicheep.Rainaissance"
  ]
end

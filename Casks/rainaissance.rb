cask "rainaissance" do
  version "2.1.1"
  sha256 "6cb1cfef63d02843bda1a8932e08dd56a6a2353ec507e8da0e5d5073897c818c"

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

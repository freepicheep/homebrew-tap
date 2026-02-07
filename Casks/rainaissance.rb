cask "rainaissance" do
  version "2.2.2"
  sha256 "65cc3bc6ab6fa0470f3739b3d59cf51a4a8e986eed8f78716680faaec59d7129"

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

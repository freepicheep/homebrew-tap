cask "rainaissance" do
  version "3.0.0"
  sha256 "38a806fef3b9d5d5f6cdf018d154be2eb2a68eb4d4d71910bc96d93f6bff6686"

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

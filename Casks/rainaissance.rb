cask "rainaissance" do
  version "2.2.1"
  sha256 "a9f7efdc38a6dd0b8978d1585c65cac3a2fb7b0ec70faf163b2d37d30e8327a6"

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

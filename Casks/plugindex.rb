cask "plugindex" do
  version "1.4.16"
  sha256 "95a6d3d4cb532d5b391c1e06f3b6383a3ebe02a937141f96f03d067e724c6b03"

  url "https://download.plugindex.app/mac-universal/Plugindex-#{version}-universal.dmg"
  name "Plugindex"
  desc "DAW plugin manager"
  homepage "https://plugindex.app/"

  livecheck do
    url "https://download.plugindex.app/mac-universal/latest-mac.yml"
    strategy :electron_builder
  end

  auto_updates true
  depends_on macos: :ventura

  app "Plugindex.app"

  zap trash: [
    "~/.plugindex",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.dylanedmunds.plugindex.sfl*",
    "~/Library/Application Support/plugindex",
    "~/Library/Caches/com.dylanedmunds.plugindex.ShipIt",
    "~/Library/Caches/plugindex-updater",
    "~/Library/Preferences/com.dylanedmunds.plugindex.plist",
  ]
end

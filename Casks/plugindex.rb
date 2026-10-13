cask "plugindex" do
  version "1.4.12"
  sha256 "e3ab9d6e9fc402f0f51cef1b15a740b76ad426df121e3072be52c53b51f54039"

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

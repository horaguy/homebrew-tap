cask "plugindex" do
  version "1.4.25"
  sha256 "f67ecb5b60eafdd47983f485168507c65fbf39a7025c961c2d0ee05d2f4da3cf"

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

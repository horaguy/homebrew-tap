cask "plugindex" do
  version "1.4.42"
  sha256 "2ca660896f3585bb8dd9d83f9915b2288b7e1b4203ecfe9bf2200a6818568940"

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

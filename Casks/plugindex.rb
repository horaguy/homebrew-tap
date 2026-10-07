cask "plugindex" do
  version "1.4.10"
  sha256 "c34dfe7e696096a71429cc40a9232cfe668e32914fd1c9f16c2aa801689ffe37"

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

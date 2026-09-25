cask "moho" do
  version "14.4"
  sha256 :no_check # The mirror URL does not contain the version.

  # Primary link (https://delivery.shopifyapps.com/-/b1b5e7614552eeac/15449ea520c87e08) doesn't work in CLI.
  # So I use a mirror URL.
  url "https://dl.dropboxusercontent.com/scl/fi/nrz0dcufujy6093mk4g2h/Moho1440_Mac.dmg?rlkey=wo8ug7lalxmjfzdmcgzrh0gyl&st=q83hblkk"
  name "MOHO"
  desc "Vector based 2D Computer animation software"
  homepage "https://moho.lostmarble.com/"

  livecheck do
    url "https://moho.lostmarble.com/pages/download"
    regex(/Current installer version - Moho (\d+(?:\.\d+)*)/i)
  end

  depends_on :macos

  app "Moho.app"

  zap trash: [
    "~/Library/Application Scripts/com.lostmarble.moho.MohoThumbnailer",
    "~/Library/Containers/com.lostmarble.moho.MohoThumbnailer",
    "~/Library/Preferences/com.lostmarble.moho.plist",
  ]
end

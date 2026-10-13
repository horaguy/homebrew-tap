cask "moho" do
  version "14.5,0527825866451b9b,b4eb054ce209785d"
  sha256 "65239124fd9c3c930c43f5d80224a23528aa930dc46bc6ae6dbafcdbb8c326ff"

  # Shopify returns 404 unless the request accepts text/html.
  url "https://delivery.shopifyapps.com/-/#{version.csv.second}/#{version.csv.third}",
      header: "Accept: text/html"
  name "MOHO"
  desc "Vector based 2D Computer animation software"
  homepage "https://moho.lostmarble.com/"

  # The trial page links to the installer, and the version is only found in
  # the file name (e.g. Moho1440_Mac.dmg for 14.4) after following the link.
  livecheck do
    url "https://moho.lostmarble.com/pages/try"
    regex(%r{Mac\s*OS.*?href=["']?https?://delivery\.shopifyapps\.com/-/(\h+)/(\h+)}im)
    strategy :page_match do |page, regex|
      match = page.match(regex)
      next if match.blank?

      headers = Homebrew::Livecheck::Strategy.page_headers(
        "https://delivery.shopifyapps.com/-/#{match[1]}/#{match[2]}",
        options: Homebrew::Livecheck::Options.new(header: "Accept: text/html"),
      )
      file = headers.filter_map { |h| h["content-disposition"] }.last
      file_match = file&.match(/Moho(\d{2})(\d)(\d)_Mac\.dmg/i)
      next if file_match.blank?

      major, minor, patch = file_match.captures
      version = [major, minor, (patch if patch != "0")].compact.join(".")
      "#{version},#{match[1]},#{match[2]}"
    end
  end

  depends_on :macos

  app "Moho.app"

  zap trash: [
    "~/Library/Application Scripts/com.lostmarble.moho.MohoThumbnailer",
    "~/Library/Containers/com.lostmarble.moho.MohoThumbnailer",
    "~/Library/Preferences/com.lostmarble.moho.plist",
  ]
end

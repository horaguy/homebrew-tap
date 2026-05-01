cask "aseprite" do
  version "1.3.17.2,408662971"
  sha256 "495ebb911ee272070f9578a4eede47db747d95e2d985d2b40d6384b349beda9f"

  # According to the EULA of Aseprite, we release built apps only in private repository.
  # - https://github.com/aseprite/aseprite/blob/main/EULA.txt
  # - The name of the environment variable should be "HOMEBREW_*"

  url "https://api.github.com/repos/horaguy/aseprite-build/releases/assets/#{version.csv.second}",
      header: [
        "Authorization: token #{ENV.fetch("HOMEBREW_PRIVATE_TAP_GITHUB_TOKEN", nil)}",
        "Accept: application/octet-stream",
      ]
  name "Aseprite"
  desc "Animated sprite editor & pixel art tool (***PRIVATE CASK***)"
  homepage "https://www.aseprite.org/"

  livecheck do
    # Get latest tag and asset ID
    url "https://api.github.com/repos/horaguy/aseprite-build/releases/latest",
        header: [
          "Authorization: token #{ENV.fetch("HOMEBREW_PRIVATE_TAP_GITHUB_TOKEN", nil)}",
          "Accept: application/json",
        ]
    regex(/v?(\d+(?:\.\d+)+)/i)
    strategy :json do |json, regex|
      tag = json["tag_name"]&.then { |t| t.scan(regex).flatten.first }
      asset = json["assets"].find { |a| a["name"]&.end_with?("-macos-aarch64.zip") }
      "#{tag},#{asset["id"]}"
    end
  end

  app "Aseprite.app"

  postflight do
    # Remove quarantine attribute to allow unsigned app to run without security warnings
    system_command "xattr",
                   args: ["-dr", "com.apple.quarantine", "#{staged_path}/Aseprite.app"]
  end

  zap trash: [
    "~/Library/Application Scripts/org.aseprite.AsepriteThumbnailer",
    "~/Library/Application Support/Aseprite",
    "~/Library/Containers/org.aseprite.AsepriteThumbnailer",
  ]
end

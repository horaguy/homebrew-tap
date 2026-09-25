cask "aseprite" do
  version "1.3.18.6,582873068"
  sha256 "041b381f9acec853f3d42eefb207937a5d840ef89b54e3a2005d75f2d0f1a995"

  # According to the EULA of Aseprite, I release a built app only in my private repository.
  # - https://github.com/aseprite/aseprite/blob/main/EULA.txt
  # Usage: HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)" brew install aseprite

  url "https://api.github.com/repos/horaguy/aseprite-build/releases/assets/#{version.csv.second}",
      header: [
        "Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", nil)}",
        "Accept: application/octet-stream",
      ]
  name "Aseprite"
  desc "Animated sprite editor & pixel art tool (TAP OWNER ONLY due to EULA)"
  homepage "https://www.aseprite.org/"

  livecheck do
    url "https://github.com/horaguy/aseprite-build"
    regex(/v?(\d+(?:\.\d+)+)/i)
    strategy :github_latest do |json, regex|
      tag = json["tag_name"]&.then { |t| t[regex, 1] }
      asset = json["assets"]&.find { |a| a["name"]&.end_with?("-macos-aarch64.zip") }
      next if tag.blank? || asset.blank?

      "#{tag},#{asset["id"]}"
    end
  end

  depends_on :macos

  app "Aseprite.app"

  postflight_steps do
    # Remove quarantine attribute to allow unsigned app to run without security warnings
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{staged_path}}/Aseprite.app"],
        must_succeed: false
  end

  zap trash: [
    "~/Library/Application Scripts/org.aseprite.AsepriteThumbnailer",
    "~/Library/Application Support/Aseprite",
    "~/Library/Containers/org.aseprite.AsepriteThumbnailer",
  ]
end

cask "live2d" do
  version "5.3.05"
  sha256 "4145129011882dc32c4012c55f5b2b3b8dd6dfa3046f6e29a0faf87bff30df7b"

  url "https://cubism.live2d.com/editor/bin/Live2D_Cubism_Setup_#{version}_arm64.pkg"
  name "Live2D Cubism Editor"
  desc "2D software to edit Live2D models"
  homepage "https://www.live2d.com/"

  livecheck do
    url "https://cubism.live2d.com/editor/js/download.js"
    regex(/LATEST_VERSION_MAC = "(\d+(?:\.\d+)*)"/)
  end

  depends_on :macos

  pkg "Live2D_Cubism_Setup_#{version}_arm64.pkg"

  uninstall delete: "/Applications/Live2D Cubism *"
end

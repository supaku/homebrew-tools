# Auto-bumped by .github/workflows/release.yml in supaku/kith on tag push.
# The `version` and `sha256` lines are rewritten programmatically; the
# rest of the file is intended to be human-edited.
cask "kith" do
  version "0.1.1"
  sha256  "5cccb946a9c2234558c4cba110ebc034624acb488f010b28f8d12f572897721d"

  url "https://github.com/supaku/kith/releases/download/v#{version}/kith-#{version}-macos-arm64.tar.gz"
  name "kith"
  desc "macOS CLI bridging Apple Contacts and iMessage for terminal users + AI agents"
  homepage "https://github.com/supaku/kith"

  livecheck do
    skip "Auto-bumped by GitHub Actions on release."
  end

  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  binary "kith"

  caveats <<~EOS
    kith reads local Apple Contacts and ~/Library/Messages/chat.db. Both
    require macOS permission grants — run `kith doctor` to see what's
    missing and how to fix it.
  EOS
end

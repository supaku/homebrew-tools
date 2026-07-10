# Auto-bumped by .github/workflows/release.yml in supaku/kith on tag push.
# The `version` and `sha256` lines are rewritten programmatically; the
# rest of the file is intended to be human-edited.
cask "kith" do
  version "0.2.4"
  sha256  "83165804e0cfa2b607979ae5fb58c01968137f0583bf6d625cd3f8405394b827"

  url "https://github.com/supaku/kith/releases/download/v#{version}/kith-#{version}-macos-arm64.tar.gz"
  name "kith"
  desc "CLI bridging Apple Contacts and iMessage for terminal users and AI agents"
  homepage "https://github.com/supaku/kith"

  livecheck do
    skip "Auto-bumped by GitHub Actions on release."
  end

  depends_on macos: :sonoma
  depends_on arch: :arm64

  # Install the headless GUI bootstrap and symlink the CLI wrapper into
  # Homebrew's bin directory. The wrapper resolves that symlink before it
  # loads the SwiftPM resource bundles from libexec.
  app "Kith.app"
  binary "kith"

  caveats <<~EOS
    kith reads local Apple Contacts and ~/Library/Messages/chat.db via the
    KithAgent LaunchAgent that ships inside Kith.app. On first use, the
    `kith` CLI auto-launches Kith.app to register the agent — just answer
    the macOS permission prompts (Contacts + Full Disk Access for
    Messages). Run `kith doctor` to see what's missing and how to fix it.
  EOS
end

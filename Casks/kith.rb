# Auto-bumped by .github/workflows/release.yml in supaku/kith on tag push.
# The `version` and `sha256` lines are rewritten programmatically; the
# rest of the file is intended to be human-edited.
cask "kith" do
  version "0.2.2"
  sha256  "b997b60ecb8e109e6d745361b6d04445e2ed6540ef2bb73b24383874255a0300"

  url "https://github.com/supaku/kith/releases/download/v#{version}/kith-#{version}-macos-arm64.tar.gz"
  name "kith"
  desc "macOS CLI bridging Apple Contacts and iMessage for terminal users + AI agents"
  homepage "https://github.com/supaku/kith"

  livecheck do
    skip "Auto-bumped by GitHub Actions on release."
  end

  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  # CLI: `binary` symlinks the `kith` wrapper into /opt/homebrew/bin/. The
  # wrapper resolves the symlink chain and execs libexec/kith with the
  # SwiftPM resource bundles co-located.
  binary "kith"

  # GUI bootstrap: `app` installs Kith.app to /Applications. Kith.app is a
  # headless (LSUIElement=true), hardened-runtime, notarized .app whose
  # only job is to be a TCC-grantable identity and register the embedded
  # KithAgent LaunchAgent at Contents/Library/LaunchAgents/. The first
  # `kith find` call auto-bootstraps Kith.app via `open -a` if the
  # com.supaku.kith.agent Mach service isn't yet registered.
  app "Kith.app"

  caveats <<~EOS
    kith reads local Apple Contacts and ~/Library/Messages/chat.db via the
    KithAgent LaunchAgent that ships inside Kith.app. On first use, the
    `kith` CLI auto-launches Kith.app to register the agent — just answer
    the macOS permission prompts (Contacts + Full Disk Access for
    Messages). Run `kith doctor` to see what's missing and how to fix it.
  EOS
end

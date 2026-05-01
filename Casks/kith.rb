# Auto-bumped by .github/workflows/release.yml in supaku/kith on tag push.
# The `version` and `sha256` lines are rewritten programmatically; the
# rest of the file is intended to be human-edited.
cask "kith" do
  version "0.2.0"
  sha256  "0a15e8fd0ae71c495ad3dc24a0e238bb2d426806d02054eae743e622b437696c"

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

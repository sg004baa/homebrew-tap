class Prtop < Formula
  desc "Terminal TUI for monitoring GitHub pull requests you're involved in as author or reviewer"
  homepage "https://github.com/sg004baa/prtop"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.8/prtop-aarch64-apple-darwin.tar.xz"
      sha256 "c29cff58a8acf125ac3386ca8c9a605c0813d3677191398cc6afee3a2e2f239e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.8/prtop-x86_64-apple-darwin.tar.xz"
      sha256 "0d337ddcc9c441558704963cccd5cf3b842b2b884966c4447524716450d5464f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.8/prtop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "402d1b76257974d10a51ce7df756522a1521eee0fb54d70957366c6cf06c79e3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.8/prtop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "043e8cf5eba4d245d18cf2198d9649eb021336df95a9f02cacde2e77d97ac737"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "prt"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "prt"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "prt"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "prt"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

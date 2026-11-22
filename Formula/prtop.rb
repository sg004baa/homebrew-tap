class Prtop < Formula
  desc "Terminal TUI for monitoring GitHub pull requests you're involved in as author or reviewer"
  homepage "https://github.com/sg004baa/prtop"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.2.0/prtop-aarch64-apple-darwin.tar.xz"
      sha256 "060f817df54a4917116ab3bce6397c0c4ca5ec84705c2ff530bbd1c7178a29e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.2.0/prtop-x86_64-apple-darwin.tar.xz"
      sha256 "7148fabcd67c72dfdd201191a18a3c0f792b4eda59f313f05a51ec51b24d162b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.2.0/prtop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d842bc501f11169f24f5ae2fd6d0211c8edc61237c714c64ec0c61e30c40113d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.2.0/prtop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "27b497520fb7fae98991e2167a7a23159976db102cfe256532670546decaf9c1"
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

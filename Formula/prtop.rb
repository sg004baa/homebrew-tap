class Prtop < Formula
  desc "Terminal TUI for monitoring GitHub pull requests you're involved in as author or reviewer"
  homepage "https://github.com/sg004baa/prtop"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.5/prtop-aarch64-apple-darwin.tar.xz"
      sha256 "9587ebfdad7364d71433bf734ba06f8922e87c5aae546ab3040cdf399b5db826"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.5/prtop-x86_64-apple-darwin.tar.xz"
      sha256 "049d7502399d2cae15885c0c7504df52e09bdbe865da9982b9c4b283cd0f491d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.5/prtop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "62d33013b6e7ec2b4901002e3fd3d8bbb4ee42479fc8b6dd91d1ad1a4b3855f9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.5/prtop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "598b4843719c248a4ae39a41add69dba811d256a47592f957d625b00fdd9e47c"
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
    bin.install "prt" if OS.mac? && Hardware::CPU.arm?
    bin.install "prt" if OS.mac? && Hardware::CPU.intel?
    bin.install "prt" if OS.linux? && Hardware::CPU.arm?
    bin.install "prt" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

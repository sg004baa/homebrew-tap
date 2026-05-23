class Prtop < Formula
  desc "Terminal TUI for monitoring GitHub pull requests you're involved in as author or reviewer"
  homepage "https://github.com/sg004baa/prtop"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.3/prtop-aarch64-apple-darwin.tar.xz"
      sha256 "d3193bcb5ae436133f16663193a410c4f943494d9ea1786bccbbef99263294e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.3/prtop-x86_64-apple-darwin.tar.xz"
      sha256 "1b9444c1cf697cf1baea535afe0a992369db7cf2b77c62b0b6eb762352c39b05"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.3/prtop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1ca409be3a698a82d86a16db69ca3bec6799a69534acdbf8d4261d836b29941d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.3/prtop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e9f2259ae5c3a0cc106b60062b20752136299cbe8e17d99bcffca17b8d93bcb5"
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

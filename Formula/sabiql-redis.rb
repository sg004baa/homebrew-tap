class SabiqlRedis < Formula
  desc "A driver-less TUI for browsing Redis keys"
  homepage "https://github.com/sg004baa/sabiql"
  version "1.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.14.0/sabiql-redis-aarch64-apple-darwin.tar.xz"
      sha256 "2f2808b338582f818e380b5661329f31cfd006fa08f31b5cc08a95db91eab9fd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.14.0/sabiql-redis-x86_64-apple-darwin.tar.xz"
      sha256 "5817ff48cfe5e0c17184067bc011cb1faef3631e3d8c718cd312e0e0612e1459"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.14.0/sabiql-redis-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "726659f90bb24a0e676c1be79124accfe5dd7bacdacd26f56a013655b5c1b194"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.14.0/sabiql-redis-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "47582b1a9ca1016ca0c19c6fed1d6ccdf1e35c00f24d57e662f83f57086b10c0"
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
    bin.install "sabiql-redis" if OS.mac? && Hardware::CPU.arm?
    bin.install "sabiql-redis" if OS.mac? && Hardware::CPU.intel?
    bin.install "sabiql-redis" if OS.linux? && Hardware::CPU.arm?
    bin.install "sabiql-redis" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

class SabiqlRedis < Formula
  desc "A driver-less TUI for browsing Redis keys"
  homepage "https://github.com/sg004baa/sabiql"
  version "1.12.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.7/sabiql-redis-aarch64-apple-darwin.tar.xz"
      sha256 "b71dc3cdc3627a83cee546c35ab048f960f3dd7be19c9301ef3dd3156bc3d2fe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.7/sabiql-redis-x86_64-apple-darwin.tar.xz"
      sha256 "261dcb57b0b89f6eb621dc2cdd410c55ae4de642d3952b4544966d5c4e2d9500"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.7/sabiql-redis-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4ebe5ce6e6ea128a6c2a832360ea14bb553ffd8338ff434834b99882d99f3705"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.7/sabiql-redis-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7b2edb88255e1392655623d0cac674159f75f5f819ae4eeef55dd4c50e1d3969"
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

class SabiqlRedis < Formula
  desc "A driver-less TUI for browsing Redis keys"
  homepage "https://github.com/sg004baa/sabiql"
  version "3.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.1/sabiql-redis-aarch64-apple-darwin.tar.xz"
      sha256 "1e29ce82ef39fb9d4de5ccc550072e2e8f359ab764f6331d076b75511a6a0bc9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.1/sabiql-redis-x86_64-apple-darwin.tar.xz"
      sha256 "a83ea81d9827fb7380e186f17c2559148e83308a8da4883f3dd260361c85c73d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.1/sabiql-redis-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "51f0ad77b9a3393860f8f39b9f56c6f0abf978c53b6f49fe6f366fea7893a533"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.1/sabiql-redis-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eaf9e03db25c90faf563b313e0c55173ae78cc24d63cc6e82fe5e1ebf0ff6b3f"
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
      bin.install "sabiql-redis"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sabiql-redis"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sabiql-redis"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sabiql-redis"
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

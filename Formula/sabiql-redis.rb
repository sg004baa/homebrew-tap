class SabiqlRedis < Formula
  desc "A driver-less TUI for browsing Redis keys"
  homepage "https://github.com/sg004baa/sabiql"
  version "3.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.2/sabiql-redis-aarch64-apple-darwin.tar.xz"
      sha256 "911d24aff9bbdfcb92d390e868963ac55512ffe9e73b2dcd48488da39e9195c5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.2/sabiql-redis-x86_64-apple-darwin.tar.xz"
      sha256 "16586c5e74fe3a998d82ecb455b219a223c1dac9f10b6cb32f24178606fd0699"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.2/sabiql-redis-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7fa02e805892a72ddb86a5e137ea89fbe80b4fe0a247685540816e629a114472"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.2/sabiql-redis-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bbf372638ecf6111a9ea3740627cd3eef608d0936a576e266d70cc573d0edb79"
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

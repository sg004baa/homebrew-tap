class SabiqlRedis < Formula
  desc "A driver-less TUI for browsing Redis keys"
  homepage "https://github.com/sg004baa/sabiql"
  version "1.12.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.9/sabiql-redis-aarch64-apple-darwin.tar.xz"
      sha256 "1462c35d8021eef7719600bccf4aea21a1317448d62aa4951d3c3925d2855c26"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.9/sabiql-redis-x86_64-apple-darwin.tar.xz"
      sha256 "59b7c75e59b959ae71057ff576793af88486c99d3e09dc2516dc89eed993a8af"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.9/sabiql-redis-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "be1b09ae6943600eebac1827a65e265a15bd96d05dae637c4a4a1dc8bb15bfbd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.9/sabiql-redis-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f6504577468ca4545d47df0f5911d2ef71109098a57094cbe45d6b48362a8484"
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

class SabiqlRedis < Formula
  desc "A driver-less TUI for browsing Redis keys"
  homepage "https://github.com/sg004baa/sabiql"
  version "1.12.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.9/sabiql-redis-aarch64-apple-darwin.tar.xz"
      sha256 "2920549209e7e7add0bb69f2a380a26e068a4191d9be1dd811d240ddf0312570"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.9/sabiql-redis-x86_64-apple-darwin.tar.xz"
      sha256 "d490ce9aea871df16fa4049e1e811e666c15999956e31329b6866342e116ae99"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.9/sabiql-redis-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "792c4eab7cf4227dede1307735619c514a075128c89fb5962ab2c7479893f269"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.9/sabiql-redis-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5c2c5f2f3036b0f14e8390cbff2058e06a4d8dc398fc80685d192fd02c29d47b"
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

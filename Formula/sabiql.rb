class Sabiql < Formula
  desc "A fast, driver-less TUI for browsing and editing PostgreSQL databases"
  homepage "https://github.com/sg004baa/sabiql"
  version "1.16.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.16.1/sabiql-aarch64-apple-darwin.tar.xz"
      sha256 "20a64fcd0b9be9f03b348de721d3a64c6a65cd3c56d806995098517502f730f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.16.1/sabiql-x86_64-apple-darwin.tar.xz"
      sha256 "efbd36371bf993ead23c757a494a3687b6343f2ea5bacbafebf00bc7fd672e0d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.16.1/sabiql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f4c8ee870ef12ff6e1ed92d05b3355f614804ffe2f64dbae369ae9b465328c89"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.16.1/sabiql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1c33de08f904ef370f8006f0a9697c2a9637dcbebd1c3ff0128bad13985b2318"
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
      bin.install "sabiql"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sabiql"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sabiql"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sabiql"
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

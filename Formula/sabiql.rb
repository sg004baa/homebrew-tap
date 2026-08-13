class Sabiql < Formula
  desc "A fast, driver-less TUI for browsing and editing PostgreSQL databases"
  homepage "https://github.com/sg004baa/sabiql"
  version "1.15.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.15.0/sabiql-aarch64-apple-darwin.tar.xz"
      sha256 "7de82a4e1663199db69743dfc43fef025c8415c073ed539b906409167c211a96"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.15.0/sabiql-x86_64-apple-darwin.tar.xz"
      sha256 "3001088bc0865587d434ddde95b5f4f114e541342ed5569cfabb226b9f912bbb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.15.0/sabiql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ee50de94c950a3fe97929a2d223d3d1354dd495f1ae4e6a30172eb3bcbcc8964"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.15.0/sabiql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4d078e299b6058737cbb8da10d82098316f1f654fa189dbe489b2cfb166c8a85"
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

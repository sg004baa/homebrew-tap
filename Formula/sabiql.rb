class Sabiql < Formula
  desc "A fast, driver-less TUI for browsing and editing PostgreSQL databases"
  homepage "https://github.com/sg004baa/sabiql"
  version "1.12.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.8/sabiql-aarch64-apple-darwin.tar.xz"
      sha256 "7664f5c9165f8f39ce8410b20eab03f42d8994b414070f68f2904aecc7104202"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.8/sabiql-x86_64-apple-darwin.tar.xz"
      sha256 "0b862ef90d38c51f56cc81a1415d06ecd6a8c566110b035cd7b5fb41cab91515"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.8/sabiql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1b779584b50ca6c2b7889d33037359494eb8943a8701720b321cf68a6798fe7d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.8/sabiql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e4d535f1438f042331353d3e14431e2f73580026c3b3d94b35899be8f3dd48e3"
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
    bin.install "sabiql" if OS.mac? && Hardware::CPU.arm?
    bin.install "sabiql" if OS.mac? && Hardware::CPU.intel?
    bin.install "sabiql" if OS.linux? && Hardware::CPU.arm?
    bin.install "sabiql" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

class Sabiql < Formula
  desc "A fast, driver-less TUI for browsing and editing PostgreSQL databases"
  homepage "https://github.com/sg004baa/sabiql"
  version "1.12.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.2/sabiql-aarch64-apple-darwin.tar.xz"
      sha256 "2c94926dd54cab173f799ae5e2a24405c388f8f0316d946e418ba5e0561999ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.2/sabiql-x86_64-apple-darwin.tar.xz"
      sha256 "0ea3b3a84232c521f428367aec7065431a51ee524b2796c2da32ad65be92e289"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.2/sabiql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ca68feb03838ccbc5acabe04b634524b811a657e77e25a81852f62e9d5216b31"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.2/sabiql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "08918593d20721f2399c4b0f530eecb896117ac8aa83aeb1b10c7987879e6d73"
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

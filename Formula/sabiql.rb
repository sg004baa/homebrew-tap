class Sabiql < Formula
  desc "A fast, driver-less TUI for browsing and editing PostgreSQL databases"
  homepage "https://github.com/sg004baa/sabiql"
  version "1.12.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.9/sabiql-aarch64-apple-darwin.tar.xz"
      sha256 "07bf3a34d0132e3290d9815e7bc3b7ac96023fa8ea8b2483e172e56a0272f309"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.9/sabiql-x86_64-apple-darwin.tar.xz"
      sha256 "e856e9a342cc6e56e4605fbd9ed7ced0a635b917362e207006d2c6c4806c32e8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.9/sabiql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "78149a4a9853fb9123fe85d4df3e5e995ec34779132ac2b15148b7fdfeeb411d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.9/sabiql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "355e4ac2ca2ea52681a48b8372d8790feabff3e733bbee0747d0cf579fc4524c"
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

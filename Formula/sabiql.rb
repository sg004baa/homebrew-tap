class Sabiql < Formula
  desc "A fast, driver-less TUI for browsing and editing PostgreSQL databases"
  homepage "https://github.com/sg004baa/sabiql"
  version "1.12.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.3/sabiql-aarch64-apple-darwin.tar.xz"
      sha256 "f3eed0781c03d30dfd3ae620cdfa8034dfeb94f674dfe9bb8c202f393e537f07"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.3/sabiql-x86_64-apple-darwin.tar.xz"
      sha256 "c9229f1710108471893af2bea006e2c2811d158f22afdb9f136ad0c236456260"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.3/sabiql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f714484b2a357ee2acf01f5e70f13f35ca8c02243bdb7437269758d7bb095ba3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.3/sabiql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e858d34412b7dd91ca2e95b3ca85ce664a457af873a76ccf8c5682e8186be63a"
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

class Sabiql < Formula
  desc "A fast, driver-less TUI for browsing and editing PostgreSQL databases"
  homepage "https://github.com/riii111/sabiql"
  version "1.12.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/riii111/sabiql/releases/download/v1.12.2/sabiql-aarch64-apple-darwin.tar.xz"
      sha256 "bef54210a8bae1bbe7d6ef32bd33ce5c901bb0315a2d77e037ab63cb769a2c5e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/riii111/sabiql/releases/download/v1.12.2/sabiql-x86_64-apple-darwin.tar.xz"
      sha256 "646cfde27ade8c4694c0174873f667cd36d41b6237980b0ed376dbf34f956fe0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/riii111/sabiql/releases/download/v1.12.2/sabiql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3096ba70fef8d701b034c089213cdb78e8f867938d89589852bdf0e57eacabf6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/riii111/sabiql/releases/download/v1.12.2/sabiql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0afb5bca62e4a37bb6315ae814876461513c9e1dd407a161e1a1a236a77fbb88"
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

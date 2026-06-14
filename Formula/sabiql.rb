class Sabiql < Formula
  desc "A fast, driver-less TUI for browsing and editing PostgreSQL databases"
  homepage "https://github.com/sg004baa/sabiql"
  version "1.12.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.6/sabiql-aarch64-apple-darwin.tar.xz"
      sha256 "73911932d0cae4dfec4de9af67455a1b3adc1db723364efe93536e2ad9246dec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.6/sabiql-x86_64-apple-darwin.tar.xz"
      sha256 "d0387a42be96c79406221062223c0dacfa1a42f8cebce923e3b4a514d15f661c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.6/sabiql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "844608fc67001295b861d26b556b3eea7f183be429b94018a21081e10d2b89cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.6/sabiql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4adf8020f20b01e3cef7f77efed5d94358afc542739b273a5332ca979d410967"
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

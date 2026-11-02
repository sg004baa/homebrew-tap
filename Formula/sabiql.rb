class Sabiql < Formula
  desc "Fast, safe-by-design, Vim-first DB TUI with ER diagrams"
  homepage "https://github.com/sg004baa/sabiql"
  version "3.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.3/sabiql-aarch64-apple-darwin.tar.xz"
      sha256 "a72bd5272ec3465d6b9f9c99322a8a472734a4b5929287b5e232aa19ad25d28a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.3/sabiql-x86_64-apple-darwin.tar.xz"
      sha256 "2b6afc4e81323dc90abe07e4eb7ec88fe072f5779c74e85df9e4333fcd536162"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.3/sabiql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "74309ca2bff787e6e36282ae63699fd98dbbf28bbabd199c8bb813d97a92d4af"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.3/sabiql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4d2da39f7fb11933b5a77d55334b73212118d4fb59c5d8692266d44fa53ea50a"
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

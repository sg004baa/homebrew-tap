class Sabiql < Formula
  desc "Fast, safe-by-design, Vim-first DB TUI with ER diagrams"
  homepage "https://github.com/sg004baa/sabiql"
  version "3.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.1/sabiql-aarch64-apple-darwin.tar.xz"
      sha256 "89e4173c56ab009297c3f897d03af574fc3dec4482a5dee09fce563737fc6d4d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.1/sabiql-x86_64-apple-darwin.tar.xz"
      sha256 "ce0c73a870d3dd3e640063478c9fd149f9a05c5954dbebc7ee0409cf11229a08"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.1/sabiql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eb205d424c4c376e529aba6d0a03c1b3af1ce4b43447019670f815f13320cbf7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.1/sabiql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1a56aca19a84b89b084d3690743a4ddf2f66f6333286bd6623cdce8791fd677e"
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

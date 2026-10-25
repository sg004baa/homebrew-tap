class Sabiql < Formula
  desc "Fast, safe-by-design, Vim-first DB TUI with ER diagrams"
  homepage "https://github.com/sg004baa/sabiql"
  version "3.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.2/sabiql-aarch64-apple-darwin.tar.xz"
      sha256 "dc7abcf09f2abd58134e91a625e12a843c844208c7dc13c01cea9febe7498482"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.2/sabiql-x86_64-apple-darwin.tar.xz"
      sha256 "a1f786bee77ed17407aebddbff5129626d1d83a9fe1970f733a2cc8545fd324b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.2/sabiql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ac7cff5cc5434c6d9b686c284ce5527e467b10d942043ad1baced0c2ebdf4d16"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.2/sabiql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "46aab74de5a9315ed50e92b0552a438a49438e810bbd54071cfd59857eb0b667"
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

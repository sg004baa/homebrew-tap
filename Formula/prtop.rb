class Prtop < Formula
  desc "Terminal TUI for monitoring GitHub pull requests you're involved in as author or reviewer"
  homepage "https://github.com/sg004baa/prtop"
  version "0.1.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.9/prtop-aarch64-apple-darwin.tar.xz"
      sha256 "4b51e162ef57b8ed364f5272a2acd00e05d079453dfefbcdbb42afc151ec1da5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.9/prtop-x86_64-apple-darwin.tar.xz"
      sha256 "950fb9bb339278360a2ed82b5a7e51f1dd45b423b0269fc7632568c0bd2845d2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.9/prtop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "992b2200e0168ca01cff8b9dc8976e781353cf6ca079418df5520cbb30fa3086"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.9/prtop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "279f14409d363bcff459caee0ac7ab816c76571933fea84fcffc03c8e721eca8"
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
      bin.install "prt"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "prt"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "prt"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "prt"
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

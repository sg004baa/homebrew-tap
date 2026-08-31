class Rusting < Formula
  desc "A terminal API client for organizing and sending HTTP requests"
  homepage "https://github.com/sg004baa/rusting"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.2/rusting-aarch64-apple-darwin.tar.xz"
      sha256 "100c770d5d9c307e77e77d42d91e8b39a8b46b3c827549014be472b8375ca52f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.2/rusting-x86_64-apple-darwin.tar.xz"
      sha256 "2d3a420e8604732d6d5e9f6f29d146d573cb542beec5f32265af4f476cf1df5a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.2/rusting-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "975fbd42f38c7a3d45b9e30afe82d96f3af8eb61641a64f474f963bec8e21712"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.2/rusting-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c0d133be005f32e031dddbba30b5d6756fc12bdfa8c11ab4ffad4f21fe9fd9d2"
    end
  end
  license "Apache-2.0"

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
      bin.install "rusting"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "rusting"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "rusting"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "rusting"
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

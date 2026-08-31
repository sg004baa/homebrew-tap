class Rusting < Formula
  desc "A terminal API client for organizing and sending HTTP requests"
  homepage "https://github.com/sg004baa/rusting"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.3/rusting-aarch64-apple-darwin.tar.xz"
      sha256 "dd27c9b5021da34f1a0afde5be10e9285790851f8f0ab6f67f91b7758d7830d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.3/rusting-x86_64-apple-darwin.tar.xz"
      sha256 "d34f4472c68fa3ed69988a5e5a9e21e579ccaa0551ef8c3d23c31b2b068152f3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.3/rusting-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "34549eacb5179a43c355d090c6141b0c16bf9af56ea96651b9e35d2e9d9d81cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.3/rusting-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "116011b6d27880c73dfc3654202882e2a87d2188cee2518693dcd4373bf8462f"
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

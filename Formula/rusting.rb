class Rusting < Formula
  desc "A terminal API client for organizing and sending HTTP requests"
  homepage "https://github.com/sg004baa/rusting"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/0.1.0/rusting-aarch64-apple-darwin.tar.xz"
      sha256 "72ef862d0fd71206175ad243aff053481585988e709454f7cf6e7b03821a2884"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/0.1.0/rusting-x86_64-apple-darwin.tar.xz"
      sha256 "2cb9d48ad0ab9a4e6a6bac62e060705e3777bcec27532c87b1c5c91131c3f7b3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/0.1.0/rusting-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c1d0295188e7db369efb2f1b66ab6cac75defba0ee1b0a61da6f7eb512b6e851"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/0.1.0/rusting-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a9f3b2ba9a3bd8a9bf9bed148e8b0dad40dce4790f55934474d5c09513b7c738"
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
    bin.install "rusting" if OS.mac? && Hardware::CPU.arm?
    bin.install "rusting" if OS.mac? && Hardware::CPU.intel?
    bin.install "rusting" if OS.linux? && Hardware::CPU.arm?
    bin.install "rusting" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

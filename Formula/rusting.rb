class Rusting < Formula
  desc "A terminal API client for organizing and sending HTTP requests"
  homepage "https://github.com/sg004baa/rusting"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/0.2.0/rusting-aarch64-apple-darwin.tar.xz"
      sha256 "4cbd7836db1248e61a2a0b76c03c7cae6a1249e706de70ec54dc8da2e9627763"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/0.2.0/rusting-x86_64-apple-darwin.tar.xz"
      sha256 "2b9fa72de38a2b520fbf32f798eb8b89f7c9d0775be13c09f481ae01bb4e9717"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/0.2.0/rusting-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fb78039e1e8dfc254a66d256f376b3b90d801675db81ff2e352bcf032631dd42"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/0.2.0/rusting-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6205ccd705d206bf9b069c60744d1d05908e95efa2cca1f98d47e7fab9b59bc3"
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

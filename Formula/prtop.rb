class Prtop < Formula
  desc "Terminal TUI for monitoring GitHub pull requests you're involved in as author or reviewer"
  homepage "https://github.com/sg004baa/prtop"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.6/prtop-aarch64-apple-darwin.tar.xz"
      sha256 "c12578ab7ecfc2bbc93f16a43f179422a73d7500b0f4e86562ea2abda5b28766"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.6/prtop-x86_64-apple-darwin.tar.xz"
      sha256 "1352a09606f3317181f979e8f0a3f70515d02d6479376e0d7e037a7ce9f23ce4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.6/prtop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "726da3156a297e7191147c8a62909812b3fb32d365a2bb2dba836a9cad9899d9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.6/prtop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "225c479fb96fdfdd04e8d554fbe219d0d2e29b4422fccbb511148df14431561e"
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
    bin.install "prt" if OS.mac? && Hardware::CPU.arm?
    bin.install "prt" if OS.mac? && Hardware::CPU.intel?
    bin.install "prt" if OS.linux? && Hardware::CPU.arm?
    bin.install "prt" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

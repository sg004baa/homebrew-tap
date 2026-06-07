class Prtop < Formula
  desc "Terminal TUI for monitoring GitHub pull requests you're involved in as author or reviewer"
  homepage "https://github.com/sg004baa/prtop"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.4/prtop-aarch64-apple-darwin.tar.xz"
      sha256 "b9a4c48b84098eab8aa731272330f75ff3cc792a37b69572f25161b46e1392e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.4/prtop-x86_64-apple-darwin.tar.xz"
      sha256 "f9aa8a70e4f170dcf31f84ae6321eb5748b74cc62b4f66dff8311b8033bfe1ec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.4/prtop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3b2750561c024ab5cb6bf19f512a3209d499211aa2f990d82aa7f162aff7ce5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.4/prtop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f2c0a83658bd31b486a066e6f771b1e4a2d4f467d676bd73121b0634600f323e"
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

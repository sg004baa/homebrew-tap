class Prtop < Formula
  desc "Terminal TUI for monitoring GitHub pull requests you're involved in as author or reviewer"
  homepage "https://github.com/sg004baa/prtop"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.7/prtop-aarch64-apple-darwin.tar.xz"
      sha256 "61fda974e9c83ab37ee0302bfed1bd243dd4428cb94c904d333faeaa927a9b8c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.7/prtop-x86_64-apple-darwin.tar.xz"
      sha256 "ffef770ff3be95a9daec0436683190684fe9f8fed0582a653791aa010f7e34ef"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.7/prtop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d6f1159c5b7f82bac58151d02cbd579d9720716290117bfa03d0e331106bd061"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/prtop/releases/download/v0.1.7/prtop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d3f273ce390f4834cfb9fe53a5489362b1730138a34b907fd11ca677bd6661db"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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

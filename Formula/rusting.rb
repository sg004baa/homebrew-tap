class Rusting < Formula
  desc "A terminal API client for organizing and sending HTTP requests"
  homepage "https://github.com/sg004baa/rusting"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.1/rusting-aarch64-apple-darwin.tar.xz"
      sha256 "5cf2ec55252d323f3bf190168be613449e854f6d3f3b85d351c7364bdcc8233e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.1/rusting-x86_64-apple-darwin.tar.xz"
      sha256 "76c20a81faf52f97d9e2c48aed897a71113346fdc576d6b15e2e66f58ae0ee24"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.1/rusting-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fc9a975124cf012cde291bc6c36f3558adb1258363038e6b6fd1d018b874710f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.1/rusting-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "96a7d844acb953495d07ea1598b2f77caf7097e3e60a4ab3d32bd6f609dd663b"
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

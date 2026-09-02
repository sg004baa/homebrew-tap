class Rusting < Formula
  desc "A terminal API client for organizing and sending HTTP requests"
  homepage "https://github.com/sg004baa/rusting"
  version "0.2.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.5/rusting-aarch64-apple-darwin.tar.xz"
      sha256 "5af914894220a56d47ffeb7b579fc32aa8faac8031db73702eac56ba46911947"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.5/rusting-x86_64-apple-darwin.tar.xz"
      sha256 "64ad1cd9de8d2f9926b5722303dfcc305abde248bacbafaa06c8d3487b163412"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.5/rusting-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "69d923bcd9ae565a557b63994d58113b71685b780cf4704b11d6f4ab437b20cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/v0.2.5/rusting-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "006f049d8beae1fa992fa98e803bb36a084628f7c64f60bfd3886b6863036aca"
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

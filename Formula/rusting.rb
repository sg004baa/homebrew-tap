class Rusting < Formula
  desc "A terminal API client for organizing and sending HTTP requests"
  homepage "https://github.com/sg004baa/rusting"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/0.1.2/rusting-aarch64-apple-darwin.tar.xz"
      sha256 "2762a4860a412bf14f5c2b90d6ccc2e03cda42ad219756ef642f3cce7df7610b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/0.1.2/rusting-x86_64-apple-darwin.tar.xz"
      sha256 "dc07ec2080b07a3409ea58ff70a62d6f2d62ddb30ce5d8be6a1066595438747d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/0.1.2/rusting-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "53310091d9abb68de86cec016b45d7b37ceba15ff9334be6bdca5181ad2c7d23"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/0.1.2/rusting-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "199103b7b3a538370e60640bfad5670cb91419e274df8c409a8429a3c1828dc0"
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

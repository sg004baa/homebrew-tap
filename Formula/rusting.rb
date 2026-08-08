class Rusting < Formula
  desc "A terminal API client for organizing and sending HTTP requests"
  homepage "https://github.com/sg004baa/rusting"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/0.1.1/rusting-aarch64-apple-darwin.tar.xz"
      sha256 "f88dd867c54c65dc8ca6b68e384ad12d0470aaeb6b46d01c13ed7462e6875d8a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/0.1.1/rusting-x86_64-apple-darwin.tar.xz"
      sha256 "017424e24417a76025bb75a02f44e7986129c587fa804fc77bdd0c329b05f8f1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/0.1.1/rusting-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6a6da87f7ec5da247e1d89d0732691626a48743ef157ba0f86f736e36d366d82"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/0.1.1/rusting-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f0a7403d3b5b9bfe98eeaf692509bf76499adceeaa7752f216cff9787c71145d"
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

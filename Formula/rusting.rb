class Rusting < Formula
  desc "A terminal API client for organizing and sending HTTP requests"
  homepage "https://github.com/sg004baa/rusting"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/v0.3.0/rusting-aarch64-apple-darwin.tar.xz"
      sha256 "10f8d8327acfcf0dca9842bace4a7395cce41226b15adb53cc26940d83face60"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/v0.3.0/rusting-x86_64-apple-darwin.tar.xz"
      sha256 "0a56e59c502fd4bfa529f59aefaa4467863a991dc85793560ea11aeb07319bf3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/rusting/releases/download/v0.3.0/rusting-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "686ce22c5d7487d6ebf4fc97164f6ba84257b2dc46b6eacbf361e13f3297787e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/rusting/releases/download/v0.3.0/rusting-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e374fef1a847deadb2e63cce2020fa9a4bfa8d76b8e96bc76dcfed5bbce15ff6"
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

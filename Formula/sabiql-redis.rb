class SabiqlRedis < Formula
  desc "A driver-less TUI for browsing Redis keys"
  homepage "https://github.com/sg004baa/sabiql"
  version "3.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.3/sabiql-redis-aarch64-apple-darwin.tar.xz"
      sha256 "aa502bcbb2a2984b07b2c15acc3025e91fc5416b14de046f36d43734b175aae0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.3/sabiql-redis-x86_64-apple-darwin.tar.xz"
      sha256 "bbbd5bd3afc922046edf3230a7c3700fdae90c791544545aff72799a78664cd6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.3/sabiql-redis-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "077c5600b4f0d304b0994ca0e89647b8b1d990d044863656d666581d336b1fa6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v3.0.3/sabiql-redis-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d9bdb565adcd8ae5de7ccc5ab487cafbf8aa670b25b1aa4bc3fa17d6c815ec38"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "sabiql-redis"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sabiql-redis"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sabiql-redis"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sabiql-redis"
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

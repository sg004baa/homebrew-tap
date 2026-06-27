class SabiqlRedis < Formula
  desc "A driver-less TUI for browsing Redis keys"
  homepage "https://github.com/sg004baa/sabiql"
  version "1.12.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.8/sabiql-redis-aarch64-apple-darwin.tar.xz"
      sha256 "aeffe37ea1f76064c1c56a34fbdc30d30961b7e9b1e05f97028ff4e083011ab7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.8/sabiql-redis-x86_64-apple-darwin.tar.xz"
      sha256 "c50f4c51be5289ec69e3689a0da222d199b57841eb5e8430deefb9d354eb7c28"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.8/sabiql-redis-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ccd9152ad5c53fa46de3c1b7731e47874266f88077d0776affc69ac8055957a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sg004baa/sabiql/releases/download/v1.12.8/sabiql-redis-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "062357fcb4081233e21710811c53848edd7e53033c2fcd358a2de83837c7498d"
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
    bin.install "sabiql-redis" if OS.mac? && Hardware::CPU.arm?
    bin.install "sabiql-redis" if OS.mac? && Hardware::CPU.intel?
    bin.install "sabiql-redis" if OS.linux? && Hardware::CPU.arm?
    bin.install "sabiql-redis" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

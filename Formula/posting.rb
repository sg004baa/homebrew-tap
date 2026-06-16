class Posting < Formula
  include Language::Python::Virtualenv

  desc "Modern API client that lives in your terminal"
  homepage "https://github.com/sg004baa/posting"
  url "https://github.com/sg004baa/posting/archive/refs/tags/v2.10.1.tar.gz"
  sha256 "dc4adf825ba74b7f2eee3d392e3d70b6990be89ca40c1c551419279a0014a47e"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    # Install posting from source but let pip pull its dependencies as
    # prebuilt PyPI wheels. Several transitive deps (e.g. the
    # tree-sitter grammars textual[syntax] pins) ship broken sdists
    # that cannot compile, and others (pydantic-core, watchfiles)
    # would otherwise require a full rust/llvm toolchain to build.
    # virtualenv_create builds the venv without pip on Python 3.12+,
    # but with --system-site-packages, so the brewed python's pip is
    # importable and installs into this venv.
    virtualenv_create(libexec, "python3.12")
    system libexec/"bin/python", "-m", "pip", "install", buildpath
    bin.install_symlink libexec/"bin/posting"
  end

  test do
    assert_match "TUI for testing HTTP APIs", shell_output("#{bin}/posting --help")
  end
end

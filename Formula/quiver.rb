class Quiver < Formula
  desc "A module manager for Nushell"
  homepage "https://github.com/freepicheep/quiver"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.2.2/quiver-aarch64-apple-darwin.tar.xz"
      sha256 "f3dc80aa4a3cfd9497c9f6723eef78ec575380967d489ca8702d4982a17383f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.2.2/quiver-x86_64-apple-darwin.tar.xz"
      sha256 "7df8ff3afe343bbb2137293424677ecb889b9e647da62429aff99b0424b3a231"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.2.2/quiver-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "09db0d0abdf750f80a1554c65d61130405f325d2b9204e7e2d1ceb0971882dac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.2.2/quiver-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fbd6f1c3f36d451db531bcf8cac611840bd4188e5e54d3b459785af166202b95"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
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
    bin.install "qv" if OS.mac? && Hardware::CPU.arm?
    bin.install "qv" if OS.mac? && Hardware::CPU.intel?
    bin.install "qv" if OS.linux? && Hardware::CPU.arm?
    bin.install "qv" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

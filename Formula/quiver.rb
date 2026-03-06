class Quiver < Formula
  desc "A module manager for Nushell"
  homepage "https://github.com/freepicheep/quiver"
  version "0.3.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.3.3/quiver-aarch64-apple-darwin.tar.gz"
      sha256 "cc79824e10a017f1751ab551ea1258c901d8ec4350279c1f02c19f5725cafe8d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.3.3/quiver-x86_64-apple-darwin.tar.gz"
      sha256 "73c2dd2b4382c668bee7d652b7dd21b9af7d209b6e77a0b68de9e9ca4eb4dd7d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.3.3/quiver-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d01d89a65801d7f4496c77f27a019e12a79b9b963ad0615962630a18f8f546b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.3.3/quiver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0e2292a4a345f5638280e00b97c7c742c2c24344c90d6ab55fae6c58d7a07d0b"
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

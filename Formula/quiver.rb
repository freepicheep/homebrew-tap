class Quiver < Formula
  desc "A module manager for Nushell"
  homepage "https://github.com/freepicheep/quiver"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.3.0/quiver-aarch64-apple-darwin.tar.xz"
      sha256 "f3833c6f6f7e4898b3691fb83b7fa0aa8bc6dc37e0e1dd45d78f82daa10d7b23"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.3.0/quiver-x86_64-apple-darwin.tar.xz"
      sha256 "9d7ec14e7210f542aec44514e6be3ecdda3b3353dba73b5f52cd95229fe2e981"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.3.0/quiver-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4adb6857ca513ea5e394712477e9e4021d2024477e225a6425c282f82879977c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.3.0/quiver-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4abb1f8b36c1914bdefa6fce1f1371ddf59c98a938a271a37ad4b3793c9a06f3"
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

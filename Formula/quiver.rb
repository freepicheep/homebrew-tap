class Quiver < Formula
  desc "A module manager for Nushell"
  homepage "https://github.com/freepicheep/quiver"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.6.0/quiver-aarch64-apple-darwin.tar.gz"
      sha256 "c92408d60beed3632545fc24a12944fcd11775e8f453a7f715ccead7326c349d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.6.0/quiver-x86_64-apple-darwin.tar.gz"
      sha256 "fdd6573cb505c2dbae40410ba958b157c3b436f3713aec9700f57ec6a46420a9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.6.0/quiver-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "95f82b79d986574ac6ebf5e9eb71e35fda5ad4739f4a4025fb58587d2af29423"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.6.0/quiver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "49618529abfc59731b2504a8330859e152d92cc10e4c33f7e43f8b132e79af73"
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
    bin.install "qv", "qvx" if OS.mac? && Hardware::CPU.arm?
    bin.install "qv", "qvx" if OS.mac? && Hardware::CPU.intel?
    bin.install "qv", "qvx" if OS.linux? && Hardware::CPU.arm?
    bin.install "qv", "qvx" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

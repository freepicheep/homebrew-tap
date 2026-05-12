class Quiver < Formula
  desc "A module manager for Nushell"
  homepage "https://github.com/freepicheep/quiver"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.7.1/quiver-aarch64-apple-darwin.tar.gz"
      sha256 "6105047ae261e24e25161b7d96ffd586c653b9629255f11a5901540c58a54ecd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.7.1/quiver-x86_64-apple-darwin.tar.gz"
      sha256 "aed486f1f965004559c682d43495eca876382c7ce82aabbfbfe679926f31e8fc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.7.1/quiver-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "74d9fcbdcf69d2be8905f57af0921a7a2da2916daf5ba9d37a3ca260141638c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.7.1/quiver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "69fdd213fbd047eda29d4cb1988541c49342cd8c2a615dcb994752cfcc070b0d"
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

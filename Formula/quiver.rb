class Quiver < Formula
  desc "A module manager for Nushell"
  homepage "https://github.com/freepicheep/quiver"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.4.0/quiver-aarch64-apple-darwin.tar.gz"
      sha256 "85ea92bc6dc83dc38f345b9eabba6b5d0d4529e08bed76647bec1b91d6a4f5ab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.4.0/quiver-x86_64-apple-darwin.tar.gz"
      sha256 "00a5d2330f876a5eff1fde3e9da6f058d35e6d9dd7adff84355c0dff33679dba"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.4.0/quiver-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9bdb93d21fc018963dce2fd6465eab4951bf50ade005289b9dd2d6bb5fb15260"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.4.0/quiver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a8dc637338a3086d1e7398f3810f1488f2638fefe6e19af79683de1c9730fea3"
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

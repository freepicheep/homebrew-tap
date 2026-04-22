class Quiver < Formula
  desc "A module manager for Nushell"
  homepage "https://github.com/freepicheep/quiver"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.5.1/quiver-aarch64-apple-darwin.tar.gz"
      sha256 "5aa9badbf388790dbf18aeab5c8696335e0432f6462d4f6bc8fa59272d34d008"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.5.1/quiver-x86_64-apple-darwin.tar.gz"
      sha256 "515a8fe6f12fd803b6c7274a5b26d2beb348cd779584e61b3acf86a695a05845"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.5.1/quiver-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9802c4436bdcb12ca7fe6b488ac18fb3f2598b44846346a74870a9e3e483f67f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.5.1/quiver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ec4f1775771fd637e1627ba4ed58fd8e0b8d61c1a3b183a9f86d952c8a621151"
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

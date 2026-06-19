class Quiver < Formula
  desc "A module manager for Nushell"
  homepage "https://github.com/freepicheep/quiver"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.8.0/quiver-aarch64-apple-darwin.tar.gz"
      sha256 "a4dcb97c2914f5460bb5fa8d169dc661840b46d81d0d607907812c479cc41488"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.8.0/quiver-x86_64-apple-darwin.tar.gz"
      sha256 "1920b23848c54e2259075d37abdaccd0e4b8b3d13464c0e7ed26ee9c3e0be1b8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.8.0/quiver-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2ac088c6c8f79e5aaee65b5773789522e757d055ffb7334871390d5d3e7d20b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.8.0/quiver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a568162d1c8acb9d0451e0b72a9907aea2027c7666b91e6d3f5626408863fbce"
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

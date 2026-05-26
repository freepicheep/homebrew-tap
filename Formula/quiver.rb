class Quiver < Formula
  desc "A module manager for Nushell"
  homepage "https://github.com/freepicheep/quiver"
  version "0.7.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.7.3/quiver-aarch64-apple-darwin.tar.gz"
      sha256 "677e8c32ada97b0b3f0ae7c47a884b1a866b803253752e024c0a90acb530e9b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.7.3/quiver-x86_64-apple-darwin.tar.gz"
      sha256 "3fb6265fbb409133d52dabfa3d83c349a7427c8ba12bc8f611b23af9288bbf3b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.7.3/quiver-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3f406ae809efdeee7b5fd58b05015da70a070dc8d47a355c5a4d5a2f5352fdcc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.7.3/quiver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "41cc02f63f3035c9172636631e15eeef715e291bb68775e81b72349fef875f9f"
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

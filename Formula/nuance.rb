class Nuance < Formula
  desc "A module and script manager for Nushell"
  homepage "https://github.com/freepicheep/nuance"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/nuance/releases/download/v0.2.1/nuance-aarch64-apple-darwin.tar.xz"
      sha256 "98c631726e034b064962ef5ded6bf2258891dc4041b22642259d9fac6efceb61"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/nuance/releases/download/v0.2.1/nuance-x86_64-apple-darwin.tar.xz"
      sha256 "ef1b87a6793b4b9c4122e5931f2f0013bfb473b9963d6a25cf7f538cfe1098d6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/nuance/releases/download/v0.2.1/nuance-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "74fa8ff288e1da7162804a3d0c055c64850a75c793bb9c590df28ca32d6fef07"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/nuance/releases/download/v0.2.1/nuance-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1aabf91c3c0dd53a938ef17570db1b73f791f171e63bd9a6729aa334e5f00020"
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
    bin.install "nuance" if OS.mac? && Hardware::CPU.arm?
    bin.install "nuance" if OS.mac? && Hardware::CPU.intel?
    bin.install "nuance" if OS.linux? && Hardware::CPU.arm?
    bin.install "nuance" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

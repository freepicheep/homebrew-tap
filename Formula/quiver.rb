class Quiver < Formula
  desc "A module manager for Nushell"
  homepage "https://github.com/freepicheep/quiver"
  version "0.3.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.3.4/quiver-aarch64-apple-darwin.tar.gz"
      sha256 "c81ce3c214976388ab22cf3bfdb4c65c88227b9d3b9d0d3205409344be4f809f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.3.4/quiver-x86_64-apple-darwin.tar.gz"
      sha256 "fb2464c88553a486d10e010e721841d5428c806c9a4486c340464888e2f2e728"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/quiver/releases/download/v0.3.4/quiver-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "54c9e1400a6fdca822071ccd15d92645168cb37e6a6dcacd47604eb72e814bce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/quiver/releases/download/v0.3.4/quiver-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a6cc8125525ec3f1f95d8e065832015cc08664f602c2c741d1f10fc91f40ddf3"
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

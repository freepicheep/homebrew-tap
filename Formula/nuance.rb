class Nuance < Formula
  desc "A module and script manager for Nushell"
  homepage "https://github.com/freepicheep/nuance"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/nuance/releases/download/v0.2.0/nuance-aarch64-apple-darwin.tar.xz"
      sha256 "56a5ea6265f24d432438757732447447c009c28c6eb76bb20f7ef49f456f8c90"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/nuance/releases/download/v0.2.0/nuance-x86_64-apple-darwin.tar.xz"
      sha256 "14c865a848886c9fc33510c5fee4dde476275357c3fee25e110adb11086d98c1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freepicheep/nuance/releases/download/v0.2.0/nuance-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3028df64ca1402a71684bb74248b58135105d77da512086e66112e8b22872ac6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freepicheep/nuance/releases/download/v0.2.0/nuance-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9e2765334bbec7e7660b846f12666425a97d0326d897bec96baa4a804d8af281"
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

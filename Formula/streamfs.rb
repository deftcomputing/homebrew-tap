# Homebrew formula for StreamFS
# Install: brew install deftcomputing/tap/streamfs
# Or:      brew tap deftcomputing/tap && brew install streamfs

class Streamfs < Formula
  desc "Cloud file streaming for media workflows — mount S3 as a local filesystem"
  homepage "https://streamfs.io"
  version "0.2.0"
  license :cannot_represent  # Proprietary — see https://streamfs.io/terms

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/deftcomputing/streamfs/releases/download/v#{version}/streamfs-darwin-aarch64"
      sha256 "PLACEHOLDER_ARM64_SHA256"
    else
      url "https://github.com/deftcomputing/streamfs/releases/download/v#{version}/streamfs-darwin-x86_64"
      sha256 "PLACEHOLDER_X86_64_SHA256"
    end
  end

  on_linux do
    url "https://github.com/deftcomputing/streamfs/releases/download/v#{version}/streamfs-linux-x86_64"
    sha256 "PLACEHOLDER_LINUX_SHA256"

    depends_on "libfuse" => :recommended
  end

  def install
    binary = Dir["*"].first || "streamfs"
    bin.install binary => "streamfs"
  end

  def caveats
    <<~EOS
      To get started:
        1. streamfs login
        2. streamfs mount -w <workspace-name>

      Configuration: ~/.streamfs/config.toml
      Documentation: https://streamfs.io/app/download
    EOS
  end

  test do
    assert_match "streamfs", shell_output("#{bin}/streamfs --version 2>&1", 0)
  end
end

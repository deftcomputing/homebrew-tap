class Streamfs < Formula
  desc "Cloud file streaming for media workflows — mount S3 as a local filesystem"
  homepage "https://streamfs.io"
  version "0.3.0"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://releases.streamfs.io/v0.3.0/streamfs-darwin-aarch64?token=bb48440012674fb7553a7cf529407922bcb036ef7a8e659d3cbe6246c5cab2fb"
      sha256 "2b9ed9529b29def0769c34150a298340941dc0fc1094ab68420f06ab2a7ed6af"
    else
      url "https://releases.streamfs.io/v0.3.0/streamfs-darwin-x86_64?token=bb48440012674fb7553a7cf529407922bcb036ef7a8e659d3cbe6246c5cab2fb"
      sha256 "6d3365b6f214336f5738f4c32719367320fe8cfc61e16497d0e55f8ee1c29b5f"
    end
  end

  on_linux do
    url "https://releases.streamfs.io/v0.3.0/streamfs-linux-x86_64?token=bb48440012674fb7553a7cf529407922bcb036ef7a8e659d3cbe6246c5cab2fb"
    sha256 "113a4187e6e9ba97b78913a1e4d7ca51519f4ebf15f5c53c9d98c653967bf223"

    depends_on "libfuse" => :recommended
  end

  def install
    bin.install Dir["*"].first => "streamfs"
  end

  def caveats
    <<~EOS
      To get started:
        1. streamfs login
        2. streamfs mount -w <workspace-name>

      Configuration: ~/.streamfs/config.toml
      Documentation: https://streamfs.io
    EOS
  end

  test do
    assert_match "streamfs", shell_output("#{bin}/streamfs --version 2>&1", 0)
  end
end

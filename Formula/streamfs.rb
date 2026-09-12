class Streamfs < Formula
  desc "Cloud file streaming for media workflows — mount S3 as a local filesystem"
  homepage "https://streamfs.io"
  version "0.6.2"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://releases.streamfs.io/v0.6.2/streamfs-darwin-aarch64/streamfs?token=bb48440012674fb7553a7cf529407922bcb036ef7a8e659d3cbe6246c5cab2fb"
      sha256 "612d3e7727ef78345a0e00296c82c7ecdfcb9fa49de04229270a7082fc283449"
    else
      url "https://releases.streamfs.io/v0.6.2/streamfs-darwin-x86_64/streamfs?token=bb48440012674fb7553a7cf529407922bcb036ef7a8e659d3cbe6246c5cab2fb"
      sha256 "390abe70c7b831b0cec4f1fa04a04e30dc843efb1bd5192c614799d75c26e3d4"
    end
  end

  on_linux do
    url "https://releases.streamfs.io/v0.6.2/streamfs-linux-x86_64/streamfs?token=bb48440012674fb7553a7cf529407922bcb036ef7a8e659d3cbe6246c5cab2fb"
    sha256 "aa5a15ebbbcf28b152107836ed731395f4b112a33258c8a5ba34ffc3dcd69ef2"

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

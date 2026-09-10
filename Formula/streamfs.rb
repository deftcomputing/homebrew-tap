class Streamfs < Formula
  desc "Cloud file streaming for media workflows — mount S3 as a local filesystem"
  homepage "https://streamfs.io"
  version "0.6.0"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://releases.streamfs.io/v0.6.0/streamfs-darwin-aarch64/streamfs?token=bb48440012674fb7553a7cf529407922bcb036ef7a8e659d3cbe6246c5cab2fb"
      sha256 "896a026967e627868f0a7ef0f7df62356039dc63586f8fac487f7264f6d34644"
    else
      url "https://releases.streamfs.io/v0.6.0/streamfs-darwin-x86_64/streamfs?token=bb48440012674fb7553a7cf529407922bcb036ef7a8e659d3cbe6246c5cab2fb"
      sha256 "3ef3f278e58d63a9b8f05120463337701e5bcc16fb49920a59439889f37988ba"
    end
  end

  on_linux do
    url "https://releases.streamfs.io/v0.6.0/streamfs-linux-x86_64/streamfs?token=bb48440012674fb7553a7cf529407922bcb036ef7a8e659d3cbe6246c5cab2fb"
    sha256 "c245e32c2f5753144dcc76d915368b92ff0970a043c47bbe846092c30ddc6efa"

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

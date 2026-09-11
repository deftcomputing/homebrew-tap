class Streamfs < Formula
  desc "Cloud file streaming for media workflows — mount S3 as a local filesystem"
  homepage "https://streamfs.io"
  version "0.6.1"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://releases.streamfs.io/v0.6.1/streamfs-darwin-aarch64/streamfs?token=bb48440012674fb7553a7cf529407922bcb036ef7a8e659d3cbe6246c5cab2fb"
      sha256 "4a7c7bc37a7162433e0d19b6a8e47ab010628594cb85f80808d81c895d21190e"
    else
      url "https://releases.streamfs.io/v0.6.1/streamfs-darwin-x86_64/streamfs?token=bb48440012674fb7553a7cf529407922bcb036ef7a8e659d3cbe6246c5cab2fb"
      sha256 "dba1e6dbac74425718429411d3ca362eee00aab572fba951b3fd5458e2d3f91f"
    end
  end

  on_linux do
    url "https://releases.streamfs.io/v0.6.1/streamfs-linux-x86_64/streamfs?token=bb48440012674fb7553a7cf529407922bcb036ef7a8e659d3cbe6246c5cab2fb"
    sha256 "acc13646f81cb04e57c175dde19d375b1a8fd8b09139356cc4dcbd388f501503"

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

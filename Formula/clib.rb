class Clib < Formula
  desc "Package manager for C programming"
  homepage "https://github.com/clibs/clib"
  url "https://github.com/clibs/clib/archive/2.8.0.tar.gz"
  sha256 "be474f6697d9a9918cbe4d3cc65a16cba2fbe0aee35d40eaca7b67557e89bce4"
  license "MIT"
  head "https://github.com/clibs/clib.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "44f5920711c2eb79e334cd7bc4b5972c9b3010a0345607b8c59ee71b1e2391c1"
    sha256 cellar: :any_skip_relocation, big_sur:       "8a4af428b5c74fed903aca3337334bf0d418fd9765ea50d73ac2f308c60f7061"
    sha256 cellar: :any_skip_relocation, catalina:      "b1d926918eab64e133117b5089f17c51f0a0888d7ed33448fd3247e05a15e919"
    sha256 cellar: :any_skip_relocation, mojave:        "277176751578539b28b96e3d18f1ca9efa576b270e6ee6a42a7f4fdea317c061"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f4aa744f8e16aea0962e74275a2a3c3961968545832318bf264ebda0f8201e88" # linuxbrew-core
  end

  uses_from_macos "curl"

  def install
    ENV["PREFIX"] = prefix
    system "make", "install"
  end

  test do
    system "#{bin}/clib", "install", "stephenmathieson/rot13.c"
  end
end

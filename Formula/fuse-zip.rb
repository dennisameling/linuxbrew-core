class FuseZip < Formula
  desc "FUSE file system to create & manipulate ZIP archives"
  homepage "https://bitbucket.org/agalanin/fuse-zip"
  # Return to the non-autogenerated tarballs (on the "Downloads" tab), when
  # possible. 0.7.1 is missing for now, so we use the autogenerated tag tarball.
  url "https://bitbucket.org/agalanin/fuse-zip/get/0.7.1.tar.gz"
  sha256 "771302586ca734bf845effcea999c38f4c2e984e29605912eb3470fbeea0b195"
  license "GPL-3.0-or-later"
  head "https://bitbucket.org/agalanin/fuse-zip", using: :hg

  bottle do
    rebuild 1
    sha256 cellar: :any, catalina:    "70905b7f3ba6baa6683d7ad1cc0ae51ae9ad37a2c4c037de96abfec298fbd7d0"
    sha256 cellar: :any, mojave:      "f99be52df0a2ff2842c615bb4fa255c4400b382d2bb98d14e023223956edb245"
    sha256 cellar: :any, high_sierra: "e72d442a43e1396c8a744e73bc9d197cbef7bb996bba97bff4b377c253c12ed8"
  end

  depends_on "pkg-config" => :build
  depends_on "libzip"

  on_macos do
    deprecate! date: "2020-11-10", because: "requires FUSE"
    depends_on :osxfuse
  end

  on_linux do
    depends_on "libfuse"
  end

  def install
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    system bin/"fuse-zip", "--help"
  end
end

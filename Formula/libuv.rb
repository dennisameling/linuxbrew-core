class Libuv < Formula
  desc "Multi-platform support library with a focus on asynchronous I/O"
  homepage "https://github.com/libuv/libuv"
  url "https://github.com/libuv/libuv/archive/v1.40.0.tar.gz"
  sha256 "70fe1c9ba4f2c509e8166c0ca2351000237da573bb6c82092339207a9715ba6b"
  license "MIT"
  head "https://github.com/libuv/libuv.git", branch: "v1.x"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "b9d7666e1a603e6fe52b16766340633dc1c4da4e669266674d696650dfd0a671"
    sha256 cellar: :any, big_sur:       "de936683bd073e5e564222cdd2dd954a422c03298591f77a720aab9183d1d62c"
    sha256 cellar: :any, catalina:      "2f7836743d77fcf9ccebd6b6d00b28b38c6490639db3cf802eac039916db0647"
    sha256 cellar: :any, mojave:        "ed9d2d1bcea3599185ec85ea3f270148971153d4e61d3e181558a768cbfffd4f"
    sha256 cellar: :any, high_sierra:   "d574eb3deffdca605ab70a0bbfd9687c3795c98db2d9224eadb39b2be77aa125"
    sha256 cellar: :any, x86_64_linux:  "6b002f00e3aeb358ae5c94596223595c15ecb85697a7d0b21a56f5b8e62e35f6"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "sphinx-doc" => :build

  def install
    # This isn't yet handled by the make install process sadly.
    cd "docs" do
      system "make", "man"
      system "make", "singlehtml"
      man1.install "build/man/libuv.1"
      doc.install Dir["build/singlehtml/*"]
    end

    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <uv.h>
      #include <stdlib.h>

      int main()
      {
        uv_loop_t* loop = malloc(sizeof *loop);
        uv_loop_init(loop);
        uv_loop_close(loop);
        free(loop);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-luv", "-o", "test"
    system "./test"
  end
end

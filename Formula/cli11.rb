class Cli11 < Formula
  desc "Simple and intuitive command-line parser for C++11"
  homepage "https://cliutils.github.io/CLI11/book/"
  url "https://github.com/CLIUtils/CLI11/archive/v2.1.0.tar.gz"
  sha256 "2661b0112b02478bad3dc7f1749c4825bfc7e37b440cbb4c8c0e2ffaa3999112"
  license "BSD-3-Clause"
  head "https://github.com/CLIUtils/CLI11.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "14e40203b7a5a2a7aba74846647ed01780ba2ebf97fbaeb78f9a82ec2a12a543" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", "-DCLI11_BUILD_DOCS=OFF", "-DCLI11_BUILD_TESTS=OFF", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "CLI/App.hpp"
      #include "CLI/Formatter.hpp"
      #include "CLI/Config.hpp"

      int main(int argc, char** argv) {
          CLI::App app{"App description"};

          std::string filename = "default";
          app.add_option("-r,--result", filename, "A test string");

          CLI11_PARSE(app, argc, argv);
          std::cout << filename << std::endl;
          return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test", "-I#{include}"
    assert_equal "foo\n", shell_output("./test -r foo")
  end
end

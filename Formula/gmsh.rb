class Gmsh < Formula
  desc "3D finite element grid generator with CAD engine"
  homepage "https://gmsh.info/"
  url "https://gmsh.info/src/gmsh-4.0.7-source.tgz"
  sha256 "c6572320d0ffdf7d2488e113861bc4bd9c38a29f7fc5b67957f6fbcb63fbdbd5"
  head "https://gitlab.onelab.info/gmsh/gmsh.git"

  bottle do
    cellar :any
    sha256 "5284401833c614c32f5d42628a40730cdbe668cf11156e7a66df4e54823304c6" => :mojave
    sha256 "96db869685bdcfeb45f7ec36f438b253d35b70d7f7f11354c99c0daca8af1bc4" => :high_sierra
    sha256 "088e0d81dd58de384d59868a56cef684ef0bb48c6122d3a5c75221d381eb6e02" => :sierra
    sha256 "68d7b180a51289bfe61eb1182a00cd1b51adfd32f4df475941e4081194499735" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "cairo"
  depends_on "fltk"
  depends_on "gcc" # for gfortran
  depends_on "open-mpi"
  depends_on "opencascade"

  def install
    args = std_cmake_args + %W[
      -DENABLE_OS_SPECIFIC_INSTALL=0
      -DGMSH_BIN=#{bin}
      -DGMSH_LIB=#{lib}
      -DGMSH_DOC=#{pkgshare}/gmsh
      -DGMSH_MAN=#{man}
      -DENABLE_BUILD_LIB=ON
      -DENABLE_BUILD_SHARED=ON
      -DENABLE_NATIVE_FILE_CHOOSER=ON
      -DENABLE_PETSC=OFF
      -DENABLE_SLEPC=OFF
      -DENABLE_OCC=ON
    ]

    ENV["CASROOT"] = Formula["opencascade"].opt_prefix

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"

      # Move onelab.py into libexec instead of bin
      mkdir_p libexec
      mv bin/"onelab.py", libexec
    end
  end

  test do
    system "#{bin}/gmsh", "#{share}/doc/gmsh/tutorial/t1.geo", "-parse_and_exit"
  end
end

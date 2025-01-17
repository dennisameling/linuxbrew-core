class Dbmate < Formula
  desc "Lightweight, framework-agnostic database migration tool"
  homepage "https://github.com/amacneil/dbmate"
  url "https://github.com/amacneil/dbmate/archive/v1.12.1.tar.gz"
  sha256 "63aaa1ec734e62d52331ee80706b24e9e3abc856a26d8e8289ce9228d38d87c8"
  license "MIT"
  head "https://github.com/amacneil/dbmate.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a7e44584e98abac0f1ee3724238308cc320de4d80ef8bc161727392c948a1b32"
    sha256 cellar: :any_skip_relocation, big_sur:       "24765d6c4a62dbe0da38fadece43cd5370496187b1c0cc8f46c385155aad2d27"
    sha256 cellar: :any_skip_relocation, catalina:      "20c977cf5fd8c4770eed868e1143b2b4faa1897f94628fb325a535b62745912c"
    sha256 cellar: :any_skip_relocation, mojave:        "daabcc8391777571779235dd6bb86a04b8a8505ca64efd3c8c8c4aa455faa925"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b6ffbff7fea5bcc6f53becab962894d5e1a5f0960a14223974033d696ec77d71" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s", "-o", bin/"dbmate", "."
  end

  test do
    (testpath/".env").write("DATABASE_URL=sqlite3:test.sqlite3")
    system bin/"dbmate", "create"
    assert_predicate testpath/"test.sqlite3", :exist?, "failed to create test.sqlite3"
  end
end

class Flow < Formula
  desc "Static type checker for JavaScript"
  homepage "https://flowtype.org/"
  url "https://github.com/facebook/flow/archive/v0.160.2.tar.gz"
  sha256 "eeb2b1b7305fd0f8090564a382c2b38f0dd952d5f34f56dd7f960daea0a7fbc8"
  license "MIT"
  head "https://github.com/facebook/flow.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a4b5b3b85872b71dac4b7d0c3ad1c60affdeec4abd052415bf524a3a552eff74"
    sha256 cellar: :any_skip_relocation, big_sur:       "c0e5aed264308227b37eb2e40ea09ac67acdbe2e2869b9fcc44b5a776de123ee"
    sha256 cellar: :any_skip_relocation, catalina:      "e5720a4d8bb642e2bfbab5f605f7d4fca4a74bf6668a12c904c2932629ff78d0"
    sha256 cellar: :any_skip_relocation, mojave:        "a374b19d73da6b3d60ec71edd489af627016345fb7b2cc6d71c530c07a2a3cbc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3f0c3eb0418f32d01a63f798cc7c61f192b5a73237e55751291a7c0c5a8e8720" # linuxbrew-core
  end

  depends_on "ocaml" => :build
  depends_on "opam" => :build

  uses_from_macos "m4" => :build
  uses_from_macos "rsync" => :build
  uses_from_macos "unzip" => :build

  def install
    system "make", "all-homebrew"

    bin.install "bin/flow"

    bash_completion.install "resources/shell/bash-completion" => "flow-completion.bash"
    zsh_completion.install_symlink bash_completion/"flow-completion.bash" => "_flow"
  end

  test do
    system "#{bin}/flow", "init", testpath
    (testpath/"test.js").write <<~EOS
      /* @flow */
      var x: string = 123;
    EOS
    expected = /Found 1 error/
    assert_match expected, shell_output("#{bin}/flow check #{testpath}", 2)
  end
end

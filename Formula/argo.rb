class Argo < Formula
  desc "Get stuff done with container-native workflows for Kubernetes"
  homepage "https://argoproj.io"
  url "https://github.com/argoproj/argo-workflows.git",
      tag:      "v3.1.7",
      revision: "5463b5d4feb626ac80def3c521bd20e6a96708c4"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6940caa433c4810661dad17c6031011dbea530487e71e45b4e2423f9f2aeedc1"
    sha256 cellar: :any_skip_relocation, big_sur:       "0e5c4cc8245d883e498ddc17031c3583b15d059f8eec0ce657d6ae31163be1ba"
    sha256 cellar: :any_skip_relocation, catalina:      "514aafddbb52e74c8452eed301922b87bcd92501da7c00ba53fa451500e03b33"
    sha256 cellar: :any_skip_relocation, mojave:        "95f80d672a29bf978123660b6bad97710fe49dc735c411bca884164ab6765723"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2e4b3b74e2133a35442647f35af7144ff44240b528d9811289f4bb95eace7d8d" # linuxbrew-core
  end

  depends_on "go" => :build
  depends_on "node@14" => :build
  depends_on "yarn" => :build

  def install
    # this needs to be remove to prevent multiple 'operation not permitted' errors
    inreplace "Makefile", "CGO_ENABLED=0", ""
    system "make", "dist/argo"
    bin.install "dist/argo"

    output = Utils.safe_popen_read("#{bin}/argo", "completion", "bash")
    (bash_completion/"argo").write output
    output = Utils.safe_popen_read("#{bin}/argo", "completion", "zsh")
    (zsh_completion/"_argo").write output
  end

  test do
    assert_match "argo:",
      shell_output("#{bin}/argo version")

    # argo consumes the Kubernetes configuration with the `--kubeconfig` flag
    # Since it is an empty file we expect it to be invalid
    touch testpath/"kubeconfig"
    assert_match "invalid configuration",
      shell_output("#{bin}/argo lint --kubeconfig ./kubeconfig ./kubeconfig 2>&1", 1)
  end
end

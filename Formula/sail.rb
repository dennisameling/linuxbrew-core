class Sail < Formula
  include Language::Python::Virtualenv

  desc "CLI toolkit to provision and deploy WordPress applications to DigitalOcean"
  homepage "https://sailed.io"
  url "https://files.pythonhosted.org/packages/be/bb/ae362ed80eccff1dc7b36139ecabb6a8eabdbed29dce1f8d5ac32231ab1f/sailed.io-0.9.14.tar.gz"
  sha256 "b4dae70770bab424c0deea2056ad8734098d22dce75971a61b6eb03c1147e487"
  license "GPL-3.0-only"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4119b62e8ee568d46d88cf6e9239b9b92d91fcc20b7830d2bd9152a2ca1967e4"
    sha256 cellar: :any_skip_relocation, big_sur:       "1326d6e9cc2c18462bdb005f4ed0336b82b9d7f36bf598c940a607bcef2c7b6b"
    sha256 cellar: :any_skip_relocation, catalina:      "bf0e68d74fa4d1cc2589ef52c4ceb7785e8289582410ed8bb3868b8dde3f07f2"
    sha256 cellar: :any_skip_relocation, mojave:        "95b6731a8c29094002dc5ce1cf99efd8286657b24c91fd108ab9e76a0f1163fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1df0d98ebe2196c62d9e3715ff07934782bb857506837660673762102fd5e8bd" # linuxbrew-core
  end

  depends_on "python@3.9"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/6d/78/f8db8d57f520a54f0b8a438319c342c61c22759d8f9a1cd2e2180b5e5ea9/certifi-2021.5.30.tar.gz"
    sha256 "2bbf76fd432960138b3ef6dda3dde0544f27cbf8546c458e60baf371917ba9ee"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/eb/7f/a6c278746ddbd7094b019b08d1b2187101b1f596f35f81dc27f57d8fcf7c/charset-normalizer-2.0.6.tar.gz"
    sha256 "5ec46d183433dcbd0ab716f2d7f29d8dee50505b3fdb40c6b985c7c4f5a3591f"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/21/83/308a74ca1104fe1e3197d31693a7a2db67c2d4e668f20f43a2fca491f9f7/click-8.0.1.tar.gz"
    sha256 "8c04c11192119b1ef78ea049e0a6f0463e4c48ef00a30160c704337586f3ad7a"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/cb/38/4c4d00ddfa48abe616d7e572e02a04273603db446975ab46bbcd36552005/idna-3.2.tar.gz"
    sha256 "467fbad99067910785144ce333826c71fb0e63a425657295239737f7ecd125f3"
  end

  resource "prettytable" do
    url "https://files.pythonhosted.org/packages/00/8d/95441120aa870aa800f8b4c6cf650bf0739d7a41883fe81769ab593556c9/prettytable-2.2.0.tar.gz"
    sha256 "bd81678c108e6c73d4f1e47cd4283de301faaa6ff6220bcd1d4022038c56b416"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/a0/a4/d63f2d7597e1a4b55aa3b4d6c5b029991d3b824b5bd331af8d4ab1ed687d/PyYAML-5.4.1.tar.gz"
    sha256 "607774cbba28732bfa802b54baa7484215f530991055bb562efbed5b2f20a45e"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/e7/01/3569e0b535fb2e4a6c384bdbed00c55b9d78b5084e0fb7f4d0bf523d7670/requests-2.26.0.tar.gz"
    sha256 "b8aa58f8cf793ffd8782d3d8cb19e66ef36f7aba4353eec859e74678b01b07a7"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/80/be/3ee43b6c5757cabea19e75b8f46eaf05a2f5144107d7db48c7cf3a864f73/urllib3-1.26.7.tar.gz"
    sha256 "4987c65554f7a2dbf30c18fd48778ef124af6fab771a377103da0585e2336ece"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/89/38/459b727c381504f361832b9e5ace19966de1a235d73cdbdea91c771a1155/wcwidth-0.2.5.tar.gz"
    sha256 "c4d647b99872929fdb7bdcaa4fbe7f01413ed3d98077df798530e5b04f116c83"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match(version.to_s, shell_output("#{bin}/sail --version"))
    assert_match("Could not parse .sail/config.json", shell_output("#{bin}/sail deploy 2>&1", 1))
  end
end

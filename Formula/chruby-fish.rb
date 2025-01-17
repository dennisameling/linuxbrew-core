class ChrubyFish < Formula
  desc "Thin wrapper around chruby to make it work with the Fish shell"
  homepage "https://github.com/JeanMertz/chruby-fish#readme"
  url "https://github.com/JeanMertz/chruby-fish/archive/v0.8.2.tar.gz"
  sha256 "e3726d39da219f5339f86302f7b5d7b62ca96570ddfcc3976595f1d62e3b34e1"
  license "MIT"
  head "https://github.com/JeanMertz/chruby-fish.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9aa6835f1c13b8d9ab4bfcd0468825d0ae6edba016bdabc88b3ab0f2b521ec74"
    sha256 cellar: :any_skip_relocation, big_sur:       "d097b0d903efe2205f98a92ac47acdd05721368a190d32736b0059ccce6662fd"
    sha256 cellar: :any_skip_relocation, catalina:      "e604e4c2114b462ff23291677a171e77284dccb7a3a0444f26dc293c01890f91"
    sha256 cellar: :any_skip_relocation, mojave:        "ba0ca145d65c92efa34f257219a96d94c4a82800ac5e37b71e3208ed61a82293"
    sha256 cellar: :any_skip_relocation, high_sierra:   "1ebd01df8a1edd51c2b73568c1db57b38a672b530fd0a55d063595370d0c301d"
    sha256 cellar: :any_skip_relocation, sierra:        "1ebd01df8a1edd51c2b73568c1db57b38a672b530fd0a55d063595370d0c301d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "09b1fe583b6d4d1c4c0162cbecd82e99deb3ca3a623fdec950680fd7d882e66d" # linuxbrew-core
  end

  depends_on "chruby"
  depends_on "fish"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match "chruby-fish", shell_output("fish -c '. #{share}/chruby/chruby.fish; chruby --version'")
  end
end

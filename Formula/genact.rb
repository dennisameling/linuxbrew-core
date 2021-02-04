class Genact < Formula
  desc "Nonsense activity generator"
  homepage "https://github.com/svenstaro/genact"
  url "https://github.com/svenstaro/genact/archive/v0.10.0.tar.gz"
  sha256 "c8db67ba56e7c327540cb5a883abcb0ab682378e9dacef79056502f32ad3c759"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b0ca573fdebdaa5c89bb0216c0d550b75b6e887eecbbf70f5ce50407a6b74719"
    sha256 cellar: :any_skip_relocation, big_sur:       "2893eecf7c750540e11f2548800950cba608e9b244975acaa8bc69e4069de7db"
    sha256 cellar: :any_skip_relocation, catalina:      "cda834ea05c4403ebf7555ff32233141eda5d6e1c05cf88c2c601e88d72e27f9"
    sha256 cellar: :any_skip_relocation, mojave:        "a8e61aa9d3683aaedd59154030f154a8bfbfcc8fceec399a1b51b03ae37091d3"
    sha256 cellar: :any_skip_relocation, high_sierra:   "d52830ec3b3744074df6193d3c714f9572472969bc610236813441ea257a8de6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b72b42fc72daada9f96ce7aecacd8a547e5211c526134696761fcde0e6c89c00"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match /Available modules:/, shell_output("#{bin}/genact --list-modules")
  end
end

require "language/perl"

class Po4a < Formula
  include Language::Perl::Shebang

  desc "Documentation translation maintenance tool"
  homepage "https://po4a.org"
  url "https://github.com/mquinson/po4a/releases/download/v0.63/po4a-0.63.tar.gz"
  sha256 "e21be3ee545444bae2fe6a44aeb9d320604708cc2e4c601bcb3cc440db75b4ce"
  license "GPL-2.0-or-later"
  revision 1
  head "https://github.com/mquinson/po4a.git"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "2398df84c002595f8c107f4ed67ba619a3767733129ef6cc7fdf745397dcd249"
    sha256 cellar: :any, big_sur:       "1dc5ba26111d1e86260b4287078bc0cd07cf385d6e3696a0523a8ca4c186e1e9"
    sha256 cellar: :any, catalina:      "7872aead33c8fa1574b49c4afab8b99cecae8d7c6dbe806b1fb5ff05bd47b401"
    sha256 cellar: :any, mojave:        "8b5c19ed360b43c0256a1b0a92bc6bf427c330b6f0cc93421bceb7a0d3c224e5"
  end

  depends_on "docbook-xsl" => :build
  depends_on "gettext"
  depends_on "perl"

  uses_from_macos "libxslt"

  resource "Locale::gettext" do
    url "https://cpan.metacpan.org/authors/id/P/PV/PVANDRY/gettext-1.07.tar.gz"
    sha256 "909d47954697e7c04218f972915b787bd1244d75e3bd01620bc167d5bbc49c15"
  end

  resource "Module::Build" do
    url "https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4231.tar.gz"
    sha256 "7e0f4c692c1740c1ac84ea14d7ea3d8bc798b2fb26c09877229e04f430b2b717"
  end

  resource "Pod::Parser" do
    url "https://cpan.metacpan.org/authors/id/M/MA/MAREKR/Pod-Parser-1.63.tar.gz"
    sha256 "dbe0b56129975b2f83a02841e8e0ed47be80f060686c66ea37e529d97aa70ccd"
  end

  resource "SGMLS" do
    url "https://cpan.metacpan.org/authors/id/R/RA/RAAB/SGMLSpm-1.1.tar.gz"
    sha256 "550c9245291c8df2242f7e88f7921a0f636c7eec92c644418e7d89cfea70b2bd"
  end

  resource "TermReadKey" do
    url "https://cpan.metacpan.org/authors/id/J/JS/JSTOWE/TermReadKey-2.38.tar.gz"
    sha256 "5a645878dc570ac33661581fbb090ff24ebce17d43ea53fd22e105a856a47290"
  end

  resource "Text::WrapI18N" do
    url "https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-WrapI18N-0.06.tar.gz"
    sha256 "4bd29a17f0c2c792d12c1005b3c276f2ab0fae39c00859ae1741d7941846a488"
  end

  resource "Unicode::GCString" do
    url "https://cpan.metacpan.org/authors/id/N/NE/NEZUMI/Unicode-LineBreak-2019.001.tar.gz"
    sha256 "486762e4cacddcc77b13989f979a029f84630b8175e7fef17989e157d4b6318a"
  end

  resource "YAML::Tiny" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/YAML-Tiny-1.73.tar.gz"
    sha256 "bc315fa12e8f1e3ee5e2f430d90b708a5dc7e47c867dba8dce3a6b8fbe257744"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", libexec/"lib"

    resources.each do |r|
      r.stage do
        system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}", "NO_MYMETA=1"
        system "make", "install"
      end
    end

    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"

    inreplace "Po4aBuilder.pm", "PERL5LIB=lib", "PERL5LIB=lib:#{ENV["PERL5LIB"]}" unless OS.mac?

    system "perl", "Build.PL", "--install_base", libexec
    system "./Build"
    system "./Build", "install"

    shell_scripts = %w[po4a-display-man po4a-display-pod]

    %w[msguntypot po4a po4a-display-man po4a-display-pod
       po4a-gettextize po4a-translate po4a-normalize po4a-updatepo].each do |cmd|
      rewrite_shebang detected_perl_shebang, libexec/"bin"/cmd unless shell_scripts.include? cmd

      (bin/cmd).write_env_script(libexec/"bin"/cmd, PERL5LIB: ENV["PERL5LIB"])
    end

    man1.install Dir[libexec/"man/man1/{msguntypot.1p.gz,po4a*}"]
    man3.install Dir[libexec/"man/man3/Locale::Po4a::*"]
    man7.install Dir[libexec/"man/man7/*"]
  end

  test do
    (testpath/"en.tex").write <<~EOS
      \\documentclass[a4paper]{article}
      \\begin{document}
      Hello from Homebrew!
      \\end{document}
    EOS

    system bin/"po4a-gettextize", "-f", "asciidoc", "-m", "en.tex", "-p", "out.pot"
    assert_match "Hello from Homebrew!", (testpath/"out.pot").read
  end
end

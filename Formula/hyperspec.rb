class Hyperspec < Formula
  desc "Common Lisp ANSI-standard Hyperspec"
  homepage "https://www.lispworks.com/documentation/common-lisp.html"
  url "http://ftp.lispworks.com/pub/software_tools/reference/HyperSpec-7-0.tar.gz"
  version "7.0"
  sha256 "1ac1666a9dc697dbd8881262cad4371bcd2e9843108b643e2ea93472ba85d7c3"

  livecheck do
    url :homepage
    regex(/href=.*?HyperSpec[._-]v?(\d+(?:[.-]\d+)+)\.t/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| match&.first&.gsub("-", ".") }
    end
  end

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4c7fdfee29fd4e726c9ec8aa42bb0b23d19024a86c04c2edde0e48bc51dfcdb4" # linuxbrew-core
  end

  def install
    doc.install Dir["*"]
  end

  def caveats
    <<~EOS
      To use this copy of the HyperSpec with SLIME, put the following in
      your .emacs initialization file:

      (eval-after-load "slime"
        '(progn
           (setq common-lisp-hyperspec-root
                 "#{HOMEBREW_PREFIX}/share/doc/hyperspec/HyperSpec/")
           (setq common-lisp-hyperspec-symbol-table
                 (concat common-lisp-hyperspec-root "Data/Map_Sym.txt"))
           (setq common-lisp-hyperspec-issuex-table
                 (concat common-lisp-hyperspec-root "Data/Map_IssX.txt"))))

    EOS
  end

  test do
    assert_predicate doc/"HyperSpec-README.text", :exist?
  end
end

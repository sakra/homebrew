class Lcab < Formula
  homepage "http://ohnopub.net/~ohnobinki/lcab/"
  url "ftp://mirror.ohnopub.net/mirror/lcab-1.0b12.tar.gz"
  mirror "https://launchpad.net/ubuntu/intrepid/+source/lcab/1.0b12-3/+files/lcab_1.0b12.orig.tar.gz"
  sha1 "3e5a1f23f0ea1c991e80322592e3ede9f38ecd94"

  bottle do
    cellar :any
    sha1 "59abd5c575ebef28014ece5e5eed683a708e743d" => :yosemite
    sha1 "baa794d78fdb16b1ce38e1f3bfbcc7d0898e6900" => :mavericks
    sha1 "4f16ad16bcd28d90c26760d7ffe3ea540d6cf46c" => :mountain_lion
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test").write "a test"

    system "#{bin}/lcab", "test", "test.cab"
    assert File.exist? "test.cab"
  end
end

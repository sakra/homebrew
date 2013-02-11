require 'formula'

class Ccache < Formula
  homepage 'http://ccache.samba.org/'
  url 'http://samba.org/ftp/ccache/ccache-3.1.9.tar.bz2'
  sha1 'e80a5cb7301e72f675097246d722505ae56e3cd3'

  def install
    ENV.llvm
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make"
    system "make install"

    libexec.mkpath

    %w[
      cc
      gcc gcc2 gcc3 gcc-3.3 gcc-4.0 gcc-4.2 gcc-4.7
      c++ c++3 c++-3.3 c++-4.0 c++-4.2 c++-4.7
      g++ g++2 g++3 g++-3.3 g++-4.0 g++-4.2 g++-4.7
      clang clang++
    ].each do |prog|
      ln_s bin+"ccache", libexec + prog
    end
  end

  def caveats; <<-EOS.undent
    To install symlinks for compilers that will automatically use
    ccache, prepend this directory to your PATH:
      #{libexec}

    If this is an upgrade and you have previously added the symlinks to
    your PATH, you will need to modify it to the path specified above so
    it points to the new version.

    NOTE: ccache can prevent some software from compiling.
    EOS
  end
end

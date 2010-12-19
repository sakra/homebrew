require 'formula'

class Clapack <Formula
  url 'http://www.netlib.org/clapack/clapack-3.2.1.tgz'
  homepage 'http://www.netlib.org/clapack/'
  md5 '040da31f3a7d4fbc9ac376c748d18d1f'

  def patches; DATA; end

  def install
    # makefiles do not work in parallel mode
    ENV.deparallelize
    ENV.append 'CFLAGS', "-I$(TOPDIR)/INCLUDE -DNO_BLAS_WRAP"
    cp 'make.inc.example', 'make.inc'
    inreplace "make.inc" do |s|
      s.change_make_var! 'PLAT', '_DARWIN'
      s.change_make_var! "CC", ENV['CC']
      s.change_make_var! 'CFLAGS', ENV['CFLAGS']
      s.change_make_var! "LOADER", ENV['LD']
      s.change_make_var! 'LOADOPTS', ENV['LDFLAGS']
    end
    system "make"
    system "make cblaswrap"
    system "make fblaswrap"
    (include + name).install Dir['INCLUDE/*.h']
    (include + name).install Dir['BLAS/WRAP/*.h']
    lib.install "lapack_DARWIN.a" => 'libclapack.a'
    lib.install "blas_DARWIN.a" => 'libcblas.a'
    lib.install "libcblaswr.a"
    lib.install "libfblaswr.a"
    lib.install "F2CLIBS/libf2c.a"
  end
end

__END__
diff --git a/F2CLIBS/libf2c/Makefile b/F2CLIBS/libf2c/Makefile
index d3b7ab4..8866b16 100644
--- a/F2CLIBS/libf2c/Makefile
+++ b/F2CLIBS/libf2c/Makefile
@@ -19,8 +19,8 @@ include ../../make.inc
 # compile, then strip unnecessary symbols
 .c.o:
 	$(CC) -c -DSkip_f2c_Undefs $(CFLAGS) $*.c
-	ld -r -x -o $*.xxx $*.o
-	mv $*.xxx $*.o
+#	ld -r -x -o $*.xxx $*.o
+#	mv $*.xxx $*.o
 ## Under Solaris (and other systems that do not understand ld -x),
 ## omit -x in the ld line above.
 ## If your system does not have the ld command, comment out

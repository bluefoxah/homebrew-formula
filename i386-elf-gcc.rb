require 'formula'

class I386ElfGcc < Formula
  desc "The GNU Compiler Collection"
  homepage "https://gcc.gnu.org"
  url "https://ftpmirror.gnu.org/gcc/gcc-4.9.3/gcc-4.9.3.tar.bz2"
  mirror "https://ftp.gnu.org/gnu/gcc/gcc-4.9.3/gcc-4.9.3.tar.bz2"
  sha256 "2332b2a5a321b57508b9031354a8503af6fdfb868b8c1748d33028d100a8b67e"

  head "svn://gcc.gnu.org/svn/gcc/branches/gcc-4_9-branch"

  depends_on 'gmp4'
  depends_on 'libmpc08'
  depends_on 'mpfr2'
  depends_on "cloog018"
  depends_on "isl011"
  depends_on 'i386-elf-binutils'

  def install
    ENV.delete 'LD'
    binutils = Formula.factory 'i386-elf-binutils'

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i386-elf',
                             "--prefix=#{prefix}",
                             "--enable-languages=c,c++",
                             "--with-gmp=#{Formula["gmp4"].opt_prefix}",
                             "--with-mpfr=#{Formula["mpfr2"].opt_prefix}",
                             "--with-mpc=#{Formula["libmpc08"].opt_prefix}",
                             "--with-cloog=#{Formula["cloog018"].opt_prefix}",
                             "--with-isl=#{Formula["isl011"].opt_prefix}",
                             "--with-system-zlib",
                             "--disable-werror",
                             "--without-headers"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"i386-elf", prefix/"i386-elf"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end

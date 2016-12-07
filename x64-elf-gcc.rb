require 'formula'

class X64ElfGcc < Formula
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
  depends_on 'x64-elf-binutils'

  def install
    binutils = Formula.factory 'x64-elf-binutils'

    ENV['CC'] = '/usr/local/bin/gcc-4.2'
    ENV['CXX'] = '/usr/local/bin/g++-4.2'
    ENV['CPP'] = '/usr/local/bin/cpp-4.2'
    ENV['LD'] = '/usr/local/bin/gcc-4.2'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=x86_64-elf',
                             "--prefix=#{prefix}",
                             "--enable-languages=c,c++",
                             "--without-headers"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"x86_64-elf", prefix/"x86_64-elf"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end

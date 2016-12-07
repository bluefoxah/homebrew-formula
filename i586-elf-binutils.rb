require 'formula'

class I586ElfBinutils < Formula
  homepage "http://www.gnu.org/software/binutils/binutils.html"
  url "http://ftpmirror.gnu.org/binutils/binutils-2.25.tar.gz"
  mirror "http://ftp.gnu.org/gnu/binutils/binutils-2.25.tar.gz"
  version "2.25"
  sha256 "cccf377168b41a52a76f46df18feb8f7285654b3c1bd69fc8265cb0fc6902f2d"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--infodir=#{info}",
                          "--mandir=#{man}",
                          "--target=i586-elf",
                          "--disable-werror",
                          "--enable-interwork"
    system "make"
    system "make", "install"
    FileUtils.rm_rf share
  end

end

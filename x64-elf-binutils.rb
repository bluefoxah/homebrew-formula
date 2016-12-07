require 'formula'

class X64ElfBinutils < Formula
  homepage "http://www.gnu.org/software/binutils/binutils.html"
  url "http://ftpmirror.gnu.org/binutils/binutils-2.25.tar.gz"
  mirror "http://ftp.gnu.org/gnu/binutils/binutils-2.25.tar.gz"
  version "2.25"
  sha256 "cccf377168b41a52a76f46df18feb8f7285654b3c1bd69fc8265cb0fc6902f2d"

  depends_on 'gcc49' => :build

  def install
    ENV['CC'] = '/usr/local/bin/gcc-4.9'
    ENV['CXX'] = '/usr/local/bin/g++-4.9'
    ENV['CPP'] = '/usr/local/bin/cpp-4.9'
    ENV['LD'] = '/usr/local/bin/gcc-4.9'

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=x86_64-elf',
                             '--enable-gold=yes',
                             "--prefix=#{prefix}"
      system 'make all'
      system 'make install'
      FileUtils.mv lib, libexec
    end
  end

end

require 'formula'

class ArmElfGdb < Formula
  homepage "https://www.gnu.org/software/gdb/"
  url "http://ftpmirror.gnu.org/gdb/gdb-7.9.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gdb/gdb-7.9.tar.xz"
  version "7.9"
  sha256 "9b315651a16528f7af8c7d8284699fb0c965df316cc7339bb0b7bae335848392"

  depends_on 'arm-elf-binutils'
  depends_on 'arm-elf-gcc'

  def install
    ENV['CC'] = '/usr/local/bin/gcc-4.2'
    ENV['CXX'] = '/usr/local/bin/g++-4.2'
    ENV['CPP'] = '/usr/local/bin/cpp-4.2'
    ENV['LD'] = '/usr/local/bin/gcc-4.2'

    mkdir 'build' do
      system '../configure', '--target=arm-elf-eabi', "--prefix=#{prefix}"
      system 'make'
      system 'make install'
      FileUtils.rm_rf share/"locale"
      FileUtils.mv lib, libexec
    end
  end
end

#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Copyright (C) 2016 Scarlett Clark <sgclark@kde.org>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) version 3, or any
# later version accepted by the membership of KDE e.V. (or its
# successor approved by the membership of KDE e.V.), which shall
# act as a proxy defined in Section 6 of version 3 of the license.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library.  If not, see <http://www.gnu.org/licenses/>.
require 'yaml'




class Sources
  attr_accessor :name

  def initialize()
    Dir.chdir('/')
    unless Dir.exist?("/app/src")
      Dir.mkdir("/app/src")
    end
    Dir.chdir('/app/src/')
  end

  def get_source(name, type, url, branch='master')
    case "#{type}"
    when 'git'
      Dir.chdir('/app/src/')
      unless Dir.exist?("/app/src/#{name}")
        system( "git clone #{url}")
        unless branch == 'master'
          Dir.chdir("/app/src/#{name}")
          system(" git checkout #{branch}")
        end
      end
    when 'xz'
      Dir.chdir('/app/src/')
      unless Dir.exist?("/app/src/#{name}")
        system("wget #{url}")
        system("tar -xvf #{name}.tar.xz")
      end
    when 'gz'
      Dir.chdir('/app/src/')
      unless Dir.exist?("/app/src/#{name}")
        system("wget #{url}")
        system("tar -zxvf #{name}.tar.gz")
      end
    when 'bz2'
      Dir.chdir('/app/src/')
      unless Dir.exist?("/app/src/#{name}")
        system("wget #{url}")
        system("tar -jxvf #{name}.tar.bz2")
      end
    when 'mercurial'
      Dir.chdir('/app/src')
      unless Dir.exist?("/app/src/#{name}")
        system("hg clone #{url}")
      end
    when 'none'
      p "No sources configured"
    else
      "You gave me #{type} -- I have no idea what to do with that."
    end
    $?.exitstatus
  end

  def run_build(name, buildsystem, options)
    ENV['PATH'] = '/app/usr/bin:/app/vlc/extras/tools/build/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
    ENV['LD_LIBRARY_PATH'] = '/app/usr/lib:/app/usr/lib/x86_64-linux-gnu:/app/vlc/extras/tools/build/lib:/app/usr/lib/Qt-5.7.0:/usr/lib64:/usr/lib:/lib:/lib64'
    ENV['CFLAGS']="-g -O2 -fPIC"
    ENV['PKG_CONFIG_PATH']='/app/usr/lib/x86_64-linux-gnu/pkgconfig:/app/usr/lib/pkgconfig:/app/usr/share/pkgconfig:/app/src/vlc/contrib/x86_64-linux-gnu/lib/pkgconfig:/usr/share/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/vlc/contrib/x86_64-linux-gnu/lib/pkgconfig:/usr/share/pkgconfig'
    ENV['ACLOCAL_PATH']='/app/usr/share/aclocal:/usr/share/aclocal'
    ENV['CPLUS_INCLUDE_PATH']='/app/usr/include:/opt/usr/include:/usr/include'
    ENV.fetch('PATH')
    ENV.fetch('LD_LIBRARY_PATH')
    ENV.fetch('CFLAGS')
    ENV.fetch('PKG_CONFIG_PATH')
    ENV.fetch('ACLOCAL_PATH')
    ENV.fetch('CPLUS_INCLUDE_PATH')
    case "#{buildsystem}"
    when 'make'
      Dir.chdir("/app/src/#{name}") do
        p ENV['PATH']
        p ENV['LD_LIBRARY_PATH']
        p "running ./configure --prefix=/app/usr #{options}"
        unless "#{options}".empty? == false
          system("autoreconf --force --install && ./configure --prefix=/app/usr #{options}")
        end
        if "#{options}".empty? == false
          system("#{options}")
        end
        system('make -j 8 && sudo make install prefix=/app/usr')
      end
    when 'cmake'
      Dir.chdir("/app/src/#{name}") do
        p "running cmake #{options}"
        p ENV['PATH']
        p ENV['LD_LIBRARY_PATH']
        system("/app/usr/bin/cmake #{options}")
        system('make -j 8 && sudo make install')
      end
    when 'custom'
      unless "#{name}" == 'cpan'
        Dir.chdir("/app/src/#{name}") do
          p "running #{options}"
          p ENV['PATH']
          p ENV['LD_LIBRARY_PATH']
          system("#{options}")
        end
      end
      if "#{name}" == 'cpan'
        p "running #{options}"
        system("#{options}")
      end
    when 'qmake'
      Dir.chdir("/app/src/#{name}") do
        p "running qmake #{options}"
        p ENV['PATH']
        p ENV['LD_LIBRARY_PATH']
        system('echo $PATH')
        system("/app/usr/bin/qmake linuxdeployqt.pro")
        system('make -j 8 && sudo make install')
      end
    when 'bootstrap'
      Dir.chdir("/app/src/#{name}") do
        p "running ./bootstrap #{options}"
        p ENV['PATH']
        p ENV['LD_LIBRARY_PATH']
        system("./bootstrap #{options}")
        if File.exist?('configure')
          system("./configure #{options}")
        end
        system('make -j 8 && sudo make install')
      end
    else
    "You gave me #{buildsystem} -- I have no idea what to do with that."
    end
    $?.exitstatus
  end
end

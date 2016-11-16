sudo add-apt-repository --yes ppa:ubuntu-toolchain-r/test
sudo apt-get -y update
sudo apt-get --yes --force-yes install  gcc-6 g++-6
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6

export PATH=/app/usr/bin:/app/vlc/extras/tools/build/bin:$PATH
export LD_LIBRARY_PATH=/app/usr/lib:/app/usr/lib/x86_64-linux-gnu:/app/vlc/extras/tools/build/lib:/usr/lib64:/usr/lib:/app/usr/lib/Qt-5.7.0:$LD_LIBRARY_PATH
export XDG_CONFIG_DIRS=/app/etc/xdg:/etc/xdg/xdg-plasma:/etc/xdg:/usr/share/:/root/.qttest/config
export XDG_DATA_DIRS=/app/usr:/app/usr/share:/usr:/usr/share:/root/.local/share
export XDG_DATA_HOME=$XDG_DATA_HOME:/root/.qttest/share:/root/.local/share
export XDG_RUNTIME_DIR=/tmp/xdg-runtime-dir
export XDG_CACHE_HOME=/root/.qttest/cache
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/vlc/contrib/x86_64-linux-gnu/lib/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH
export ACLOCAL_PATH=/usr/share/aclocal:$ACLOCAL_PATH
export LIBTOOL=/app/usr/bin/libtool
export CPLUS_INCLUDE_PATH=/app/usr/include:/opt/usr/include:/usr/include:$CPLUS_INCLUDE_PATH

cd /app/src/vlc/contrib
mkdir native
cd native
../bootstrap --prefix=/app/usr --disable-bluray --disable-util-macros
autoreconf --force --install && ./configure --prefix=/app/usr
make -j 8

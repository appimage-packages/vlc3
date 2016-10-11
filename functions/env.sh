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
# Build failures without this, putting at top for consistancy
export CFLAGS=-fPIC

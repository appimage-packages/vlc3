
add-apt-repository --yes ppa:ubuntu-toolchain-r/test
apt-get update
apt-get --yes --force-yes install  gcc-6 g++-6
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6

update-alternatives --config gcc

gcc --version
export PATH=/app/usr/bin:/app/vlc/extras/tools/build/bin:$PATH
export LD_LIBRARY_PATH=/app/usr/lib:/app/usr/lib/x86_64-linux-gnu:/app/vlc/extras/tools/build/lib:/usr/lib64:/usr/lib:/opt/usr/lib/Qt-5.7.0:$LD_LIBRARY_PATH
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
../bootstrap --prefix=/app/usr --disable-xorg-macros --disable-gettext --disable-qt --enable-openjpeg \
 --enable-ffmpeg --disable-SDL_image --disable-a52dec --disable-a52 \
 --disable-aribb24 --disable-aribb25 --disable-asdcplib --disable-ass --disable-bghudappkit --disable-bluray \
 --disable-bpg --disable-caca --enable-cddb --disable-chromaprint --disable-crystalhd --disable-d3d11 \
 --disable-d3d9 --disable-daala --disable-dca --disable-directx --disable-dshow --disable-dvbpsi \
 --disable-dvdcss --disable-dvdread --disable-dvdnav --disable-libebml --disable-faad2 --disable-ffi \
 --disable-flac --disable-gsml --disable-fluid --disable-fluidlite --disable-fontconfig \
 --disable-freetype2 --disable-fribidi --disable-gcrypt --disable-glew --disable-glib --disable-gme \
 --disable-gmp --disable-gnutls --disable-goom --disable-gpg-error --disable-growl  --disable-gsm \
 --disable-harfbuzz --disable-iconv --disable-jack --disable-jpeg --disable-kate --disable-lame \
 --disable-libarchive --disable-libdsm --disable-libmpeg2 --disable-libtasn1 --disable-libxml2 \
 --disable-live555 --disable-lua --disable-mad --disable-matroska --disable-mfx --disable-microdns \
 --disable-modplug --disable-mpcdec --disable-mpg123 --disable-ncurses --disable-nettle --disable-nfs\
 --disable-ogg --disable-opus --disable-orc --disable-png --disable-postproc \
 --disable-projectM --disable-protobuf --disable-pthreads --disable-regex \
 --disable-samplerate --disable-schroedinger --disable-sdl --disable-shout --disable-sidplay2 \
 --disable-soxr --disable-sparkle --disable-speex --disable-speexdsp --disable-sqlite --disable-ssh2 \
 --disable-taglib --disable-theora --disable-tiff --disable-tiger --disable-tremor --disable-twolame \
 --disable-upnp --disable-vncclient --disable-vorbis --disable-vpx --disable-x264 --disable-x265 \
 --disable-xau --disable-xcb-proto --disable-xcb --disable-xproto --disable-zlib \
 --disable-zvbi


make -j 8

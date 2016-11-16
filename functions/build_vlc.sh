#!/bin/bash
cd /app/src/vlc
./bootstrap
./configure --disable-chromaprint --disable-bluray --enable-alsa=true --enable-pulse --disable-chromecast \
--prefix=/app/usr

make -j 8

make install

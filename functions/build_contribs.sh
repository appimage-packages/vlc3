sudo add-apt-repository --yes ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get --yes --force-yes install  gcc-6 g++-6
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6

#Fix broken crap.
sed -i '/$(UPDATE_AUTOCONFIG)/d' /app/src/vlc/contrib/src/dca/rules.mak
sed -i '/$(UPDATE_AUTOCONFIG)/d' /app/src/vlc/contrib/src/dvbpsi/rules.mak
sed -i '/$(UPDATE_AUTOCONFIG)/d' /app/src/vlc/contrib/src/libmpeg2/rules.mak
sed -i '/$(UPDATE_AUTOCONFIG)/d' /app/src/vlc/contrib/src/libsamplerate/rules.mak
sed -i '/$(UPDATE_AUTOCONFIG)/d' /app/src/vlc/contrib/src/twolame/rules.mak
sed -i '/$(UPDATE_AUTOCONFIG)/d' /app/src/vlc/contrib/src/samplerate/rules.mak
cd /app/src/vlc/contrib
mkdir native
cd native
../bootstrap --prefix=/app/usr
make -j 8

#!/bin/bash 

echo "Starting initial set up"

# Make sure we have the right modules downloaded
apt install autoconf libtool libdrm-dev xorg xorg-dev openbox libx11-dev libgl1 libglx-mesa0 -y
apt install git cmake pkg-config meson libdrm-dev automake libtool -y

# Make the necessary folders
mkdir -p ~/workspace
cd ~/workspace

# Build and install Libva
echo "Building and installing Libva"
git clone https://github.com/intel/libva.git
cd libva

./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu
make
make install

echo "Libva installed!"

# Build and install gmmlib
echo "Building and installing gmmlib"

cd ~/workspace
git clone https://github.com/intel/gmmlib.git
cd gmmlib
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j"$(nproc)"
make install

echo "gmmlib installed!"

# Build and install the media driver
echo "Building and installing the drivers"

cd ~/workspace
mkdir media-driver
mkdir build_media

git clone https://github.com/intel/media-driver.git

cd build_media

cmake ../media-driver
make -j"$(nproc)"
make install

echo "Drivers installed!"

echo "Finished!"



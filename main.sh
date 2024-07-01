#! /bin/bash

DEBIAN_FRONTEND=noninteractive
apt-get update

# Clone Upstream
git clone https://gitlab.freedesktop.org/wayland/wayland-protocols.git -b 1.36
cd wayland-protocols
cp -rvf ../debian ./

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/

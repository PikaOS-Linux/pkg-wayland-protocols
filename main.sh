#! /bin/bash

DEBIAN_FRONTEND=noninteractive
apt-get update

# Clone Upstream
git clone https://gitlab.freedesktop.org/wayland/wayland-protocols.git
cd wayland-protocols
git checkout 1.32
cp -rvf ../debian ./
for i in $(cat ../patches/series) ; do echo "Applying Patch: $i" && patch -Np1 -i ../patches/$i || bash -c "echo "Applying Patch $i Failed!" && exit 2"; done

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/

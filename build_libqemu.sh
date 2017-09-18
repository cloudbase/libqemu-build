#!/bin/bash
set -e

cd /build/qemu
git submodule update --init dtc

git reset --hard
git clean -f -d
git apply ../libqemu.diff

rpm -Uvh /build/out/libnfs-*.rpm

./configure
make clean
make libqemu -j4
# Ensure that all shared libs are linked and that the lib loads in Python
python -c "import ctypes; ctypes.CDLL('./libqemu.so')"

mkdir -p /build/out
cp libqemu.so /build/out

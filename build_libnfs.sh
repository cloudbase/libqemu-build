#!/bin/bash
set -e

libnfs_tag=libnfs-1.10.0

mkdir -p /root/rpmbuild/SOURCES
mkdir -p /root/rpmbuild/SPECS

cd /build/libnfs
git reset --hard
git clean -f -d
git checkout $libnfs_tag
git apply ../libnfs.diff

./bootstrap
./configure
make clean
./packaging/RPM/makerpms.sh

cd /root/rpmbuild/RPMS/x86_64/
mkdir -p /build/out
rm /build/out/libnfs-*.rpm || true
cp  libnfs-*.rpm /build/out

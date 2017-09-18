#!/bin/bash
set -e

# Use Python to get the basedir as readlink -f is not working on Macos
basedir=$(python -c 'import os,sys;print(os.path.dirname(os.path.realpath(sys.argv[1])))' "$0")
build_dir="$basedir/build"

docker build -t qemu-build $basedir/docker

mkdir -p $build_dir

cp libnfs.diff $build_dir
cp build_libnfs.sh $build_dir
cp libqemu.diff $build_dir
cp build_libqemu.sh $build_dir

cd $build_dir

if [ ! -d libnfs ]; then
    git clone https://github.com/sahlberg/libnfs
fi

if [ ! -d qemu ]; then
    git clone https://github.com/qemu/qemu
fi

docker run -ti --name build_libnfs -v $build_dir:/build qemu-build /build/build_libnfs.sh
docker rm build_libnfs

docker run -ti --name build_qemu -v $build_dir:/build qemu-build /build/build_libqemu.sh
docker rm build_qemu

echo ""
echo "Done! Get your freshly built binaries from: $build_dir/out"

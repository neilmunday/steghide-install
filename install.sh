#!/bin/bash

#
# Helper script to install steghide (with patches) by Neil Munday.
#
# Tested on CentOS 7 (x86_64)
#
# Uses patches from Arch Linux: https://git.archlinux.org/svntogit/community.git/tree/trunk?h=packages/steghide
#
# Usage:
#
# ./install.sh path/to/install/to
#

function die {
	echo $1
	exit 1
}

function checkExe {
	if ! command -v $1 > /dev/null 2>&1; then
		echo "$1 does not exist, please install"
		exit 1
	fi
}

if [ -z $1 ]; then
	die "Please specify directory to install to, e.g. $HOME/install"
fi

installdir=$1

if [ ! -d $installdir ]; then
	die "$installdir does not exist, please create it first"
fi

exes="patch
make
gcc
g++
libtool
autoreconf
tar
touch"

for e in $exes; do
	checkExe $e
done

basedir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $basedir

mkdir -p build
cd build

version=0.5.1

if [ ! -e steghide-${version}.tar.gz ]; then
	wget http://prdownloads.sourceforge.net/steghide/steghide-${version}.tar.gz?download -O steghide-${version}.tar.gz || die "Download failed"
fi

if [ -d steghide-${version} ]; then
	rm -rf steghide-${version}
fi

tar xvfz steghide-${version}.tar.gz || die "untar failed"

cd steghide-${version}

patch -p1 < ${basedir}/buildsystem.patch || die "buildsystem.patch failed"
patch -Np1 -i ${basedir}/gcc-4.2.patch || die "gcc-4.2.patch failed"
patch -Np1 -i ${basedir}/steghide-climits.patch || die "steghide-climits patch failed"

touch NEWS AUTHORS ChangeLog

autoreconf -i
./configure --prefix=$installdir || die "configure failed"
make -j || die "make failed"
make install || die "make install failed"

echo -e "\nFinished!\nTo use steghide, run ${installdir}/bin/steghide or update your \$PATH environment variable\n"

exit 0


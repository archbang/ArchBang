#!/bin/bash
	ARTWORK="overlay/src/pkgs/archbang-artwork-2010.06-2-$(arch).pkg.tar.xz"
	PLYMOUTH="overlay/src/pkgs/plymouth-git-20100611-1-$(arch).pkg.tar.xz"
	if [ "$1" = "clean" ]; then
	rm -v ./overlay/src/pkgs/*.tar.*
	exit 1
	fi
	
	exec < ./overlay/src/pkgs/packages.extra
	while read package
	do
	pkgs=$(echo "$pkgs $package")
	done

	echo "fetching $pkgs"
	pacman -d -Sw --noconfirm --cachedir ./overlay/src/pkgs $pkgs
if [ -e $ARTWORK ]; then
	echo "Packages already exist"!
	else if [ "$(arch)" = "i686" ]; then
	pushd overlay/src/pkgs/
	wget "http://s2.sigmirror.com/files/84982_mnw1y/archbang-artwork-2010.06-2-i686.pkg.tar.xz"
	popd
	else
	pushd overlay/src/pkgs/
	wget "http://s2.sigmirror.com/files/84732_qzrkg/archbang-artwork-2010.06-2-x86_64.pkg.tar.xz"
	popd
	fi
fi

if [ -e $PLYMOUTH ]; then
	echo "Packages already exist"!
	else if [ "$(arch)" = "i686" ]; then
	pushd overlay/src/pkgs/
	wget "http://s2.sigmirror.com/files/82711_cc3bl/plymouth-git-20100611-1-i686.pkg.tar.xz"
	popd
	else
	pushd overlay/src/pkgs/
	wget "http://s2.sigmirror.com/files/82710_yppu0/plymouth-git-20100611-1-x86_64.pkg.tar.xz"
	popd
	fi
fi

#!/bin/sh
#Script to make AUR packages mentioned in packages.list.aur
#V.-0.3
#AUTHOR - PDG - sHy [pdg@archlinux.us]
# Check if we're root before going ahead
if [ `whoami` != 'root' ]; then
        zenity --info --text="Script needs to be run with root privileges.\nUse \"sudo aurscript.sh\"."
        exit
fi

URL="http://gitorious.org/archbang/archbang/blobs/raw/master/packages.list.aur"
defpath=$(grep PKGDEST /etc/makepkg.conf | cut -d"=" -f2)
echo "Your packages will be by default stored in $defpath"
read -p "Would you like to set a custom storage path? (Y/N):	"
	if [[ "$REPLY" =~ ^[yY] ]]; then
	echo "Enter the exact path to your custom package storage location: "
	read newpath
	mkdir -p $newpath &>/dev/null
	echo "Path successfully created if it didn't already exist!"
#	echo "Now you will be asked for your root password twice for modifying makepkg.conf!"
	sed -i "/PKGDEST/d" /etc/makepkg.conf
	echo "PKGDEST=$newpath" >> /etc/makepkg.conf
	echo "Path changed! Your package location is : $newpath"
	echo "Press Enter to continue"
	read
	cd $newpath
	defpath=$newpath
	else
	echo "Path not changed! Your package location is still : $defpath"
	echo "Press Enter to continue"
	read
	cd $defpath
	fi
wget $URL
for i in $(cat packages.list.aur); do wget http://aur.archlinux.org/packages/$i/$i.tar.gz; done
for a in `ls -1 *.tar.gz`; do tar -zxvf $a; done
rm *.tar.gz
rm packages.list.aur
for dir in $defpath/*
do
  (cd $dir && makepkg -sf --asroot)
done

repo-add $defpath/custom.db.tar.gz $defpath/*.pkg.tar.xz

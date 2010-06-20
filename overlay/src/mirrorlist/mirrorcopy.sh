#!/bin/bash
#Copy Mirrorlist 
DESTDIR="/mnt"
clear
echo
echo
echo -e "\e[01;32m"
head -6 /src/mirrorlist/mirrorlist.$(arch)
echo
echo
echo -e "\e[01;36mCopying mirrorlist . . ."
mv ${DESTDIR}/etc/pacman.d/mirrorlist ${DESTDIR}/etc/pacman.d/mirrorlist.backup
cp /src/mirrorlist/mirrorlist.$(arch) ${DESTDIR}/etc/pacman.d/mirrorlist
echo
echo
echo -e "\e[01;33mPress Enter to Continue . . ."
read
echo -e "\e[00mExiting ..."

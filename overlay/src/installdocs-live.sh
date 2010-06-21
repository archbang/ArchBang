#!/bin/bash
clear
echo
echo
echo "Copying Docs . . ."
rm -f /etc/arch-release &> /dev/null
rm -rf /usr/share/doc/archbang/ &> /dev/null
echo "2010.09 - \"apeiro\" - RC" > /etc/archbang.release
mkdir -p /etc/archbang
echo "1" > /etc/archbang/updater.conf
mkdir -p /usr/share/doc/
cp -r /src/archbang /usr/share/doc/ &> /dev/null
touch /usr/share/doc/archbang/CHANGELOG
echo "GIT log can be found here: /usr/share/doc/archbang/GITLOG" > /usr/share/doc/archbang/CHANGELOG
echo "	" >> /usr/share/doc/CHANGELOG
echo "CHANGES since 2010.06" >> /usr/share/doc/archbang/CHANGELOG
echo "---------------------" >> /usr/share/doc/archbang/CHANGELOG
echo "	" >> /usr/share/doc/archbang/CHANGELOG
pacman -Q | sort >> /usr/share/doc/archbang/CHANGELOG
echo
echo "Done!"
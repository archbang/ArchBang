#!/bin/bash
DESTDIR="/mnt"
clear
echo
echo
echo "Copying Docs . . ."
rm -rf ${DESTDIR}/etc/archbang
rm -rf ${DESTDIR}/usr/share/doc/archbang
rm -f ${DESTDIR}/etc/arch-release &> /dev/null
rm -rf ${DESTDIR}/usr/share/doc/archbang/ &> /dev/null
echo "2010.09 - \"apeiro\" - RC" > ${DESTDIR}/etc/archbang.release
mkdir -p ${DESTDIR}/etc/archbang
cp -a /etc/archbang/*.png ${DESTDIR}/etc/archbang
echo "1" > ${DESTDIR}/etc/archbang/updater.conf
mkdir -p ${DESTDIR}/usr/share/doc/
cp -r /src/archbang ${DESTDIR}/usr/share/doc/ &> /dev/null
touch ${DESTDIR}/usr/share/doc/archbang/CHANGELOG
echo "GIT log can be found here: /usr/share/doc/archbang/GITLOG" > ${DESTDIR}/usr/share/doc/archbang/CHANGELOG
echo "	" >> ${DESTDIR}/usr/share/doc/CHANGELOG
echo "CHANGES since 2010.06" >> ${DESTDIR}/usr/share/doc/archbang/CHANGELOG
echo "---------------------" >> ${DESTDIR}/usr/share/doc/archbang/CHANGELOG
echo "	" >> ${DESTDIR}/usr/share/doc/archbang/CHANGELOG
pacman -Q | sort >> ${DESTDIR}/usr/share/doc/archbang/CHANGELOG
echo
echo "Done!"
clear
echo
echo
echo 
echo -e "\e[01;32m"
echo "Remember to run \"sudo chimera\" after you Login for the first time."
echo "This is essential." 
echo "We recommend using this process to upgrade your packages atleast once a week"!
echo
read -p "Press enter to continue ..."


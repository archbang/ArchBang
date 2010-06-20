#!/bin/bash
DESTDIR="/mnt"
clear
echo
echo
echo
echo
echo "Nvidia Post-Install Configuration is in Progress ...."
echo
if [ -e /root/xorg.conf.new ]; then
echo  "\"nv\" driver will be used! Exiting . . ."
exit
else
echo	"Attempting to remove unnecessary packages . . ."
echo
	pacman -Rsnd xorg-video-drivers -r ${DESTDIR} --noconfirm --noprogressbar &>/dev/null
	pacmn -Rsnd libgl -r ${DESTDIR} --noconfirm --noprogressbar &>/dev/null
        pacman -Ufd /src/pkgs/nvidia-utils* -r ${DESTDIR} --noconfirm --noprogressbar &>/dev/null
        pacman -Ufd /src/pkgs/nvidia-1* -r ${DESTDIR} --noconfirm --noprogressbar &>/dev/null
	rm -f ${DESTDIR}/etc/X11/xorg.conf  &>/dev/null
	cp /etc/X11/xorg.conf ${DESTDIR}/etc/X11/xorg.conf  &>/dev/null
echo
echo "Done!"
fi





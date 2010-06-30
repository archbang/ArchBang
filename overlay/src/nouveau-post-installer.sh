#!/bin/bash
DESTDIR="/mnt"
clear
echo
echo "Nouveau Opensource NVIDIA driver is being installed on your system . . ."
echo
echo "Read more about it here: http://wiki.archlinux.org/index.php/Nouveau"
pacman -Rsnd xorg-video-drivers -r ${DESTDIR} --noconfirm --noprogressbar &>/dev/null
#pacman -Ufd /src/pkgs/nouveau-dri-* -r $DESTDIR --noprogressbar --noconfirm &> /dev/null
#pacman -Ufd /src/pkgs/nouveau-firmware-* -r $DESTDIR --noprogressbar --noconfirm &> /dev/null
#pacman -Ufd /src/pkgs/xf86-video-nouveau-* -r $DESTDIR --noprogressbar --noconfirm &> /dev/null
cp /etc/X11/xorg.conf $DESTDIR/etc/X11/xorg.conf &> /dev/null	
cp /src/kms/mkinitcpio.conf.nouveau $DESTDIR/etc/mkinitcpio.conf
echo "Done."

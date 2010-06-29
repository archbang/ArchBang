#!/bin/bash

pacman -Rsnd xorg-video-drivers --noconfirm --noprogressbar &>/dev/null
pacman -Ufd /src/pkgs/nouveau-dri-* --noprogressbar --noconfirm &> /dev/null
pacman -Ufd /src/pkgs/nouveau-firmware-* --noprogressbar --noconfirm &> /dev/null
pacman -Ufd /src/pkgs/xf86-video-nouveau-* --noprogressbar --noconfirm &> /dev/null
modprobe nouveau 
#X -configure &> /dev/null
#cp /root/xorg.conf.new /etc/X11/xorg.conf &> /dev/null	


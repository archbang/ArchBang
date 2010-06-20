#!/bin/sh
#pacman -Rs $(pacman -Qs xf86-video | grep xf86 | awk '{print $1}' | awk -F /  '{print $2}') --noconfirm --noprogressbar &>/dev/null
pacman -Rsnd xorg-video-drivers --noconfirm --noprogressbar &>/dev/null
pacman -Rd libgl --noconfirm --noprogressbar &>/dev/null
pacman -U $@ --noconfirm --noprogressbar &>/dev/null
rm -f /etc/X11/xorg.conf &> /dev/null
nvidia-xconfig &> /dev/null


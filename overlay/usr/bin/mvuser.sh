#!/bin/sh
clear
if [ -e /home/live ];then
  echo "Only create one user for now!"
  echo
  echo -en "Enter the new username\n=> " && read
  usr1="live"
  usr2="$REPLY"
if [ -e /home/$usr2 ];then
  echo "WARNING: User already exists! Select a new name."
  echo "Press enter to continue..."
  read
  exit 
fi
  echo "Password :"
  useradd -m -s /bin/bash $usr2
  while true; do
   passwd $usr2 && break
  done
  sync
  usermod -G lp,wheel,ftp,hal,log,http,games,video,audio,optical,floppy,storage,power,users $usr2
  echo ""
  for i in $(find /home/$usr1 -type f);do grep "home/$usr1" $i >/dev/null && sed -i "s/home\/$usr1/home\/$usr2/g" $i && echo $i;done
  echo "Done !"
  sleep 1
  echo "Wait..."
  sed -i "s/$usr1/$usr2/g" /etc/group
  sed -i "s/$usr1/$usr2/g" /etc/gshadow
  sed -i "s/$usr1/$usr2/g" /etc/passwd
  sed -i "s/$usr1/$usr2/g" /etc/shadow
  sed -i "s/$usr1/$usr2/g" /etc/sudoers
  echo "Defaults insults" >> /etc/sudoers
  echo "$usr2      ALL=(ALL) ALL" >> /etc/sudoers
  sed -i "s/$usr1/$usr2/" /etc/inittab
  rm -rf /home/$usr2
  mv /home/$usr1 /home/$usr2 &> /dev/null
  rm /home/$usr2/.bash_profile
  rm /home/$usr2/.config/autostart/release.desktop
  rm /home/$usr2/Desktop/Cp2RAM.desktop
  rm /home/$usr2/Desktop/Install.desktop	
  chown $usr2 /home/$usr2
  chgrp $usr2 /home/$usr2
else
  echo "Done !"
  echo "Press enter to continue..."
  read
fi

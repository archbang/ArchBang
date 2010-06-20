#### Change these settings to modify how this ISO is built.
#  The directory that you'll be using for the actual build process.
SHELL = /bin/sh
WORKDIR=archbangftw
#  A list of packages to install, either space separated in a string or line separated in a file. Can include groups.
PACKAGES="$(shell cat packages.list packages.list.aur) syslinux"
# The name of our ISO. Does not specify the architecture!
NAME=archbang
# Version will be appended to the ISO.
VER=2010.06-GIT_apeiro-testing
# Kernel version. You'll need this.
KVER=2.6.33-ARCH
# Architecture will also be appended to the ISO name.
ARCH?=$(shell uname -m)
# Current working directory
PWD:=$(shell pwd)
# This is going to be the full name the final iso/img will carry
FULLNAME="$(PWD)"/$(NAME)-$(VER)-$(ARCH)
# Default make instruction to build everything.
all: archbang

rem:
	$(SHELL) "$(PWD)"/scripts/fetch-pkg.sh
	
# The following will first run the base-fs routine before creating the final iso image.
archbang: rem base-fs 
	touch "$(FULLNAME)".iso
	rm -r "$(FULLNAME)".iso
	mkarchiso -v -p syslinux iso "$(WORKDIR)" "$(FULLNAME)".iso

# This is the main rule for make the working filesystem. It will run routines from left to right. 
# Thus, root-image is called first and syslinux is called last.
base-fs: root-image boot-files initcpio overlay iso-mounts syslinux

# The root-image routine is always executed first. 
# It only downloads and installs all packages into the $WORKDIR, giving you a basic system to use as a base.
root-image: "$(WORKDIR)"/root-image/.arch-chroot
"$(WORKDIR)"/root-image/.arch-chroot:
root-image:
	mkarchiso -v -p $(PACKAGES) create "$(WORKDIR)"

# Rule for make /boot
boot-files: 
	cp -r "$(WORKDIR)"/root-image/boot "$(WORKDIR)"/iso/
	cp -r boot-files/* "$(WORKDIR)"/iso/boot/

# Rules for initcpio images
initcpio: "$(WORKDIR)"/iso/boot/archbang.img
"$(WORKDIR)"/iso/boot/archbang.img: mkinitcpio.conf "$(WORKDIR)"/root-image/.arch-chroot
	mkdir -p "$(WORKDIR)"/iso/boot
	mkinitcpio -c ./mkinitcpio.conf -b "$(WORKDIR)"/root-image -k $(KVER) -g $@

# See: Overlay
overlay:
	mkdir -p "$(WORKDIR)"/overlay/etc/pacman.d
	cp -r overlay "$(WORKDIR)"/
	chmod 0440 "$(WORKDIR)"/overlay/etc/sudoers
	wget -O "$(WORKDIR)"/overlay/etc/pacman.d/mirrorlist http://www.archlinux.org/mirrorlist/$(ARCH)/all/
	sed -i "s/#Server/Server/g" "$(WORKDIR)"/overlay/etc/pacman.d/mirrorlist	
#	chmod 0440 "$(WORKDIR)"/root-image/etc/sudoers
# Rule to process isomounts file.
iso-mounts: "$(WORKDIR)"/isomounts
"$(WORKDIR)"/isomounts: isomounts root-image
	sed "s|@ARCH@|$(ARCH)|g" isomounts > $@

# This routine is always executed just before generating the actual image. 
syslinux:
	mkdir -p $(WORKDIR)/iso/boot/isolinux
	cp $(WORKDIR)/root-image/usr/lib/syslinux/*.c32 $(WORKDIR)/iso/boot/isolinux/
	cp $(WORKDIR)/root-image/usr/lib/syslinux/isolinux.bin $(WORKDIR)/iso/boot/isolinux/	
# In case "make clean" is called, the following routine gets rid of all files created by this Makefile.
clean:
	rm -rf "$(WORKDIR)" "$(FULLNAME)".img "$(FULLNAME)".iso

refresh: overlay boot-files syslinux	
	touch "$(FULLNAME)".iso	
	rm "$(FULLNAME)".iso
	mkarchiso -v -p syslinux iso "$(WORKDIR)" "$(FULLNAME)".iso

.PHONY: all archbang
.PHONY: base-fs
.PHONY: root-image boot-files initcpio overlay iso-mounts
.PHONY: syslinux
.PHONY: clean
.PHONY: refresh

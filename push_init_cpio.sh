#!/usr/bin/env bash

# Get kernel name/version from current Makefile
KERN_VER=`grep ^VERSION\ \= /usr/src/linux/Makefile | awk '{ print $3 };'`
KERN_PAT=`grep ^PATCHLEVEL\ \= /usr/src/linux/Makefile | awk '{ print $3 };'`
KERN_SUB=`grep ^SUBLEVEL\ \= /usr/src/linux/Makefile | awk '{ print $3 };'`
KERN_EXV=`grep ^EXTRAVERSION\ \= /usr/src/linux/Makefile | sed -e "s/EXTRAVERSION =//" -e "s/ //g"`
RD_FILE="initramfs-${KERN_VER}.${KERN_PAT}.${KERN_SUB}${KERN_EXV}.img"

# Compress and output img file to /boot
find . -print0 | cpio --null -ov --format=newc | gzip -9 > /boot/${RD_FILE}

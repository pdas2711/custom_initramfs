#!/usr/bin/env bash

init_src_dir="/usr/src/initramfs"
bins=("/sbin/btrfs" "/bin/busybox" "/usr/sbin/dropbear")


mkdir -p ${init_src_dir}/{bin,dev,etc,lib,lib64,mnt/root,proc,root,sbin,sys,usr/lib,usr/lib64,usr/sbin}

libs=()
for bin in "${bins[@]}"; do
	libs_s=$(lddtree -l ${bin})
	for (( i=1; i<=$(echo "${libs_s}" | wc -l); i++ )); do
		lib_path=$(echo "${libs_s}" | sed -n ${i}p)
		libs+=("${lib_path}")
	done
done

for lib in "${libs[@]}"; do
	echo "Copying ${lib} ..."
	cp -L "${lib}" "${init_src_dir}${lib}"
done

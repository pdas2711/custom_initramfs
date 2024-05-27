#!/usr/bin/env bash

# No trailing forward slashes
init_src_dir="/usr/src/initramfs"
bins=("/sbin/btrfs" "/bin/busybox" "/usr/sbin/dropbear" "/sbin/cryptsetup")
libs=("libgcc_s.so.1")


mkdir -p ${init_src_dir}/{bin,dev,etc,lib,lib64,mnt/root,proc,root,sbin,sys,usr/lib,usr/lib64,usr/sbin,run/cryptsetup}

parsed_libs=()
for bin in "${bins[@]}"; do
	libs_s=$(lddtree -l ${bin})
	for (( i=1; i<=$(echo "${libs_s}" | wc -l); i++ )); do
		lib_path=$(echo "${libs_s}" | sed -n ${i}p)
		parsed_libs+=("${lib_path}")
	done
done

for parsed_lib in "${parsed_libs[@]}"; do
	echo "Copying ${parsed_lib} ..."
	cp -L "${parsed_lib}" "${init_src_dir}${parsed_lib}"
done

lib_paths=()
for lib in "${libs[@]}"; do
	lib_path_coll=$(find /usr/lib/ -name "${lib}")
	for (( i=1; i<=$(echo "${lib_path_coll}" | wc -l); i++ )); do
		lib_path=$(echo "${lib_path_coll}" | sed -n ${i}p)
		lib_paths+=("${lib_path}")
	done
done
for lib in "${libs[@]}"; do
	lib_path_coll=$(find /usr/lib64/ -name "${lib}")
	for (( i=1; i<=$(echo "${lib_path_coll}" | wc -l); i++ )); do
		lib_path=$(echo "${lib_path_coll}" | sed -n ${i}p)
		lib_paths+=("${lib_path}")
	done
done

for s_lib in "${lib_paths[@]}"; do
	if [[ "${s_lib}" != "" ]]; then
		lib_path=$(printf %s "${s_lib}" | sed -e 's/\/[^/]*$//g')
		mkdir -p "${init_src_dir}${lib_path}"
		echo "Copying ${s_lib} ..."
		cp "${s_lib}" "${init_src_dir}${lib_path}"
	fi
done

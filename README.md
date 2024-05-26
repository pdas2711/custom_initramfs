# Custom Initramfs

This is an *init* script written in shell code for BusyBox to run the initramfs environment. It runs on a system with a LUKS encrypted root partition to a BTRFS filesystem and allows SSH access to remotely unlock the partition to allow the system to boot. *(WIP)*

I might make this more modular in the future to account for more various setups. At the moment, this uses a Raspberry PI that is connected via ethernet and runs a SSH server as a proxy to the Dropbear server in the initramfs.

## To-Do

- [ ] Enable networking through ethernet interface (connected via direct connection, not to a DHCP server).
- [ ] Allow the user that's physically on the machine to override SSH control by unlocking the root partition and boot the machine normally.

## Resources

I couldn't have done this without the [Gentoo Wiki](https://wiki.gentoo.org/wiki/Custom_Initramfs) and this helpful [example](https://wiki.gentoo.org/wiki/Custom_Initramfs/Examples#Simple_initramfs_for_unlocking_LUKS_encrypted_root_remotely_over_SSH) to get me started.

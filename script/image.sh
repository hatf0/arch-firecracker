#! /bin/bash
set -ex

sudo rm -rf /output/*

sudo chmod +x /script/*
sudo cp /home/build/linux/trunk/src/archlinux-linux/vmlinux /output/vmlinux
sudo cp /home/build/linux/trunk/config /output/config

sudo truncate -s 3G /output/image.ext4
sudo mkfs.ext4 /output/image.ext4

sudo mount /output/image.ext4 /rootfs
sudo pacstrap /rootfs base base-devel 
sudo mount --bind / /rootfs/mnt

sudo chmod +x /rootfs/mnt/script/provision.sh
sudo arch-chroot /rootfs /mnt/script/provision.sh

sudo umount /rootfs/mnt
sudo umount /rootfs


#!/bin/bash
# Partition and format disk
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./disko.nix
if [ $? -ne 0 ]; then
    echo "Error in partitioning or formatting disk!"
    exit 1
fi
echo "Done partitioning and formatting disk!"

# Install NixOS (nextOS)
sudo mkdir -p /mnt/etc/nixos
sudo cp -r ./* /mnt/etc/nixos
cd /mnt
sudo nixos-install --flake ./etc/nixos#vm
if [ $? -ne 0 ]; then
    echo "Error in installing NixOS!"
    exit 1
fi
echo "Done installing NixOS!"

# Welcome the user
echo "Welcome to nextOS!"

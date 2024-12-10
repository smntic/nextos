#!/usr/bin/env bash
# Partition and format disk
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./disko.nix
if [ $? -ne 0 ]; then
    echo "Error in partitioning or formatting disk!"
    exit 1
fi
echo "Done partitioning and formatting disk!"

# Create NixOS configuration folder
sudo mkdir -p /mnt/etc/nixos
echo "Done creating NixOS configuration folder!"

# Generate hardware configuration (and only hardware configuration)
sudo nixos-generate-config --root /mnt
sudo rm /mnt/etc/nixos/configuration.nix
echo "Done generating hardware configuration!"

# Install NixOS (nextOS)
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

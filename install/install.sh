#!/usr/bin/env bash

# Check if hostname argument is provided
if [ -z "$1" ]; then
    echo "Usage: ./install.sh HOSTNAME"
    exit 1
fi

# Set hostname and disk configuration path
HOSTNAME=$1
DISKO_PATH="./hosts/$HOSTNAME/disko.nix"

# Check if the disko configuration file exists for the given hostname
if [ ! -f "$DISKO_PATH" ]; then
    echo "Error: Disk configuration file $DISKO_PATH not found!"
    exit 1
fi

# Partition and format disk using the specific disko configuration
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko "$DISKO_PATH"
if [ $? -ne 0 ]; then
    echo "Error in partitioning or formatting disk!"
    exit 1
fi
echo "Done partitioning and formatting disk!"

# Create NixOS configuration folder
sudo mkdir -p /mnt/etc/nixos
echo "Done creating NixOS configuration folder!"

# Install NixOS (nextOS)
sudo cp -r ./* /mnt/etc/nixos
cd /mnt
sudo nixos-install --flake ./etc/nixos#vm
if [ $? -ne 0 ]; then
    echo "Error in installing NixOS!"
    exit 1
fi
echo "Done installing NixOS!"

# Generate hardware configuration (and only hardware configuration)
sudo nixos-generate-config --root /mnt
sudo rm /mnt/etc/nixos/configuration.nix
sudo mv /mnt/etc/nixos/hardware-configuration.nix "/mnt/etc/nixos/hosts/$HOSTNAME"
echo "Done generating hardware configuration!"

# Welcome the user
echo "Welcome to nextOS!"


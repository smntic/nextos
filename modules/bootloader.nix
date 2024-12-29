{ lib, ... }:

{
  imports = [
    ./bootloader/grub.nix
    ./bootloader/systemd-boot.nix
  ];

  grub.enable = lib.mkDefault true;
  systemd-boot.enable = lib.mkDefault false;
}

{ lib, ... }:

{
  imports = [
    ./virtualization/docker.nix
    ./virtualization/qemu.nix
    ./virtualization/wine.nix
  ];

  docker.enable = lib.mkDefault true;
  qemu.enable = lib.mkDefault true;
  wine.enable = lib.mkDefault true;
  wine.waylandSupport = lib.mkDefault true;
}

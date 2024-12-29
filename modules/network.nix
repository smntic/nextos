{ lib, ... }:

{
  imports = [
    ./network/netcat.nix
    ./network/networkmanager.nix
    ./network/wget.nix
  ];

  netcat.enable = lib.mkDefault true;
  networkmanager.enable = lib.mkDefault true;
  wget.enable = lib.mkDefault true;
}

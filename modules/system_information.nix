{ lib, ... }:

{
  imports = [
    ./system_information/htop.nix
    ./system_information/neofetch.nix
  ];

  htop.enable = lib.mkDefault true;
  neofetch.enable = lib.mkDefault true;
}

{ lib, ... }:

{
  imports = [
    ./images/feh.nix
    ./images/krita.nix
    ./images/sxiv.nix
  ];

  feh.enable = lib.mkDefault false;
  krita.enable = lib.mkDefault true;
  sxiv.enable = lib.mkDefault true;
}

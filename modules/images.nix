{ lib, ... }:

{
  imports = [
    ./images/feh.nix
    ./images/krita.nix
  ];

  feh.enable = lib.mkDefault true;
  krita.enable = lib.mkDefault true;
}

{ lib, ... }:

{
  imports = [
    ./documents/libreoffice.nix
  ];

  libreoffice.enable = lib.mkDefault true;
}

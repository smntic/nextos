{ lib, ... }:

{
  imports = [
    ./printing/cups.nix
  ];

  cups.enable = lib.mkDefault true;
}

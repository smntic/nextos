{ lib, ... }:

{
  imports = [
    ./compression/zip.nix
  ];

  zip.enable = lib.mkDefault true;
}

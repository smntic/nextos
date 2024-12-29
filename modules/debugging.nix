{ lib, ... }:

{
  imports = [
    ./debugging/gdb.nix
  ];

  gdb.enable = lib.mkDefault true;
}

{ lib, ... }:

{
  imports = [
    ./languages/java.nix
    ./languages/pnpm.nix
    ./languages/python.nix
  ];

  java.enable = lib.mkDefault true;
  pnpm.enable = lib.mkDefault true;
  python.enable = lib.mkDefault true;
}

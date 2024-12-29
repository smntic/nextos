{ lib, ... }:

{
  imports = [
    ./build_tools/gcc.nix
    ./build_tools/make.nix
    ./build_tools/ninja.nix
    ./build_tools/scons.nix
  ];

  gcc.enable = lib.mkDefault true;
  make.enable = lib.mkDefault true;
  ninja.enable = lib.mkDefault true;
  scons.enable = lib.mkDefault true;
}

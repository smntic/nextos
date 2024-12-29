{ lib, ... }:

{
  imports = [
    ./build_tools/bear.nix
    ./build_tools/gcc.nix
    ./build_tools/make.nix
    ./build_tools/cmake.nix
    ./build_tools/ninja.nix
    ./build_tools/scons.nix
  ];

  bear.enable = lib.mkDefault true;
  gcc.enable = lib.mkDefault true;
  make.enable = lib.mkDefault true;
  cmake.enable = lib.mkDefault true;
  ninja.enable = lib.mkDefault true;
  scons.enable = lib.mkDefault true;
}

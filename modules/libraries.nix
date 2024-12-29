{ lib, ... }:

{
  imports = [
    ./libraries/opencv.nix
    ./libraries/sdl2.nix
  ];

  opencv.enable = lib.mkDefault true;
  sdl2.enable = lib.mkDefault true;
}

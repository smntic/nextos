{ lib, ... }:

{
  imports = [
    ./android/android_studio.nix
    ./android/scrcpy.nix
  ];

  android_studio.enable = lib.mkDefault true;
  android_studio.enableADB = lib.mkDefault true;
  scrcpy.enable = lib.mkDefault true;
}

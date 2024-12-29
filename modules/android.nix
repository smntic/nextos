{ lib, ... }:

{
  imports = [
    ./android/android_studio.nix
    ./android/kdeconnect.nix
    ./android/scrcpy.nix
  ];

  android_studio.enable = lib.mkDefault true;
  android_studio.enableADB = lib.mkDefault true;
  kdeconnect.enable = lib.mkDefault true;
  scrcpy.enable = lib.mkDefault true;
}

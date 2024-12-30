{ lib, ... }:

{
  programs.hyprlock.settings.background = lib.mkForce [
    {
      path = "screenshot";
      blur_passes = 2;
      blur_size = 5;
    }
  ];
}

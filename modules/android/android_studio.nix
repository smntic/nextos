{ pkgs, lib, config, ... }:

{
  options = {
    android_studio.enable = lib.mkEnableOption "android studio";
    android_studio.enableADB = lib.mkEnableOption "adb";
  };

  config = lib.mkIf config.android_studio.enable {
    environment.systemPackages = [ pkgs.android-studio ];

    programs.adb = lib.mkIf config.android_studio.enableADB {
      enable = true;
    };
  };
}

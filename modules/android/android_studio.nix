{ pkgs, lib, config, ... }:

{
  options = {
    modules.android_studio.enable = lib.mkEnableOption "android studio";
    modules.android_studio.enableADB = lib.mkEnableOption "adb";
  };

  config = lib.mkIf config.modules.android_studio.enable {
    environment.systemPackages = [ pkgs.android-studio ];

    programs.adb = lib.mkIf config.modules.android_studio.enableADB {
      enable = true;
    };
  };
}

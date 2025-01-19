{ pkgs, lib, config, ... }:

{
  options = {
    modules.appimage-run.enable = lib.mkEnableOption "appimage-run-run-free";
  };

  config = lib.mkIf config.modules.appimage-run.enable {
    environment.systemPackages = [ pkgs.appimage-run ];
  };
}

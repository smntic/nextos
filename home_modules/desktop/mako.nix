{ lib, config, pkgs, ... }:

{
  options = {
    homeModules.mako.enable = lib.mkEnableOption "mako";
  };

  config = lib.mkIf config.homeModules.mako.enable {
    home.packages = [
      pkgs.libnotify
    ];

    services.mako = {
      enable = true;
      settings.default-timeout = 3000;
    };
  };
}

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
      defaultTimeout = 3000;
    };
  };
}

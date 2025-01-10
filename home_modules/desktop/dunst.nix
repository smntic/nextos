{ lib, config, ... }:

{
  options = {
    homeModules.dunst.enable = lib.mkEnableOption "dunst";
  };

  config = lib.mkIf config.homeModules.dunst.enable {
    services.dunst = {
      enable = true;
      settings.global = {
        transparency = 20;
      };
    };
  };
}

{ lib, config, ... }:

{
  options = {
    homeModules.hyprpaper.enable = lib.mkEnableOption "hyprpaper";
  };

  config = lib.mkIf config.homeModules.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;

      settings = {
        preload = [ "${config.stylix.image}" ];
        wallpaper = [ ",${config.stylix.image}" ];
      };
    };
  };
}

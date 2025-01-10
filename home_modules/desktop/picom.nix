{ lib, config, ... }:

{
  options = {
    homeModules.picom.enable = lib.mkEnableOption "picom";
  };

  config = lib.mkIf config.homeModules.picom.enable {
    services.picom = {
      enable = true;
      vSync = true;

      settings = {
        backend = "glx";
        
        blur = {
          method = "dual_kawase";
          strength = 3;
        };
      };
    };
  };
}

{ lib, config, ... }:

{
  options = {
    modules.i3.enable = lib.mkEnableOption "i3";
  };

  config = lib.mkIf config.modules.i3.enable {
    services.xserver = {
      enable = true;

      displayManager = {
        startx.enable = true;
      };

      windowManager = {
        i3.enable = true;
      };
    };
  };
}


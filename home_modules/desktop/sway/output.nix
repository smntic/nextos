{ lib, config, ... }:

{
  services.kanshi = lib.mkIf config.homeModules.sway.enable {
    enable = true;
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
          }
        ];
      }
     
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            position = "1680,0";
          }
          {
            criteria = "HDMI-A-1";
            position = "0,0";
          }
        ];
      }
    ];
  };
}

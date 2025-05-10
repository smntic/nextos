{ lib, config, ... }:

{
  options = {
    homeModules.gammastep.enable = lib.mkEnableOption "gammastep";
  };

  config = lib.mkIf config.homeModules.gammastep.enable {
    services.gammastep = {
      enable = true;

      # Approximately Vancouver
      provider = "manual";
      latitude = 49.3;
      longitude = -123.1;

      temperature = {
        day = 5500;
        night = 3000;
      };

      # Specify the times to align with my sleep "schedule"
      dawnTime = "5:00-6:00";
      duskTime = "20:30-21:30";
    };
  };
}

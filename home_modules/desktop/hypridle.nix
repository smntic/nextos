{ lib, config, ... }:

{
  options = {
    homeModules.hypridle.enable = lib.mkEnableOption "hypridle";
  };

  config = lib.mkIf config.homeModules.hypridle.enable {
    services.hypridle = {
      enable = true;

      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          before_sleep_cmd = "loginctl lock-session";
          lock_cmd = "pidof hyprlock || hyprlock";
        };

        listener = [
          # Turn screen off after 5 minutes
          {
            timeout = 300;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }

          # Lock session after 10 minutes
          {
            timeout = 600;
            on-timeout = "loginctl lock-session";
          }
        ];
      };
    };
  };
}

{ lib, config, ... }:

{
  options = {
    homeModules.i3status.enable = lib.mkEnableOption "i3 status";
  };

  config = lib.mkIf config.homeModules.i3status.enable {
    programs.i3status = {
      enable = true;
      enableDefault = false;

      general = {
        colors = true;
        color_bad = "#${config.lib.stylix.colors.base08}";
        color_degraded = "#${config.lib.stylix.colors.base09}";
        color_good = "#${config.lib.stylix.colors.base0B}";
        interval = 1;
      };

      modules = {
        "wireless _first_" = {
          enable = true;
          position = 1;
          settings = {
            format_up = "  %essid %quality : %ip ";
            format_down = " 󰖪 down ";
          };
        };

        "disk /" = {
          enable = true;
          position = 2;
          settings = {
            format = "   %avail ";
          };
        };

        "memory" = {
          enable = true;
          position = 3;
          settings = {
            format = "  󰍛 %used ";
            threshold_degraded = "1G";
            format_degraded = "MEMORY < %available";
          };
        };

        "battery all" = {
          enable = true;
          position = 4;
          settings = {
            format = "‌ %status %percentage ‌";
            status_chr = " ";
            status_full = " 󰚥";
            status_bat = " 󱐤";
            status_unk = " ";
            status_idle = " 󰚥";
          };
        };

        "volume master" = {
          enable = true;
          position = 5;
          settings = {
            format = "  󰎇 %volume ";
            format_muted = " 󰎊 %volume ";
            device = "pulse";
            mixer = "Master";
            mixer_idx = 0;
          };
        };
      };
    };
  };
}

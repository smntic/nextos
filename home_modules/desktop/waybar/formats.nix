{ ... }:

{
  programs.waybar.settings.mainBar = {
    network = {
      format-wifi = "󰖩 {essid} {signalStrength}% : {ipaddr}";
      format-ethernet = "󰈀 {cidr} : {ipaddr}";
      format-disconnected = "󰖪 Disconnected";
      interval = 1;
      tooltip = false;
    };

    disk = {
      format = "󰗮 {specific_free:0.1f} GB";
      unit = "GB";
      interval = 1;
      tooltip = false;
    };

    memory = {
      format = "󰍛 {used:0.1f} GB";
      interval = 1;
      tooltip = false;
    };

    battery = {
      states = {
        warning = 30;
        critical = 15;
      };
      "format-charging" = "󱐥 {capacity}%";
      "format-discharging" = "󱐤 {capacity}%";
      "format-full" = "󰚥 {capacity}%";
      "format-not charging" = "󰚥 {capacity}%";
      "format-unknown" = " {capacity}%";
      interval = 1;
      tooltip = false;
    };

    wireplumber = {
      format = "󰎇 {volume}%";
      format-muted = "󰎊 {volume}%";
      interval = 1;
      tooltip = false;
    };

    "custom/separator" = {
      format = "|";
      interval = "once";
      tooltip = false;
    };
  };
}

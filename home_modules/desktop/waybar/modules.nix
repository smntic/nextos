{ ... }:

{
  programs.waybar.settings.mainBar = {
    modules-left = [ "hyprland/workspaces" ];
    modules-right = [
      "network"
      "custom/separator"
      "disk"
      "custom/separator"
      "memory"
      "custom/separator"
      "battery"
      "custom/separator"
      "wireplumber"
    ];
  };
}

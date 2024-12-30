{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 3;
      gaps_out = 6;
      border_size = 1;
    };

    decoration = {
      shadow = {
        enabled = false;
      };

      blur = {
        enabled = true;
        size = 4;
      };
    };

    blurls = [
      "waybar"
      "kitty"
    ];
  };
}

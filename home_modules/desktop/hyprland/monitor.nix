{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, preferred, 0x0, 1"
      ", preferred, auto, 1"
    ];

    workspace = [
      "1, monitor:eDP-1"
    ];

    cursor = {
      default_monitor = "eDP-1";
    };
  };
}

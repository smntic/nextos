{ ... }:

{
  imports = [
    ./hyprland/animation.nix
    ./hyprland/appearance.nix
    ./hyprland/bindings.nix
    ./hyprland/input.nix
    ./hyprland/misc.nix
    ./hyprland/monitor.nix
    ./hyprland/start.nix
  ];

  wayland.windowManager.hyprland.enable = true;
}

{ lib, config, ... }:

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

  options = {
    homeModules.hyprland.enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf config.homeModules.hyprland.enable {
    wayland.windowManager.hyprland.enable = true;
  };
}

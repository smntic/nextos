{ pkgs, lib, config, inputs, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      xwayland.enable = true;

      # https://wiki.hyprland.org/Useful-Utilities/Systemd-start/
      withUWSM = true;
    };

    security.pam.services.hyprlock = {};

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}

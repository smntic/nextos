{ pkgs, lib, config, inputs, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "hyprland";
    hyprland.withUWSM = lib.mkEnableOption "UWSM for Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      xwayland.enable = true;

      # https://wiki.hyprland.org/Useful-Utilities/Systemd-start/
      withUWSM = config.hyprland.withUWSM;
    };
   
    programs.uwsm = lib.mkIf config.hyprland.withUWSM {
      enable = true;
    };

    security.pam.services.hyprlock = {};

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}

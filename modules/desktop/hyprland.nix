{ pkgs, lib, config, inputs, ... }:

{
  options = {
    modules.hyprland.enable = lib.mkEnableOption "hyprland";
    modules.hyprland.withUWSM = lib.mkEnableOption "UWSM for Hyprland";
  };

  config = lib.mkIf config.modules.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;

      # Get the latest and greatest
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;

      # https://wiki.hyprland.org/Useful-Utilities/Systemd-start/
      withUWSM = config.modules.hyprland.withUWSM;
    };

    programs.uwsm = lib.mkIf config.modules.hyprland.withUWSM {
      enable = true;
    };

    # PAM must be configured to enable hyprlock to perform authentication
    # This should technically be in it's own module...
    security.pam.services.hyprlock = {};

    # Communication between apps
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}

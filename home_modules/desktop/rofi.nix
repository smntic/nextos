{ lib, pkgs, config, ... }:

{
  imports = [
    ./rofi/config.nix
    ./rofi/bindings.nix
    ./rofi/theme.nix
  ];

  options = {
    homeModules.rofi.enable = lib.mkEnableOption "rofi";
  };

  config = lib.mkIf config.homeModules.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      extraConfig = {
        monitor = -1;
      };
    };
  };
}

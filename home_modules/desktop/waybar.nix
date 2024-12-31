{ lib, config, ... }:

{
  imports = [
    ./waybar/modules.nix
    ./waybar/formats.nix
    ./waybar/style.nix
  ];

  options = {
    homeModules.waybar.enable = lib.mkEnableOption "waybar";
  };

  config = lib.mkIf config.homeModules.waybar.enable {
    programs.waybar.enable = true;
  };
}

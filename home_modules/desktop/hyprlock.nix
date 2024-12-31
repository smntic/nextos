{ lib, config, ... }:

{
  imports = [
    ./hyprlock/general.nix
    ./hyprlock/background.nix
    ./hyprlock/input_field.nix
  ];

  options = {
    homeModules.hyprlock.enable = lib.mkEnableOption "hyprlock";
  };

  config = lib.mkIf config.homeModules.hyprlock.enable {
    programs.hyprlock.enable = true;
  };
}

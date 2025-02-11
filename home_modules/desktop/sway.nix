{ lib, config, ... }:

{
  imports = [
    ./sway/appearance.nix
    ./sway/bars.nix
    ./sway/config.nix
    ./sway/input.nix
    ./sway/output.nix
  ];

  options = {
    homeModules.sway.enable = lib.mkEnableOption "sway";
  };

  config = lib.mkIf config.homeModules.sway.enable {
    wayland.windowManager.sway = {
      extraConfig = ''
        floating_modifier Mod4
        title_align center
      '';
    };
  };
}

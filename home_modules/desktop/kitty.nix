{ lib, config, ... }:

{
  imports = [
    ./kitty/bindings.nix
    ./kitty/config.nix
  ];

  options = {
    homeModules.kitty.enable = lib.mkEnableOption "kitty";
  };

  config = lib.mkIf config.homeModules.kitty.enable {
    programs.kitty.enable = true;
  };
}

{ pkgs, lib, config, ... }:

{
  options = {
    homeModules.bluetui.enable = lib.mkEnableOption "bluetui";
  };

  config = lib.mkIf config.homeModules.bluetui.enable {
    home.packages = [ pkgs.bluetui ];
  };
}

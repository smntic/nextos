{ pkgs, lib, config, ... }:

{
  options = {
    modules.cura.enable = lib.mkEnableOption "cura";
  };

  config = lib.mkIf config.modules.cura.enable {
    environment.systemPackages = [ pkgs.cura ];
  };
}

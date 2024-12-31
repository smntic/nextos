{ pkgs, lib, config, ... }:

{
  options = {
    modules.feh.enable = lib.mkEnableOption "feh";
  };

  config = lib.mkIf config.modules.feh.enable {
    environment.systemPackages = [ pkgs.feh ];
  };
}

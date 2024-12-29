{ pkgs, lib, config, ... }:

{
  options = {
    feh.enable = lib.mkEnableOption "feh";
  };

  config = lib.mkIf config.feh.enable {
    environment.systemPackages = [ pkgs.feh ];
  };
}

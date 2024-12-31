{ pkgs, lib, config, ... }:

{
  options = {
    modules.ninja.enable = lib.mkEnableOption "ninja";
  };

  config = lib.mkIf config.modules.ninja.enable {
    environment.systemPackages = [ pkgs.ninja ];
  };
}

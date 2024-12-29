{ pkgs, lib, config, ... }:

{
  options = {
    ninja.enable = lib.mkEnableOption "ninja";
  };

  config = lib.mkIf config.ninja.enable {
    environment.systemPackages = [ pkgs.ninja ];
  };
}

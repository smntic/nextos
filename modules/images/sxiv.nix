{ pkgs, lib, config, ... }:

{
  options = {
    sxiv.enable = lib.mkEnableOption "sxiv";
  };

  config = lib.mkIf config.sxiv.enable {
    environment.systemPackages = [ pkgs.sxiv ];
  };
}

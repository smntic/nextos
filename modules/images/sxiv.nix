{ pkgs, lib, config, ... }:

{
  options = {
    modules.sxiv.enable = lib.mkEnableOption "sxiv";
  };

  config = lib.mkIf config.modules.sxiv.enable {
    environment.systemPackages = [ pkgs.sxiv ];
  };
}

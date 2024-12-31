{ pkgs, lib, config, ... }:

{
  options = {
    modules.bear.enable = lib.mkEnableOption "bear";
  };

  config = lib.mkIf config.modules.bear.enable {
    environment.systemPackages = [ pkgs.bear ];
  };
}

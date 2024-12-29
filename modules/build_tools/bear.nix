{ pkgs, lib, config, ... }:

{
  options = {
    bear.enable = lib.mkEnableOption "bear";
  };

  config = lib.mkIf config.bear.enable {
    environment.systemPackages = [ pkgs.bear ];
  };
}

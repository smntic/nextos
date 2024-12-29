{ pkgs, lib, config, ... }:

{
  options = {
    netcat.enable = lib.mkEnableOption "netcat";
  };

  config = lib.mkIf config.netcat.enable {
    environment.systemPackages = [ pkgs.netcat-gnu ];
  };
}

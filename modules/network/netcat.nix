{ pkgs, lib, config, ... }:

{
  options = {
    modules.netcat.enable = lib.mkEnableOption "netcat";
  };

  config = lib.mkIf config.modules.netcat.enable {
    environment.systemPackages = [ pkgs.netcat-gnu ];
  };
}

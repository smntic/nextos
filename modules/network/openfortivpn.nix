{ pkgs, lib, config, ... }:

{
  options = {
    modules.openfortivpn.enable = lib.mkEnableOption "openfortivpn";
  };

  config = lib.mkIf config.modules.openfortivpn.enable {
    environment.systemPackages = [ pkgs.openfortivpn ];
  };
}

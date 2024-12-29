{ pkgs, lib, config, ... }:

{
  options = {
    psmisc.enable = lib.mkEnableOption "psmisc";
  };

  config = lib.mkIf config.psmisc.enable {
    environment.systemPackages = [ pkgs.psmisc ];
  };
}

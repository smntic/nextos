{ pkgs, lib, config, ... }:

{
  options = {
    modules.psmisc.enable = lib.mkEnableOption "psmisc";
  };

  config = lib.mkIf config.modules.psmisc.enable {
    environment.systemPackages = [ pkgs.psmisc ];
  };
}

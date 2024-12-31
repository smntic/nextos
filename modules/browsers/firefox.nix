{ pkgs, lib, config, ... }:

{
  options = {
    modules.firefox.enable = lib.mkEnableOption "firefox";
  };

  config = lib.mkIf config.modules.firefox.enable {
    environment.systemPackages = [ pkgs.firefox ];
  };
}

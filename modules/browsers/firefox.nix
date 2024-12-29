{ pkgs, lib, config, ... }:

{
  options = {
    firefox.enable = lib.mkEnableOption "firefox";
  };

  config = lib.mkIf config.firefox.enable {
    environment.systemPackages = [ pkgs.firefox ];
  };
}

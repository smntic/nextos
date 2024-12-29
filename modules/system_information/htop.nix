{ pkgs, lib, config, ... }:

{
  options = {
    htop.enable = lib.mkEnableOption "htop";
  };

  config = lib.mkIf config.htop.enable {
    environment.systemPackages = [ pkgs.htop ];
  };
}

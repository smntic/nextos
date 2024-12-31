{ pkgs, lib, config, ... }:

{
  options = {
    modules.htop.enable = lib.mkEnableOption "htop";
  };

  config = lib.mkIf config.modules.htop.enable {
    environment.systemPackages = [ pkgs.htop ];
  };
}

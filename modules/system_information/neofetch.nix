{ pkgs, lib, config, ... }:

{
  options = {
    modules.neofetch.enable = lib.mkEnableOption "neofetch";
  };

  config = lib.mkIf config.modules.neofetch.enable {
    environment.systemPackages = [ pkgs.neofetch ];
  };
}

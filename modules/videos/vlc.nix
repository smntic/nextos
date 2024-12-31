{ pkgs, lib, config, ... }:

{
  options = {
    modules.vlc.enable = lib.mkEnableOption "vlc";
  };

  config = lib.mkIf config.modules.vlc.enable {
    environment.systemPackages = [ pkgs.vlc ];
  };
}

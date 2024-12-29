{ pkgs, lib, config, ... }:

{
  options = {
    vlc.enable = lib.mkEnableOption "vlc";
  };

  config = lib.mkIf config.vlc.enable {
    environment.systemPackages = [ pkgs.vlc ];
  };
}

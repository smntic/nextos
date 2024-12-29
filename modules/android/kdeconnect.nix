{ pkgs, lib, config, ... }:

{
  options = {
    kdeconnect.enable = lib.mkEnableOption "kdeconnect";
  };

  config = lib.mkIf config.kdeconnect.enable {
    programs.kdeconnect.enable = true;
  };
}

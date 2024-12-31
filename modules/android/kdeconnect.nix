{ lib, config, ... }:

{
  options = {
    modules.kdeconnect.enable = lib.mkEnableOption "kdeconnect";
  };

  config = lib.mkIf config.modules.kdeconnect.enable {
    programs.kdeconnect.enable = true;
  };
}

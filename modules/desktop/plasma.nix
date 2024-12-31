{ lib, config, ... }:

{
  options = {
    modules.plasma.enable = lib.mkEnableOption "plasma";
  };

  config = lib.mkIf config.modules.plasma.enable {
    services.desktopManager.plasma6.enable = true;
  };
}

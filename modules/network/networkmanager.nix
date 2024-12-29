{ lib, config, ... }:

{
  options = {
    networkmanager.enable = lib.mkEnableOption "networkmanager";
  };

  config = lib.mkIf config.networkmanager.enable {
    networking.networkmanager.enable = true;
  };
}

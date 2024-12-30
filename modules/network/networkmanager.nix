{ lib, config, root, ... }:

{
  options = {
    networkmanager.enable = lib.mkEnableOption "networkmanager";
    networkmanager.waitForOnline = lib.mkEnableOption "NetworkManager-wait-online service";
  };

  config = lib.mkIf config.networkmanager.enable {
    networking.networkmanager.enable = true;
    systemd.services.NetworkManager-wait-online.enable = config.networkmanager.waitForOnline;
  };
}

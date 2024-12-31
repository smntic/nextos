{ lib, config, root, ... }:

let
  option = import "${root}/lib/option.nix" { inherit lib; };
in
  {
    options = {
      modules.networkmanager.enable = lib.mkEnableOption "networkmanager";
      modules.networkmanager.waitForOnline = option.mkDisableOption "NetworkManager-wait-online service (may delay startup)";
    };

    config = lib.mkIf config.modules.networkmanager.enable {
      networking.networkmanager.enable = true;
      systemd.services.NetworkManager-wait-online.enable = config.modules.networkmanager.waitForOnline;
    };
  }

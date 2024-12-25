{ lib, config, ... }:

{
  options = {
    cups.drivers = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "List of printer drivers to use.";
    };
  };

  # https://nixos.wiki/wiki/Printing
  config = {
    services = {
      printing = {
        enable = true;
        drivers = config.cups.drivers;
      };

      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}

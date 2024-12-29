{ lib, config, ... }:

{
  options = {
    cups.enable = lib.mkEnableOption "cups";
    cups.drivers = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "List of printer drivers to use.";
    };
  };

  config = lib.mkIf config.cups.enable {
    # https://nixos.wiki/wiki/Printing
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

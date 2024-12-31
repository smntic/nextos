{ lib, config, ... }:

{
  options = {
    modules.cups.enable = lib.mkEnableOption "cups";
    modules.cups.drivers = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      description = "List of printer drivers to use.";
      example = "[ pkgs.hplip ]";
      default = [];
    };
  };

  config = lib.mkIf config.modules.cups.enable {
    # https://nixos.wiki/wiki/Printing
    services = {
      printing = {
        enable = true;
        drivers = config.modules.cups.drivers;
      };

      # Enable autodiscovery of network printers
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}

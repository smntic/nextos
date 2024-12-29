{ lib, config, ... }:

{
  options = {
    systemd-boot.enable = lib.mkEnableOption "systemd-boot as the bootloader";
  };

  config = lib.mkIf config.systemd-boot.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
}

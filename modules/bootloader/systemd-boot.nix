{ lib, config, ... }:

{
  options = {
    modules.systemd-boot.enable = lib.mkEnableOption "systemd-boot as the bootloader";
  };

  config = lib.mkIf config.modules.systemd-boot.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true; # Allow NixOS to modify the EFI variables
      systemd-boot.enable = true;
    };
  };
}

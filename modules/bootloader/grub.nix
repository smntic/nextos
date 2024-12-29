{ lib, config, ... }:

{
  options = {
    grub.enable = lib.mkEnableOption "grub as the bootloader";
  };

  config = lib.mkIf config.grub.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
         enable = true;
         efiSupport = true;
         device = "nodev";
      };
    };
  };
}

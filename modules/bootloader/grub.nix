{ lib, config, ... }:

{
  options = {
    modules.grub.enable = lib.mkEnableOption "grub as the bootloader";
  };

  config = lib.mkIf config.modules.grub.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true; # Allow NixOS to modify the EFI variables
      grub = {
         enable = true;
         efiSupport = true; # Support UEFI firmware
         device = "nodev"; # Grub should not be installed on a specific device

         # Set background color to black (black background in the splash as well)
         backgroundColor = "#000000";
         splashImage = ./grub/background.png;
         splashMode = "normal"; # Disables image stretching
      };
    };
  };
}

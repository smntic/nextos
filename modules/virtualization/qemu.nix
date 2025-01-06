{ pkgs, lib, config, ... }:

{
  options = {
    modules.qemu.enable = lib.mkEnableOption "qemu";
  };

  config = lib.mkIf config.modules.qemu.enable {
    environment.systemPackages = [
      pkgs.qemu
      pkgs.spice
      pkgs.spice-gtk
    ];
  };
}

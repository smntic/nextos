{ pkgs, lib, config, ... }:

{
  options = {
    qemu.enable = lib.mkEnableOption "qemu";
  };

  config = lib.mkIf config.qemu.enable {
    environment.systemPackages = [
      pkgs.qemu
    ];
  };
}

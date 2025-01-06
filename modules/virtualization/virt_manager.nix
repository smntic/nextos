{ pkgs, lib, config, ... }:

{
  options = {
    modules.virt-manager.enable = lib.mkEnableOption "virt-manager";
  };

  config = lib.mkIf config.modules.virt-manager.enable {
    environment.systemPackages = [
      pkgs.virt-manager
    ];
  };
}

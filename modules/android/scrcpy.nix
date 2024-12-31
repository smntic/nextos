{ pkgs, lib, config, ... }:

{
  options = {
    modules.scrcpy.enable = lib.mkEnableOption "scrcpy";
  };

  config = lib.mkIf config.modules.scrcpy.enable {
    environment.systemPackages = [ pkgs.scrcpy ];
  };
}

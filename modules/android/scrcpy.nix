{ pkgs, lib, config, ... }:

{
  options = {
    scrcpy.enable = lib.mkEnableOption "scrcpy";
  };

  config = lib.mkIf config.scrcpy.enable {
    environment.systemPackages = [ pkgs.scrcpy ];
  };
}

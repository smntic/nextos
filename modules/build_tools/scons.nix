{ pkgs, lib, config, ... }:

{
  options = {
    scons.enable = lib.mkEnableOption "scons";
  };

  config = lib.mkIf config.scons.enable {
    environment.systemPackages = [ pkgs.scons ];
  };
}

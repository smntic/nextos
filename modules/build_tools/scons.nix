{ pkgs, lib, config, ... }:

{
  options = {
    modules.scons.enable = lib.mkEnableOption "scons";
  };

  config = lib.mkIf config.modules.scons.enable {
    environment.systemPackages = [ pkgs.scons ];
  };
}

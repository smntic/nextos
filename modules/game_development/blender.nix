{ pkgs, lib, config, ... }:

{
  options = {
    blender.enable = lib.mkEnableOption "blender";
  };

  config = lib.mkIf config.blender.enable {
    environment.systemPackages = [ pkgs.blender ];
  };
}

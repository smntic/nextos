{ pkgs, lib, config, ... }:

{
  options = {
    modules.blender.enable = lib.mkEnableOption "blender";
  };

  config = lib.mkIf config.modules.blender.enable {
    environment.systemPackages = [ pkgs.blender ];
  };
}

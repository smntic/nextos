{ pkgs, lib, config, ... }:

{
  options = {
    modules.godot.enable = lib.mkEnableOption "godot";
  };

  config = lib.mkIf config.modules.godot.enable {
    environment.systemPackages = [ pkgs.godot_4-mono ];
  };
}

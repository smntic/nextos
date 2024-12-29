{ pkgs, lib, config, ... }:

{
  options = {
    godot.enable = lib.mkEnableOption "godot";
  };

  config = lib.mkIf config.godot.enable {
    environment.systemPackages = [ pkgs.godot_4-mono ];
  };
}

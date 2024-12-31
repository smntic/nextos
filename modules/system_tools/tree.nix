{ pkgs, lib, config, ... }:

{
  options = {
    modules.tree.enable = lib.mkEnableOption "tree";
  };

  config = lib.mkIf config.modules.tree.enable {
    environment.systemPackages = [ pkgs.tree ];
  };
}

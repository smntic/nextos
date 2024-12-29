{ pkgs, lib, config, ... }:

{
  options = {
    tree.enable = lib.mkEnableOption "tree";
  };

  config = lib.mkIf config.tree.enable {
    environment.systemPackages = [ pkgs.tree ];
  };
}

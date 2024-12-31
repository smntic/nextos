{ pkgs, lib, config, ... }:

{
  options = {
    modules.gdb.enable = lib.mkEnableOption "gdb";
  };

  config = lib.mkIf config.modules.gdb.enable {
    environment.systemPackages = [ pkgs.gdb ];
  };
}

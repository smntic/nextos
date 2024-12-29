{ pkgs, lib, config, ... }:

{
  options = {
    gdb.enable = lib.mkEnableOption "gdb";
  };

  config = lib.mkIf config.gdb.enable {
    environment.systemPackages = [ pkgs.gdb ];
  };
}

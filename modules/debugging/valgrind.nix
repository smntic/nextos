{ pkgs, lib, config, ... }:

{
  options = {
    modules.valgrind.enable = lib.mkEnableOption "valgrind";
  };

  config = lib.mkIf config.modules.valgrind.enable {
    environment.systemPackages = [ pkgs.valgrind ];
  };
}

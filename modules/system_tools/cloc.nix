{ pkgs, lib, config, ... }:

{
  options = {
    modules.cloc.enable = lib.mkEnableOption "cloc";
  };

  config = lib.mkIf config.modules.cloc.enable {
    environment.systemPackages = [ pkgs.cloc ];
  };
}

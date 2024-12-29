{ pkgs, lib, config, ... }:

{
  options = {
    cloc.enable = lib.mkEnableOption "cloc";
  };

  config = lib.mkIf config.cloc.enable {
    environment.systemPackages = [ pkgs.cloc ];
  };
}

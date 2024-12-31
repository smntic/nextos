{ pkgs, lib, config, ... }:

{
  options = {
    modules.zip.enable = lib.mkEnableOption "zip";
  };

  config = lib.mkIf config.modules.zip.enable {
    environment.systemPackages = [ pkgs.zip pkgs.unzip ];
  };
}

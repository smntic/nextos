{ pkgs, lib, config, ... }:

{
  options = {
    zip.enable = lib.mkEnableOption "zip";
  };

  config = lib.mkIf config.zip.enable {
    environment.systemPackages = [ pkgs.zip pkgs.unzip ];
  };
}

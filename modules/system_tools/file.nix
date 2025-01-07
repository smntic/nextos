{ pkgs, lib, config, ... }:

{
  options = {
    modules.file.enable = lib.mkEnableOption "file";
  };

  config = lib.mkIf config.modules.file.enable {
    environment.systemPackages = [ pkgs.file ];
  };
}

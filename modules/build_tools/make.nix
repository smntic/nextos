{ pkgs, lib, config, ... }:

{
  options = {
    modules.make.enable = lib.mkEnableOption "make";
  };

  config = lib.mkIf config.modules.make.enable {
    environment.systemPackages = [ pkgs.gnumake ];
  };
}

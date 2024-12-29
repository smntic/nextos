{ pkgs, lib, config, ... }:

{
  options = {
    make.enable = lib.mkEnableOption "make";
  };

  config = lib.mkIf config.make.enable {
    environment.systemPackages = [ pkgs.gnumake ];
  };
}

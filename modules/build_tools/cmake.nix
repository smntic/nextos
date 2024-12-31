{ pkgs, lib, config, ... }:

{
  options = {
    modules.cmake.enable = lib.mkEnableOption "cmake";
  };

  config = lib.mkIf config.modules.cmake.enable {
    environment.systemPackages = [ pkgs.cmake ];
  };
}

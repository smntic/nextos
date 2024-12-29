{ pkgs, lib, config, ... }:

{
  options = {
    cmake.enable = lib.mkEnableOption "cmake";
  };

  config = lib.mkIf config.cmake.enable {
    environment.systemPackages = [ pkgs.cmake ];
  };
}

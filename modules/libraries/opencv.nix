{ pkgs, lib, config, ... }:

{
  options = {
    opencv.enable = lib.mkEnableOption "opencv";
  };

  config = lib.mkIf config.opencv.enable {
    environment.systemPackages = [ pkgs.opencv ];
  };
}

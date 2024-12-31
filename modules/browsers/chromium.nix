{ pkgs, lib, config, ... }:

{
  options = {
    modules.chromium.enable = lib.mkEnableOption "chromium";
  };

  config = lib.mkIf config.modules.chromium.enable {
    environment.systemPackages = [ pkgs.chromium ];
  };
}

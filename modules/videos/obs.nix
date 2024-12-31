{ pkgs, lib, config, ... }:

{
  options = {
    modules.obs.enable = lib.mkEnableOption "obs";
  };

  config = lib.mkIf config.modules.obs.enable {
    environment.systemPackages = [ pkgs.obs-studio ];
  };
}

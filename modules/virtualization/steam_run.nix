{ pkgs, lib, config, ... }:

{
  options = {
    modules.steam_run.enable = lib.mkEnableOption "steam-run-free";
  };

  config = lib.mkIf config.modules.steam_run.enable {
    environment.systemPackages = [ pkgs.steam-run-free ];
  };
}

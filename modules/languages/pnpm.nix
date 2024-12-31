{ pkgs, lib, config, ... }:

{
  options = {
    modules.pnpm.enable = lib.mkEnableOption "pnpm";
  };

  config = lib.mkIf config.modules.pnpm.enable {
    environment.systemPackages = [ pkgs.pnpm ];
  };
}

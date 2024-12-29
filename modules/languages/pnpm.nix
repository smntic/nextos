{ pkgs, lib, config, ... }:

{
  options = {
    pnpm.enable = lib.mkEnableOption "pnpm";
  };

  config = lib.mkIf config.pnpm.enable {
    environment.systemPackages = [ pkgs.pnpm ];
  };
}

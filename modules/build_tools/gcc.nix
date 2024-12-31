{ pkgs, lib, config, ... }:

{
  options = {
    modules.gcc.enable = lib.mkEnableOption "gcc";
  };

  config = lib.mkIf config.modules.gcc.enable {
    environment.systemPackages = [ pkgs.gcc ];
  };
}

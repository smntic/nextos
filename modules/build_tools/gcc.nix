{ pkgs, lib, config, ... }:

{
  options = {
    gcc.enable = lib.mkEnableOption "gcc";
  };

  config = lib.mkIf config.gcc.enable {
    environment.systemPackages = [ pkgs.gcc ];
  };
}

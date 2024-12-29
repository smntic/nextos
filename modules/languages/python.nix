{ pkgs, lib, config, ... }:

{
  options = {
    python.enable = lib.mkEnableOption "python";
  };

  config = lib.mkIf config.python.enable {
    environment.systemPackages = [ pkgs.python3 ];
  };
}

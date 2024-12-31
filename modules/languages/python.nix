{ pkgs, lib, config, ... }:

{
  options = {
    modules.python.enable = lib.mkEnableOption "python";
  };

  config = lib.mkIf config.modules.python.enable {
    environment.systemPackages = [ pkgs.python3 ];
  };
}

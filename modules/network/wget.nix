{ pkgs, lib, config, ... }:

{
  options = {
    modules.wget.enable = lib.mkEnableOption "wget";
  };

  config = lib.mkIf config.modules.wget.enable {
    environment.systemPackages = [ pkgs.wget ];
  };
}

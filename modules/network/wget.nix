{ pkgs, lib, config, ... }:

{
  options = {
    wget.enable = lib.mkEnableOption "wget";
  };

  config = lib.mkIf config.wget.enable {
    environment.systemPackages = [ pkgs.wget ];
  };
}

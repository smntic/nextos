{ pkgs, lib, config, ... }:

{
  options = {
    krita.enable = lib.mkEnableOption "krita";
  };

  config = lib.mkIf config.krita.enable {
    environment.systemPackages = [
      pkgs.krita
    ];
  };
}

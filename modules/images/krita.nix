{ pkgs, lib, config, ... }:

{
  options = {
    modules.krita.enable = lib.mkEnableOption "krita";
  };

  config = lib.mkIf config.modules.krita.enable {
    environment.systemPackages = [
      pkgs.krita
    ];
  };
}

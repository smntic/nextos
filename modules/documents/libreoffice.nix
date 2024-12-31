{ pkgs, lib, config, ... }:

{
  options = {
    modules.libreoffice.enable = lib.mkEnableOption "libreoffice";
  };

  config = lib.mkIf config.modules.libreoffice.enable {
    # https://nixos.wiki/wiki/LibreOffice
    environment.systemPackages = [ 
      pkgs.libreoffice-qt
      pkgs.hunspell
    ];
  };
}

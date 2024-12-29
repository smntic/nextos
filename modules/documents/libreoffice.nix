{ pkgs, lib, config, ... }:

{
  options = {
    libreoffice.enable = lib.mkEnableOption "libreoffice";
  };

  config = lib.mkIf config.libreoffice.enable {
    # https://nixos.wiki/wiki/LibreOffice
    environment.systemPackages = [ 
      pkgs.libreoffice-qt
      pkgs.hunspell
    ];
  };
}

{ lib, ... }:

{
  imports = [
    ./videos/obs.nix
    ./videos/vlc.nix
    ./videos/ytdlp.nix
  ];

  obs.enable = lib.mkDefault true;
  vlc.enable = lib.mkDefault true;
  ytdlp.enable = lib.mkDefault true;
}

{ pkgs, lib, config, ... }:

{
  options = {
    ytdlp.enable = lib.mkEnableOption "ytdlp";
  };

  config = lib.mkIf config.ytdlp.enable {
    environment.systemPackages = [ pkgs.yt-dlp ];
  };
}

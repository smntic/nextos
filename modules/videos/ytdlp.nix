{ pkgs, lib, config, ... }:

{
  options = {
    modules.ytdlp.enable = lib.mkEnableOption "ytdlp";
  };

  config = lib.mkIf config.modules.ytdlp.enable {
    environment.systemPackages = [ pkgs.yt-dlp ];
  };
}

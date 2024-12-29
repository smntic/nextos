{ pkgs, lib, config, ... }:

{
  options = {
    sdl2.enable = lib.mkEnableOption "sdl2";
  };

  config = lib.mkIf config.sdl2.enable {
    environment.systemPackages = [
      pkgs.SDL2
      pkgs.SDL2_ttf
      pkgs.SDL2_net
      pkgs.SDL2_gfx
      pkgs.SDL2_sound
      pkgs.SDL2_mixer
      pkgs.SDL2_image
      pkgs.SDL2_Pango
    ];
  };
}

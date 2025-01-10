{ pkgs, lib, config, ... }:

{
  imports = [
    ./i3/config.nix
    ./i3/appearance.nix
    ./i3/bars.nix
  ];

  options = {
    homeModules.i3.enable = lib.mkEnableOption "i3";
  };

  config = lib.mkIf config.homeModules.i3.enable {
    home.packages = [
      pkgs.dbus
      pkgs.xclip
    ];

    xsession.windowManager.i3 = {
      extraConfig = ''
        floating_modifier Mod4
        title_align center
      '';
    };

    home.file.".xinitrc".text = ''
      SHELL=zsh exec dbus-launch --exit-with-session i3
    '';
  };
}

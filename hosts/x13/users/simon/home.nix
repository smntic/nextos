{ config, hostRoot, ... }:

{
  homeModules = {
    bluetui.enable = true;
    cp-tool.enable = true;
    dunst.enable = true;
    firefox.enable = true;
    gammastep.enable = true;
    hypridle.enable = true;
    hyprland.enable = true;
    hyprlock.enable = true;
    hyprpaper.enable = true;
    i3.enable = true;
    i3status.enable = true;
    kitty.enable = true;
    mako.enable = true;
    nvim.enable = true;
    picom.enable = true;
    precomp-bits.enable = true;
    redshift.enable = true;
    rofi.enable = true;
    tmux.enable = true;
    waybar.enable = true;
    yazi.enable = true;
    zsh.enable = true;

    aliases = {
      hypr = "uwsm start -S hyprland-uwsm.desktop";
      hyprexit = "uwsm stop";

      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#x13";
      update = "sudo sh -c 'nix flake update --flake /etc/nixos && nixos-rebuild switch --flake /etc/nixos#x13'";
      garbage = "sudo nix-collect-garbage -d --delete-older-than 14d";

      cpt = "source cpt -t=${hostRoot}/assets/cp/template";
    };

    git = {
      enable = true;
      name = "Simon Ashton";
      email = "simonashton.dev@gmail.com";
    };

    xdg = {
      userDirs = {
        enable = true;

        directories = {
          desktop = "${config.home.homeDirectory}/desktop";
          documents = "${config.home.homeDirectory}/documents";
          download = "${config.home.homeDirectory}/downloads";
          music = "${config.home.homeDirectory}/music";
          pictures = "${config.home.homeDirectory}/pictures";
          publicShare = "${config.home.homeDirectory}/public_share";
          templates = "${config.home.homeDirectory}/templates";
          videos = "${config.home.homeDirectory}/videos";
        };

        extraDirectories = {
          XDG_GIT_DIR = "${config.home.homeDirectory}/git";
        };
      };

      mimeApps = {
        enable = true;

        defaultApplications = {
          image = "sxiv.desktop";
        };
      };
    };
  };

  home.stateVersion = "24.11";
}

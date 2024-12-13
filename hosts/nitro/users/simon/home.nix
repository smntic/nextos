{ pkgs, ... }:

{
  imports = [
    ./desktop/hyprland.nix
  ];

  home = {
    packages = [
      pkgs.tree
      pkgs.git
      pkgs.neovim
      pkgs.cowsay
    ];

    stateVersion = "24.11";
  };

  programs = {
    git = {
      enable = true;

      userName = "Simon Ashton";
      userEmail = "simonashton.dev@gmail.com";
    };

    bash = {
      enable = true;

      # Replace TTY with hyprland
      initExtra = ''
        if [ -z $WAYLAND_DISPLAY ]; then
	  Hyprland
	  logout
	fi
      '';
    };
  };
}

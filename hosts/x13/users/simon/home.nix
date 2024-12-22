{ pkgs, ... }:

{
  imports = [
    ./desktop/hyprland.nix
    ./shell/zsh.nix
    ./editor/nvim.nix
  ];

  home = {
    packages = [
      pkgs.tree
      pkgs.git
      pkgs.cowsay
    ];

    shellAliases = {
      hypr = "Hyprland";
      hyprexit = "hyprctl dispatch exit";
    };

    stateVersion = "24.11";
  };

  programs = {
    git = {
      enable = true;

      userName = "Simon Ashton";
      userEmail = "simonashton.dev@gmail.com";
    };

    # Enable bash here so aliases apply to it as well.
    bash.enable = true;
  };
}

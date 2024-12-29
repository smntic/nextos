{ ... }:

{
  imports = [
    ./desktop/hyprland.nix
    ./shell/zsh.nix
    ./editor/nvim.nix
    ./python/python.nix

    ./xdg.nix
  ];

  home = {
    shellAliases = {
      hypr = "uwsm start -S hyprland-uwsm.desktop";
      hyprexit = "uwsm stop";

      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#x13";
      update = "sudo sh -c 'nix flake update --flake /etc/nixos && nixos-rebuild switch --flake /etc/nixos#x13'";
      garbage = "sudo nix-collect-garbage -d --delete-older-than 14d";
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

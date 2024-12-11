{ config, lib, pkgs, inputs, ... }:

{
  programs.git = {
    enable = true;

    userName = "Simon Ashton";
    userEmail = "simonashton.dev@gmail.com";
  };

  home = {
    packages = [
      pkgs.tree
      pkgs.git
      pkgs.neovim
      pkgs.cowsay
    ];

    stateVersion = "24.11";
  };
}

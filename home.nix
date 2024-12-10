{ config, lib, pkgs, inputs, ... }:

{
  programs.git = {
    enable = true;

    userName = "Simon Ashton";
    userEmail = "simonashton.dev@gmail.com";
  };

  home = {
    packages = [pkgs.tree pkgs.git pkgs.neovim];

    # You probably don't want to change this.
    stateVersion = "25.05";
  };
}

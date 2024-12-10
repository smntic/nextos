{ config, lib, pkgs, inputs, ... }:

{
  programs.git = {
    enable = true;

    userName = "Simon Ashton";
    userEmail = "simonashton.dev@gmail.com";
  };

  # You probably don't want to change this.
  home.stateVersion = "25.05";
}

{ pkgs, inputs, ... }:

{
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

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
    ];
 
    stateVersion = "24.11";
  };
}

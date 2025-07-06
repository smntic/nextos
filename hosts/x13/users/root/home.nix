{ ... }:

{
  homeModules = {
    nvim.enable = true;

    git = {
      enable = true;
      name = "Simon Ashton";
      email = "simonashton.dev@gmail.com";
    };
  };

  home.stateVersion = "24.11";
}

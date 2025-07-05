{ ... }:

{
  homeModules = {
    nvim.enable = true;

    git = {
      enable = true;
      name = "Simon Ashton";
      email = "simon@smntic.dev";
    };
  };

  home.stateVersion = "24.11";
}

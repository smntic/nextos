{ ... }:

{
  # Dear firefox, fuck you kindly.
  imports = [
    ./firefox/policies.nix
    ./firefox/preferences.nix
    ./firefox/extensions.nix
    ./firefox/profiles.nix
  ];

  programs.firefox.enable = true;
}

{ lib, config, ... }:

{
  # Dear firefox, fuck you kindly.
  imports = [
    ./firefox/policies.nix
    ./firefox/preferences.nix
    ./firefox/extensions.nix
    ./firefox/profiles.nix
  ];

  options = {
    homeModules.firefox.enable = lib.mkEnableOption "firefox";
  };

  config = lib.mkIf config.homeModules.firefox.enable {
    programs.firefox.enable = true;
  };
}

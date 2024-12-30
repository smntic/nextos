{ ... }:

{
  imports = [
    ./hyprlock/general.nix
    ./hyprlock/background.nix
    ./hyprlock/input_field.nix
  ];

  programs.hyprlock.enable = true;
}
